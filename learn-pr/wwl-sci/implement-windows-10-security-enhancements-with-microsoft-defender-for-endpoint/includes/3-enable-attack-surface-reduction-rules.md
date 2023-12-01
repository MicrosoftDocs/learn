Your attack surface includes all the places where an attacker could compromise your organization's devices or networks. Reducing your attack surface means protecting your organization's devices and network, which leaves attackers with fewer ways to perform attacks.

Attack surface reduction rules target certain software behaviors that are often abused by attackers. Such behaviors include:

- Launching executable files and scripts that attempt to download or run files

- Running obfuscated or otherwise suspicious scripts

- Performing behaviors that apps don't usually initiate during normal day-to-day work.

Such software behaviors are sometimes seen in legitimate applications; however, these behaviors are often considered risky because they're commonly abused by malware. Attack surface reduction rules can constrain risky behaviors and help keep your organization safe.

Each Attack Surface Reduction rule contains one of four settings:

- **Not configured**: Disable the attack surface reduction rule

- **Block**: Enable the Attack Surface Reduction rule

- **Audit**: Evaluate how the attack surface reduction rule would impact your organization if enabled

- **Warn**: Enable the Attack Surface Reduction rule but allow the end user to bypass the block

## Attack surface reduction rules

Attack Surface Reduction rules currently support the rules below:

- Block executable content from email client and webmail
- Block all Office applications from creating child processes
- Block Office applications from creating executable content
- Block Office applications from injecting code into other processes
- Block JavaScript or VBScript from launching downloaded executable content
- Block execution of potentially obfuscated scripts
- Block Win32 API calls from Office macro
- Use advanced protection against ransomware
- Block credential stealing from the Windows local security authority subsystem (lsass.exe)
- Block process creations originating from PSExec and WMI commands
- Block untrusted and unsigned processes that run from USB
- Block executable files from running unless they meet a prevalence, age, or trusted list criteria
- Block Office communication applications from creating child processes
- Block Adobe Reader from creating child processes
- Block persistence through WMI event subscription

## Exclude files and folders from attack surface reduction rules

You can exclude files and folders from being evaluated by most attack surface reduction rules. This means that even if an attack surface reduction rule determines the file or folder contains malicious behavior, it will not block the file from running, which also means potentially unsafe files are allowed to run and infect your devices.

You exclude attack surface reduction rules from triggering based on certificate and file hashes by allowing specified Defender for Endpoint file and certificate indicators.

You can specify individual files or folders (using folder paths or fully qualified resource names), but you can't specify which rules the exclusions apply to. An exclusion is applied only when the excluded application or service starts. For example, if you add an exclusion for an update service that is already running, the update service will continue to trigger events until the service is stopped and restarted.

## Audit mode for evaluation

Use audit mode to evaluate how attack surface reduction rules would impact your organization if they were enabled. It's best to run all rules in audit mode first so you can understand their impact on your line-of-business applications. Many line-of-business applications are written with limited security concerns, and they may perform tasks in ways that seem similar to malware. By monitoring audit data and adding exclusions for necessary applications, you can deploy attack surface reduction rules without impacting productivity.

## Notifications when a rule is triggered

Whenever a rule is triggered, a notification will be displayed on the device. You can customize the notification with your company details and contact information. The notification also displays within the Microsoft 365 Defender portal.

## Configure attack surface reduction rules

You can set these rules for devices running any of the following editions and versions of Windows:

- Windows 10 Pro, version 1709 or later
- Windows 10 Enterprise, version 1709 or later
- Windows Server, version 1803 (Semi-Annual Channel) or later
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2022

You can enable attack surface reduction rules by using any of these methods:

- Microsoft Intune
- Mobile Device Management (MDM)
- Microsoft Endpoint Configuration Manager
- Group Policy
- PowerShell

Enterprise-level management such as Intune or Microsoft Endpoint Configuration Manager is recommended. Enterprise-level management will overwrite any conflicting Group Policy or PowerShell settings on startup.

### Intune

#### Device Configuration Profiles:

1. Select **Device configuration > Profiles**. Choose an existing endpoint protection profile or create a new one. To create a new one, select **Create profile** and enter information for this profile. For Profile type, select **Endpoint protection**. If you've chosen an existing profile, select **Properties** and then select **Settings**.

1. In the Endpoint protection pane, select **Windows Defender Exploit Guard**, then select **Attack Surface Reduction**. Select the desired setting for each rule.

1. Under Attack Surface Reduction exceptions, enter individual files and folders. You can also select Import to import a CSV file that contains files and folders to exclude from attack surface reduction rules. Each line in the CSV file should be formatted as follows:

    C:\folder, %ProgramFiles%\folder\file, C:\path

1. Select **OK** on the three configuration panes. Then select Create if you're creating a new endpoint protection file or Save if you're editing an existing one.

#### Endpoint security policy:

1.  Select **Endpoint Security > Attack surface reduction**. Choose an existing rule or create a new one. To create a new one, select **Create Policy** and enter information for this profile. For Profile type, select **Attack surface reduction rules**. If you've chosen an existing profile, select **Properties** and then select **Settings**.

1. In the Configuration settings pane, select **Attack Surface Reduction** and then select the desired setting for each rule.

1. Under **List of additional folders that need to be protected, List of apps that have access to protected folders, and Exclude files and paths from attack surface reduction rules**, enter individual files and folders. You can also select Import to import a CSV file that contains files and folders to exclude from attack surface reduction rules. Each line in the CSV file should be formatted as follows:  

    C:\folder, %ProgramFiles%\folder\file, C:\path

1. Select **Next** on the three configuration panes, then select **Create** if you're creating a new policy or **Save** if you're editing an existing policy.

### Mobile device management

To manage the attack surface reduction rules in mobile device management:

- Use the ./Vendor/MSFT/Policy/Config/Defender/AttackSurfaceReductionRules configuration service provider (CSP) to individually enable and set the mode for each rule.

- Follow the mobile device management reference in [Attack surface reduction rules](/windows/security/threat-protection/microsoft-defender-atp/attack-surface-reduction#attack-surface-reduction-rules?azure-portal=true) for using GUID values.

- OMA-URI path: ./Vendor/MSFT/Policy/Config/Defender/AttackSurfaceReductionRules

- Value: 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84=2|3B576869-A4EC-4529-8536-B80A7769E899=1|D4F940AB-401B-4EfC-AADC-AD5F3C50688A=2|D3E037E1-3EB8-44C8-A917-57927947596D=1|5BEB7EFE-FD9A-4556-801D-275E5FFC04CC=0|BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550=1

- The values to enable, disable, or enable in audit mode are:

  - Disable = 0

  - Block (enable attack surface reduction rule) = 1

  - Audit = 2

- Use the ./Vendor/MSFT/Policy/Config/Defender/AttackSurfaceReductionOnlyExclusions configuration service provider (CSP) to add exclusions.

Example:

- OMA-URI path: ./Vendor/MSFT/Policy/Config/Defender/AttackSurfaceReductionOnlyExclusions

- Value: c:\path|e:\path|c:\wlisted.exe

### Microsoft Endpoint Configuration Manager

To manage the attack surface reduction rules in Microsoft Endpoint Configuration Manager:

1. In Microsoft Endpoint Configuration Manager, go to **Assets and Compliance > Endpoint Protection > Windows Defender Exploit Guard**.

1. Select **Home > Create Exploit Guard Policy**.

1. Enter a name and a description, select **Attack Surface Reduction**, and select **Next**.

1. Choose which rules will block or audit actions and select **Next**.

1. Review the settings and select **Next** to create the policy.

1. After the policy is created select **Close**.

### Group policy

To manage the attack surface reduction rules in Group Policy:

> [!WARNING]
> If you manage your computers and devices with Intune, Configuration Manager, or another enterprise-level management platform, the management software will overwrite any conflicting Group Policy settings on startup.

1. On your Group Policy management computer, open the Group Policy Management Console, right-click the Group Policy Object you want to configure, and select **Edit**.

1. In the Group Policy Management Editor, go to Computer configuration and select Administrative templates.

1. Expand the tree to **Windows components > Microsoft Defender Antivirus > Windows Defender Exploit Guard > Attack surface reduction**.

1. Select **Configure Attack surface reduction rules** and select **Enabled**. You can then set the individual state for each rule in the options section.

1. Select Show... and enter the rule ID in the Value name column and your chosen state in the Value column as follows:

    Disable = 0
    Block (enable attack surface reduction rule) = 1
    Audit = 2

1. To exclude files and folders from attack surface reduction rules, select the **Exclude files and paths from Attack surface reduction rules** setting and set the option to **Enabled**. Select **Show** and enter each file or folder in the Value name column. Enter **0** in the Value column for each item.

### PowerShell

To manage the attack surface reduction rules with PowerShell:

> [!WARNING]
> If you manage your computers and devices with Intune, Configuration Manager, or another enterprise-level management platform, the management software will overwrite any conflicting PowerShell settings on startup. To allow users to define the value using PowerShell, use the "User Defined" option for the rule in the management platform.

1. Type *PowerShell* in the Start menu, right-click Windows PowerShell, and select Run as administrator.

1. Enter the following cmdlet:
    
    ```powershell
    Set-MpPreference -AttackSurfaceReductionRules_Ids <rule ID> -AttackSurfaceReductionRules_Actions Enabled

    ```

1. To enable attack surface reduction rules in audit mode, use the following cmdlet:

    ```powershell
    Add-MpPreference -AttackSurfaceReductionRules_Ids <rule ID> -AttackSurfaceReductionRules_Actions AuditMode

    ```

1. To turn off attack surface reduction rules, use the following cmdlet:

    ```powershell
    Add-MpPreference -AttackSurfaceReductionRules_Ids <rule ID> -AttackSurfaceReductionRules_Actions Disabled

    ```

1. You must specify the state individually for each rule, but you can combine rules and states in a comma-separated list.
1. In the following example, the first two rules will be enabled, the third rule will be disabled, and the fourth rule will be enabled in audit mode:

    ```powershell
    Set-MpPreference -AttackSurfaceReductionRules_Ids <rule ID 1>,<rule ID 2>,<rule ID 3>,<rule ID 4> -AttackSurfaceReductionRules_Actions Enabled, Enabled, Disabled, AuditMode

    ```

1. You can also use the Add-MpPreference PowerShell verb to add new rules to the existing list.
1. Set-MpPreference will always overwrite the existing set of rules. If you want to add to the existing set, you should use Add-MpPreference instead. You can obtain a list of rules and their current state by using Get-MpPreference.
1. To exclude files and folders from attack surface reduction rules, use the following cmdlet:

    ```powershell
    Add-MpPreference -AttackSurfaceReductionOnlyExclusions "<fully qualified path or resource>"

    ```

1. Continue to use Add-MpPreference -AttackSurfaceReductionOnlyExclusions to add more files and folders to the list.

> [!IMPORTANT]
> Use Add-MpPreference to append or add apps to the list. Using the Set-MpPreference cmdlet will overwrite the existing list.

### List of attack surface reduction events

All attack surface reduction events are located under Applications and Services Logs > Microsoft > Windows in the Windows Event viewer.
