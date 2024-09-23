Certificate requirements are grouped by area and the namespaces used and the certificates that are required for each namespace. The table in this unit describes the Azure Stack Hub public endpoint PKI certificates that are required for both Microsoft Entra ID and AD FS Azure Stack Hub deployments. The folder in which your solution provider copies the different certificates per public endpoint.

Certificates with the appropriate DNS names for each Azure Stack Hub public infrastructure endpoint are required. Each endpoint's DNS name is expressed in the format: `<prefix>.<region>.<fqdn>`.

For your deployment, the \[region\] and \[externalfqdn\] values must match the region and external domain names that you chose for your Azure Stack Hub system. As an example, if the region name was Redmond and the external domain name was `contoso.com`, the DNS names would have the format `<prefix>.redmond.contoso.com`. The `<prefix>` values are predesignated by Microsoft to describe the endpoint secured by the certificate. In addition, the `<prefix>` values of the external infrastructure endpoints depend on the Azure Stack Hub service that uses the specific endpoint.

For the production environments, we recommend individual certificates are generated for each endpoint and copied into the corresponding directory. For development environments, certificates can be provided as a single wildcard certificate-covering namespaces in the Subject and Subject Alternative Name (SAN) fields copied into all directories. A single certificate covering all endpoints and services is an insecure posture and hence development-only. Remember, both options require you to use wildcard certificates for endpoints like **acs** and Key Vault where they're required.

:::row:::
  :::column:::
    **Deployment folder**
  :::column-end:::
  :::column:::
    **Required certificate subject and subject alternative names (SAN)**
  :::column-end:::
  :::column:::
    **Scope (per region)**
  :::column-end:::
  :::column:::
    **Subdomain namespace**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Public Portal
  :::column-end:::
  :::column:::
    Portal.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
  :::column:::
    Portals
  :::column-end:::
  :::column:::
    &lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Admin Portal
  :::column-end:::
  :::column:::
    adminportal.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
  :::column:::
    Portals
  :::column-end:::
  :::column:::
    &lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Resource Manager Public
  :::column-end:::
  :::column:::
    management.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
  :::column:::
    Azure Resource Manager
  :::column-end:::
  :::column:::
    &lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Resource Manager Admin
  :::column-end:::
  :::column:::
    adminmanagement.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
  :::column:::
    Azure Resource Manager
  :::column-end:::
  :::column:::
    &lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ACSBlob
  :::column-end:::
  :::column:::
    \*.blob.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificate)
  :::column-end:::
  :::column:::
    Blob Storage
  :::column-end:::
  :::column:::
    blob.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ACSTable
  :::column-end:::
  :::column:::
    \*.table.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificate)
  :::column-end:::
  :::column:::
    Table Storage
  :::column-end:::
  :::column:::
    table.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ACSQueue
  :::column-end:::
  :::column:::
    \*.queue.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificate)
  :::column-end:::
  :::column:::
    Queue Storage
  :::column-end:::
  :::column:::
    queue.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    KeyVault
  :::column-end:::
  :::column:::
    \*.vault.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificate)
  :::column-end:::
  :::column:::
    Key Vault
  :::column-end:::
  :::column:::
    vault.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    KeyVaultInternal
  :::column-end:::
  :::column:::
    \*.adminvault.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificate)
  :::column-end:::
  :::column:::
    Internal Keyvault
  :::column-end:::
  :::column:::
    adminvault.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Admin Extension Host
  :::column-end:::
  :::column:::
    \*.adminhosting.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificates)
  :::column-end:::
  :::column:::
    Admin Extension Host
  :::column-end:::
  :::column:::
    adminhosting.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Public Extension Host
  :::column-end:::
  :::column:::
    \*.hosting.&lt;region&gt;.&lt;fqdn&gt; (Wildcard secure socket layer (SSL) Certificates)
  :::column-end:::
  :::column:::
    Public Extension Host
  :::column-end:::
  :::column:::
    Hosting.&lt;region&gt;.&lt;fqdn&gt;
  :::column-end:::
:::row-end:::
