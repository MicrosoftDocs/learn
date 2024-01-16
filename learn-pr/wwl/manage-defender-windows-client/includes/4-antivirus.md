

Microsoft Defender Antivirus helps protect your computer from spyware, malware, and viruses. Microsoft Defender Antivirus also is Hyper-V–aware, which means that it detects if Windows is running as a virtual machine. Microsoft Defender Antivirus uses definitions to determine if software it detects is unwanted, and it alerts you to potential risks. To help keep definitions up to date, Microsoft Defender Antivirus automatically installs new definitions as they are released.

You can use Microsoft Defender Antivirus to run a Quick, Full, or Custom scan. If you suspect spyware has infected a specific area of a computer, you can customize a scan by selecting specific drives and folders. You also can configure the schedule that Microsoft Defender Antivirus will use.

You can choose to have Microsoft Defender Antivirus exclude processes in your scan. This can make a scan finish more quickly, but your computer will have less protection. When Microsoft Defender Antivirus detects potential spyware activity, it stops the activity, and then it raises an alert.

Alert levels help you determine how to respond to spyware and unwanted software. You can configure Microsoft Defender Antivirus behavior when a scan identifies unwanted software. You also receive an alert if software attempts to change important Windows operating system settings.

To help prevent spyware and other unwanted software from running on a computer, turn on Microsoft Defender Antivirus real-time protection.

Microsoft Defender Antivirus includes automatic scanning options that provide regular scanning and on-demand scanning for malware. The following table identifies scanning options.

| Scan options | Description                                                        |
|--------------|--------------------------------------------------------------------|
| Quick        | Checks the areas that malware, including viruses, spyware, and unwanted software, are most likely to infect. |
| Full         | Checks all files on your hard disk and all running programs.         |
| Custom       | Enables users to scan specific drives and folders.                   |

As a best practice, you should schedule a daily Quick scan. At any time, if you suspect that spyware has infected a computer, run a Full scan. When you run a scan, the progress displays on the Virus &amp; threat protection page in the Windows Security Center. When Microsoft Defender Antivirus detects a potentially harmful file, it moves the file to a quarantine area, and it does not allow it to run or allow other processes to access it. Once the scan is complete, you can open the Scan history page, and in the Quarantined threats section, you can choose to Remove or Restore each discovered threat. Alternatively, if you want to remove all quarantined items, select **Remove All**.

Do not restore software with severe or high alert ratings because it can put your privacy and your computer’s security at risk.

You can add exclusions to stop Microsoft Defender Antivirus from alerting you to threats by adding files, folders, file types, or processes to the Exclusions list. To add an exclusion:

1.  Open **Windows Security Center**.
2.  In Virus &amp; threat protection, select **Virus &amp; threat protection settings**.
3.  On the Virus &amp; threat protection settings page, select **Add or remove exclusions**.
4.  In the Exclusions section, select the plus sign, and then select **File**, **Folder**, **File type**, or **Process** depending on which type of exclusion you want to create. Exclusions for folders apply to subfolders as well.

By using Microsoft Defender Antivirus Offline, you can boot and run a scan from a trusted environment, rather than running Microsoft Defender Antivirus from a fully booted Windows environment. Microsoft Defender Offline runs separate from the Windows kernel and can target malware that bypasses the Windows shell, including malware that may infect or overwrite a computer’s master boot record (MBR). You run also Microsoft Defender Offline scan from the Windows Security Center.

You can configure Microsoft Defender Antivirus with several tools, including:

 -  Microsoft Intune
 -  Configuration Manager
 -  Group Policy
 -  PowerShell cmdlets
 -  Windows Management Instrumentation (WMI)

The following broad categories of features can be configured:

 -  Cloud-delivered protection
 -  Always-on real-time protection, including behavioral, heuristic, and machine-learning-based protection
 -  How end-users interact with the client on individual endpoints

If you use the Microsoft 365 platform, it’s recommended to use Intune to manage Microsoft Defender. To manage Microsoft Defender by using Intune, follow these steps:

1.  In the Microsoft Intune admin center, select **Devices**, then select **Windows** platform, then select **Configuration Profiles**.
2.  Select **Create Profile**.
3.  Enter the following properties:
    
     -  **Platform**: Choose which versions of Windows to include.
     -  **Profile type**: Select **Device restrictions**.
4.  On the **Configuration settings** tab, expand the **Microsoft Defender Antivirus** item and configure the desired settings.

:::image type="content" source="../media/intune-defender-antivirus-1d2f7442.png" alt-text="Screenshot of Windows Defender Antivirus screen.":::


### Additional features in Microsoft Defender Antivirus

Block at First Sight is a feature of Microsoft Defender Antivirus cloud protection that allows Microsoft Defender Antivirus to rapidly identify and block new malware. You enable Block at First Sight through Group Policy. When you enable this feature, both cloud-based protection and Automatic sample submission will be turned on.

Detect and Block Potentially Unwanted Applications is another feature that you can use to block unwanted software during downloading and installation times. For example, you can block software that is bundled with other downloads, advertisement injection software, and driver and registry optimizers. The Detect and Block Potentially Unwanted Applications feature is available to enterprise users whose client infrastructure you manage by using Microsoft Configuration Manager or Intune.
