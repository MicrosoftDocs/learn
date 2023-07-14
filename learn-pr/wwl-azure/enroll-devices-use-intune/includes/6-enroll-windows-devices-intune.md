

Enrolling personal and organization-owned devices in Intune can significantly enhance your organization's security and device management capabilities. Enrolling a device establishes a connection between the device and Intune, allowing you to manage and control the device remotely.

Once enrolled, the device will receive the policies and profiles you created, including email, Wi-Fi, security settings, and more configurations. These policies and profiles can be customized to meet your organization's specific needs, ensuring that your devices are configured and secured in accordance with your policies.

Enrolling personal devices in Intune can be particularly useful for organizations allowing employees to use their own devices for work purposes. With Intune, you can ensure that these devices are configured and secured properly without taking full control of the device or accessing personal data. This helps to maintain a balance between work and personal use of the device.
Overall, enrolling personal and organization-owned devices in Intune is a powerful tool for device management and security, allowing organizations to maintain control over their devices and protect their data.

#### Enrolling Windows devices

Enrolling Windows devices into Microsoft Intune for device management has many ways. Some are user-driven, and IT administrators control some. Some exist to support BYOD programs, and others to streamline modern provisioning scenarios and management for corporate-owned devices. Each enrollment method can have different setup requirements and behaviors. The following methods can be utilized to complete Intune enrollment:

 -  Method 1: Add work or school account
 -  Method 2: Enroll in MDM only (user driven)
 -  Method 3: Azure AD join (OOBE)
 -  Method 4: Azure AD join (Autopilot – user-driven deployment mode)
 -  Method 5: Azure AD join (Autopilot self-deploying mode)
 -  Method 6: Enroll in MDM only (Device Enrollment Manager)
 -  Method 7: Configuration Manager co-management
 -  Method 8: Azure AD join (bulk enrollment)

##### Method 1: Add work or school account

This enrollment method will "Azure AD Join" the device. If you have Azure AD Premium licenses and your Azure AD tenant has auto-enrollment for Intune configured, your device will also be enrolled into Intune during this process. This method is preferred when Autopilot isn’t used in the environment. You would provide users with instructions on accessing the **“set up a work or school account”** from the **Settings** app.

:::image type="content" source="../media/windows-add-work-school-account-40b25f77.png" alt-text="Screenshot of the Setup a work or school account window, which appears after selecting Connect from the Access work or school page.":::


##### Method 2: Enroll only in device management (user driven)

This enrollment method will only enroll the device in Intune and not Azure AD join the device. You’ll only use this form of enrollment in environments that don’t have Azure AD Premium licenses required to enable auto-enrollment of devices into Intune.

:::image type="content" source="../media/windows-enroll-sign-work-school-dda8cbb6.png" alt-text="Screenshot of the Setup a work or school account window, which appears after selecting the Enroll only in device management option from the Access work or school page in Intune.":::


##### Method 3: Azure AD join (OOBE)

This enrollment method does the same as method 1, with one exception. The device is enrolled during the Out of Box Experience (OOBE) and not from the **Settings** app. The device will be Azure AD joined by choosing **Setup for an organization** and using a **Work Account** to sign in. If you have Azure AD Premium licenses and your Azure AD tenant has auto-enrollment for Intune configured, your device will also be enrolled into Intune. This method will be used when you need direct access to your users and their devices. This could be a remote office where the devices are delivered directly with Windows pre-installed, typically Windows Pro edition. The user then powers on the machine and joins Azure AD during OOBE. The device is enrolled in Intune and will receive apps and configuration from Intune. The version of Windows is typically uplifted to Windows Enterprise edition using an Intune profile setting.

:::image type="content" source="../media/windows-work-school-account-sign-86470f16.png" alt-text="Screenshot of the Sign in with Microsoft - work or school account page.":::

##### Method 4: Azure AD join (Autopilot – user-driven deployment mode)

This enrollment method does the same as method 2, with a few exceptions. The device is enrolled during the Out of Box Experience (OOBE), which is customized and not from the Settings app. Many of the OOBE screens can be skipped to ensure a smoother setup experience for end users. If configured, the desktop will first be shown to the user when installed software and policies are applied.

This method is preferred for enrolling devices in Intune, but it requires Azure AD Premium licenses, and your Azure AD tenant has auto-enrollment for Intune configured.

:::image type="content" source="../media/windows-sign-azure-active-directory-d70a89a4.png" alt-text="Screenshot of sample sign-in screen. The title reads, Welcome to A. Datum Azure AD.":::


##### Method 5: Azure AD join (Autopilot self-deploying mode)

This enrollment method basically does the same as method 4, with one exception. It allows all OOBE screens to be skipped after the device is first powered on. The Azure AD join and Intune enrollment are fully automated with no user interaction.

This type of enrollment is primarily for user-less devices such as kiosks, but it can also be used for normal users. You can pre-assign a user to a device so all the user has to supply is a password. This setup experience is the most streamlined compared to the other methods.

:::image type="content" source="../media/intune-policy-set-region-1e566302.png" alt-text="Screenshot of the Autopilot profile settings page in Intune.":::


##### Method 6: Enroll in MDM only (Device Enrollment Manager)

This method of enrollment is like method 3, except it’s performed by IT admins using a special type of account - A Device Enrollment Manager (DEM) account. The devices are enrolled and prepared by users before handing them out. The DEM would enroll the device, log on to the company portal and install the apps required by the user. This account can enroll up to 1000 devices into Intune. The IT administrator who performs the enrollment must have access to local administrator credentials to complete the enrollment from the Settings menu. For more information about DEM, refer to the topic **Enrollment Rules** later in this Module.

:::image type="content" source="../media/intune-device-enrollment-manager-add-0caa052a.png" alt-text="Screenshot of the Device enrollment - Device enrollment managers screen.":::


##### Method 7: Configuration Manager co-management

Co-management enables you to manage Windows devices concurrently by using both Configuration Manager and Intune. It’s a solution that bridges traditional to modern management and gives you a path to transition using a phased approach. Co-management is the preferred way to enroll existing devices, Microsoft Configuration Manager is already managing that. Once enabled, the device can be managed by Configuration Manager and Intune, using the best features of both.

##### Method 8: Azure AD join (bulk enrollment)

Bulk enrollment is an efficient way to set up many devices to be managed by Intune without the need to re-image the devices. You enable bulk enrollment by creating a provisioning package using the Windows Configuration Designer app from the Store. You then apply this package during the OOBE or run it from the Settings app. This method can be used instead of method 1 if you want the enrollment process to be as easy as possible for your users. You don’t have to give users instructions on how to **set up a work or school** account from the **Settings** app. You supply them with the provisioning package and all they’ve to it to select it to enroll in Azure AD and Intune.

:::image type="content" source="../media/windows-configuration-designer-create-menu-15ea5078.png" alt-text="Screenshot of the Windows Configuration Designer start page.":::
