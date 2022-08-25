The Az PowerShell module is a set of cmdlets for managing Azure resources directly from PowerShell. PowerShell provides powerful features for automation that you can use to manage your Azure resources; for example, in the context of a continuous integration and continuous delivery (CI/CD) pipeline.

The Az PowerShell module is the replacement for AzureRM and is the recommended version to use for interacting with Azure. To keep up with the latest Azure features in PowerShell, you should migrate to the Az PowerShell module.

> [!NOTE]
> There's no support for having both the AzureRM and Az modules installed for PowerShell 5.1 on Windows at the same time.

## Benefits of the Az PowerShell module

The Az PowerShell module features the following benefits:

- Security and stability:

  - Token cache encryption
  - Prevention of man-in-the-middle attack type
  - Support for authentication with Active Directory Federation Services (AD FS) in Windows Server 2019
  - Username and password authentication in PowerShell 7
  - Support for features such as continuous access evaluation

- Support for all Azure services:

  - All generally available Azure services have a corresponding supported PowerShell module
  - Multiple bug fixes and API version upgrades since AzureRM

- New capabilities:

  - Support in Cloud Shell and cross-platform
  - Ability to get and use access tokens to access Azure resources
  - Cmdlets for advanced Representational State Transfer (REST) operations with Azure resources

The Az PowerShell module is based on the .NET Standard library and works with PowerShell 7 and newer on all platforms including Windows, macOS, and Linux. It's also compatible with Windows PowerShell 5.1.

> [!NOTE] 
> PowerShell 7 and newer are the recommended versions of PowerShell for use with Az PowerShell on all platforms.

Az is the most current PowerShell module for Azure. You can log issues or feature requests directly on the GitHub repository. You can also contact Microsoft support if you have a support contract. Feature requests will be implemented in the latest version of Az. Critical issues will be implemented on the last two versions of Az.

> [!NOTE]
> Because Az PowerShell modules now have all the capabilities of AzureRM PowerShell modules and more, Microsoft plans to retire AzureRM PowerShell modules on February 29, 2024.
