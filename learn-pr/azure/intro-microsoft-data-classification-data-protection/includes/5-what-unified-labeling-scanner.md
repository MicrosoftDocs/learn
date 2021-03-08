As an alternative solution to integrating Azure Information Protection with your local Windows Server file classification infrastructure (FCI), you can use the Azure Information Protection scanner. The Azure Information Protection scanner runs as a service on the server. By using the Azure Information Protection scanner, you can define classification rules in Azure Information Protection, instead of in Windows Server FCI. You can use the Azure Information Protection scanner to help discover, classify, and protect files in the following locations:

- Local folders on the Windows Server computer that runs the scanner.
- Universal Naming Convention (UNC) paths for network shares that use the Server Message Block (SMB) protocol.
- Sites and libraries for SharePoint Server 2013 and newer.

When you’ve configured your Azure Information Protection policy for labels that apply automatic classification, files that this scanner discovers can then be labeled. Labels apply classification, and optionally, apply protection or remove protection.
The Azure Information Protection scanner can inspect any files that Windows can index. It works by using IFilters that are installed on the Windows Server computer. To determine if the files need labeling, the Azure Information Protection scanner uses the Microsoft 365 built-in data loss prevention (DLP) sensitivity information types and pattern detection, or Microsoft 365 regex patterns.
You can run the Azure Information Protection scanner in discovery mode only. Then, use the reports to check what would happen if the files were labeled. Instead, you can run the scanner to apply the labels automatically. Additionally, you can run the scanner to discover files that contain sensitive information types, without configuring labels for conditions that apply automatic classification.

The following image shows the Azure Information Protection scanner architecture, where the scanner discovers files across your on-premises and SharePoint servers.

:::image type="content" source="../media/5-ul-scanner-arch.png" alt-text="Image displays unified labeling scanner architecture.":::

## How to configure Azure Information Protection scanner

Before you install the scanner, or upgrade it from an older general availability version:
1. Configure or verify your scanner settings in the Azure Information Protection administrative portal. Sign in with the appropriate role (Compliance Administrator, Compliance data administrator, Security administrator, or Global Administrator) and then navigate to the **Azure Information Protection** pane.
2. Create a scanner cluster. This cluster defines your scanner and is used to identify the scanner instance, such as during installation, upgrades, and other processes.
3. Next, create a content scan job to define the repositories you want to scan.
4. When you've configured the scanner in the Azure portal, you need to install the Azure Information Protection scanner software on your Windows Server computer. Use an account that has local administrator rights and that has permissions to write to the SQL Server database. You must have the Azure Information Protection unified labeling client installed on your machine before installing the scanner. To install the scanner components, you need to use the `Install-AIPScanner` cmdlet in PowerShell.
