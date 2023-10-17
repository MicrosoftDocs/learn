

Every object you store in Azure Storage has a unique URL address. Your storage account name forms the _subdomain_ portion of the URL address. The combination of the subdomain and the domain name, which is specific to each service, forms an endpoint for your storage account. 

Let's look at an example. If your storage account name is *mystorageaccount*, default endpoints for your storage account are formed for the Azure services as shown in the following table:

| Service | Default endpoint |
| --- | --- |
| **Container service** | `//`**`mystorageaccount`**`.blob.core.windows.net` |
| **Table service** | `//`**`mystorageaccount`**`.table.core.windows.net` |
| **Queue service** | `//`**`mystorageaccount`**`.queue.core.windows.net` |
| **File service** | `//`**`mystorageaccount`**`.file.core.windows.net` |

We create the URL to access an object in your storage account by appending the object's location in the storage account to the endpoint.

To access the *myblob* data in the *mycontainer* location in your storage account, we use the following URL address:

`//`**`mystorageaccount`**`.blob.core.windows.net/`**`mycontainer`**`/`**`myblob`**.

## Configure custom domains

You can configure a custom domain to access blob data in your Azure storage account. As we reviewed, the default endpoint for Azure Blob Storage is `\<storage-account-name>.blob.core.windows.net`. You can also use the web endpoint that's generated as a part of the static websites feature. If you map a custom domain and subdomain, such as `www.contoso.com`, to the blob or web endpoint for your storage account, your users can use that domain to access blob data in your storage account.

> [!NOTE]
> Azure Storage doesn't currently provide native support for HTTPS with custom domains. You can implement an Azure Content Delivery Network (CDN) to access blobs by using custom domains over HTTPS.

There are two ways to configure a custom domain: direct mapping and intermediary domain mapping.

- **Direct mapping** lets you enable a custom domain for a subdomain to an Azure storage account. For this approach, you create a `CNAME` record that points from the subdomain to the Azure storage account.

   The following example shows how a subdomain is mapped to an Azure storage account to create a `CNAME` record in the domain name system (DNS):

   - Subdomain: `blobs.contoso.com`
   - Azure storage account: `\<storage account>\.blob.core.windows.net`
   - Direct `CNAME` record: `contosoblobs.blob.core.windows.net`

- **Intermediary domain mapping** is applied to a domain that's already in use within Azure. This approach might result in minor downtime while the domain is being mapped. To avoid downtime, you can use the `asverify` intermediary domain to validate the domain. By prepending the `asverify` keyword to your own subdomain, you permit Azure to recognize your custom domain without modifying the DNS record for the domain. After you modify the DNS record for the domain, your domain is mapped to the blob endpoint with no downtime.

   The following example shows how a domain in use is mapped to an Azure storage account in the DNS with the `asverify` intermediary domain:

   - `CNAME` record: **`asverify`**`.blobs.contoso.com`
   - Intermediate `CNAME` record: **`asverify`**`.contosoblobs.blob.core.windows.net`


   [Learn more about intermediary domain mapping](/azure/storage/blobs/storage-custom-domain-name?tabs=azure-portal)