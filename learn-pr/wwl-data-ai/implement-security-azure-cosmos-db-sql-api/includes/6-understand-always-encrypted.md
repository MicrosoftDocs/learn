Always encrypted encrypts sensitive data like credit card numbers or payroll information inside client-side applications. The database receives the data already encrypted from the client side, and doesn't contain the decryption keys. This means that the database has no way to decrypt this data.  When the client requires the data, the database will send the encrypted data back and since the client has the decryption keys, the client will decrypt the data.

Always Encrypted brings client-side encryption capabilities to Azure Cosmos DB. Since the data is encrypted on the client side, the Azure Cosmos DB service is never provided with the decryption keys or the unencrypted data. You own, control, and manage the decryption keys. these keys are stored in Azure Key Vault, where you can apply policies to control what keys and secrets each client can access. 

## Always encrypted concepts

Always encrypted uses encryption keys and decryption policies.

### Encryption keys

***Data Encryption keys***

Always encrypted requires that you create data encryption keys (DEK) ahead of time. The DEKs are created at client-side using the Azure Comsos DB SDK. These DEKs are stored in the Azure Cosmos DB service. The DEKs are defined at the database level so they can be shared across multiple containers. Each DEK you create can be used to encrypt only one property, or can be used to encrypt many properties. You can have multiple DEKs per databases.

***Customer-managed keys***

A DEK must be wrapped by a customer-managed key (CMK) before it stored in Azure Cosmos DB. Since CMKs control the wrapping and unwrapping of the DEKs, they control the access to the data that is encrypted with those DEKs. CMK storage is designed as an extensible/plug-in model, with a default implementation that expects them to be stored in Azure Key Vault. The relationship between these components is displayed in the following diagram.

:::image type="content" source="../media/6-always-encrypted-cmk-dek.png" alt-text="Diagram that shows the always encrypted encryption keys and how are connected with Azure Cosmos DB.":::


### Encryption policy

Encryption policies are container-level specifications describing how the JSON properties should be encrypted. These policies are similar to indexing policies in structure. In the current release, you must create these policies at the container creation time and can't be updated once they're created. 

For each property that you want to encrypt, the encryption policy defines:

- The path of the property in the form of **/property**. Only top-level paths are currently supported, nested paths such as **/path/to/property** aren't supported.
- The *ID* of the *DEK* to use when encrypting and decrypting the property.
- An encryption type. It can be either *randomized* or *deterministic*.
- The encryption algorithm to use when encrypting the property. The specified algorithm can override the algorithm defined when creating the key if they're compatible.

You can't encrypt the ID or the container's partition key.

***Randomized vs. deterministic encryption***

Because the Azure Cosmos DB service might need to support some querying capabilities over the encrypted data, and it can't evaluate the data in plain text, Always Encrypted has more than one encryption type. The encryption types supported by Always Encrypted are:

- **Deterministic encryption**: It always generates the same encrypted value for any given plain text value and encryption configuration. Using deterministic encryption allows queries to do equality filters on encrypted properties. However, it may allow attackers to guess information about encrypted values by examining patterns in the encrypted property. This is especially true if there's a small set of possible encrypted values, such as True/False, or North/South/East/West region.

- **Randomized encryption**: It uses a method that encrypts data in a less predictable manner. Randomized encryption is more secure, but prevents queries from filtering on encrypted properties.

## Setting up and using Always Encrypted with Azure Cosmos DB

Setting up Always encrypted will be a multi-step process, from setting your CMK on the Azure Key Vault to creating your DEK and finally creating containers with the encryption policies.

### Setup Azure Key Vault

Before we create our CMK, we need to create a new or use an existing Azure Key Vault to store the CMK in.

1. In the Azure portal, follow the instructions to create a new Azure Key Vault or pick and existing one.
1. Under **Keys**, create a new Key.
1. Once the key is created, browse to its current version, and copy its full key identifier:
`https://<my-key-vault>.vault.azure.net/keys/<key>/<version>`. If you would like to always use the latest version of the key, just omit the key version at the end of the key identifier.

A Microsoft Entra identity will be needed to grant the Azure Cosmos DB SDK access to the Azure Key Vault instance. A Microsoft Entra application or a managed identity is commonly used as a proxy between the client code and the Azure Key Vault instance. To use an AD application as the proxy use these steps:

1. Create a new Microsoft Entra application and add a client secret as described in this [quickstart][/azure/active-directory/develop/quickstart-register-app].
1. In the Azure Key Vault instance, under **Access policies**, select **+ Add Access Policy** and add a new policy:
    1. In **Key permissions**, select **Get**, **List**, **Unwrap Key**, **Wrap Key**, **Verify, and **Sign**.
    1. In **Select principal**, search for the Microsoft Entra application you've created before.

[/azure/active-directory/develop/quickstart-register-app]: /azure/active-directory/develop/quickstart-register-app

### Initialize the SDK

To use Always Encrypted, an instance of an `EncryptionKeyStoreProvider` must be attached to your Azure Cosmos DB SDK instance. This object is used to interact with the key store hosting your CMKs. The default key store provider for Azure Key Vault is named `AzureKeyVaultKeyStoreProvider`. To use the `AzureKeyVaultKeyStoreProvider`, you'll need to add the `Microsoft.Data.Encryption.AzureKeyVaultProvider` package. 

The following snippets show how to use the identity of a Microsoft Entra application with a client secret.

```C#
var tokenCredential = new ClientSecretCredential(
    "<aad-app-tenant-id>", "<aad-app-client-id>", "<aad-app-secret>");
var keyStoreProvider = new AzureKeyVaultKeyStoreProvider(tokenCredential);
var client = new CosmosClient("<connection-string>")
    .WithEncryption(keyStoreProvider);
```

### Create a data encryption key

Once we created the CMK in the Azure Key Vault, it's time to create our DEK in the parent database. To create this DEK, we'll use the `CreateClientEncryptionKeyAsync` method and pass the following information:

- A string identifier that will uniquely identify the key in the database.
- The encryption algorithm intended to be used with the key. Only one algorithm is currently supported.
- The key identifier of the CMK stored in Azure Key Vault. This parameter is passed in a generic `EncryptionKeyWrapMetadata` object where the `name` can be any friendly name you want, and the `value` must be the key identifier.

The following snippets show how we create this DEK in .NET.

```C#
var database = client.GetDatabase("my-database");
await database.CreateClientEncryptionKeyAsync(
    "my-key",
    DataEncryptionKeyAlgorithm.AEAD_AES_256_CBC_HMAC_SHA256,
    new EncryptionKeyWrapMetadata(
        keyStoreProvider.ProviderName,
        "akvKey",
        "https://<my-key-vault>.vault.azure.net/keys/<key>/<version>"));
```

It's a good security practice to rotate your CMKs regularly. You should also rotate your CMK if you suspect that the current CMK has been compromised. Once the CMK is rotated, you provide that new CMK identifier for the DEK rewrapper to start using it. This operation doesn't affect the encryption of your data, but the protection of the DEK. Review the following script that rewraps the new CMK to the DEK:

```C#
await database.RewrapClientEncryptionKeyAsync(
    "my-key",
    new EncryptionKeyWrapMetadata(
        keyStoreProvider.ProviderName,
        "akvKey",
        " https://<my-key-vault>.vault.azure.net/keys/<new-key>/<version>"));
```

### Create a container with encryption policy

Now that we've configured both the CMK and DEK, it's time to create a new container using the .NET SDK. The following snippets show how we create the container `my-container` using the DEK `my-key` created in the previous example.  This container will have two-encryption policy on properties, `property1` and, `property2` and a partition key `partition-key`. Both properties will use the `my-key` DEK, but one will use encryption type *deterministic*, while the other will use *randomized*.

```C#
var path1 = new ClientEncryptionIncludedPath
{
    Path = "/property1",
    ClientEncryptionKeyId = "my-key",
    EncryptionType = EncryptionType.Deterministic.ToString(),
    EncryptionAlgorithm = DataEncryptionKeyAlgorithm.AEAD_AES_256_CBC_HMAC_SHA256.ToString()
};
var path2 = new ClientEncryptionIncludedPath
{
    Path = "/property2",
    ClientEncryptionKeyId = "my-key",
    EncryptionType = EncryptionType.Randomized.ToString(),
    EncryptionAlgorithm = DataEncryptionKeyAlgorithm.AEAD_AES_256_CBC_HMAC_SHA256.ToString()
};
await database.DefineContainer("my-container", "/partition-key")
    .WithClientEncryptionPolicy()
    .WithIncludedPath(path1)
    .WithIncludedPath(path2)
    .Attach()
    .CreateAsync();
```
## Write encrypted data

When an Azure Cosmos DB document is written, the SDK evaluates the encryption policies to determine if any properties need to be encrypted and how to encrypt them. If a property needs to be encrypted, it creates a base 64 string in place of the original text.

**Encryption of complex types**

- When the property to encrypt is a JSON array, every entry of the array is encrypted.
- When the property to encrypt is a JSON object, only the leaf values of the object get encrypted. The intermediate subproperty names remain in plain text form.

## Read encrypted items

If you're fetching a single item by `ID` and partition key, running queries, or reading the change feed, no extra steps will be required to decrypt the encrypted properties. This is because the SDK figures out which properties need to be decrypted by looking up the encryption policy.

### Filter queries on encrypted properties

The `AddParameterAsync` method passes the value of the query parameter used in queries that filter on encrypted properties. This method takes the following arguments:

- The name of the query parameter.
- The value to use in the query.
- The path of the encrypted property (as defined in the encryption policy).

We can see an example that uses the `AddParameterAsync` below: 

```C#
var queryDefinition = container.CreateQueryDefinition(
    "SELECT * FROM c where c.property1 = @Property1");
await queryDefinition.AddParameterAsync(
    "@Property1",
    1234,
    "/property1");
```

Encrypted properties can only be used in equality filters (`WHERE c.property = @Value`). Any other usage will return unpredictable and wrong query results.

### Reading documents when only a subset of properties can be decrypted

Different document properties in the same container can use different encryption policies. Each policy can use different CMKs to encrypt the properties. If your client has access to some of the CMKs used to decrypt some of the properties, but not access to other CMKs to decrypt other properties, you can still partially query the documents with the properties you can decrypt. You should just remove those properties from your queries, which you don't have access to their CMKs. For example, if `property1` was encrypted with `key1` and `property2` was encrypted with `key2`, and your app only has access to `key1`, your query should ignore `property2`. This query could look like, `SELECT c.property1, c.property3 FROM c`.
