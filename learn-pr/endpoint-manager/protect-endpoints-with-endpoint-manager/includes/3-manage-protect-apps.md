Microsoft Intune gives you a range of features to help you manage and protect apps and data. Intune supports mobile application management (MAM) policies without managing the device. 

> [!IMPORTANT]
> Intune MAM capabilities are supported whether you choose to enroll the device or not.

Intune MAM supports two configurations. The first involves mobile device management (MDM) along with Mobile App Management (MAM). This configuration is where IT administrators can only manage apps using MAM and app protection policies on devices that are *enrolled* with Intune mobile device management (MDM). The second configuration involves MAM without device enrollment. MAM without device enrollment, or MAM-WE, allows IT administrators to manage apps using MAM and app-protection policies on devices *not enrolled* with Intune MDM. This configuration allows apps to be managed by Intune on devices enrolled with third-party enterprise mobility management (EMM) providers. Additionally, members of your organization can choose to use their own devices—known as bring-your-own-device (BYOD)—and still support an Intune mobile application management scenario.

## Examples of app policies

App policies allow you to perform several different types of actions to configure and protect apps. By using MAM policies in Intune you can configure, secure, publish, monitor, and update apps for devices and users of your organization. For example, you can:

- Add and assign apps to devices and users.
- Assign apps to devices not enrolled with Intune.
- Use app-configuration policies to control app startup behavior.
- Prevent data from being backed up from a protected app.
- Restrict copy and paste actions to other apps.
- Require a PIN to access an app.
