For deployment, you'll need to provide Secure Sockets Layer (SSL) certificates for public-facing endpoints. At a high level, certificates have the following requirements:

 -  You can use a single wildcard certificate or you can use a set of dedicated certificates, and then use wildcards only for endpoints like storage and Key Vault.
 -  Certificates can be issued by a public trusted certificate authority (CA) or a customer-managed CA.

> [!IMPORTANT]
> The provided PKI certificate information should be used as general guidance. Before you acquire any PKI certificates for Azure Stack Hub, work with your OEM hardware partner. They'll provide more detailed certificate guidance and requirements.
