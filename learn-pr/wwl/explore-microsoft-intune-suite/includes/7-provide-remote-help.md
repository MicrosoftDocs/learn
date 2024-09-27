### Remote Help in the Microsoft Intune Suite

The **Remote Help** feature in the **Microsoft Intune Suite** enables IT professionals to provide real-time support to users, no matter where they're located. As organizations increasingly adopt hybrid and remote work models, this feature allows IT teams to offer efficient, secure assistance to end users without needing physical access to their devices.

> [!IMPORTANT]
> This article describes the capabilities and configuration tasks that are applicable in general for Remote Help across supported platforms. For specific capabilities, prerequisites, and other details based on the platform that you are using, go to:
>
> - [Remote Help on Windows with Microsoft Intune](/mem/intune/fundamentals/remote-help-windows)
> - [Remote Help on Android with Microsoft Intune](/mem/intune/fundamentals/remote-help-android)
> - [Remote Help on macOS with Microsoft Intune](/mem/intune/fundamentals/remote-help-macos)

## Remote Help capabilities and requirements

The Remote Help app supports the following capabilities in general across the supported platforms.

> [!NOTE]
> To know more about specific capabilities and requirements based on the platform that you're using, go to:
>  - [Remote Help on Windows with Microsoft Intune](/mem/intune/fundamentals/remote-help-windows#remote-help-capabilities-and-requirements-on-windows)
>  - [Remote Help on Android with Microsoft Intune](/mem/intune/fundamentals/remote-help-android#remote-help-capabilities-and-requirements-on-android)
>  - [Remote Help on macOS with Microsoft Intune](/mem/intune/fundamentals/remote-help-macos#remote-help-capabilities)

- **Enable Remote Help for your tenant**: By default, Intune tenants aren't enabled for Remote Help. If you choose to turn on Remote Help, its use is enabled tenant-wide. Remote Help must be enabled before users can be authenticated through your tenant when using Remote Help.

- **Use Remote Help with unenrolled devices**: Remote Help is supported on enrolled devices that also need to be Microsoft Entra registered devices. This setting is disabled by default. To allow Remote Help on devices that aren't enrolled in Intune, you must turn on this setting.

- **Requires Organization login**: To use Remote Help, both the helper and the sharer must sign in with a Microsoft Entra account from your organization. You can't use Remote Help to assist users who aren't members of your organization.

- **Compliance Warnings**: Before a helper connects to a user's device, the helper will see a non-compliance warning about that device if it's not compliant with its assigned policies.

- **Role-based access control**: Admins can set RBAC rules that determine the scope of a helper's access, such as:
  - The users who can help others and the range of actions they can do while providing help. For example, who can run elevated privileges while helping.
  - The users who can only view a device, and who can request full control of the session while assisting others.

- **Monitor active Remote Help sessions, and view details about past sessions**: In the Microsoft Intune admin center, you can view reports that include details about who helped who, on what device, and for how long. You can also find details about active sessions. An administrator can also reference audit log sessions created for Remote Help in Intune under **Tenant Administration** > **Audit Logs**.

  For unenrolled devices, auditing the Remote Help sessions is limited.

## Prerequisites

General prerequisites that apply to Remote Help:

  - [Intune subscription](/mem/intune/fundamentals/licenses)
  - [Remote Help add on license or an Intune Suite license](/mem/intune/fundamentals/intune-add-ons#available-add-ons) for all IT support workers (helpers) and users (sharers) that are targeted to use Remote Help and benefit from the service.
  - [Supported platforms and devices](/mem/intune/fundamentals/remote-help#supported-platforms-and-devices)

For specific prerequisites based on the platform that you're using, go to:

- [Remote Help on Windows with Microsoft Intune](/mem/intune/fundamentals/remote-help-windows#prerequisites-for-remote-help-on-windows)
- [Remote Help on Android with Microsoft Intune](/mem/intune/fundamentals/remote-help-android#prerequisites-for-remote-help-on-android)
- [Remote Help on macOS with Microsoft Intune](/mem/intune/fundamentals/remote-help-macos#remote-help-requirements)

Limitations:  

- Remote Help is supported in Government Community Cloud (GCC) environments on the following platforms:

  - Windows 10/11
  - Windows 10/11 on ARM64 devices
  - Windows 365
  - Samsung and Zebra devices enrolled as Android Enterprise dedicated devices
  - macOS 12, 13, 14

    Remote Help isn't supported on GCC High or DoD (U.S. Department of Defense) tenants. For more information, go to [Microsoft Intune for US Government GCC High and DoD service description](/mem/intune/fundamentals/intune-govt-service-description).

  - You can't establish a Remote Help session from one tenant to a different tenant.
  - Remote Help might not be available in all markets or localizations.

### Supported platforms and devices

This feature is supported on the following platforms:
- Windows 10/11
- Windows 10/11 on ARM64 devices
- Windows 365
- Samsung and Zebra devices enrolled as Android Enterprise dedicated devices
- macOS 12, 13, and 14

### Data and privacy considerations for Remote Help in Microsoft Intune

When utilizing the **Remote Help** feature within Microsoft Intune, certain data is logged to ensure security and compliance. Microsoft records the following information:

- **Session Start and End Times**: The duration of each remote help session is logged and stored on Microsoft's servers for 30 days.

- **Participant Details**: Information about who provided assistance to whom, including device identifiers, is stored for 30 days.

- **Error Logs**: Any errors encountered during the session, such as unexpected disconnections, are recorded. These error logs are stored on the sharer's device within the event viewer.

- **Feature Usage**: Details about features utilized during the session, like "view only" mode or elevation actions, are stored on Microsoft's servers for 30 days.

These data collection practices are designed to maintain a high level of security and to ensure compliance with organizational policies. For more detailed information, refer to Microsoft's documentation on [Remote Help](/mem/intune/fundamentals/remote-help).

During a **Remote Help** session, both the helper (the IT professional providing assistance) and the sharer (the user receiving help) have visibility into certain details from each other’s organizational profiles. This transparency helps verify the identity of both parties, ensuring trust and accountability during the session. The following information is visible to both individuals:

- **Profile Picture**: If a profile picture is present in the organization’s directory, it will be visible to the other participant.
- **Company Name**: The name of the organization associated with each individual is displayed, ensuring that both parties are from recognized and trusted sources.
- **Verified Domain**: The domain associated with the individual's email or organization, confirming their association with a legitimate organization.
- **First and Last Name**: The full name of both the helper and sharer is shown, aiding in identification.
- **Job Title**: The job title listed in the organization’s profile is visible, providing context on the individual’s role within the company.

These details are drawn from the respective organizational profiles, and are essential for building a secure and trustworthy connection between both parties during the support session.

### Data Retention Policy

Microsoft follows a strict data retention policy to ensure user privacy. All data related to the helper and sharer is stored for no longer than **30 days**. After this period, Microsoft permanently deletes all session-related data. This approach ensures that personal and session data isn't stored indefinitely, aligning with privacy best practices and regulatory compliance requirements.

### Configure Remote Help for your tenant

To configure **Remote Help** in your tenant, follow these steps to ensure the feature is properly set up across all supported platforms.

### Step 1: Enable Remote Help

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/#home) and navigate to **Tenant administration** > **Remote Help**.

2. On the **Settings** tab, configure the following:
   - Set **Enable Remote Help** to **Enabled**. By default, this setting is **Disabled**.
   - If you wish to allow Remote Help on unenrolled devices, set **Allow Remote Help to unenrolled devices** to **Enabled**. This setting is also **Disabled** by default.
   - If you prefer to disable the chat function, set **Disable chat** to **Yes**. By default, this feature is enabled, and the setting is **No**.

3. Select **Save** to apply these settings.

> [!NOTE] 
> Once licenses are purchased or a trial is started, activation might take between 30 minutes to 8 hours. If you attempt to initiate a Remote Help session before the licenses are fully activated, you may see a message indicating that Remote Help isn't enabled for your tenant.

### Step 2: Configure permissions for Remote Help

Remote Help uses **Intune Role-Based Access Control (RBAC)** to define the level of access for the helper. RBAC ensures that helpers can only perform actions within the limits set by their role, maintaining security and protecting privacy.

- **Helpers should use the minimum required privileges** to provide remote assistance. An **Unattended session** should only be requested if there's no user present at the sharer's device to accept the session.

You can manage the following permissions for the **Remote Help app** within Intune RBAC. Set each permission to **Yes** or **No** to control access:

- **Elevation**  
- **View screen**  
- **Take full control**  
- **Unattended control**

> [!IMPORTANT] 
> - If **Take full control** is set to **Yes**, the user automatically gains **View screen** permission, even if it’s set to **No**.
> - If **Elevation** is set to **Yes**, the user gains additional permissions for **View screen** and **Take full control**, even if those permissions are set to **No**.
> - If **Unattended control** is set to **Yes**, the user is automatically granted permissions for **View screen**, **Take full control**, and **Elevation**, even if those are set to **No**.

Additionally, under the **Remote tasks** category, you can enable the permission to **Offer remote assistance**.

By default, the built-in **Help Desk Operator** role grants all these permissions. You can customize these roles or create new ones as needed.

### Step 3: Assign users to roles

Once you’ve created the roles that manage Remote Help permissions, assign users to these roles.

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/#home) and navigate to **Tenant administration** > **Roles**.
2. Select a role that grants Remote Help permissions.
3. Choose **Assignments** > **Assign** to open the **Add Role Assignment** window.
4. Enter an **Assignment name** and optional **Assignment description**, then choose **Next**.
5. On the **Admin Groups** page, select the group containing the user to whom you want to assign permissions. Choose **Next**.
6. On the **Scope (Groups)** page, select the group containing users or devices that the helper is allowed to manage, or select all users or devices. Choose **Next** to proceed.
7. On the **Review + Create** page, verify your settings and choose **Create**.

> [!IMPORTANT]  
> A helper cannot provide assistance if the sharer or their device is outside the scope of the helper’s role.

### Monitoring and reports

You can monitor Remote Help usage within the **Microsoft Intune admin center**. For unenrolled devices, reporting may be limited.

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/#home) and navigate to **Tenant administration** > **Remote Help**.
2. On the **Monitor** tab, you’ll see a count of active sessions and historical data for previous sessions.
3. On the **Remote Help sessions** tab, you can view session records, including:
   - Helper (Provider ID) and sharer (Recipient ID)
   - The device that received assistance
   - Start and end times of the session
   - The type of control granted during the session

> [!NOTE] 
> For Android Enterprise Dedicated devices without user affinity, the **Recipient ID** and **Recipient name** fields will display "--".

This guide outlines the process for setting up, configuring, and monitoring **Remote Help** in the **Microsoft Intune Suite** while detailing role-based access control and reporting capabilities. 

### Try an interactive demo

The [Remote Help](https://regale.cloud/Microsoft/viewer/1746/remote-help/index.html#/0/0) interactive demo walks you through scenarios step by step with interactive annotations and navigation controls.