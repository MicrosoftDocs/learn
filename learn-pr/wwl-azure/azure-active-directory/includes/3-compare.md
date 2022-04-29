**Azure AD is different from AD DS** \- Although Azure AD has many similarities to AD DS, there are also many differences. It is important to realize that using Azure AD is different from deploying an Active Directory domain controller on an Azure virtual machine and adding it to your on-premises domain. Here are some characteristics of Azure AD that make it different.

 -  **Identity solution.** Azure AD is primarily an identity solution, and it is designed for Internet-based applications by using HTTP and HTTPS communications.
 -  **REST API Querying.** Because Azure AD is HTTP/HTTPS based, it cannot be queried through LDAP. Instead, Azure AD uses the REST API over HTTP and HTTPS.
 -  **Communication Protocols.** Because Azure AD is HTTP/HTTPS based, it does not use Kerberos authentication. Instead, it uses HTTP and HTTPS protocols such as SAML, WS-Federation, and OpenID Connect for authentication (and OAuth for authorization).
 -  **Authentication Services.** Include SAML, WS-Federation, or OpenID.
 -  **Authorization Service.** Uses OAuth.
 -  **Federation Services.** Azure AD includes federation services, and many third-party services (such as Facebook).
 -  **Flat structure.** Azure AD users and groups are created in a flat structure, and there are no Organizational Units (OUs) or Group Policy Objects (GPOs).

The following table summarizes the differences:

:::row:::
  :::column:::
    **Azure Active Directory**
  :::column-end:::
  :::column:::
    **Active Directory Domain Services**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud
  :::column-end:::
  :::column:::
    On-Premises
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Designed for HTTP &amp; HTTPS
  :::column-end:::
  :::column:::
    Query via LDAP
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queried via REST API's
  :::column-end:::
  :::column:::
    Used Kerberos for Authentication
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Uses SAML, WS-Federation, or OpenID for authentication
  :::column-end:::
  :::column:::
    No Federated Services
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Uses OAuth for authorization
  :::column-end:::
  :::column:::
    Organizational Units (OU's)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Includes federation services
  :::column-end:::
  :::column:::
    Group Policy (GPO's)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Flat Structure
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
