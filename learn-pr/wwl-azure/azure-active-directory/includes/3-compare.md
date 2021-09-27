
**Azure AD is different from AD DS** - Although Azure AD has many similarities to AD DS, there are also many differences. It is important to realize that using Azure AD is different from deploying an Active Directory domain controller on an Azure virtual machine and adding it to your on-premises domain. Here are some characteristics of Azure AD that make it different.  

* **Identity solution.** Azure AD is primarily an identity solution, and it is designed for Internet-based applications by using HTTP and HTTPS communications.  

* **REST API Querying.** Because Azure AD is HTTP/HTTPS based, it cannot be queried through LDAP. Instead, Azure AD uses the REST API over HTTP and HTTPS.  

* **Communication Protocols.** Because Azure AD is HTTP/HTTPS based, it does not use Kerberos authentication. Instead, it uses HTTP and HTTPS protocols such as SAML, WS-Federation, and OpenID Connect for authentication (and OAuth for authorization).  

* **Authentication Services.** Include SAML, WS-Federation, or OpenID.

* **Authorization Service.**  Uses OAuth.

* **Federation Services.** Azure AD includes federation services, and many third-party services (such as Facebook).

* **Flat structure.** Azure AD users and groups are created in a flat structure, and there are no Organizational Units (OUs) or Group Policy Objects (GPOs).  

The following table summarizes the differences:

| **Azure Active Directory** | **Active Directory Domain Services** |
| --- | --- |
| Cloud | On-Premises|
| Designed for HTTP & HTTPS | Query via LDAP |
| Queried via REST API's | Used Kerberos for Authentication |
| Uses SAML, WS-Federation, or OpenID for authentication | No Federated Services|
| Uses OAuth for authentication | Organizational Units (OU's) |
| Includes federation services| Group Policy (GPO's) |
| Flat Structure |   |

>[!IMPORTANT]
>Azure AD is a managed service. You only manage the users, groups, and policies. Deploying AD DS with virtual machines using Azure is a **IaaS deployment**. Meaning that you manage the deployment, configuration, virtual machines, patching, and other backend tasks. 
