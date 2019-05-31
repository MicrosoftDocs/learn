Certificates can be used to provide TLS mutual authentication between the client and the API gateway. You can configure the API Management gateway to allow only requests with certificates containing a specific thumbprint. The authorization at the gateway level is handled through inbound policies.

For your meteorological app, you have some customers who have client certificates issued by a certificate authority that you both trust. You want to allow those customers to authenticate by passing those certificates.

Here, you will learn how to configure API Management to accept client certificates.

## TLS Client Authentication

In a classic TLS handshake, the client authenticates the server that it is communicating with, by using a protocol known as TLS mutual authentication. However, for our example, we want the server to authenticate the request of the client, so you will be using TLS client authentication. This technique allows the API Management gateway to inspect the certificate contained within the client request and check for properties like:

| Property | Reason |
| -------- | ------ |
| **Certificate Authority (CA)** | Only allow certificates signed by a particular CA |
| **Thumbprint** | Allow certificates containing a specified thumbprint |
| **Subject** | Only allow certificates with a specified subject |
| **Expiration Date** | Only allow certificates that have not expired |
| | |

These properties are not mutually exclusive and they can be mixed together to form your own policy requirements. For instance, you can specify that the certificate passed in the request is signed by a certain certificate authority and hasn't expired.
 
## Certificate Authorization Policies

Create these policies in the inbound processing policy file within the API Management gateway:

![Inbound processing policy button](../media/5-inbound-policy.png)

**Check thumbprint of client certificate**

The following example checks the thumbprint of the certificate passed in the request:

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Thumbprint != "desired-thumbprint")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```

**Check issuer and S=subject of client certificate**

This example checks the issuer and subject of the certificate passed in the request:

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Issuer != "trusted-issuer" || context.Request.Certificate.SubjectName.Name != "expected-subject-name")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```