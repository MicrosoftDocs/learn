When you create your SAS, a URI is created using parameters and tokens. The URI consists of your Storage Resource URI and the SAS token.

:::image type="content" source="../media/secure-parameters-76db5bda.png" alt-text="Storage Resource and the SAS Token combine to form the URI.":::


Below is an example URI.

```
https://myaccount.blob.core.windows.net/?restype=service&comp=properties&sv=2015-04-05&ss=bf&srt=s&st=2015-04-29T22%3A18%3A26Z&se=2015-04-30T02%3A23%3A26Z&sr=b&sp=rw&sip=168.1.5.60-168.1.5.70&spr=https &sig=F%6GRVAZ5Cdj2Pw4txxxxx

```

Each parameter has a specific meaning.

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **SAS portion**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource URI
  :::column-end:::
  :::column:::
    https://myaccount.blob.core.windows.net/?restype=service&amp;comp=properties
  :::column-end:::
  :::column:::
    The Blob service endpoint, with parameters for getting service properties (when called with GET) or setting service properties (when called with SET).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage services version
  :::column-end:::
  :::column:::
    sv=2015-04-05
  :::column-end:::
  :::column:::
    For storage services version 2012-02-12 and later, this parameter indicates the version to use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Services
  :::column-end:::
  :::column:::
    ss=bf
  :::column-end:::
  :::column:::
    The SAS applies to the Blob and File services
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource types
  :::column-end:::
  :::column:::
    srt=s
  :::column-end:::
  :::column:::
    The SAS applies to service-level operations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Start time
  :::column-end:::
  :::column:::
    st=2015-04-29T22%3A18%3A26Z
  :::column-end:::
  :::column:::
    Specified in UTC time. If you want the SAS to be valid immediately, omit the start time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Expiry time
  :::column-end:::
  :::column:::
    se=2015-04-30T02%3A23%3A26Z
  :::column-end:::
  :::column:::
    Specified in UTC time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource
  :::column-end:::
  :::column:::
    sr=b
  :::column-end:::
  :::column:::
    The resource is a blob.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Permissions
  :::column-end:::
  :::column:::
    sp=rw
  :::column-end:::
  :::column:::
    The permissions grant access to read and write operations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IP Range
  :::column-end:::
  :::column:::
    sip=168.1.5.60-168.1.5.70
  :::column-end:::
  :::column:::
    The range of IP addresses from which a request will be accepted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Protocol
  :::column-end:::
  :::column:::
    spr=https
  :::column-end:::
  :::column:::
    Only requests using HTTPS are permitted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Signature
  :::column-end:::
  :::column:::
    sig=F%6GRVAZ5Cdj2Pw4tgU7IlSTkWgn7bUkkAg8P6HESXwmf%4B
  :::column-end:::
  :::column:::
    Used to authenticate access to the blob. The signature is an HMAC computed over a string-to-sign and key using the SHA256 algorithm, and then encoded using Base64 encoding.
  :::column-end:::
:::row-end:::
