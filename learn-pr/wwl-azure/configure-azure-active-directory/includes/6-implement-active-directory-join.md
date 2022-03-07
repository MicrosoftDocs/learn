Azure Active Directory (Azure AD) enables single sign-on to devices, apps, and services from anywhere. IT administrators must ensure corporate assets are protected and that devices meet standards for security and compliance.

:::image type="content" source="../media/azure-joined-devices-27a1fc5f.png" alt-text="A device is shown connecting to Azure AD. Azure AD is shown connecting with On-premises AD.":::


Azure AD Join is designed to provide access to organizational apps and resources and to simplify Windows deployments of work-owned devices. AD Join has these benefits.

 -  **Single-Sign-On (SSO)** to your Azure-managed SaaS apps and services. Your users won't have additional authentication prompts when accessing work resources. The SSO functionality is available even when users are not connected to the domain network.
 -  **Enterprise state roaming** of user settings across joined devices. With Windows 10,users gain the ability to securely synchronize their user settings and application settings data to the cloud. This reduces the time to configure a new device. 
 -  **Access to Microsoft Store for Business** using an Azure AD account. Your users can choose from an inventory of applications pre-selected by the organization.
 -  **Windows Hello** support for secure and convenient access to work resources.
 -  **Restriction of access** to apps from only devices that meet compliance policy.
 -  **Seamless access to on-premise resources** when the device has line of sight to the on-premises domain controller.

## Connection options

To get a device under the control of Azure AD, you have two options:

 -  **Registering** a device to Azure AD enables you to manage a device’s identity. Azure AD device registration provides the device with an identity that is used to authenticate the device when a user signs-in to Azure AD. You can use the identity to enable or disable a device.
 -  **Joining** a device is an extension to registering a device. Joining provides the benefits of registering and changes the local state of a device. Changing the local state enables your users to sign-in to a device using an organizational work or school account instead of a personal account.

> [!NOTE]
> Registration combined with a mobile device management (MDM) solution such as Microsoft Intune, provides additional device attributes in Azure AD. You can create conditional access rules that enforce access from devices to meet your standards for security and compliance.

> [!NOTE]
> Although AD Join is intended for organizations that do not have on-premises Windows Server Active Directory infrastructure it can be used for other scenarios like branch offices.
