Key Vault certificates support provides for management of your x509 certificates.

- A certificate owner to create a certificate through a Key Vault creation process or through the import of an existing certificate. Includes both self-signed and CA-generated certificates.

- A Key Vault certificate owner to implement secure storage and management of X509 certificates without interaction with private key material.

- A certificate owner to create a policy that directs Key Vault to manage the life-cycle of a certificate.

- Certificate owners to provide contact information for notification about lifecycle events of expiration and renewal of certificate.

- Automatic renewal with selected issuers - Key Vault partner X509 certificate providers and CAs.

When a Key Vault certificate is created, an addressable key and secret are also created with the same name. The Key Vault key allows key operations and the Key Vault secret allows retrieval of the certificate value as a secret. A Key Vault certificate also contains public x509 certificate metadata.

The identifier and version of certificates is similar to that of keys and secrets. A specific version of an addressable key and secret created with the Key Vault certificate version is available in the Key Vault certificate response.

![A diagram starts with an application, which points to the Key Vault REST API, and then to the three resources that make up the certificate. ](../media/M4-certificates-key-vault.png)

When a Key Vault certificate is created, it can be retrieved from the addressable secret with the private key in either PFX or PEM format. However, the policy used to create the certificate must indicate that the key is exportable. If the policy indicates non-exportable, then the private key isn't a part of the value when retrieved as a secret.

The addressable key becomes more relevant with non-exportable Key Vault certificates. The addressable Key Vault key’s operations are mapped from the keyusage field of the Key Vault certificate policy used to create the Key Vault certificate. If a Key Vault certificate expires, it’s addressable key and secret become inoperable.

Two types of key are supported – RSA or RSA HSM with certificates. Exportable is only allowed with RSA, and is not supported by RSA HSM.

### Certificate policy

A certificate policy contains information on how to create and manage the Key Vault certificate lifecycle. When a certificate with private key is imported into the Key Vault, a default policy is created by reading the x509 certificate.

When a Key Vault certificate is created from scratch, a policy needs to be supplied. This policy specifies how to create the Key Vault certificate version, or the next Key Vault certificate version. After a policy has been established, it’s not required with successive create operations for future versions. There's only one instance of a policy for all the versions of a Key Vault certificate.

At a high level, a certificate policy contains the following information:

* X509 certificate properties. Contains subject name, subject alternate names, and other properties used to create an x509 certificate request.

* Key Properties. Contains key type, key length, exportable, and reuse key fields. These fields instruct key vault on how to generate a key.

* Secret properties. Contains secret properties such as content type of addressable secret to generate the secret value, for retrieving certificate as a secret.

* Lifetime Actions. Contains lifetime actions for the Key Vault certificate. Each lifetime action contains:

    - Trigger, which specifies via days before expiry or lifetime span percentage.

    - Action, which specifies the action type: emailContacts, or autoRenew.

* Issuer: Contains the parameters about the certificate issuer to use to issue x509 certificates.

* Policy attributes: Contains attributes associated with the policy.

### Certificate Issuer

Before you can create a certificate issuer in a Key Vault, the following two prerequisite steps must be completed successfully:

1. Onboard to CA providers:

    * An organization administrator must onboard their company with at least one CA provider.

2. Admin creates requester credentials for Key Vault to enroll (and renew) SSL certificates:

    * Provides the configuration to be used to create an issuer object of the provider in the key vault.

### Certificate contacts

Certificate contacts contain contact information to send notifications triggered by certificate lifetime events. The contacts information is shared by all the certificates in the key vault. A notification is sent to all the specified contacts for an event for any certificate in the key vault.

If a certificate's policy is set to auto renewal, then a notification is sent for the following events:

* Before certificate renewal

* After certificate renewal, and stating if the certificate was successfully renewed, or if there was an error, requiring manual renewal of the certificate

* When it’s time to renew a certificate for a certificate policy that is set to manually renew (email only)

### Certificate access control

The Key Vault that contains certificates manages access control for those same certificates. The access control policy for certificates is distinct from the access control policies for keys and secrets in the same Key Vault. Users might create one or more vaults to hold certificates, to maintain scenario appropriate segmentation and management of certificates.

The following permissions closely mirror the operations allowed on a secret object, and can be used on a per-principal basis in the secrets access control entry on a key vault:

* Permissions for certificate management operations:

    - get: Get the current certificate version, or any version of a certificate.

    - list: List the current certificates, or versions of a certificate.

    - update: Update a certificate.

    - create: Create a Key Vault certificate.

    - import: Import certificate material into a Key Vault certificate.

    - delete: Delete a certificate, its policy, and all of its versions.

    - recover: Recover a deleted certificate.

    - backup: Back up a certificate in a key vault.

    - restore: Restore a backed-up certificate to a key vault.

    - managecontacts: Manage Key Vault certificate contacts.

    - manageissuers: Manage Key Vault certificate authorities/issuers.

    - getissuers: Get a certificate's authorities/issuers.

    - listissuers: List a certificate's authorities/issuers.

    - setissuers: Create or update a Key Vault certificate's authorities/issuers.

    - deleteissuers: Delete a Key Vault certificate's authorities/issuers.

* Permissions for privileged operations:

    - purge: Purge (permanently delete) a deleted certificate.

For more information, see [Azure Key Vault REST API](https://docs.microsoft.com/rest/api/keyvault).

For information on establishing permissions, see: 

* [Vaults - Create Or Update](https://docs.microsoft.com/rest/api/keyvault/vaults/createorupdate)

* [Vaults - Update Access Policy](https://docs.microsoft.com/rest/api/keyvault/vaults/updateaccesspolicy) 
 
‎### Set and retrieve a secret from Azure Key Vault using the Azure portal

### Lab

In this lab, you create a key vault, then use it to store a secret.

1. Sign in to the Azure Portal.
1. Select the **Create a resource** option on the upper left-hand corner of the Azure portal.

![Screen shot of portal search box](../media/M04-L07-04-search-services.png)

1. In the Search box, enter **Key Vault**.
1. From the results list, choose **Key Vault**.
1. On the Key Vault section, choose **Create**.
1. On the Create key vault section provide the following information:
   * **Name** - A unique name is required. For this lab we use **Contoso-vault2**.
   * **Subscription** - Choose a subscription.
   * Under **Resource Group** choose **Create new** and enter a resource group name.
   * In the **Location** pull-down menu, choose a location.
   * Leave the other options to their defaults.
1. After providing the information above, select **Create**.

Take note of the two properties listed below:
* **Vault Name** - In the example, this is Contoso-Vault2. You will use this name for other steps.
* **Vault URI** - In the example, this is https://contoso-vault2.vault.azure.net/. Applications that use your vault through its REST API must use this URI.

At this point, your Azure account is the only one authorized to perform operations on this new vault.
![Screen shot of create Key Vault screen](../media/M04-L07-04-vault-properties.png)

### Add a secret to Key Vault

To add a secret to the vault, you just need to take a couple of additional steps. In this case, we add a password that could be used by an application. The password is called **ExamplePassword** and we store the value of **hVFkk965BuUv** in it.
1. On the Key Vault properties pages select **Secrets**.
1. Click on **Generate/Import**.
1. On the **Create a secret** screen choose the following values:
    * **Upload options**: Manual.
    * **Name**: ExamplePassword.
    * **Value**: hVFkk965BuUv
    * Leave the other values to their defaults. Click **Create**.

Once that you receive the message that the secret has been successfully created, you may click on it on the list. You can then see some of the properties. If you click on the current version, you can see the value you specified in the previous step.

![Screen shot of the create secret page](../media/M04-L07-04-current-version-hidden.png)

By clicking "Show Secret Value" button in the right pane, you can see the hidden value.

![Screen shot of the show secret button on create secret page](../media/M04-L07-04-current-version-shown.png)

When no longer needed, delete the resource group, which deletes the Key Vault and related resources. To delete the resource group through the portal:
1. Enter the name of your resource group in the Search box at the top of the portal. When you see the resource group used in this quickstart in the search results, select it.
1. Select **Delete resource group**.
1. In the **TYPE THE RESOURCE GROUP NAME**: box type in the name of the resource group and select **Delete**.
