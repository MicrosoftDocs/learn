A team manages a Windows Server environment with Active Directory Domain Services (ADDS). New employee onboarding requires creating user accounts, assigning group memberships, setting up home directories, and configuring email. Doing all these tasks manually, is time-consuming and error-prone.

> [!NOTE]
> The prompts shown in this unit illustrate how an operations engineer might interact with the Plan agent for each scenario. They're examples of effective prompt patterns that demonstrate the kind of context the agent needs. They're not step-by-step instructions to follow.



An engineer starting this automation would describe the full scope of the task to the Plan agent in a single prompt. An example of how that prompt might be structured:

```text
/plan Create a PowerShell script for automating new employee onboarding in Active Directory. The script should read a CSV file of new hires with columns for FirstName, LastName, Department, JobTitle, and Manager. For each user, it should create an AD account, set the correct OU based on department, add the user to department-specific security groups, create a home directory on \\fileserver\homes$, and set NTFS permissions.
```

The Plan agent researches your workspace and generates a structured plan:

1. Create a `New-EmployeeOnboarding.ps1` script with a parameter for the CSV file path.
2. Define a department-to-OU mapping hashtable.
3. Implement a function to create the AD user account with `New-ADUser`, setting properties like display name, title, department, and manager.
4. Implement a function to add the user to department-specific groups using `Add-ADGroupMember`.
5. Implement a function to create the home directory and set NTFS permissions using `New-Item` and `Set-Acl`.
6. Add logging to track successful and failed operations for each user.
7. Add verification steps to validate the script with a test CSV file in a nonproduction OU.

## Iterate on the plan

After reviewing the plan, the engineer notices it doesn't handle existing users or duplicate accounts. A follow-up prompt to address this gap might look like:

```text
Add a check for existing accounts before creation. If a username already exists, generate an alternative username by appending a number. Also add an email notification to the manager when the account is ready.
```

The Plan agent revises the plan to include username conflict resolution and an email notification step using `Send-MailMessage`.

## Scenario: Harden a Windows Server baseline

Security hardening involves multiple configuration changes across different system areas. Planning all changes before implementation helps avoid lockouts or service disruptions. An example of how an engineer might describe a hardening goal to the Plan agent:

```text
/plan Create a PowerShell DSC (Desired State Configuration) document that hardens a Windows Server 2022 baseline. Include: disabling SMBv1, enforcing TLS 1.2 as minimum, configuring Windows Firewall to block all inbound traffic except RDP (port 3389) from the management subnet 10.0.1.0/24, disabling unused services (Print Spooler, Xbox services), and configuring audit policies for logon events and object access.
```

The Plan agent generates a comprehensive plan:

1. Create a DSC configuration file `ServerHardening.ps1` with a configuration block.
2. Add a resource to disable SMBv1 using the `WindowsFeature` resource.
3. Add registry resources to enforce TLS 1.2 and disable TLS 1.0/1.1.
4. Add `Firewall` resources from the `NetworkingDsc` module to configure inbound rules.
5. Add `Service` resources to disable Print Spooler and Xbox-related services.
6. Add `AuditPolicySubcategory` resources from the `AuditPolicyDsc` module to configure audit logging.
7. Create a `Deploy-ServerHardening.ps1` script that compiles and applies the DSC configuration.
8. Add verification steps to test the configuration with `Test-DscConfiguration` and validate compliance.

## Scenario: Create a server monitoring and alerting script

Monitoring server health is a routine operations task. A structured approach is helpful when requirements span multiple metrics and notification channels. An example prompt for this kind of monitoring scenario:

```text
/plan Create a PowerShell script that monitors Windows Server health and sends alerts. The script should check: CPU usage (alert if above 90% for 5 minutes), memory usage (alert if above 85%), disk space (alert if any drive is below 10% free), and critical Windows services (DNS, DHCP, Active Directory Domain Services). Send alerts via email and write events to a custom Windows Event Log.
```

The plan might include:

1. Create a `Monitor-ServerHealth.ps1` script with configurable threshold parameters.
2. Implement CPU monitoring using `Get-Counter` with a sampling period.
3. Implement memory monitoring using `Get-CimInstance Win32_OperatingSystem`.
4. Implement disk monitoring using `Get-CimInstance Win32_LogicalDisk`.
5. Implement service monitoring using `Get-Service` for each critical service.
6. Create a custom event log source using `New-EventLog`.
7. Implement an alert function that sends email via `Send-MailMessage` and writes to the event log.
8. Create a scheduled task registration script to run the monitor at specified intervals.

## Tips for effective system administration prompting

When you use the Plan agent for system administration tasks, consider including:

- **Target environment details**: Specify the operating system version, domain name, or server role.
- **Existing infrastructure**: Mention existing scripts, modules, or configurations that the new code should integrate with.
- **Error handling expectations**: State whether the script should stop on first error, continue and log, or require manual intervention.
- **Testing approach**: Describe how you plan to test (nonproduction OU, test servers, dry-run mode).
- **Output requirements**: Specify logging format, report output, or notification preferences.

> [!NOTE]
> The Plan agent works with whatever files are in your workspace. If you have existing PowerShell modules, DSC configurations, or script libraries in your repository, the agent references them when generating plans. This means your plans are tailored to your team's existing code and patterns, not generic templates.
