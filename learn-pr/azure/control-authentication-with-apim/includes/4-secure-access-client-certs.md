Certificates can be used to provide TLS mutual authentication between the client and the API gateway. You can configure the API Management gateway to allow only requests with certificates containing a specific thumbprint. The authorization at the gateway level is handled through inbound policies.

For your meteorological app, you have some customers who have client certificates issued by a certificate authority (CA) that you both trust. You want to allow those customers to authenticate by passing those certificates.

Here, you'll learn how to configure API Management to accept client certificates.

## TLS client authentication

With TLS client authentication, the API Management gateway can inspect the certificate contained within the client request and check for properties like:

| Property | Reason |
| -------- | ------ |
| **Certificate Authority (CA)** | Only allow certificates signed by a particular CA. |
| **Thumbprint** | Allow certificates containing a specified thumbprint. |
| **Subject** | Only allow certificates with a specified subject. |
| **Expiration Date** | Only allow certificates that haven't expired. |
| | |

These properties aren't mutually exclusive and they can be combined to form your own policy requirements. For example, you can specify that the certificate passed in the request hasn't expired, and has been signed by a particular certificate authority.

Client certificates are signed to ensure that they aren't tampered with. When a partner sends you a certificate, verify that it comes from them and not an imposter. There are two common ways to verify a certificate:

- Check who issued the certificate. If the issuer was a certificate authority that you trust, you can use the certificate. You can configure the trusted certificate authorities in the Azure portal to automate this process.

- If the certificate is issued by a partner, verify that it came from them. For example, if they deliver the certificate in person, you can be sure of its authenticity. These certificates are known as *self-signed certificates*.

## Accept client certificates in the Consumption tier

The Consumption tier in API Management is designed to conform with serverless design principles. If you build your APIs from serverless technologies, such as Azure Functions, this tier is a good fit. In the Consumption tier, you must explicitly enable the use of client certificates, which you can do on the **Custom domains** pane. This step isn't necessary in other tiers.

![Configure the gateway to request certificates.](../media/5-config-request-certificates.png)

## Create certificate authorization policies

Create these policies in the inbound processing policy file within the API Management gateway.

![Inbound processing policy button.](../media/5-inbound-policy.png)

### Check the thumbprint of a client certificate

Every client certificate includes a thumbprint, which is a hash, calculated from other certificate properties. The thumbprint ensures that the values in the certificate haven't been altered since the certificate was issued by the certificate authority. You can check the thumbprint in your policy. The following example checks the thumbprint of the certificate passed in the request.

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Thumbprint != "desired-thumbprint")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```

### Check the thumbprint against certificates uploaded to API Management

In the previous example, only one thumbprint would work so only one certificate would be validated. Usually, each customer or partner company would pass a different certificate with a different thumbprint. To support this scenario, obtain the certificates from your partners, and use the **Client certificates** pane in the Azure portal to upload them to the API Management resource. Then, add this code to your policy.

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || !context.Request.Certificate.Verify()  || !context.Deployment.Certificates.Any(c => c.Value.Thumbprint == context.Request.Certificate.Thumbprint))" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```

### Check the issuer and subject of a client certificate

The following example checks the issuer and subject of the certificate passed in the request.

```XML
<choose>
    <when condition="@(context.Request.Certificate == null || context.Request.Certificate.Issuer != "trusted-issuer" || context.Request.Certificate.SubjectName.Name != "expected-subject-name")" >
        <return-response>
            <set-status code="403" reason="Invalid client certificate" />
        </return-response>
    </when>
</choose>
```
