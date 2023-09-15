By using a shared access signature (SAS), you can delegate access to your resources. Clients don't have direct access to your storage account credentials and, at a granular level, you control what they access.

After you investigate all the authorization options, you decide to look at a SAS in more detail. You want to create and use a SAS in a C# .NET web app. You also want to follow Microsoft's best practices on when and how to use a SAS.

In this unit, you review how a SAS works at a technical level and what C# code you must write to use it.

## How shared access signatures work

A SAS has two components: a URI that points to one or more storage resources and a token that indicates how the client may access the resources.

In a single URI, such as `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D`, you can separate the URI from the SAS token as follows:

| URI  | SAS token  |
|------|------------|
| `https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg?`    | `sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D` |

The SAS token contains the following components, or query parameters.

| Query Parameter | Field Name | Example | Description |
|-----|---------|---------|---------|
| sp | signed permission | sp=r | Indicates one or more operations the client can perform. Values can be compounded: a (add), c (create), d (delete), l (list), r (read), and w (write). sp=r is read only; sp=acdlrw grants all the available rights. |
| st | start time | st=2020-01-20T11:42:32Z | The date and time when access starts. |
| se | expiry time | se=2020-01-20T19:42:32Z | The date and time when access ends. Based on the start date, this example grants eight hours of access. |
| spr | signed protocol | spr=https | The protocol permitted for a request made with the SAS. An optional field that has possible values of both HTTPS and HTTP (the default value), or HTTPS only. |
| sv | signed version | sv=2019-02-02 | The service version of the storage API to use. |
| sr | scope of resource| sr=b | The kind of storage being accessed. Available values include b (blob), c (container), d (directory), f (file), s (share) |
| sig | signature | sig=SrW1...wVZs%3D | The cryptographic signature. |

The signature is signed with your storage account key when you create a service or account shared access signature. If you use an Azure Active Directory (Azure AD) security principal with access to the storage, you create a user delegation shared access signature. You also grant the **Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey** action to the principal.

### Create a SAS in .NET

Because your company provides access to third parties, you can't use Azure AD to create service principals for each third party that requires access to medical images. Your app uses a storage account key for each individual file. The following steps show how to create a SAS using C# code.

#### Create a blob container client to connect to the storage account on Azure

```csharp
BlobContainerClient container = new BlobContainerClient( "ConnectionString", "Container" );
```

#### Retrieve the blob you want to create a SAS token for and create a BlobClient

```csharp
foreach (BlobItem blobItem in container.GetBlobs())
{
    BlobClient blob = container.GetBlobClient(blobItem.Name);
}
```

#### Create a BlobSasBuilder object for the blob you use to generate the SAS token

```csharp
BlobSasBuilder sas = new BlobSasBuilder
{
    BlobContainerName = blob.BlobContainerName,
    BlobName = blob.Name,
    Resource = "b",
    ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
};

// Allow read access
sas.SetPermissions(BlobSasPermissions.Read);
```

#### Authenticate a call to the ToSasQueryParameters method of the BlobSasBuilder object

```csharp
StorageSharedKeyCredential storageSharedKeyCredential = new StorageSharedKeyCredential( "AccountName", "AccountKey");

sasToken = sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
```

### Best practices

To reduce the potential risks of using a SAS, Microsoft provides some guidance:

- To securely distribute a SAS and help prevent man-in-the-middle attacks, always use HTTPS.
- The most secure SAS is user delegation. Use it wherever possible because it removes the need to store your storage account key in code. Azure AD must be used to manage credentials; this option might not be possible for your solution.
- Try to set your expiration time to the smallest useful value. If a SAS key becomes compromised, it can be exploited for only a short time.
- Apply the rule of minimum-required privileges. Only grant the access that's required. For example, in your app, read-only access is sufficient.
- There are some situations where a SAS isn't the correct solution. When there's an unacceptable risk of using a SAS, create a middle-tier service to manage users and their access to storage.

The most flexible and secure way to use a service or account SAS is to associate the SAS tokens with a stored access policy. In a later unit, you explore these benefits and how they work.
