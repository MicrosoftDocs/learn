When you create your shared access signature (SAS), a uniform resource identifier (URI) is created by using parameters and tokens. The URI consists of your Azure Storage resource URI and the SAS token.

:::image type="content" source="../media/secure-parameters-76db5bda.png" alt-text="Storage Resource and the S A S Token combine to form the U R I.":::

### Things to know about URI definitions

Let's look at an example URI definition and examine the parameters. This example creates a service-level SAS that grants read and write permissions to a blob. Consider how you might configure the parameters to support your Azure Storage resources.

```URI
https://myaccount.blob.core.windows.net/?restype=service&comp=properties&sv=2015-04-05&ss=bf&st=2015-04-29T22%3A18%3A26Z&se=2015-04-30T02%3A23%3A26Z&sr=b&sp=rw&sip=168.1.5.60-168.1.5.70&spr=https&sig=F%6GRVAZ5Cdj2Pw4tgU7IlSTkWgn7bUkkAg8P6HESXwmf%4B
```

| Parameter | Example | Description |
| --- | --- | --- |
| **Resource URI** | `https://myaccount.`**`blob`**`.core.windows.net/` `?restype=`**`service`** `&amp;comp=properties` | Defines the Azure Storage endpoint and other parameters. This example defines an endpoint for Blob Storage and indicates that the SAS applies to service-level operations. When the URI is used with `GET`, the Storage properties are retrieved. When the URI is used with `SET`, the Storage properties are configured. |
| **Storage version** | **`sv`**`=2015-04-05` | For Azure Storage version 2012-02-12 and later, this parameter indicates the version to use. This example indicates that version 2015-04-05 (April 5, 2015) should be used. |
| **Storage service** | **`ss`**`=bf` | Specifies the Azure Storage to which the SAS applies. This example indicates that the SAS applies to Blob Storage and Azure Files. |
| **Start time** | **`st`**`=2015-04-29T22%3A18%3A26Z` | (Optional) Specifies the start time for the SAS in UTC time. This example sets the start time as April 29, 2015 22:18:26 UTC. If you want the SAS to be valid immediately, omit the start time. |
| **Expiry time** | **`se`**`=2015-04-30T02%3A23%3A26Z` | Specifies the expiration time for the SAS in UTC time. This example sets the expiry time as April 30, 2015 02:23:26 UTC. |
| **Resource** | **`sr`**`=b` | Specifies which resources are accessible via the SAS. This example specifies that the accessible resource is in Blob Storage. |
| **Permissions** | **`sp`**`=rw` | Lists the permissions to grant. This example grants access to read and write operations. |
| **IP range** | **`sip`**`=168.1.5.60-168.1.5.70` | Specifies a range of IP addresses from which a request is accepted. This example defines the IP address range 168.1.5.60 through 168.1.5.70.|
| **Protocol** | **`spr`**`=https` | Specifies the protocols from which Azure Storage accepts the SAS. This example indicates that only requests by using HTTPS are accepted. |
| **Signature** | **`sig`**`=F%6GRVAZ5Cdj2Pw4tgU7Il` `STkWgn7bUkkAg8P6HESXwmf%4B` | Specifies that access to the resource is authenticated by using a Hash-Based Message Authentication Code (HMAC) signature. The signature is computed with a key using the SHA256 algorithm, and encoded by using Base64 encoding. |