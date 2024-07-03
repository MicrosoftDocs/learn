Starting with Windows 10 and continuing into Windows 11, in addition to joining an Active Directory Domain Services (AD DS) domain, deploy Microsoft Entra joined devices. Along with creating user accounts in Microsoft Entra ID, you can have objects that represent devices, and you can manage devices that are joined to Microsoft Entra ID from the cloud.

Before you decide whether you want to join a device to an AD DS domain or to Microsoft Entra ID, it’s important to understand the difference between these two concepts. Devices that join an AD DS domain must run a supported operating system version; for example, Home editions of the Windows and Windows RT operating systems don't support joining a domain. Devices that are capable of joining an AD DS domain usually access on-premises applications and services. Devices also can access some cloud resources if you integrate the domain accounts and Microsoft accounts.

Microsoft Entra join allows All Windows 11 and Windows 10 devices except Home editions, Windows Server 2019 and newer Virtual Machines running in Azure (Server core isn't supported). Devices must meet certain requirements, such as having the correct ports open and not being joined to another AD DS domain. Devices running operating systems such as Windows 10 Home, Pro, or Enterprise, Windows Server, macOS, iOS, or Android can register with Microsoft Entra ID. When you register a device with Microsoft Entra ID, it can access cloud-based resources and Azure-based resources by using SSO. From a management perspective, you can use Intune to manage and provision devices that are registered with Microsoft Entra ID. However, you can't manage these devices by using Group Policy. We'll talk more about device registration in the next unit.

<a name='usage-scenarios-for-azure-ad-join'></a>

### Usage Scenarios for Microsoft Entra join

#### Scenario 1: Businesses Largely in the Cloud

Microsoft Entra join (Microsoft Entra join) can benefit you if you currently operate and manage identities for your business in the cloud or are moving to the cloud soon. You can use an account that you have created in Microsoft Entra ID to sign into Windows. Through the first run experience (FRX) process, or by joining Microsoft Entra ID from the settings menu, your users can join their machines to Microsoft Entra ID. Your users can also enjoy single sign-on (SSO) access to cloud resources like Microsoft 365, either in their browsers or in Office applications.

#### Scenario 2: Educational Institutions

Educational institutions usually have two user types: faculty and students.

Faculty members are considered longer-term members of the organization. Creating on-premises accounts for them is desirable. But students are shorter-term members of the organization and their accounts can be managed in Microsoft Entra ID. This means that directory scale can be pushed to the cloud instead of being stored on-premises. It also means that students will be able to sign into Windows with their Microsoft Entra accounts and get access to Microsoft 365 resources in Office applications.

You may want to join devices to Microsoft Entra ID in these scenarios:

 -  **If most applications and resources that you use are in the cloud**. If you already use certain cloud services such as Microsoft 365 and you plan to move your other workloads to the cloud, you should join the client devices to Microsoft Entra ID to ensure ease of access and SSO for cloud-based services.
 -  **If you want to separate temporary accounts**. If you need to manage temporary accounts separately from your regular accounts, such as for contractors or seasonal workers, yet you still want to provide them with limited cloud-based services, you can create these accounts in Microsoft Entra ID and join the users' devices to Microsoft Entra ID.
 -  **If you want to enable users to join their own devices to the organizational environment**. If you support the Bring Your Own Device (BYOD) concept and you want to enable users to join their devices to your business environment, Microsoft Entra ID might be the right solution. This is particularly the case in situations where users are utilizing non-Microsoft devices such as iPads or Android tablets that can't join an AD DS domain, but they can enroll in Intune and Microsoft Entra ID.
 -  **You want to transition to cloud-based infrastructure** using Microsoft Entra ID and an MDM such Intune.
 -  **You have remote branch offices with limited on-premises infrastructure** and wish to provide joining capabilities to workers.

Users can join Windows devices to Microsoft Entra ID during initial Windows setup or later by opening their system settings. In both instances, users need to type in their Microsoft Entra credentials and accept the management policies.

Keep in mind that you also need to prepare Microsoft Entra ID so that it can join a device. To do this, open the Azure portal, navigate to your Microsoft Entra instance, and then open Users and groups administration pane. You can configure options for joining a device in the Device settings section.

<a name='hybrid-azure-ad-join'></a>

#### Microsoft Entra hybrid join

If you have an on-premises Active Directory environment and you want to join your domain-joined devices to Microsoft Entra ID, you can accomplish this by configuring Microsoft Entra hybrid joined devices. Microsoft Entra hybrid join supports a broad range of Windows devices. Because the configuration for devices running older versions of Windows requires additional or different steps, the supported devices are grouped into two categories:

**Supported Operating Systems**

 -  Windows 11, Windows 10 or 8.1 except Home editions
 -  Windows Server 2008/R2, 2012/R2, 2016, 2019 and 2022

As a first planning step, you should review your environment and determine whether you need to support Windows down-level devices. *Microsoft Workplace Join for non-Windows 10 computers*, available on the Microsoft Download Center, must be installed for down-level devices.

You can't use a Microsoft Entra hybrid join if your environment consists of a single forest that synchronized identity data to more than one Microsoft Entra tenant.

<a name='reasons-to-use-hybrid-azure-ad-join'></a>

#### Reasons to use Microsoft Entra hybrid join:

 -  You have Win32 apps deployed to these devices that rely on Active Directory machine authentication.
 -  You require Group Policy to manage some of your devices.
 -  You want to continue to use imaging solutions to configure devices for your employees.

Microsoft Entra hybrid join is a process to automatically register your on-premises domain-joined devices with Microsoft Entra ID. There are cases where you don't want all your devices to register automatically. If this is true for you, you should control the Microsoft Entra hybrid join of your devices.

