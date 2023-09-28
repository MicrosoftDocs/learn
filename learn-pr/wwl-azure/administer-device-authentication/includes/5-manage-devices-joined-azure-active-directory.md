
Group Policy or Microsoft Configuration Manager applications mostly manage devices that are capable of joining AD DS. When you join a device to Azure AD, Group Policy isn't available except when you use with Azure AD Domain Services. However, even with Azure AD Domain Services, Group Policy can't manage devices such as smartphones and tablets.

Azure AD doesn't provide a built-in management mechanism for devices that don't support Group Policy. Additionally, Azure AD Domain Services isn't enabled by default, you must manually enable and configure this service.

If you want to manage devices that join Azure AD, you can configure integration between Azure and a mobile device management mechanism such as Intune. If you configure Intune as an application in Azure, each device that joins Azure AD can be configured to enroll in Intune automatically. For this to work, you need to have an active Intune subscription that’s associated with the same Azure AD tenant where you configured the integration of these services. Additionally, a user who joins a device to Azure AD needs to have an assigned Intune license.

After the device enrolls in Intune, you can configure Intune security and configuration policies that will apply to the user or to the device. It’s important to understand that management through Intune doesn't follow the same logic as management with Group Policy, nor does it have as many available options. Intune management options mostly focus on security and the apps that are on managed devices.
