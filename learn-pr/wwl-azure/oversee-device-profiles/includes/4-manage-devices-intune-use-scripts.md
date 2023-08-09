
The Intune management extension lets you upload PowerShell scripts in Intune to run on Windows devices, in addition to shell scripts for the macOS. The management extension supplements mobile device management (MDM) capabilities and makes it easier for you to move to modern management.

You can create scripts to run on the devices that provide the capabilities you need. For example, you can create a PowerShell script that installs a legacy Win32 app on your Windows devices, upload the script to Intune, assign the script to an Azure Active Directory (Azure AD) group, and run the script on Windows devices. You can then monitor the run status of the script on Windows devices from start to finish.

The Intune management extension has the following prerequisites:

| **Windows**                                                             | **macOS**                                                                                            |
| ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Version 1607 or later.                                                  | version 10.12 or later                                                                               |
| Devices must be joined to Azure AD, including Hybrid AD joined devices. | Devices are managed by Intune.                                                                       |
| Automatic MDM enrollment must be enabled in Azure AD.                   | Shell scripts begin with #! and must be in a valid location such as #!/bin/sh or #!/usr/bin/env zsh. |
|                                                                         | Command-line interpreters for the applicable shells are installed.                                   |


### Create a PowerShell script policy for Windows

1.  In the Microsoft Intune admin center, select **Devices**.
2.  In the Policy section, select **Scripts** and select **Add**, then select **Windows 10 and later**.
    
    Adding scripts is similar to the process for creating a profile. After adding a name and description, you'll configure the Script settings.

3.  In **Script settings**, enter the following properties:
    
     -  **Script location**: Browse to the PowerShell script. The script must be less than 200 KB (ASCII).
     -  **Run this script using the logged on credentials**: Select Yes to run the script with the user's credentials on the device. Choose No (default) to run the script in the system context. Many administrators choose Yes. If the script is required to run in the system context, choose No.
     -  **Enforce script signature check**: Select Yes if the script must be signed by a trusted publisher. Select No (default) if there isn't a requirement for the script to be signed.
     -  **Run script in 64-bit PowerShell host**: Select Yes to run the script in a 64-bit PowerShell host on a 64-bit client architecture. Select No (default) runs the script in a 32-bit PowerShell host.
4.  Select **Next** and configure scope tags and assignments. Note that PowerShell scripts in Intune can be targeted to Azure AD device security groups or Azure AD user security groups.

### Create a shell script policy for macOS

Adding a script for the macOS uses the same steps creating a PowerShell script policy, selecting **macOS** after choosing **Add**. The macOS script settings are slightly different.

1.  In **Script settings**, enter the following properties:
    
     -  **Upload script**: Browse to the PowerShell script. The script must be less than 200 KB (ASCII).
     -  **Run script as signed-in user**: Select **Yes** to run the script with the user's credentials on the device. Choose **No** (default) to run the script as the root user.
     -  **Hide script notifications on devices**: By default, script notifications are shown for each script that is run. End users see an IT is configuring your computer notification from Intune on macOS devices.
     -  **Script frequency**: Select how often the script is to be run. Choose **Not configured** (default) to run a script only once.
     -  **Max number of times to retry if script fails**: Select how many times the script should be run if it returns a non-zero exit code (zero, meaning success). Choose **Not configured** (default) to not retry when a script fails.
2.  Select **Next** and configure scope tags and assignments. Note that shell scripts assigned to user groups apply to any user signing in to the Mac.
