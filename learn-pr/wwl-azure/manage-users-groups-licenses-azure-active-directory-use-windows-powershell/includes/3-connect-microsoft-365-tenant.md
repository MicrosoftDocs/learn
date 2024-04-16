You can manage Microsoft 365 by using the Azure AD PowerShell for Graph (AzureAD) module or the Microsoft Azure Active Directory module for Windows PowerShell (MSOnline) module. The Azure AD PowerShell for Graph module is the newer module and is generally preferred over the Azure Active Directory module for Windows PowerShell module. However, some functionality in the Azure Active Directory module for Windows PowerShell module isn't replicated in the Azure AD PowerShell for Graph module. Depending on your task, you might need to install and use both modules.

## Azure AD PowerShell for Graph

You can use the Azure AD PowerShell for Graph module in Windows PowerShell 5.1 or newer, including PowerShell 6 and PowerShell 7. Azure AD PowerShell for Graph is the newest PowerShell module for managing Microsoft 365 and has some features that aren't available in the older Azure Active Directory module for Windows PowerShell module. As a result, when using PowerShell to manage Microsoft 365, the Azure AD module is preferred.

> [!NOTE]
> All cmdlets provided by the Azure AD PowerShell for Graph module have **AzureAD** in the name of the cmdlet. For example, **Get-AzureADUser**.

The AzureAD cmdlets use the Azure AD Graph API to access and modify data. The Azure AD Graph API is a REST API that can be accessed directly by web requests. The AzureAD cmdlets simplify this process for you.

You can install the Azure AD PowerShell for Graph module from the PowerShell Gallery by running the following command:

```powershell
Install-Module AzureAD
```

After the Azure AD PowerShell for Graph module is installed, you can connect to Microsoft 365 by running the following command:

```powershell
Connect-AzureAD
```

When you connect to Microsoft 365, you're prompted for a username and password to sign in. You need to sign in with a user account that has sufficient privileges to perform the actions. You might also be prompted for multifactor authentication.

> [!NOTE]
> For tenants in China or Germany, you need to use the *-AzureEnvironmentName* parameter and specify **AzureChinaCloud** or **AzureGermanyCloud** respectively. For secure US government tenants, you need to specify **AzureUSGovernment**.

## Azure AD module for Windows PowerShell

The Azure Active Directory module for Windows PowerShell module can be used in Windows PowerShell 5.1 or PowerShell 6. This is the original module for managing Microsoft 365. Some tasks that you can perform by using the Azure Active Directory module for Windows PowerShell module were never added to the Azure AD PowerShell for Graph module. There are also some tasks that are easier to perform by using cmdlets from the Azure Active Directory module for Windows PowerShell module. Microsoft isn't developing new features for this module, but you can continue to use these cmdlets.

> [!NOTE]
> All of the cmdlets provided by the Azure Active Directory module for Windows PowerShell module have **Msol** in the name of the cmdlet. For example, **Get-MsolUser**.

You can install the Azure Active Directory module for Windows PowerShell module from the PowerShell Gallery by running the following command:

```powershell
Install-Module MSOnline
```

After the Azure Active Directory module for Windows PowerShell module is installed, you connect to Microsoft 365 by running the following command:

```powershell
Connect-MSOnline
```

## Microsoft Graph PowerShell SDK

Microsoft has announced that future management interface development will be focused on the Microsoft Graph API. This is a web-based API that's separate from the Azure AD Graph API used by the Azure AD PowerShell for Graph module. The Azure AD Graph API will cease updates after June 2022. All future development will be in the Microsoft Graph API.

To access the Microsoft Graph API, you can use **Invoke-WebRequest**, but this process is difficult. To simplify the process of using Microsoft Graph API, you can use the Microsoft Graph PowerShell SDK (Microsoft.Graph).

You can install the Microsoft.Graph module from the PowerShell Gallery by running the following command:

```powershell
Install-Module Microsoft.Graph
```

After the Microsoft.Graph module is installed, you can connect to Microsoft 365 by running the following command:

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

When you connect by using Microsoft.Graph, the scope specifies the permissions required. If your user account hasn't been assigned the necessary permissions already, an administrator needs to grant the permissions. There are many permission scopes available based on the type of object to be managed and the actions allowed.

The Microsoft.Graph module creates cmdlets for the available Microsoft Graph options. This avoids much of the complexity that's typically required when using web-based APIs where you need to understand which URL to use and send data in a specific format. The Microsoft.Graph module provides you with cmdlets and parameters as the user interface.

> [!NOTE]
> Cmdlets provided by the Microsoft.Graph module have **Mg** in the name of the cmdlet. For example, **Get-MgUser**.

> **Additional reading:** The remainder of this module focuses on using the AzureAD and Azure Active Directory module for Windows PowerShell modules. For more information about using the Microsoft.Graph module, refer to [Get started with the Microsoft Graph PowerShell SDK](https://aka.ms/get-started-with-the-Microsoft-Graph-PowerShell-SDK).

## Azure Cloud Shell

As an alternative to installing and maintaining the AzureAD and Azure Active Directory module for Windows PowerShell modules in multiple locations, you can use Azure Cloud Shell. Cloud Shell is a prompt with PowerShell functionality that you can access through a web browser. The Microsoft 365 admin center provides a link to open Cloud Shell.

Many PowerShell modules that are used to manage Microsoft 365 services are automatically installed in the shell. You must have an Azure subscription to use Cloud Shell.

> **Additional reading:** For more information about Cloud Shell, see [Overview of Azure Cloud Shell](https://aka.ms/overview-of-azure-cloud-shell-2).
