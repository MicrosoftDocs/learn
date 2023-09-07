
While there's no denying the rapid pace at which organizations are moving their workloads to the cloud, many businesses, and corporations are still a mixture of on-premises and cloud applications. Regardless of where an application is hosted, users expect and require easy access. As such, there's need to have a single identity across these various applications.

Microsoft’s identity solutions span on-premises and cloud-based capabilities. These solutions create a common identity for authentication and authorization to all resources, regardless of location. We call this hybrid identity.

Hybrid identity is accomplished through provisioning and synchronization.

- Inter-directory provisioning is provisioning an identity between two different directory services systems. For a hybrid environment, the most common scenario for inter-directory provisioning is when a user already in Active Directory is provisioned into Microsoft Entra ID.
- Synchronization is responsible for making sure identity information for your on-premises users and groups is matching the cloud.

One of the available methods for accomplishing inter-directory provisioning and synchronization is through Microsoft Entra ID Connect cloud sync.  Microsoft Entra ID Connect cloud sync is designed to meet and accomplish your hybrid identity goals for the provisioning and synchronization of users, groups, and contacts to Microsoft Entra ID. It accomplishes this by using the Microsoft Entra ID cloud provisioning agent.  The agent provides a lightweight inter-directory provisioning experience that acts as a bridge between Microsoft Entra ID and Active Directory. An organization only needs to deploy the agent in their on-premises or IaaS-hosted environment. The provisioning configuration is stored in Microsoft Entra ID and managed as part of the service.  

:::image type="content" source="../media/microsoft-entra-cloud-connect-sync-inline.png" alt-text="Image that depicts a hybrid identity. It shows a user in an on-premise Active Directory that includes Microsoft Entra ID Connect cloud sync with an arrow pointing to the cloud-based Microsoft Entra ID.":::

The Microsoft Entra ID Connect cloud sync provisioning agent uses the System for Cross-domain Identity Management (SCIM) specification with Microsoft Entra ID to provision and deprovision users and groups. The SCIM specification is a standard that is used to automate the exchanging of user or group identity information between identity domains such as Microsoft Entra ID and is becoming the de facto standard for provisioning.
