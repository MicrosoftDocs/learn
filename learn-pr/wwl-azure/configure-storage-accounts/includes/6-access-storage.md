Every object you store in Azure Storage has a unique URL address. Your storage account name forms the _subdomain_ portion of the URL address. The combination of the subdomain and the domain name, which is specific to each service, forms an endpoint for your storage account. 

Let's look at an example. If your storage account name is *mystorageaccount*, default endpoints for your storage account are formed for the Azure services as shown in the following table:

| Service | Default endpoint |
| --- | --- |
| **Container service** | `//`**`mystorageaccount`**`.blob.core.windows.net` |
| **Table service** | `//`**`mystorageaccount`**`.table.core.windows.net` |
| **Queue service** | `//`**`mystorageaccount`**`.queue.core.windows.net` |
| **File service** | `//`**`mystorageaccount`**`.file.core.windows.net` |

We create the URL to access an object in your storage account by appending the object's location in the storage account to the endpoint.

For example, to access the *myblob* data in the *mycontainer* location in your storage account, we use the following URL address:

`//`**`mystorageaccount`**`.blob.core.windows.net/`**`mycontainer`**`/`**`myblob`**.

## Configure custom domains

You can configure a [custom domain](/azure/storage/blobs/storage-custom-domain-name) to access blob data in your Azure storage account. As we reviewed, the default endpoint for Azure Blob Storage is `\<storage-account-name>.blob.core.windows.net`. If you map a custom domain and subdomain, such as `www.contoso.com`, to the blob or web endpoint for your storage account, your users can use that domain to access blob data in your storage account.

**Direct mapping** lets you enable a custom domain for a subdomain to an Azure storage account. For this approach, you create a `CNAME` record that points from the subdomain to the Azure storage account.

   The following example shows how a subdomain is mapped to an Azure storage account to create a `CNAME` record in the domain name system (DNS):

   - Subdomain: `blobs.contoso.com`
   - Azure storage account: `\<storage account>\.blob.core.windows.net`
   - Direct `CNAME` record: `contosoblobs.blob.core.windows.net`

:::image type="content" source="../media/custom-domains.png" alt-text="Image of the direct mapping for a custom domain.":::

