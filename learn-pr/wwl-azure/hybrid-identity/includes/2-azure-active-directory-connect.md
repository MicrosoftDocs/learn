**Azure AD Connect** will integrate your on-premises directories with Azure Active Directory. This allows you to provide a common identity for your users for Microsoft 365, Azure, and SaaS applications integrated with Azure AD.

Azure AD Connect provides the following features:

 -  **Password hash synchronization**. A sign-in method that synchronizes a hash of a users on-premises AD password with Azure AD.
 -  **Pass-through authentication**. A sign-in method that allows users to use the same password on-premises and in the cloud, but doesn't require the additional infrastructure of a federated environment.
 -  **Federation integration**. Federation is an optional part of Azure AD Connect and can be used to configure a hybrid environment using an on-premises Active Directory Federation Server (AD FS) infrastructure. It also provides AD FS management capabilities such as certificate renewal and additional AD FS server deployments.
 -  **Synchronization**. Responsible for creating users, groups, and other objects. As well as, making sure identity information for your on-premises users and groups is matching the cloud. This synchronization also includes password hashes.
 -  **Health Monitoring**. Azure AD Connect Health can provide robust monitoring and provide a central location in the Azure portal to view this activity.

:::image type="content" source="../media/azure-ad-connect-example-b5aa5f3f.png" alt-text="Image showing how Azure AD Connect supports an On-premise Active Directory, Users, and Devices.":::


Azure AD Connect provides the following features:

 -  **Password hash synchronization**. A sign-in method that synchronizes a hash of a users on-premises AD password with Azure AD.
 -  **Pass-through authentication**. A sign-in method that allows users to use the same password on-premises and in the cloud, but doesn't require the additional infrastructure of a federated environment.
 -  **Federation integration**. Federation is an optional part of Azure AD Connect and can be used to configure a hybrid environment using an on-premises AD FS infrastructure. It also provides AD FS management capabilities such as certificate renewal and additional AD FS server deployments.
 -  **Synchronization**. Responsible for creating users, groups, and other objects. As well as, making sure identity information for your on-premises users and groups is matching the cloud. This synchronization also includes password hashes.
 -  **Health Monitoring**. Azure AD Connect Health can provide robust monitoring and provide a central location in the Azure portal to view this activity.

## What is Azure AD Connect Health?

Azure Active Directory (Azure AD) Connect Health provides robust monitoring of your on-premises identity infrastructure. It enables you to maintain a reliable connection to Microsoft 365 and Microsoft Online Services. This reliability is achieved by providing monitoring capabilities for your key identity components. Also, it makes the key data points about these components easily accessible.

The information is presented in the Azure AD Connect Health portal. Use the Azure AD Connect Health portal to view alerts, performance monitoring, usage analytics, and other information. Azure AD Connect Health enables the single lens of health for your key identity components in one place.

:::image type="content" source="../media/azure-ad-connect-health-8f546ab0.png" alt-text="Image showing how Azure AD Connect Health monitors an on-premise identity infrastructure.":::


## Why use Azure AD Connect?

Integrating your on-premises directories with Azure AD makes your users more productive by providing a common identity for accessing both cloud and on-premises resources. Users and organizations can take advantage of the following:

 -  Users can use a single identity to access on-premises applications and cloud services such as Microsoft 365.
 -  Single tool to provide an easy deployment experience for synchronization and sign-in.
 -  Provides the newest capabilities for your scenarios. Azure AD Connect replaces older versions of identity integration tools such as Directory Synchronization (DirSync) and Azure AD Sync.

## Why use Azure AD Connect Health?

When authenticating with Azure AD, your users are more productive because there's a common identity to access both cloud and on-premises resources. Ensuring the environment is reliable so that users can access these resources becomes a challenge. Azure AD Connect Health helps monitor and gain insights into your on-premises identity infrastructure, thus ensuring the reliability of this environment. It is as simple as installing an agent on each of your on-premises identity servers.

Azure AD Connect Health for AD FS supports AD FS 2.0 on Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019. It also supports monitoring the AD FS proxy or web application proxy servers that provide authentication support for extranet access. With an easy and quick installation of the Health Agent, Azure AD Connect Health for AD FS provides you a set of key capabilities.

Key benefits and best practices:

| **Key Benefits**                                                                      | **Best Practices**                                                                                      |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Enhanced security                                                                     | Extranet lockout trends<br>Failed sign-ins report<br>In privacy compliant                               |
| Get alerted on all critical Active Directory Federation Services (ADFS) system issues | Server configuration and availability<br>Performance and connectivity<br>Regular maintenance            |
| Easy to deploy and manage                                                             | Quick agent installation<br>Agent auto upgrade to the latest<br>Data available in portal within minutes |
| Rich usage metrics                                                                    | Top applications usage<br>Network locations and TCP connection<br>Token requests per server             |
| Great user experience                                                                 | Dashboard fashion from Azure portal<br>Alerts through emails                                            |

> [!IMPORTANT]
> Using AD Connect Health works by installing an agent on each of your on-premises sync servers.
