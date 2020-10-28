You can enable or disable CORS using the Azure REST API, and Azure Storage Services provides a secure way for clients to manage their services and access your Azure Storage Services resources.

In the utilities company scenario, some of your company's document resources are located in Blob storage. You've been asked to set up CORS rules to restrict access to these resources to requests from specific domains. You'll use the REST API to do this.

You configure CORS rules individually for each of the Azure storage services by using the following REST APIs: `Set Blob Service Properties`, `Set File Service Properties`, `Set Queue Service Properties`, and `Set Table Service Properties`. Once you've configured the rules for a storage service, when that service receives a properly authenticated CORS request, the service will evaluate the request to determine whether it is allowed according to the CORS rules you have set.

In this unit, you will learn about the REST commands and the parameters that are required to configure CORS.

## The Set Blob Service Properties request

You configure CORS for Azure storage by sending an HTTP PUT request that contains the requisite parameters for the Azure Storage REST API. For example, the following URL shows the format for this type of request:

```
https://<account-name>.blob.core.windows.net/?restype=service&comp=properties
```

## Request headers

The REST API PUT request requires you to provide security information in the HTTP request headers. These headers are:

| HTTP Header | Description |
|---|---|
| `Authorization` | Specifies the authentication scheme, storage account name, and signature. |
| `Date` or `x-ms-date` | Specifies the Coordinated Universal Time (UTC) for the request. |
| `x-ms-version` | Specifies the version of the operation to use for this request; this header is required for all authenticated requests. |
| `x-ms-client-request-id` | This header is optional. It provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled. Using this header is highly recommended for correlating client-side activities with requests received by the server.

## The request body

The request body contains an XML document containing the data for the request. The body includes a `<Cors>` element that describes the CORS rule being added. The following code shows the structure of this element:  

```XML
<?xml version="1.0" encoding="utf-8"?>  
<StorageServiceProperties>
    <Cors>  
        <CorsRule>  
            <AllowedOrigins>comma-separated-list-of-allowed-origins</AllowedOrigins>
            <AllowedMethods>comma-separated-list-of-HTTP-verbs</AllowedMethods>  
            <MaxAgeInSeconds>max-caching-age-in-seconds</MaxAgeInSeconds>  
            <ExposedHeaders>comma-separated-list-of-response-headers</ExposedHeaders>  
            <AllowedHeaders>comma-separated-list-of-request-headers</AllowedHeaders>
        </CorsRule>  
    </Cors> 
</StorageServiceProperties>
```

The XML document in the request body contains the following elements:

| Element | Description |
|---|---|
| `Cors` | Contains all of your CORS rules. |
| `CorsRule` | Specifies a single CORS rule for a storage service.<ul><li>You can include up to five `CorsRule` elements in the request.</li><li>If no `CorsRule` elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the blob service.</li></ul> |
| `AllowedOrigins` | Specifies a comma-separated list of origin domains that will be allowed via CORS, or "*" to allow all domains.<ul><li>This list is limited to 64 origin domains.</li><li>Each origin is limited to 256 characters.</li></ul> |
| `ExposedHeaders` | Specifies a comma-separated list of HTTP response headers to expose to CORS clients.<ul><li>This list is limited to 64 defined headers and two prefixed headers.</li><li>Each header is limited to 256 characters.</li></ul> |
| `MaxAgeInSeconds` | Specifies the number of seconds that a client or browser should cache a CORS preflight response. |
| `AllowedHeaders` | Specifies a comma-separated list of headers allowed to be part of the CORS request.<ul><li>This list is limited to 64 defined headers and two prefixed headers.</li><li>Each header is limited to 256 characters.</li></ul> |
| `AllowedMethods` | Specifies a comma-separated list of HTTP methods that the origin is permitted to use. For Azure Storage, the permitted methods are: DELETE, GET, HEAD, MERGE, PATCH, POST, OPTIONS, and PUT. |
  
As an example, the following CORS rule enables CORS for GET and PUT requests that are received from the domains www.fabrikam.com and www.contoso.com:

```XML
<Cors>  
    <CorsRule>  
        <AllowedOrigins>http://www.fabrikam.com,http://www.contoso.com</AllowedOrigins>  
        <AllowedMethods>GET,PUT</AllowedMethods>  
        <MaxAgeInSeconds>500</MaxAgeInSeconds>  
        <ExposedHeaders>x-ms-meta-data*,x-ms-meta-customheader</ExposedHeaders>  
        <AllowedHeaders>x-ms-meta-target*,x-ms-meta-customheader</AllowedHeaders>  
    </CorsRule>  
</Cors>
```

## The response

The response from the request includes a status code and a set of response headers. If successful, the request will return an **HTTP 202 Accepted** response, which includes the following headers:

| HTTP Header | Description |
|---|---|
| `x-ms-request-id` | This value uniquely identifies a request that was made against the service. |
| `x-ms-version` | This header specifies the version of the operation that was used for the response. |
