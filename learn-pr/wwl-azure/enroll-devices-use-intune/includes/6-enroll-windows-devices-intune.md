
#### Enrolling Windows devices

There are many ways to enroll Windows devices into Microsoft Intune for device management. Some are user-driven and some controlled by IT administrators. Some exist to support BYOD programs and others to streamline modern provisioning scenarios and management for corporate-owned devices. Each enrollment method can have different setup requirements and behaviors. The following methods, that can be used to enroll in Intune are:

 -  Method 1: Add work or school account
 -  Method 2: Enroll in MDM only (user driven)
 -  Method 3: Azure AD join (OOBE)
 -  Method 4: Azure AD join (autopilot – user-driven deployment mode)
 -  Method 5: Azure AD join (autopilot self-deploying mode)
 -  Method 6: Enroll in MDM only (Device Enrollment Manager)
 -  Method 7: Configuration Manager co-management
 -  Method 8: Azure AD join (bulk enrollment)

##### Method 1: Add work or school account

This enrollment method will Azure AD join the device. If you have Azure AD Premium licenses and your Azure AD tenant has auto-enrollment for Intune configured, your device will also be enrolled into Intune during as well. This method is the preferred method when Autopilot is not used in the environment. You would normally provide users with instructions on how to access **set up a work or school account** from the **Settings** app.

:::image type="content" source="../media/windows-add-work-school-account-40b25f77.png" alt-text="Screenshot of the Set up a work or school account window which appears after selecting Connect from the Access work or school page.":::


##### Method 2: Enroll only in device management (user driven)

This enrollment method will only enroll the device in Intune and not Azure AD join the device. You will only use this form of enrollment in environments that do not have Azure AD Premium licenses that are required to enable auto-enrollment of devices into Intune.

:::image type="content" source="../media/windows-enroll-sign-work-school-dda8cbb6.png" alt-text="Screenshot of the Set up a work or school account window which appears after selecting the Enroll only in device management option from the Access work or school page in Intune.":::


##### Method 3: Azure AD join (OOBE)

This enrollment method basically does the same as method 1, with one exception. The device is enrolled during the Out of Box Experience (OOBE) and not from with the **Settings** app. By choosing **Setup for an organization** and using a work account to sign in, the device will be Azure AD joined. If you have Azure AD Premium licenses and your Azure AD tenant has auto-enrollment for Intune configured, your device will also be enrolled into Intune during as well. This method will typically be used where you do not have direct access to your user´s and their devices. This could be a remote office where the devices are delivered directly with Windows pre-installed, typically Windows Pro edition. The user then powers on the machine and join Azure AD during OOBE. The device is enrolled in Intune and will receive apps and configuration from Intune. The version of Windows is typically uplifted to Windows Enterprise edition using an Intune profile setting.

:::image type="content" source="../media/windows-work-school-account-sign-86470f16.png" alt-text="Screenshot of the Sign in with Microsoft - work or school account page.":::


##### Method 4: Azure AD join (autopilot – user-driven deployment mode)

This enrollment method basically does the same as method 2, with a few exceptions. The device is enrolled during the Out of Box Experience (OOBE), which is customized, and not from with the Settings app. Many of the OOBE screens can be skipped to ensure a smoother setup experience for end users. If configured, the desktop will first be shown to the user when software has been installed and policies are applied.

This method is the preferred method for enrolling device in Intune but it requires Azure AD Premium licenses and your Azure AD tenant has auto-enrollment for Intune configured.

:::image type="content" source="../media/windows-sign-azure-active-directory-d70a89a4.png" alt-text="Screenshot of sample login screen. The title reads, Welcome to A. Datum Azure AD.":::


##### Method 5: Azure AD join (autopilot self-deploying mode)

This enrollment method basically does the same as method 4, with one exception. It allows all OOBE screens to be skipped after the device is first powered on. The Azure AD join and Intune enrollment are fully automated without any user interaction.

This type of enrollment is primarily for user-less devices such as kiosks, but it can be used for normal users as well. You can pre-assign a user to a device so all the user has to supply is a password. This setup experience is the most streamlined compared to the other methods.

:::image type="content" source="../media/intune-policy-set-region-1e566302.png" alt-text="Screenshot of the Autopilot profile settings page in Intune.":::


##### Method 6: Enroll in MDM only (Device Enrollment Manager)

This method of enrollment is very similar to method 3, except it's performed by IT admins using a special type of account - A Device Enrollment Manager (DEM) account. A DEM account is useful for scenarios where devices are enrolled and prepared before handing them out to the users of the devices. The DEM would enroll the device, log on to the company portal and install the apps required by the user. This account can be used to enroll up to 1000 devices into Intune. The IT administrator who performs the enrollment must have access to local administrator credentials to complete the enrollment from the Settings menu. For more information about DEM, refer to the topic **Enrollment Rules** later in this lesson.

:::image type="content" source="../media/intune-device-enrollment-manager-add-0caa052a.png" alt-text="Screenshot of the Device enrollment - Device enrollment managers screen.":::


##### Method 7: Configuration Manager co-management

Co-management enables you to concurrently manage Windows devices by using both Configuration Manager and Intune. It's a solution that provides a bridge from traditional to modern management and gives you a path to make the transition using a phased approach. Co-management is the preferred way to enroll existing devices, that are already being managed by Endpoint Configuration Manager. Once enabled, the device can be managed by Configuration Manager and Intune, leveraging the best features of both.

##### Method 8: Azure AD join (bulk enrollment)

Bulk enrollment is an efficient way to set up a large number of devices to be managed by Intune without the need to re-image the devices. You enable bulk enrollment by creating a provisioning package using the Windows Configuration Designer app from the Store. You then apply this package either during the OOBE or run it from the Settings app. This method can be used instead of method 1, if you want the enrollment process to be as easy as possible for your users. You don´t have to provide users with instructions on how to access **set up a work or school** account from the **Settings** app. You just supply them with the provision package and all they have to it to select it to enroll in Azure AD and Intune.

:::image type="content" source="../media/windows-configuration-designer-create-menu-15ea5078.png" alt-text="Screenshot of the Windows Configuration Designer start page.":::
