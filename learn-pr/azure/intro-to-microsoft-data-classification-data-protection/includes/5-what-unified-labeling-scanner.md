This unit describes the Microsoft Purview Information Protection scanner, formerly named the Azure Information Protection unified labeling scanner or on-premises scanner. The information protection scanner runs as a service on Windows Server, as an alternative to using local Windows Server file classification infrastructure (FCI). You can use the scanner to define classification rules and help discover, classify, and protect files in the following locations:

- Local folders on a Windows Server computer that runs the scanner.
- Universal Naming Convention (UNC) paths for network shares that use the Server Message Block (SMB) protocol.
- Sites and libraries for SharePoint Server 2013 through SharePoint Server 2019.

The scanner can inspect any files that Windows can index by using `IFilter` handlers installed on the Windows Server computer. To determine if the files need labeling, the scanner uses the built-in data loss prevention (DLP) sensitivity information types and pattern detection, or regex patterns. The scanner uses the Azure Information Protection client, and can classify and protect the same types of files as the client.

The following diagram shows the scanner architecture, where the scanner discovers files across your on-premises and SharePoint servers.

:::image type="content" source="../media/5-ul-scanner-arch.png" alt-text="Diagram that shows unified labeling scanner architecture." lightbox="../media/5-ul-scanner-arch.png":::

You can run the scanner in *discovery mode* to discover files that contain sensitive information types, and view reports. After you configure label policies that apply automatic classification, you can label the files that the scanner discovers. You can optionally apply or remove protection.

The scanner doesn't discover and label in real time. It systematically crawls through files on data stores that you specify. You can configure this cycle to run once, or repeatedly. You can specify file types or specific files to scan or exclude.

## Configure the scanner

Scanner configuration has moved from the Azure portal to the Microsoft Purview Compliance Portal. You can also use PowerShell to configure the scanner.

To configure the scanner in the compliance portal:

1. Sign in to the compliance portal with one of the following roles:

   - **Compliance Administrator**
   - **Compliance Data Administrator**
   - **Security Administrator**
   - **Global Administrator**
   - **Organization Management**

1. Select **Settings** in the left navigation, and then select **Information protection scanner** in the **Settings** pane.

1. On the **Information protection scanner** screen, select **Add** on the **Clusters** tab and create a new cluster. This cluster defines your scanner and identifies the scanner instance during installation, upgrades, and other processes.

1. Select the **Content scan jobs** tab, and select **Add** to create a content scan job.

1. On the **Edit content scan job** tab, configure the following settings among others:

   - **Schedule**
   - **Info types to be discovered**
   - Labeling policy to enforce
   - **Default label**
   - File types to scan

1. After you save the content scan job, open it and select the **Repositories** tab to specify the location you want to scan.

1. Select **Add**, and on the **Repository** screen, enter a **Path** for the data repository. Set any other configurations as needed. Repeat these steps for as many paths as you need to add.

## Install and use the scanner

After you configure the scanner in the compliance portal, you install the Azure Information Protection scanner software on the target computers. Use an account that has local administrator rights and permissions to write to the SQL Server database.

1. Install the Azure Information Protection unified labeling client on the machine.

1. Use the `Install-AIPScanner` PowerShell cmdlet to install the scanner components. Specify the cluster name you created, and the SQL Server instance to use for the scanner database.

   ```powershell
   Install-AIPScanner -SqlServerInstance <name> -Cluster <cluster name>
   ```

After you install the scanner, the scanner service account needs an Azure Active Directory (Azure AD) token to authenticate the scanner to run unattended.

1. In the Azure portal, create an Azure AD application and copy the Application ID and client secret.

1. On the client computer, run `Set-AIPAuthentication`, using the values for the registered app, your Azure tenant, and your Azure AD account.

   ```powershell
   Set-AIPAuthentication -AppId <ID of the registered app> -AppSecret <client secret sting> -TenantId <your tenant ID> -DelegatedUser <Azure AD account>
   ```

You can now run the scanner in discovery mode, apply classification and protection, or use DLP settings.