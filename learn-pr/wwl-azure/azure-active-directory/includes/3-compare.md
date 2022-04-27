**Azure AD is different from Active Directory Domain Services (AD DS)** \- Although Azure AD is similar to AD DS, it's important to know how they are different. Using Azure AD is different from deploying an Active Directory domain controller on an Azure virtual machine and adding it to your on-premises domain. 

Here are some characteristics of Azure AD that make it different from AD DS:

 -  **Identity solution** - Azure AD is primarily an identity solution, and it is designed for internet-based applications by using HTTP and HTTPS communications.
 -  **REST API querying** - Because Azure AD is HTTP/HTTPS-based, it can't be queried through LDAP. Instead, Azure AD uses the REST API over HTTP and HTTPS.
 -  **Communication protocols** - Because Azure AD is HTTP/HTTPS-based, it doesn't use Kerberos authentication. Instead, it uses HTTP and HTTPS protocols like SAML, WS-Federation, and OpenID Connect for authentication (and OAuth for authorization).
 -  **Authentication services** - Includes SAML, WS-Federation, or OpenID.
 -  **Authorization service** - Uses OAuth.
 -  **Federation services** - Azure AD includes federation services and many third-party services (such as Facebook).
 -  **Flat structure** - Azure AD users and groups are created in a flat structure, and there are no Organizational Units (OUs) or Group Policy Objects (GPOs).

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
    On-premises
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
    Query via REST APIs
  :::column-end:::
  :::column:::
    Uses Kerberos for authentication
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Uses SAML, WS-Federation, or OpenID for authentication
  :::column-end:::
  :::column:::
    No federated services
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Uses OAuth for authorization
  :::column-end:::
  :::column:::
    Organizational Units (OUs)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Includes federation services
  :::column-end:::
  :::column:::
    Group Policy Objects (GPOs)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Flat structure
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::


> [!IMPORTANT]
> Azure AD is a managed service. You manage only the users, groups, and policies. Deploying AD DS with virtual machines by using Azure is an **IaaS deployment**. In an IaaS deployment, you manage the deployment, configuration, virtual machines, patching, and other back-end tasks.
