The following steps guide you on how to create roles in the Microsoft 365 Defender portal. It assumes that you have already created Azure Active Directory user groups.

1. Access the Microsoft 365 Defender portal using an account with a Security administrator or Global administrator role assigned.
1. In the navigation pane, select **Settings** then select **Endpoints**. Under the **Permissions** category, select **Roles**.
1. Select the **Turn on roles** button.
1. Select **+ Add item**.
1. Enter the role name, description, and permissions you'd like to assign to the role.
1. Select **Next** to assign the role to an Azure AD Security group.
1. Use the filter to select the Azure AD group that you would like to add this role to.
1. Select **Save**.


> [!IMPORTANT]
> After creating roles, you'll need to create a device group and provide access to the device group by assigning it to a role that you just created.

## Permission options

The permission options:

- View data

  - Security operations - View all security operations data in the portal

  - Threat and vulnerability management - View threat and vulnerability management data in the portal

- Active remediation actions

  - Security operations - Take response actions, approve or dismiss pending remediation actions, manage allowed/blocked lists for automation and indicators

  - Threat and vulnerability management - Exception handling - Create new exceptions and manage active exceptions

  - Threat and vulnerability management - Remediation handling - Submit new remediation requests, create tickets, and manage existing remediation activities  
  
  - Threat and vulnerability management - Application handling - Apply immediate mitigation actions by blocking vulnerable applications, and manage the blocked apps by unblocking if approved

- Threat and vulnerability management – Manage security baselines assessment profiles - Create and manage profiles to assess if your devices comply with security industry baselines

- Alerts investigation - Manage alerts, start automated investigations, run scans, collect investigation packages, manage device tags, and download only portable executable (PE) files

- Manage security settings in Security Center - Configure alert suppression settings, manage folder exclusions for automation, onboard and offboard devices, and manage email notifications, manage evaluation lab

- Manage endpoint security settings in Microsoft Endpoint Manager - Full access to the "Endpoint Security" area in Microsoft Endpoint Manager, Intune "Endpoint Security Manager" role permissions, configure endpoint security and compliance features including Microsoft Defender for Endpoint onboarding, and the ability to view the "Configuration Management" page in Security Center

- Live response capabilities

  - Basic commands:

    - Start a live response session

    - Perform read-only live response commands on remote device (excluding file copy and execution)

  - Advanced commands:

    - Download a file from the remote device via live response

    - Download PE and non-PE files from the file page

    - Upload a file to the remote device

    - View a script from the files library

    - Execute a script on the remote device from the files library

