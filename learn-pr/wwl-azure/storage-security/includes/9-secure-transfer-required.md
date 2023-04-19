
You can configure your storage account to accept requests from secure connections only by setting the Secure transfer required property for the storage account. When you require secure transfer, any requests originating from an insecure connection are rejected. Microsoft recommends that you always require secure transfer for all of your storage accounts.

When secure transfer is required, a call to an Azure Storage REST API operation must be made over HTTPS. Any request made over HTTP is rejected.

Connecting to an Azure File share over SMB without encryption fails when secure transfer is required for the storage account. Examples of insecure connections include those made over SMB 2.1, SMB 3.0 without encryption, or some versions of the Linux SMB client.

**By default, the Secure transfer required property is enabled when you create a storage account**. Azure Storage doesn't support HTTPS for **custom domain names**, this option is not applied when you're using a custom domain name.

### Require secure transfer for a new storage account

:::image type="content" source="../media/az500-secure-transfer-c6388d7d.png" alt-text="Screenshot of the create a storage account page with secure transfer selection.":::


> [!IMPORTANT]
> Azure Files connections require encryption (SMB)
