The Azure Active Directory Module for Windows PowerShell provides cmdlets that you can use for Azure Active Directory (Azure AD) administrative tasks. These tasks include user management, domain management, and configuring single sign-on. This topic includes information about how to install these cmdlets for use with your directory.

You mostly need the Azure Active Directory Module for Windows PowerShell when you manage users, groups, and services such as Microsoft 365. However, Microsoft is replacing the Azure Active Directory Module for Windows PowerShell with Azure Active Directory PowerShell for Graph. The Azure Active Directory Module for Windows PowerShell cmdlets include **Msol** in their names, while the Azure Active Directory PowerShell for Graph cmdlets use **AzureAD** in their names.

## Azure Active Directory Module for Windows PowerShell

The following Windows operating systems support the Azure Active Directory Module for Windows PowerShell, with the default version of Microsoft .NET Framework and Windows PowerShell:

- Windows 8.1
- Windows 8
- Windows 7
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2

The easiest way to install the module is from the PowerShell Gallery. You can install the module with the **Install-Module** cmdlet by running the following command:

```powershell
Install-Module MSOnline
```

## Azure Active Directory PowerShell for Graph

Currently, the Azure Active Directory PowerShell for Graph module doesn't completely replace the functionality of the Azure Active Directory Module for Windows PowerShell module for user, group, and license administration. In some cases, you need to use both versions. You can safely install both versions on the same computer.

The Azure AD PowerShell for Graph module has two versions: a Public Preview version and a General Availability version. It isn't recommended to use the Public Preview version for production scenarios.

> **Additional reading:** For more information about downloading either version of the Azure AD PowerShell for Graph module, refer to [Install Azure Active Directory PowerShell for Graph](https://aka.ms/install-azure-active-directory-powershell-for-graph).

To install the General Availability version of the Azure AD PowerShell for Graph module on your computer, run the following command:

```powershell
Install-Module AzureAD
```

To install the public preview release of this module, run the following command:

```powershell
Install-module AzureADPreview
```

## Connecting to Azure AD with PowerShell

If you want to connect to the Azure AD service with the Azure Active Directory Module for Windows PowerShell, run the following command:

```powershell
Connect-MsolService
```

If you use the Azure AD PowerShell for Graph module, and want to connect to Azure AD, run the following command:

```powershell
Connect-AzureAD
```

After running either of the previous commands, you'll be prompted for your Azure AD credentials. You should use the credentials that you use to sign in to Microsoft 365 or your Azure services. After you authenticate, you'll be able to use the cmdlets available for Azure AD management.

> **Additional reading:** For more information about the Azure Active Directory PowerShell for Graph cmdlets, refer to [AzureAD](https://aka.ms/azure-ad-2).

> **Additional reading:** For more information about the Azure Active Directory Module for Windows PowerShell cmdlets, refer to [MSOnline](https://aka.ms/msonline).
