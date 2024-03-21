Microsoft Entra Connect is an on-premises Microsoft application that's designed to meet and accomplish your hybrid identity goals.

## Microsoft Entra Connect features

 -  Password hash synchronization - A sign-in method that synchronizes a hash of a users on-premises AD password with Microsoft Entra ID.
 -  Pass-through authentication - A sign-in method that allows users to use the same password on-premises and in the cloud, but doesn't require the additional infrastructure of a federated environment.
 -  Federation integration - Federation is an optional part of Microsoft Entra Connect and can be used to configure a hybrid environment using an on-premises AD FS infrastructure. It also provides AD FS management capabilities such as certificate renewal and additional AD FS server deployments.
 -  Synchronization - Responsible for creating users, groups, and other objects. As well as, making sure identity information for your on-premises users and groups is matching the cloud. This synchronization also includes password hashes.
 -  Health Monitoring - Microsoft Entra Connect Health can provide robust monitoring and provide a central location in the Microsoft Entra admin center to view this activity.

:::image type="content" source="../media/microsoft-entra-connect-12c088d8.png" alt-text="Diagram showing an example of Microsoft Entra connect architechture.":::


## What is Microsoft Entra Connect Health?

Microsoft Entra Connect Health provides robust monitoring of your on-premises identity infrastructure. It enables you to maintain a reliable connection to Microsoft 365 and Microsoft Online Services. This reliability is achieved by providing monitoring capabilities for your key identity components. Also, it makes the key data points about these components easily accessible.

The information is presented in the Microsoft Entra Connect Health portal. Use the Microsoft Entra Connect Health portal to view alerts, performance monitoring, usage analytics, and other information. Microsoft Entra Connect Health enables the single lens of health for your key identity components in one place.

:::image type="content" source="../media/microsoft-entra-connect-health-32913d4b.png" alt-text="Diagram showing Microsoft Entra connect health portal functionality.":::


## Why use Microsoft Entra Connect?

Integrating your on-premises directories with Microsoft Entra ID makes your users more productive by providing a common identity for accessing both cloud and on-premises resources. Users and organizations can take advantage of:

 -  Users can use a single identity to access on-premises applications and cloud services such as Microsoft 365.<br>
 -  Single tool to provide an easy deployment experience for synchronization and sign-in.
 -  Provides the newest capabilities for your scenarios. Microsoft Entra Connect replaces older versions of identity integration tools such as DirSync and Azure AD Sync.

## Why use Microsoft Entra Connect Health?

When authenticating with Microsoft Entra ID, your users are more productive because there's a common identity to access both cloud and on-premises resources. Ensuring the environment is reliable, so that users can access these resources, becomes a challenge. Microsoft Entra Connect Health helps monitor and gain insights into your on-premises identity infrastructure thus ensuring the reliability of this environment. It is as simple as installing an agent on each of your on-premises identity servers.

Microsoft Entra Connect Health for AD FS supports AD FS on Windows Server 2012 R2, Windows Server 2016, Windows Server 2019 and Windows Server 2022. It also supports monitoring the web application proxy servers that provide authentication support for extranet access. With an easy and quick installation of the Health Agent, Microsoft Entra Connect Health for AD FS provides you a set of key capabilities.

Key benefits and best practices:

| **Key Benefits**                               | **Best Practices**                                                                              |
| ---------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Enhanced security                              | Extranet lockout trendsFailed sign-ins reportIn privacy compliant                               |
| Get alerted on all critical ADFS system issues | Server configuration and availability<br><br>Performance and connectivityRegular maintenance    |
| Easy to deploy and manage                      | Quick agent installationAgent auto upgrade to the latestData available in portal within minutes |
| Rich usage metrics                             | Top applications usage<br>Network locations and TCP connection<br>Token requests per server     |
| Great user experience                          | Dashboard fashion from Microsoft Entra admin center<br><br>Alerts through emails                |
