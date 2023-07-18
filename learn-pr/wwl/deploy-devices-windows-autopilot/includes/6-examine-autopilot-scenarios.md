

Windows Autopilot supports several deployment scenarios depending on the desired experience:

 -  Windows Autopilot user-driven mode
 -  Windows Autopilot self-deploying mode
 -  Autopilot for existing devices
 -  Windows Autopilot for pre-provisioned deployment
 -  Windows Autopilot reset

### User-driven mode

Windows Autopilot user-driven mode is designed to enable new Windows 10 or later devices to be transformed from their initial state, directly from the factory, into a ready-to-use state without requiring that IT personnel ever touch the device. The process is designed to be simple so that anyone can complete it, enabling devices to be shipped or distributed to the end user directly with simple instructions:

 -  Unbox the device, plug it in, and turn it on.
 -  Choose a language, locale and keyboard.
 -  Connect it to a wireless or wired network with internet access.
 -  Specify your e-mail address and password for your organization account.

To enable User-driven mode for Azure Active Directory join, the following actions must be taken as part of preparing the Autopilot deployment:

 -  Users must be able to join Azure AD.
 -  If using Intune (and not Microsoft Store for Business), user-driven mode must be selected in the Autopilot profile assigned to the device if using Intune. The Autopilot profile must also be assigned to an Azure AD device group.
 -  The device must be added to Windows Autopilot and a profile must be assigned to the device.

User-driven mode is also supported for hybrid Azure Active Directory join. In addition to the actions above, the following steps must also be taken:

 -  The device must be running Windows 1809 or later.
 -  **Hybrid Azure AD joined** must be specified as the selected option under **Join to Azure AD as** in the Autopilot profile.
 -  The device must be able to access the internet and an Active Directory domain controller.
 -  The Intune Connector for Active Directory must be installed (this performs the on-premises AD join instead of requiring user permission to join).

### Self-deploying mode

Windows Autopilot self-deploying mode enables a device to be deployed with little to no user interaction, achieving a ZTI experience with all OOBE prompts pre-configured. The enrollment status page will display while the device is being configured, and then the computer will either complete and display the sign-in screen, ready for Azure AD credentials. If the device is configured as a kiosk device, it will automatically sign in by using a locally configured account.

To perform a self-deploying mode deployment using Windows Autopilot:

 -  Create an Autopilot profile for self-deploying mode with the desired settings. In Microsoft Intune, this mode is explicitly chosen when creating the profile. Note that this mode isn't available using the Microsoft Store for Business.
 -  Ensure that the profile has been assigned to the device before attempting to deploy that device.
 -  Self-deploying mode requires devices with TPM 2.0 and Windows 10 version 1903 or later.

Some interaction may be required under certain circumstances. If only wireless connectivity is available, the wireless network must be selected. If multiple languages are pre-installed, a language must be selected.

### Autopilot for existing devices

As discussed previously, the Autopilot process requires that the device has Windows 10 or Windows 11 installed. This feature allows you to re-image and provision a 8.1 device for Windows Autopilot user-driven mode using a single, native Configuration Manager task sequence. This process allows a device that was traditionally managed with images to transition to device using modern methods.

In order to facilitate this, a special task sequence must be used to deploy the image to the Windows 8.1 device, which includes delivering a configuration file associated with an Intune profile. The profile(s) must be created in Microsoft Intune before the configuration files are created. Once the profiles are set up, use PowerShell (Administrator) to create the configuration file.

1.  Install the required modules
    
    ```
    Install-Module AzureAD
    Install-Module WindowsAutopilotIntune
    Import-Module WindowsAutopilotIntune
    
    ```
2.  Sign in to Intune `Connect-AutopilotIntune`
3.  Retrieve the Autopilot profiles associated with your tenant ' `$AutopilotProfile = Get-AutopilotProfile`
4.  Create a JSON configuration file for each profile. In this example, each filename is the name of the profile. `$AutopilotProfile | ForEach-Object { $_ | ConvertTo-AutopilotConfigurationJSON | Set-Content -Encoding Ascii "~\Desktop\$($_.displayName).json" }`
5.  Save one of the profiles to an ANSI-encoded file named **AutopilotConfigurationFile.json.** This filename must be used.

Once the configuration file is created, you can create the task sequence in **Configuration Manager** using the following steps:

1.  Add the desired OS image to Configuration Manager.
2.  Create a package containing the **AutopilotConfigurationFile.json** configuration file.
3.  Create a Task Sequence using the **Deploy Windows Autopilot for existing devices** option.
4.  Configured the Task Sequence as needed. Be sure that the following are set:
    
    1.  Enable **Partition and format the target computer before installing the operating system.**
    2.  Select the option to **Join a workgroup.** Sysprep will fail if joined to a domain.
    3.  Select the option **Do not install any software updates.**
    4.  On the System Preparation page, select the package containing the Autopilot configuration file.
    5.  For Windows 1903 and 1909, if using Configuration Manager's built-in template for *Windows Autopilot existing devices* task sequence, you'll need to disable the **Prepare Windows for Capture** step and add a new **Run command-line** step that will run `c:\windows\system32\sysprep\sysprep.exe /oobe /reboot`. This prevents Sysprep from deleting the AutopilotConfiguration file.
5.  Complete the task sequence wizard.

> [!NOTE]
> Devices should not already be registered with the Windows Autopilot service.

### Windows Autopilot for pre-provisioned deployment

Starting with Windows 10 version 1903, Windows Autopilot can also provide a capability that enables partners or IT staff to pre-provision a Windows PC so that it's fully configured and business-ready. From the end user's perspective, the Windows Autopilot user-driven experience is unchanged, but getting their device to a fully provisioned state is faster.

Instead of the entire provisioning process occurring when the user powers on the device, the provisioning process is split. Time-consuming portions such as device and user application installs and policies are completed by IT. Final user settings and policies are applied when the user connects and powers on the device.

The process for configuring a pre-provisioned deployment is as follows:

1.  Enable the **White Glove OOBE** option in the desired Autopilot Profile.
2.  Connect (ethernet required for pre-provision) and boot the device. At the first OOBE screen press, the Windows key five times.
3.  In the additional dialog options, select **Windows Autopilot provisioning**.
4.  Verify the device information. If changes are needed, complete them in Intune, and select refresh to re-download the updated information.
5.  Select Provision to provision the device.
6.  When the process is complete, select Reseal.

The device can now be delivered to the user. When the user receives the device, they simply need to connect and power on the device, select regional and keyboard settings, select a WiFi network if applicable, and sign in.

Pre-provisioned deployment requires Windows 1903 or later and an Intune subscription. The device must also support TPM 2.0 and device attestation, virtual machines aren't supported. Access to the on-premises domain isn't required in the pre-provision process. Internet connectivity (or connectivity to a domain controller is using Hybrid Azure AD join) is required during the final user process.

> [!TIP]
> The advantage of pre-provisioned deployment enables an administrator to install the bulk of applications, which are machine targeted, leaving only applications specific to the user onboarding to complete the process. This can drastically reduce the time to provision the device and improve the user experience.

For more information on pre-provisioned deployment s, refer to [Windows Autopilot for Pre-provisioned deployment](https://aka.ms/AA6dcx6).

### Windows Autopilot Reset

In many environments, you regularly need to reset devices to their initial states after they've been in use for some time. For example, an organization might provide temporary employees with Windows devices, which the organization must reset for every new user. Organizations must also reset the computers in training rooms after each class. With traditional deployment, you would need to redeploy the Windows image each time you reset a device to its initial state. Windows Autopilot Reset enables you to achieve this goal without redeploying a Windows image. It removes all personal files, apps, and settings, and it resets a Windows device to its initial state from the lock screen. It can also deploy organizational apps and settings by using Intune or another MDM solution so that a device is ready to use after the Windows Autopilot Reset.

Windows Autopilot Reset supports two scenarios:

 -  Local reset
 -  Remote reset

#### Local Windows Autopilot Reset

Local Windows Autopilot Reset uses Windows reset functionality. You can use local Windows Autopilot Reset regardless of how you're currently managing a device. It preserves device name, Azure AD membership, and MDM enrollment.

By default, local Windows Autopilot Reset is disabled in Windows, which helps ensure that it doesn't start by accident. To enable local Windows Autopilot Reset, you must set the **DisableAutomaticReDeploymentCredentials** policy to **0** (false).

After enabling local Windows Autopilot Reset, you can start it by pressing *Ctrl+Windows logo key+R* when you're at the Windows lock screen. Only users with administrative permissions can start local Windows Autopilot Reset.

#### Remote Windows Autopilot Reset

To initiate a remote Windows Autopilot Reset, you can leverage an MDM service such as Microsoft Intune. This method eliminates the necessity for IT personnel to physically visit each individual machine in order to commence the reset procedure. By following these steps, you can use Intune to initiate the remote Windows Autopilot Reset process:

1.  In Microsoft Intune admin center, navigate to **Devices** > **Windows**.
2.  Select the device for which you want to initiate a remote Windows Autopilot Reset.
3.  Select **More** (the ellipsis) and then select **Autopilot Reset** to start the reset.
