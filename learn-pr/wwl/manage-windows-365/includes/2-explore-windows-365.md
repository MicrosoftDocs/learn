

Windows 365 is a cutting-edge cloud-based service that simplifies how you create and manage virtual machines. It automatically generates a new Windows virtual machine called Cloud PCs for your end users. With Windows 365, each Cloud PC is assigned to an individual user, providing them with a dedicated Windows device. By using Windows 365, you can experience the benefits of Microsoft 365, which include increased productivity, enhanced security, and seamless collaboration. With these features, Windows 365 offers a flexible and scalable solution to support your organization's growth and changing needs.

Windows 365 is available in two editions:

 -  **Windows 365 Business:** Windows 365 Business is made specifically for use in smaller companies (up to 300 seats) who want ready-to-use Cloud PCs with simple management options. There are no licensing prerequisites to set up Windows 365 Business. There are no dependencies on Azure or Active Directory. Purchases are made through the Microsoft 365 admin center or the Windows 365 product site. For more information, see [Getting started with Windows 365 Business and Cloud PCs](/windows-365/business/get-started-windows-365-business).
 -  **Windows 365 Enterprise:** Windows 365 Enterprise is designed for larger organizations seeking unlimited seats to create Cloud PCs. It offers the flexibility to build custom Cloud PCs using your own device images, provides additional management options, and seamlessly integrates with Microsoft Intune. Windows 365 Enterprise utilizes Azure AD and AD DS domains to enhance its functionality. For more information, see [What is Windows 365 Enterprise?](/windows-365/enterprise/overview).

## Compare Windows 365 Business and Enterprise

## General comparisons

|Capability|Windows 365 Business|Windows 365 Enterprise|
|:-----|:-----|:-----|
|Domain join|Azure AD join without Azure Virtual Network (VNet) Support|Azure AD Join without VNet support. <br> Azure AD Join with VNet support. <br> Hybrid Azure AD with VNet support. <br> For other domain support, see [In development for Windows 365 Enterprise.](/windows-365/enterprise/in-development) |

## Purchasing and licensing comparisons
| Capability | Windows 365 Business | Windows 365 Enterprise |
| --- | --- | --- |
| Domain Join | Azure AD Join without Azure Virtual Network (VNet) support. | Azure AD Join without VNet support. <br> Azure AD Join with VNet support. <br> Hybrid Azure AD with VNet support. <br> For other domain support, see In development for Windows 365 Enterprise. |
| Purchase channels | Web direct, self-service, Cloud Solution Provider (CSP). | Web direct, Enterprise Agreements (EA), CSP. |
| License assignment | Microsoft 365 Admin Center or the Azure AD portal. | Microsoft 365 Admin Center or the Azure AD portal. |
| Licensing requirements | No licensing pre-requirements to buy and deploy Windows 365 Business. Other features (like device management) can be used if users are licensed for Microsoft Endpoint Management. | Each user must be licensed for Windows 10 or 11 Enterprise (when available), Microsoft Endpoint Manager, and Azure AD P1. |
| Networking costs | Outbound data/month is based on the RAM of the Cloud PC: <br> - 2-GB RAM = 12-GB outbound data <br> - 4-GB or 8-GB RAM = 20-GB outbound data <br> - 16-GB RAM = 40-GB outbound data <br> - 32-GB RAM = 70-GB outbound data <br> Data bandwidth may be restricted when these levels are exceeded. | When providing a network, Networking goes through the customer's Azure VNet and isn't included in the license. [Azure bandwidth pricing](https://azure.microsoft.com/pricing/details/bandwidth/) applies for these network usage costs. <br> If using a Microsoft-hosted network, the same charges (as described in Windows 365 Business networking charges) apply. |
| Seat limits | Capped to 300 seats per tenant.| No seat cap per tenant.|

## Administration comparisons

| Capability | Windows 365 Business | Windows 365 Enterprise |
| --- | --- | --- |
| Provisioning | Provisioning is simplified and uses default configurations. Cloud PCs are automatically provisioned with a standard image after a Cloud PC license is assigned. | Provisioning is configurable and customizable to the needs of the organization. Admins select the network, configure user permissions (local admin or not), and assign the policy to an Azure AD group. Cloud PCs are then provisioned by using standard gallery images or custom images (admin choice). |
| Policy management | Not Supported. | Group Policy Objects (GPO) and Intune MDM are supported. |
| Application deployment | Supported only if you have Intune license. | Supported. |
| Windows updates | Default Windows Update for Business settings are configured for users. With an Intune license, these settings can be edited. | Can be managed by using Microsoft Endpoint Manager. |
| Device management | Device management is limited to assigning and unassigning of Cloud PC licenses in the Microsoft Admin Center. Some device management is possible in Microsoft Endpoint Manager if you have an Intune license but Cloud PCs won't be visible in the Windows 365 blade. | Microsoft Intune admin center options, including image management, link and access on-premises resources, granular targeting of policies, resizing Cloud PCs, other user experience settings, and all the policy-based management options available to physical devices. |
| Monitoring | Not supported. | Endpoint Analytics reporting and monitoring, service health, and operational health alerts. |
| Troubleshooting | Not supported | Microsoft Endpoint Manager troubleshooting including the Troubleshooting blade, device management actions, and reprovisioning of Cloud PCs to their initial state. |
| Partner/programmatic access | Not supported | Partners can manage Cloud PCs through Microsoft 365 Lighthouse or restful web APIs (Graph) to support Managed Service Provider tooling for up to 300 seats. |
| Universal Print | Not supported. | Supported |

## End-user comparisons

| Capability | Windows 365 Business | Windows 365 Enterprise |
| --- | --- | --- |
| Management | Users can restart, reset, rename, and troubleshoot their Cloud PCs on the Windows 365 homepage. | Users can restart, rename, and troubleshoot their Cloud PCs on the Windows 365 homepage. |
| Role | By default, each user is a Standard User on their Cloud PC. To grant Local Administrator permissions to a specific user on a Cloud PC, see [Remote management actions](/windows-365/business/remotely-manage-business-cloud-pcs#remote-management-actions). To grant Local Administrator permissions for Cloud PCs that you create in the future, see [Change organizational default settings](/windows-365/business/change-organization-default-settings). | By default, each user is assigned a standard user role on their Cloud PC. The administrator has the capability to modify this role within the Microsoft Intune admin center. |
| Access | Users can access their Cloud PC at windows365.microsoft.com or by using Microsoft Remote Desktop or the Windows 365 app. | Users can access their Cloud PC at windows365.microsoft.com or by using Microsoft Remote Desktop or the Windows 365 app. |
| Platform | Any platform that supports Microsoft Remote Desktop clients or the Windows 365 app. | Any platform that supports Microsoft Remote Desktop clients or the Windows 365 app. |

## Security comparisons
| Capability | Windows 365 Business | Windows 365 Enterprise |
| --- | --- | --- |
| Conditional Access | Conditional Access policies can be deployed only by using Azure AD with an Azure AD P1 license. | Conditional Access policies can be deployed by using the Microsoft Intune admin center or Azure AD. |
| Per-user multi-factor authentication (MFA) | Only MFA using Azure AD Conditional Access is supported. Legacy per-user MFA isn't supported. | Legacy per-user MFA is supported for user connections to Hybrid Azure AD joined Cloud PCs. It's not supported for user connections to Azure AD joined Cloud PCs. |
| Security baselines | Not supported. | Dedicated Security Baselines can be edited and deployed by using Microsoft Endpoint Manager. |
| Microsoft Defender for Endpoint | Supported if the customer separately has the requisite E5 license. | Integration with Defender for Endpoint. If the customer has an E5 license, all Cloud PCs respond to Defender for Endpoint policies and show up in MDE dashboards. |

### Access cloud PCs

Users can navigate to [https://windows365.microsoft.com](https://windows365.microsoft.com/) to access their Cloud PCs, connecting through Remote Desktop.

:::image type="content" source="../media/cloud-personal-computer-gear-04bac88c.png" alt-text="Screenshot of the cloud pc gear, showing; Restart, Reset, Rename, Troubleshoot, and System information.":::


The Remote Desktop client is available for Windows, macOS, iOS/iPadOS and Android.
