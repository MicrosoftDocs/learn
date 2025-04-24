The Microsoft Purview Information Protection scanner extends labeling and protection to on-premises files. Before running scans, you need to define scanner settings, install the service, configure authentication, and optionally enable data loss prevention (DLP) rules.

## Step 1: Configure scanner settings in the portal

Start in the Microsoft Purview portal. First, define a scanner cluster, which acts as a logical container for the scanner instance. Then, create one or more content scan jobs to specify the schedule, labeling behavior, and repositories to scan.

You need one of these Microsoft Purview roles to configure the scanner in the portal:

- Compliance Administrator
- Compliance Data Administrator
- Security Administrator
- Organization Management

### Steps to configure scanner settings

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) > **Settings** > **Information Protection** > **Information protection scanner**.
1. On the Clusters tab, select **Add**.
1. Give your cluster a **name** and optional **description**.
1. Select **Save** to save your changes.

The cluster name is required later when you install the scanner.

### Create the content scan job

1. On the **Content scan jobs** tab, select **Add**.
1. Configure the scan job settings:

   - **Schedule**: Controls how often the scan runs. The default setting is **Manual**. Change it to **Always** to enable continuous scanning.
   - **Info types to be discovered**: Determines which information types are identified during scanning. Choose Policy only to scan only for types defined in your labeling policy, or All to include all built-in types.
   - **Enable DLP rules**: Activates enforcement of data loss prevention policies. Set to On only if a DLP policy is already configured in Microsoft Purview.
   - **Enforce sensitivity labeling policy**: Turns automatic labeling on or off. Set this to On if you want the scanner to apply sensitivity labels based on content.
   - **Relabel files**: Specifies whether files that already have a label can be relabeled. Turn this on if you want labels to be updated during scanning.
   - **Preserve metadata**: Keeps original file attributes such as Date modified, Last modified, and Modified by during scanning. This setting is On by default.

     :::image type="content" source="../media/content-scan-job.png" alt-text="Screenshot showing where to edit a content scan job for the Microsoft Purview Information Protection scanner." lightbox="../media/content-scan-job.png":::

1. Add repositories on the **Repositories** tab:
    - Use UNC paths, for example: `\\Server\Folder`
    - Use local file paths, for example: `C:\Folder`
    - Add SharePoint Server libraries, for example: `http://sp2016/Shared Documents/Reports`
    - To scan an entire SharePoint root site, for example `http://sp2016`, the scanner account must have **Site Collection Auditor** permissions

      :::image type="content" source="../media/repository-settings.png" alt-text="Screenshot showing the repository settings for the Microsoft Purview Information Protection scanner." lightbox="../media/repository-settings.png":::

## Step 2: Install the scanner service

Once you configured your cluster and scan job, the next step is to install the scanner service on a supported Windows Server. This step uses PowerShell and requires that you meet a few key setup requirements.

### Prerequisites

Before you begin installation, make sure the following requirements are met:

- You're installing on a **64-bit Windows Server 2016 or later**.
- The server has at least **4 CPU cores**, **8 GB of RAM**, and **10 GB of available disk space**.
- The **Microsoft Purview Information Protection client** (full version) is already installed on the server.
- A **SQL Server 2016 or later** instance is available to store the scanner's configuration database. This can be a local or remote SQL Server.
- You have the **scanner cluster name** you defined earlier in the Microsoft Purview portal. This is required during installation.

### Install using PowerShell

Open a PowerShell session with Run as administrator on the Windows Server that hosts the scanner. Run this command to install the scanner:

``` powershell
Install-Scanner -SqlServerInstance <SQLServerName> -Cluster <ClusterName>
```

Example:

``` powershell
Install-Scanner -SqlServerInstance SQL01\SCANNER -Cluster Europe
```

After you run the command, you'll be prompted to enter the credentials for the scanner service account. This should be an Active Directory account that is synced to Microsoft Entra ID.

When the installation completes, a Windows service named **Microsoft Purview Information Protection Scanner** is created and set to run under the service account you provided.

## Step 3: Authenticate with Microsoft Entra ID

To allow the scanner to run unattended and apply sensitivity labels, it needs to authenticate with Microsoft Entra ID using an app registration. This step connects the scanner to Microsoft Purview services securely and enables policy enforcement.

### Set up API permissions in Microsoft Entra ID

The app registration used by the scanner must be granted specific permissions:

- Azure Rights Management Service
  - `Content.DelegatedReader`: allows the scanner to read sensitivity labels and policies.
  - `Content.DelegatedWriter`: allows the scanner to apply or remove labels and protection.

- Microsoft Information Protection Sync Service
  - `UnifiedPolicy.Tenant.Read`: allows the scanner to retrieve labeling policies.

These permissions must be added and admin consent granted in the Microsoft Entra admin center before proceeding.

### Authenticate using PowerShell

Once permissions are configured, use this PowerShell command to authenticate the scanner:

``` powershell
Set-Authentication -AppId <AppID> -AppSecret <Secret> -TenantId <TenantID> -DelegatedUser <EntraUser>
```

Example:

``` powershell
Set-Authentication -AppId "77c3c1c3-abf9-404e-8b2b-4652836c8c66" `
  -AppSecret "OAkk+rnuYc/u+]ah2kNxVbtrDGbS47L4" `
  -TenantId "9c11c87a-ac8b-46a3-8d5c-f4d0b72ee29a" `
  -DelegatedUser scanner@contoso.com
```

If the scanner service account isn't allowed to sign in locally, use the `-OnBehalfOf` parameter along with credentials for the service account:

Example:

``` powershell
$creds = Get-Credential CONTOSO\scanner
Set-Authentication -AppId "<AppID>" -AppSecret "<Secret>" -TenantId "<TenantID>" `
  -DelegatedUser scanner@contoso.com -OnBehalfOf $creds
```

After this step, the scanner is registered with Microsoft Entra ID and ready to classify and protect content according to your configured policies.

## Step 4: Turn on policy enforcement

When first created, content scan jobs are set to discovery mode by default. This means the scanner scans files but doesn't apply labels or enforce protection. To move from discovery to enforcement, you need to update the scan job configuration.

### Update the scan job in the Microsoft Purview portal

Follow these steps to enable protection:

1. In the Microsoft Purview portal, go to the Content scan jobs tab.
1. Select the scan job you created earlier.
1. Change the **Schedule** setting from **Manual** to **Always** so that the scan runs continuously.
1. Turn on **Enforce sensitivity labeling policy**. This allows the scanner to apply labels and protection automatically based on the policy.
1. Once a scanner node is online, select **Scan now** to begin the job.

> [!TIP]
> The **Scan now** button only appears when a scanner node is connected and available.

### Use PowerShell to enable enforcement

If you're configuring the scanner using PowerShell, use this command:

``` powershell
Set-ScannerContentScan -Schedule Always -Enforce On
```

This command changes the scan job from manual to continuous and enables policy enforcement, allowing the scanner to apply classification and protection to the scanned files.

## Step 5: Run your first scan

With configuration complete, go back to the Microsoft Purview portal and start your first scan by selecting **Scan now** on your content scan job. This action starts the scan using your defined settings.

It's a good practice to begin in discovery mode to review what the scanner finds without making changes. Once you're confident in the results, switch to enforcement to apply labeling and protection.
