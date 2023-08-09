

Once device IDs have been uploaded, configurations are ready to be defined and applied to target devices.

### Create a Windows Autopilot deployment profile

Once device IDs have been uploaded, a Windows Autopilot deployment profile must be created. This profile specifies the settings that should apply to the devices that you deploy by using Windows Autopilot. You can create and use multiple deployment profiles with Windows Autopilot, but you only use a single profile to deploy each device. Using Intune, you can use the following high-level procedure to create a deployment profile:

1.  Sign in to Intune as a global admin, and in the portal, select **Device enrollment**, select **Windows enrollment**, select **Deployment Profiles** and then select **Create Profile**. Provide a Name and Description.
2.  Then, for Deployment mode, choose between user-driven and self-deploying. With the former, the user specifies credentials during deployment, and devices with this profile are associated with the user account. With the latter, user credentials aren't required to enroll the device, and devices with this profile aren't associated with the user account.
3.  Next, configure the Out-of-box experience (OOBE) settings, which include: language, keyboard, EULA, privacy settings, and user account.
4.  Finally, create the profile. The Autopilot deployment profile is now available to assign to devices.

### Apply a deployment profile

Next, the deployment profile is applied to a device or a group of devices. Until you apply the deployment profile, Windows Autopilot doesn’t manage the OOBE setup phase on the device. After you apply the profile, Windows Autopilot takes control of the OOBE setup phase on the devices to which you apply the profile. You can use the following high-level process to apply the profile:

1.  Sign in to Intune as a global admin, and in the portal, select **Device enrollment**, select **Windows enrollment**, select **Deployment profiles**, and then choose a profile.
2.  Choose **Assignments**, and then select the group(s) that you want to assign the profile to.

After the setup process is complete, you can turn on the devices, and Windows Autopilot manages their OOBE setup phases.

### Compare the default and Autopilot OOBE experience

When employees turn on a computer that a hardware vendor has delivered, the OOBE setup phase occurs. During this phase, the Windows operating system asks for several configuration settings, such as:

 -  What is your preferred keyboard layout?
 -  Do you accept the Microsoft Software License Terms?
 -  Should the computer join AD DS or Azure AD?
 -  Which privacy settings should you use?

These settings can be confusing for employees, and therefore, they often call the help desk or they misconfigure Windows. With traditional, custom image deployment, you can preconfigure those settings so that employees can’t view or configure them. However, when a hardware vendor delivers a computer directly, the default Windows image is used, and the employee has to provide all of the configuration settings. An employee who completes the OOBE also becomes a member of the local Administrators group, which can cause many problems.

The Default OOBE setup phase:

:::image type="content" source="../media/microsoft-account-sign-d6997be5.png" alt-text="The screenshots depict the dialog boxes that display during the default out-of-box experience setup phase and during the Windows AutoPilot–controlled OOBE setup phase.":::


The OOBE setup phase with Windows Autopilot:

:::image type="content" source="../media/azure-active-directory-sign-9f107960.png" alt-text="Screenshot shows the Windows AutoPilot setup process. The user enters their Azure AD email address instead of a Microsoft Account during the setup.":::


Windows Autopilot puts administrators in control of the entire OOBE setup phase for known Windows devices. After administrators identify devices by their hardware IDs, they can create and apply a Windows Autopilot deployment profile to those devices. When the devices start and have internet connectivity, they connect to the Windows Autopilot cloud service, ask the employees for their company credentials, and apply settings from the Windows Autopilot profile. This preconfigures and hides many dialog boxes that would otherwise display during OOBE. It simplifies the user experience and enables employees to get configured and productive Windows devices in just a few selects. Based on employee credentials, the devices join Azure AD and can automatically enroll in Intune or another mobile device management solution.

You can’t use Windows Autopilot to perform advanced provisioning, but you can use mobile device management solutions such as Intune to do this. Windows Autopilot deployment is also the only way in which a user who goes through OOBE doesn’t become a local Administrator of the device. Note that you can manage Windows Autopilot in Microsoft Store for Business or in Intune.
