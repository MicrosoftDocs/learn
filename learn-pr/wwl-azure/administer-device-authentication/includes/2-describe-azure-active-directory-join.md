

With Windows 11 or later, in addition to joining an AD DS domain, you can now join a device to Azure AD. Along with creating user accounts in Azure AD, you can now have objects that represent devices in Azure AD, and you can manage devices that are joined to Azure AD from the cloud.

Before you decide whether you want to join a device to an AD DS domain or to Azure AD, it’s important to understand the difference between these two concepts. Devices that join an AD DS domain must run a supported operating system version; for example, Home editions of the Windows and Windows RT operating systems don't support joining a domain. Devices that are capable of joining an AD DS domain usually access on-premises applications and services. Devices also can access some cloud resources if you integrate the domain accounts and Microsoft accounts.

Azure AD join allows devices running Windows 10, Windows Server, or later operating systems to join an Azure AD domain. Devices must meet certain requirements, such as having the correct ports open and not being joined to another AD DS domain. Devices running operating systems such as Windows 10 Home, Pro, or Enterprise, Windows Server, macOS, iOS, or Android can register with Azure AD. When you register a device with Azure AD, it can access cloud-based resources and Azure-based resources by using SSO. From a management perspective, you can use Intune to manage and provision devices that are registered with Azure AD. However, you can't manage these devices by using Group Policy. We'll talk more about device registration in the next unit.

### Usage Scenarios for Azure AD Join

#### Scenario 1: Businesses Largely in the Cloud

Azure Active Directory join (Azure AD join) can benefit you if you currently operate and manage identities for your business in the cloud or are moving to the cloud soon. You can use an account that you have created in Azure AD to sign into Windows. Through the first run experience (FRX) process, or by joining Azure AD from the settings menu, your users can join their machines to Azure AD. Your users can also enjoy single sign-on (SSO) access to cloud resources like Microsoft 365, either in their browsers or in Office applications.

#### Scenario 2: Educational Institutions

Educational institutions usually have two user types: faculty and students.

Faculty members are considered longer-term members of the organization. Creating on-premises accounts for them is desirable. But students are shorter-term members of the organization and their accounts can be managed in Azure AD. This means that directory scale can be pushed to the cloud instead of being stored on-premises. It also means that students will be able to sign into Windows with their Azure AD accounts and get access to Microsoft 365 resources in Office applications.

You may want to join devices to Azure AD in these scenarios:

 -  **If most applications and resources that you use are in the cloud**. If you already use certain cloud services such as Microsoft 365 and you plan to move your other workloads to the cloud, you should join the client devices to Azure AD to ensure ease of access and SSO for cloud-based services.
 -  **If you want to separate temporary accounts**. If you need to manage temporary accounts separately from your regular accounts, such as for contractors or seasonal workers, yet you still want to provide them with limited cloud-based services, you can create these accounts in Azure AD and join the users' devices to Azure AD.
 -  **If you want to enable users to join their own devices to the organizational environment**. If you support the Bring Your Own Device (BYOD) concept and you want to enable users to join their devices to your business environment, Azure AD might be the right solution. This is particularly the case in situations where users are utilizing non-Microsoft devices such as iPads or Android tablets that can't join an AD DS domain, but they can enroll in Intune and Azure AD.
 -  **You want to transition to cloud-based infrastructure** using Azure AD and an MDM such Intune.
 -  **You have remote branch offices with limited on-premises infrastructure** and wish to provide joining capabilities to workers.

Users can join Windows devices to Azure AD during initial Windows setup or later by opening their system settings. In both instances, users need to type in their Azure AD credentials and accept the management policies.

Keep in mind that you also need to prepare Azure AD so that it can join a device. To do this, open the Azure portal, navigate to your Azure AD instance, and then open Users and groups administration pane. You can configure options for joining a device in the Device settings section.

#### Hybrid Azure AD join

If you have an on-premises Active Directory environment and you want to join your domain-joined devices to Azure AD, you can accomplish this by configuring hybrid Azure AD joined devices. Hybrid Azure AD join supports a broad range of Windows devices. Because the configuration for devices running older versions of Windows requires additional or different steps, the supported devices are grouped into two categories:

**Windows current devices**

 -  Windows 11 or later
 -  Windows Server 2022 or later

**Windows down-level devices**

 -  Windows 10
 -  Windows Server 2019

As a first planning step, you should review your environment and determine whether you need to support Windows down-level devices. *Microsoft Workplace Join for non-Windows 10 computers*, available on the Microsoft Download Center, must be installed for down-level devices.

You can't use a hybrid Azure AD join if your environment consists of a single forest that synchronized identity data to more than one Azure AD tenant.

#### Reasons to use Hybrid Azure AD join:

 -  You have Win32 apps deployed to these devices that rely on Active Directory machine authentication.
 -  You require Group Policy to manage some of your devices.
 -  You want to continue to use imaging solutions to configure devices for your employees.

Hybrid Azure AD join is a process to automatically register your on-premises domain-joined devices with Azure AD. There are cases where you don't want all your devices to register automatically. If this is true for you, you should control the hybrid Azure AD join of your devices.
