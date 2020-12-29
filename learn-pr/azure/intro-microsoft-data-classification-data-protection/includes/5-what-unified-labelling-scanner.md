As an alternative solution to integrating Azure Information Protection with your local Windows Server FCI, you can use the Azure Information Protection (AIP) scanner. The AIP scanner runs as a service on the server. By using the AIP scanner, you can define classification rules in Azure Information Protection, instead of in Windows Server FCI. You can use the AIP scanner to discover, classify, and protect files in the following locations:

- Local folders on the Windows Server computer that runs the scanner.
- Universal Naming Convention (UNC) paths for network shares that use the Server Message Block (SMB) protocol.
- Sites and libraries for SharePoint Server 2013 and newer.

When you have configured your Azure Information Protection policy for labels that apply automatic classification, files that this scanner discovers can then be labeled. Labels apply classification, and optionally, apply protection or remove protection. 
The AIP scanner can inspect any files that Windows can index. It works by using IFilters that are installed on the Windows Server computer. To determine if the files need labeling, the AIP scanner uses the Office 365 built-in DLP sensitivity information types and pattern detection, or Office 365 regex patterns. 
You can run the AIP scanner in discovery mode only; you then use the reports to check what would happen if the files were labeled. Alternatively, you can run the scanner to apply the labels automatically. Additionally, you can run the scanner to discover files that contain sensitive information types, without configuring labels for conditions that apply automatic classification.

The following image shows the AIP scanner architecture, where the scanner discovers files across your on-premises and SharePoint servers.

:::image type="content" source="../media/5-ul-scanner-arch.png" alt-text="Image shows unified labelling scanner architecture.":::

### How to configure AIP scanner

Before you install the scanner, or upgrade it from an older general availability version, configure or verify your scanner settings in the Azure Information Protection area of the Azure portal. You need to sign in to Azure portal with appropriate role (Compliance Administrator, Compliance data administrator, Security administrator or Global Administrator) and then navigate to the Azure Information Protection pane.  You then create a scanner cluster. This cluster defines your scanner and is used to identify the scanner instance, such as during installation, upgrades, and other processes. After that you need to create a content scan job to define the repositories you want to scan. When you have configured scanner in Azure portal, you need to install the AIP scanner software on your Windows Server computer. You should use an account that has local administrator rights and that has permissions to write to the SQL Server master database. You must have the AIP unified labeling client installed on your machine before installing the scanner. To install the scanner components, you need to use Install-AIPScanner cmdlet in PowerShell.