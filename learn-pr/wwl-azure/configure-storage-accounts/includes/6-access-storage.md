Every object that you store in Azure Storage has a unique URL address. The storage account name forms the subdomain of that address. The combination of subdomain and domain name, which is specific to each service, forms an endpoint for your storage account.

For example, if your storage account is named *mystorageaccount*, then the default endpoints for your storage account are:

 -  Container service: `//mystorageaccount.blob.core.windows.net`
 -  Table service: `//mystorageaccount.table.core.windows.net`
 -  Queue service: `//mystorageaccount.queue.core.windows.net`
 -  File service: `//mystorageaccount.file.core.windows.net`

The URL for accessing an object in a storage account is built by appending the object's location in the storage account to the endpoint. For example, to access *myblob* in the *mycontainer*, use this format: `//mystorageaccount.blob.core.windows.net/mycontainer/myblob`.

## Configure a custom domain

You can configure a custom domain for accessing blob data in your Azure storage account. As mentioned previously, the default endpoint for Azure Blob storage is &lt;storage-account-name&gt;.blob.core.windows.net. You can also use the web endpoint that's generated as a part of the static websites feature. If you map a custom domain and subdomain, such as www.contoso.com, to the blob or web endpoint for your storage account, your users can use that domain to access blob data in your storage account. There are two ways to configure this service: Direct CNAME mapping and an intermediary domain.

> [!NOTE]
> Azure Storage does not yet natively support HTTPS with custom domains. You can currently Use Azure CDN to access blobs by using custom domains over HTTPS.

**Direct CNAME mapping** for example, to enable a custom domain for the blobs.contoso.com sub domain to an Azure storage account, create a CNAME record that points from blobs.contoso.com to the Azure storage account \[storage account\].blob.core.windows.net. The following example maps a domain to an Azure storage account in DNS:

:::row:::
  :::column:::
    **CNAME record**
  :::column-end:::
  :::column:::
    **Target**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    blobs.contoso.com
  :::column-end:::
  :::column:::
    contosoblobs.blob.core.windows.net
  :::column-end:::
:::row-end:::


**Intermediary mapping with *asverify*** Mapping a domain that is already in use within Azure may result in minor downtime as the domain is updated. To avoid downtime, you can use the asverify subdomain to validate the domain. By prepending asverify to your own subdomain, you permit Azure to recognize your custom domain without modifying the DNS record for the domain. After you modify the DNS record for the domain, it will be mapped to the blob endpoint with no downtime.

The following examples maps a domain to the Azure storage account in DNS with the asverify intermediary domain:

:::row:::
  :::column:::
    **CNAME record**
  :::column-end:::
  :::column:::
    **Target**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    asverify.blobs.contoso.com
  :::column-end:::
  :::column:::
    asverify.contosoblobs.blob.core.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    blobs.contoso.com
  :::column-end:::
  :::column:::
    contosoblobs.blob.core.windows.net
  :::column-end:::
:::row-end:::
