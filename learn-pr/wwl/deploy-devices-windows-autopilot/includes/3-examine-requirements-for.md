

You can deploy only known devices by using Windows Autopilot. When you purchase new devices, the hardware vendor can upload device-specific information on your behalf. If you want to use Windows Autopilot to deploy devices that your company already owns, you can transfer device-specific information to a comma-separated value (CSV) file by running a Windows PowerShell script and then uploading the CSV file to Microsoft Intune or Microsoft Store for Business. You can manage Windows Autopilot by using either Microsoft Store for Business or Microsoft Intune admin center.

Before you can start using Windows Autopilot for Windows 10 deployment, you must meet the following prerequisites:

 -  **Devices must have Windows 10 preinstalled:** Windows Autopilot transforms an existing or Windows 11 installation by providing configuration settings to the OOBE setup phase. It doesn’t deploy a Windows image, and the device must start to the OOBE setup. The device can be a new device with a preinstalled  or later operating system that a hardware vendor delivered, or it can be an existing  or later device that is configured to start the OOBE setup; for example, by using the System Preparation Tool (Sysprep).
 -  **Windows Pro, Enterprise, or Education:** Windows Autopilot can’t deploy Windows Home or an operating system that is older than Creators Update (version 1703). Some features, such as Windows Automatic Redeployment or Autopilot for existing devices require more recent versions.
 -  **Devices must have internet connectivity:** Windows Autopilot is a cloud service, and it can deploy the Windows 10/11 operating system only to devices that are connected to the internet. Furthermore, DNS name resolution for internet DNS names must be available, and access to all hosts via port 80 (HTTP), 443 (HTTPS), and 123 (UDP/NTP).
 -  **Organization must be using Azure AD:** Azure AD is mandatory because Windows Autopilot depends on Microsoft Store for Business or Intune, and both of them require Azure AD. Windows devices that you deploy by using Windows Autopilot also automatically join Azure AD. If you want deployed devices to automatically enroll in a mobile device management solution such as Intune, the company must be using Azure AD Premium P1 or P2.
 -  **Intune or Microsoft Store for Business:** You can upload device-specific information in Intune or Microsoft Store for Business and configure a Windows Autopilot deployment either in Intune or Microsoft Store for Business. Because of that, your organization must be using at least one of those cloud services.
 -  **Intune or another mobile device management service (optional):** When Windows Autopilot deploys Windows devices, it automatically joins them to Azure AD. If you want to manage such devices, you can configure Azure AD to enroll joined devices in Intune or another mobile device management service automatically. Windows Autopilot uses cloud services to configure your devices. These cloud services must be accessible from your registered Windows Autopilot devices. The following URLs need to be accessible:
    
     -  go.microsoft.com
     -  login.microsoftonline.com
     -  login.live.com
     -  account.live.com
     -  signup.live.com
     -  licensing.mp.microsoft.com
     -  licensing.md.mp.microsoft.com
     -  ctldl.windowsupdate.com
     -  download.windowsupdate.com
