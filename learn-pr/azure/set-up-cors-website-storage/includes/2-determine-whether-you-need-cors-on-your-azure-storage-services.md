Using Cross-Origin Resource Sharing (CORS) with Azure Storage imposes a series of requirements on the configuration. It helps to understand how CORS works, and what its requirements are, in order to configure CORS effectively. 

In the utilities company scenario, many of the job specifications documents for your company are kept in Azure Storage. Your company would like your development team to implement CORS rules in order to enable access to its resources that are maintained in Azure Storage from another website.

In this unit, you'll learn more about how CORS requests are handled and how CORS rules are validated.

## CORS requests

A CORS request from an origin domain may consist of one or more from the following request types:

| Request Type | Description |
|---|---|
| Simple Request | Simple requests do not require a preflight request, but they must meet a specific set of criteria:<ul><li>The HTTP verb must be GET, HEAD, or POST</li><li>The `Content-Type`, if specified, must be `application/x-www-form-urlencoded`, `multipart/form-data`, or `text/plain`</li><li>Only CORS safe-listed headers are used</li></ul> |
| Preflight Request | Preflight requests query the CORS restrictions for the service, and a preflight request is required unless is a simple request. The preflight request includes the HTTP OPTIONS verb, your proposed request method, the origin domain, and additional HTTP headers for CORS; these are evaluated against the resource to see if the request would be allowed.<ul><li>If the preflight request is accepted and an **HTTP 200 OK** response is returned to the client, then the client will send an actual request for a resource.</li><li>If the preflight request is NOT accepted and an **HTTP 403 Forbidden** response is returned to the client, then a request for a resource will be refused.</li></ul> |
| Actual Request | An actual request in a CORS transaction is handled as a normal HTTP request for a resource. The request includes an `Origin` header that indicates the original source of the request. When the Azure Storage Service receives an actual request, it will check the CORS rules that have been set and do one of the following:<ul><li>If a rule matches, then ACCESS-CONTROL headers are added to any response</li><li>If no rule matches, then ACCESS-CONTROL headers are not returned</li></ul> |

## CORS rules

CORS rules are configured at the service level, so you need to enable or disable CORS separately for each Azure Storage service: Blob, File, Queue, and Table. By default, CORS is disabled for each service. To enable CORS, you need to set the appropriate service properties through the use of CORS rules.

The following code block shows an example of what a CORS rule might look like.

```XML
<Cors>
   <CorsRule>  
      <AllowedOrigins>http://www.contoso.com, http://www.fabrikam.com</AllowedOrigins>  
      <AllowedMethods>PUT,GET</AllowedMethods>  
      <AllowedHeaders>x-ms-meta-data*,x-ms-meta-target*,x-ms-meta-abc</AllowedHeaders>  
      <ExposedHeaders>x-ms-meta-*</ExposedHeaders>  
      <MaxAgeInSeconds>200</MaxAgeInSeconds>  
   </CorsRule>  
<Cors>
```

Each element included in the example CORS rule is described below:

| Element | Description |
|---|---|
| `AllowedOrigins` | Specifies the list of origin domains that can send CORS requests.<ul><li>An *origin domain* is the originating domain for a CORS request, and the domain in the `AllowedOrigins` element must be an exact, case-sensitive match with the origin that is sent to the service.</li><li>You can use the wildcard character '*' to allow all origin domains to send CORS requests.</li></ul> |
| `AllowedMethods` | Specifies the list of methods (HTTP request verbs) that the origin domain can use for a CORS request. In the example above, only PUT and GET requests are permitted. |
| `AllowedHeaders` | Specifies the list of HTTP request headers that the origin domain can specify in the CORS request. In the above example:<ul><li>All metadata headers starting with `x-ms-meta-data` or `x-ms-meta-target` are permitted, and the `x-ms-meta-abc` header is permitted.</li><li>The wildcard character '*' indicates that any header beginning with the specified prefix is allowed.</li></ul>  |
| `ExposedHeaders` | Specifies the list of HTTP response headers that can be sent in the response to the CORS request and exposed by the browser to the client who originated the request. In the example above, the originating client will receive any header beginning with `x-ms-meta`. |
| `MaxAgeInSeconds` | Specifies the maximum amount of time that the originating client will cache the preflight OPTIONS request. |

## Limitations of CORS rules

Azure Storage mandates the following conditions for CORS rules:

- There is a maximum of five CORS rules per Azure Storage service (Blob, File, Table, and Queue).
- The maximum size of all CORS rules for a request should be less than 2 KB.
- The length of the allowed header or exposed header and the allowed origin should be 256 characters or less.
- The HTTP verbs specified in `AllowedMethods` must be one of the following methods that are supported by Azure Storage service APIs: GET, HEAD, MERGE, DELETE, POST, OPTIONS, and PUT.
