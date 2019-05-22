Certicates can be used to provide TLS mutual authentication between the client and the API gateway. The API Management gateway can be configured to only allow requests with certificates containg a specific thumbprint. The authorisation at the gateway level is handled through inbound policies.

## TLS Client Authentication

In a classic TLS handshake, the client authenticates the server that it is communicating with, using a protocol known as TLS mutual authentication. However, for our example we want the Server to authenticate the request of the client, so you will be using TLS client authentication. This allows the API Management gateway to inspect the certificate contained within the client request and check for properties like:

|Property|Reason|
|--------|------|
|**Certificate Authority (CA)**|Only allow certificates signed by a particular CA|
|**Thumbprint**|Allow certificates containing a specified thumbprint|
|**Subject**|Only allow certificates with a specified subject|
|**Expiration Date**|Only allow certificates that have not expired|

These properties are NOT mutually exclusive and they can mixed together to form your own policy requirements. For instance, you can specify that the certificate passed in the request is Signed by a certain CA and hasn't expired
 
## Certificate Authorization Policies

The creation of theses policies are handled within the inbound processing policy file within the API Management gateway

![Screenshot showing inbound processing policy button](../media/5-inbound-policy.png)

**Check Thumbprint of client certificate**

The following example checks the thumbprint of the certificate passed in the request

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Thumbprint != "desired-thumbprint")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```

**Check Issuer and Subject of client certificate**

This example checks the issuer and subject of the certificate passed in the request

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Issuer != "trusted-issuer" || context.Request.Certificate.SubjectName.Name != "expected-subject-name")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```