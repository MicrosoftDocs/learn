Azure Storage provides a REST API to work with the containers and data stored in each account. Each type of data you can store has its own independent API. Recall that we have four specific data types:

- **Blobs** for unstructured data such as binary and text files.
- **Queues** for persistent messaging.
- **Tables** for structured storage of key/values.
- **Files** for traditional SMB file shares.

## Use the REST API

The Storage REST APIs are accessible from anywhere on the Internet by any app that can send an HTTP/HTTPS request and receive an HTTP/HTTPS response.

For example, if you wanted to list all the blobs in a container, you'd create a request something like:

```http
GET https://[url-for-service-account]/?comp=list&include=metadata
```

This request returns an XML block with data specific to the account:

```xml
<?xml version="1.0" encoding="utf-8"?>  
<EnumerationResults AccountName="https://[url-for-service-account]/">  
  <Containers>  
    <Container>  
      <Name>container1</Name>  
      <Url>https://[url-for-service-account]/container1</Url>  
      <Properties>  
        <Last-Modified>Sun, 24 Sep 2018 18:09:03 GMT</Last-Modified>  
        <Etag>0x8CAE7D0C4AF4487</Etag>  
      </Properties>  
      <Metadata>  
        <Color>orange</Color>  
        <ContainerNumber>01</ContainerNumber>  
        <SomeMetadataName>SomeMetadataValue</SomeMetadataName>  
      </Metadata>  
    </Container>  
    <Container>  
      <Name>container2</Name>  
      <Url>https://[url-for-service-account]/container2</Url>  
      <Properties>  
        <Last-Modified>Sun, 24 Sep 2018 17:26:40 GMT</Last-Modified>  
        <Etag>0x8CAE7CAD8C24928</Etag>  
      </Properties>  
      <Metadata>  
        <Color>pink</Color>  
        <ContainerNumber>02</ContainerNumber>  
        <SomeMetadataName>SomeMetadataValue</SomeMetadataName>  
      </Metadata>  
    </Container>  
    <Container>  
      <Name>container3</Name>  
      <Url>https://[url-for-service-account]/container3</Url>  
      <Properties>  
        <Last-Modified>Sun, 24 Sep 2018 17:26:40 GMT</Last-Modified>  
        <Etag>0x8CAE7CAD8EAC0BB</Etag>  
      </Properties>  
      <Metadata>  
        <Color>brown</Color>  
        <ContainerNumber>03</ContainerNumber>  
        <SomeMetadataName>SomeMetadataValue</SomeMetadataName>  
      </Metadata>  
    </Container>  
  </Containers>  
  <NextMarker>container4</NextMarker>  
</EnumerationResults>  
```

However, this approach requires manual parsing and creating HTTP packets to work with each API. For this reason, Azure provides pre-built _client libraries_ that make working with the service easier for common languages and frameworks.

## Use a client library

Client libraries can save a significant amount of work for app developers because the API has been tested and often provides nicer wrappers around the data models sent and received by the REST API.

:::row:::  
    :::column:::  
    Microsoft has Azure client libraries that support many languages and frameworks, including:
    - .NET
    - Java
    - Python
    - Node.js
    - Go
    :::column-end:::
    :::column:::
        <br> ![Logos of supported frameworks you can use with Azure.](../media/4-common-tools.png)
    :::column-end:::  
:::row-end:::  

For example, to retrieve the same list of blobs in C#, we could use the following code snippet:

```csharp
string containerName = "...";
BlobContainerClient container = new BlobContainerClient(connectionString, containerName);

var blobs = container.GetBlobs();
foreach (var blob in blobs)
{
    Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:YYYY-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
}
```

Or in JavaScript:

```javascript
const containerName = '...';
const containerClient = blobServiceClient.getContainerClient(containerName);

let blobs = containerClient.listBlobsFlat();
for await (const blob of blobs) {
  console.log(`${blob.name} --> Created: ${blob.properties.createdOn}   Size: ${blob.properties.contentLength}`);
}
```

> [!NOTE]
> The client libraries are just thin _wrappers_ around the REST API. They're doing exactly what you would do if you used the web services directly. These libraries are also open source, making them very transparent. For links to these libraries' source code on GitHub, see the _Additional Resources_ section at the end of this module.

Next, let's add client library support to your app.
