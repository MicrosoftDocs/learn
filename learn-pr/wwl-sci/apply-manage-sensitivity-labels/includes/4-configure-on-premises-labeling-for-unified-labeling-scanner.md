The installation and configuration of the Unified Labeling Scanner is done from the AIPService PowerShell module on a server that will act as the Unified Labeling Scanner in an environment.

### Installation of the unified labeling scanner

After fulfilling the requirements like service accounts and a SQL Server instance, it´s possible to install the Unified Labeling Scanner in the following steps:

1. Install and sign into a Windows Server computer or VM.

1. Install the Unified Labeling Client on the machine.

1. Run the Windows PowerShell as local administrator in an elevated command shell.

1. Run the cmdlet from the AIPService PowerShell module to install the AIP Scanner:

    ```powershell
    Install-AIPScanner -SqlServerInstance <name> -Cluster <cluster name>

    ```

1. Verify that the service is now installed by using Administrative Tools > Services. The installed service is named Azure Information Protection Scanner and is configured to run by using the scanner service account that you created.

1. You can control the installation and operation in the Task Manager of the Windows Server, which is the host for the scanner.

### Configuration of the unified labeling scanner

The Unified label is installed on a Windows server and is connected to the SQL Server instance. In the next steps to configure the Scanner we need to connect the local instance with the Azure environment with an Azure AD Token and after it we can configure it to make the first run.

### Acquire an Azure AD Token for the scanner

Perform the following steps to fetch an Azure AD Token for the Unified Labeling Scanner:

1. Navigate to the **Azure portal** at [https://portal.azure.com](https://portal.azure.com/?azure-portal=true).

1. In the top search bar, enter **App Registrations** and select **App registrations**.

1. Select **+ New registration**.

1. Provide a meaningful **name**.

1. Select the **Supported account type** (or leave as default).

1. Set the **Redirect url** to: https://localhost

1. Select **Register.**

1. The overview page provides the **Application (client) ID**, copy this ID for use later.

1. Select the **Certificates & secrets** setting.

1. Under **Client secrets**, click **New client secret** to create a new secret.

1. Provide a **description** for the secret and choose the desired **expiration interval**.

1. Immediately copy the value of the **new secret** to a secure location. The full value is displayed to you only once.

1. Select **Add.**

1. Navigate to **API Permissions.**

1. Select **+ Add a permission.**

1. Select **Azure Rights Management Services** > **application permissions.**

1. Expand the **content** permissions.

1. Select **Content.DeletegratedReader** and **Content.DelegatedWriter.**

1. Select **Add Permission.**

1. Select **+ Add a permission > APIs my organization uses.**

1. Search for **Microsoft Information Protection Sync Service.**

1. Select **Microsoft Information Protection Sync Service > Application permissions.**

1. Expand the **content** permissions.

1. Select **UnifiedPolicy.Tenant.Read**.

1. Select **Add Permission**.

1. Select the **Grant admin consent button.**

1. Navigate to the **Azure Active Directory.**

1. Within the overview page copy, the **Tenant ID** required for the next step.

1. Configure the Azure AD applications for **Set-AIP Authentications** from the Windows Server computer, if your scanner service account has been granted the Log-on locally right for the installation, sign in with this account and start a PowerShell session using the **AzureInformationProtection** module.

    ```powershell
    Set-AIPAuthentication -AppId <ID of the registered app> -AppSecret <client secret sting> -TenantId <your tenant ID> -DelegatedUser <Azure AD account>

    ```

1. After this cmdlet is run the scanner will have an Azure AD Token and be registered as an application in the Azure environment. With this connection, the scanner has access to the label scheme and the settings.

### Configuration of the scanner and scan methods

The configuration for the scanner is done in the Azure portal. Follow these steps to configure and set up the Scanner to perform scans in an organization's network:

1. Sign into the **Azure portal** at [https://portal.azure.com](https://portal.azure.com/?azure-portal=true).

1. The user requires one of the roles (requirements).

1. Create a scanner cluster.

1. Scan your network for risky repositions (optional).

1. Run your network scan job (Public Preview).

1. Create a content scan job.

1. Start the Scan.

Moreover, it´s also possible to restart the scan and rescan all the files.

> [!WARNING]
> The Unified Labeling scanner does not scan and protect in real time. The crawler runs a cycle and repeat. 

## Operational scenarios for the unified labeling scanner

The Unified labeling scanner can be used for different operational scenarios, some of them include:

| **Scenario**| **Scanner run**|
| :--- | :--- |
| Scan for a report only to know your data| Run the scanner in discovery mode only to create reports that check to see what happens when your files are labeled.|
| Run the scanner to find and discover files with sensitive information| Run the scanner to discover files with sensitive information, without configuring labels that apply automatic classification.|
| Run and apply labels| Run the scanner automatically to apply labels as configured.|
| Specific scan only a few files types| Define a file types list to specify specific files to scan or to exclude.|

## Learn more

[Install and configure the Azure Information Protection (AIP) unified labeling scanner | Microsoft Docs](https://docs.microsoft.com/azure/information-protection/deploy-aip-scanner-configure-install?azure-portal=true)


