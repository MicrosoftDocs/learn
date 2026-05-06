You can manage Microsoft 365 identity features by using the **Microsoft Entra PowerShell** module or the **Microsoft Graph PowerShell SDK**. Both modules use the Microsoft Graph API — the unified interface for managing Microsoft Entra ID and Microsoft 365 services.

> [!NOTE]
> The **AzureAD** (Azure AD PowerShell for Graph) and **MSOnline** (Azure Active Directory module for Windows PowerShell) modules were fully retired in 2025 and are no longer functional. Any documentation or scripts that reference `Install-Module AzureAD`, `Connect-AzureAD`, `Install-Module MSOnline`, or `Connect-MsolService` are outdated and shouldn't be followed.

## Microsoft Entra PowerShell

Microsoft Entra PowerShell is the recommended module for managing Microsoft Entra ID and Microsoft 365 identity features. It's built on top of the Microsoft Graph PowerShell SDK and is fully interoperable with it. Cmdlets use the **Entra** prefix — for example, **Get-EntraUser**.

Microsoft Entra PowerShell supports Windows PowerShell 5.1 and PowerShell 7 or later. PowerShell 7 is recommended for the best performance and compatibility.

You can install Microsoft Entra PowerShell from the PowerShell Gallery by running the following command:

```powershell
Install-Module Microsoft.Entra
```

After the Microsoft Entra PowerShell module is installed, connect to your Microsoft 365 tenant by specifying the permissions (scopes) you need:

```powershell
Connect-Entra -Scopes "User.ReadWrite.All"
```

When you connect, you're prompted to sign in with a user account that has sufficient privileges to perform the actions you want to complete. You can specify multiple scopes in a single connection:

```powershell
Connect-Entra -Scopes "User.ReadWrite.All","Group.ReadWrite.All","RoleManagement.ReadWrite.Directory"
```

> [!NOTE]
> If your organization has existing scripts that use AzureAD cmdlet syntax, you can run **Enable-EntraAzureADAlias** to enable backward-compatible aliases, allowing older scripts to run without modification while you migrate them.

## Microsoft Graph PowerShell SDK

The Microsoft Graph PowerShell SDK is the foundation on which Microsoft Entra PowerShell is built. It provides cmdlets for every capability available through the Microsoft Graph API, including identity management and other Microsoft 365 services. Cmdlets use the **Mg** prefix — for example, **Get-MgUser**.

You can install the Microsoft Graph PowerShell SDK from the PowerShell Gallery by running the following command:

```powershell
Install-Module Microsoft.Graph
```

After the module is installed, connect to Microsoft 365 by specifying the required scopes:

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

## Choosing between the modules

Both modules connect to the same Microsoft Graph API. Use the following guidelines to decide which to use:

- **Microsoft Entra PowerShell** — Recommended for most identity management tasks. Provides human-readable cmdlets designed for managing Microsoft Entra ID, and closely mirrors the familiar AzureAD cmdlet naming convention.
- **Microsoft Graph PowerShell SDK** — Better suited for advanced automation or when you need to access Microsoft Graph capabilities beyond identity management, such as Teams, SharePoint, or Intune.

The remainder of this module focuses on using Microsoft Entra PowerShell. For more information about the Microsoft Graph PowerShell SDK, refer to [Get started with the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/get-started).

## Azure Cloud Shell

As an alternative to installing modules on a local machine, you can use Azure Cloud Shell. Cloud Shell is a PowerShell environment accessible through a web browser from the Azure portal or the Microsoft 365 admin center. Microsoft Entra PowerShell and Microsoft Graph PowerShell are available in Cloud Shell without requiring installation.

> [!NOTE]
> You must have an Azure subscription to use Azure Cloud Shell.

> **Additional reading:** For more information about Cloud Shell, see [Overview of Azure Cloud Shell](https://aka.ms/overview-of-azure-cloud-shell-2).
