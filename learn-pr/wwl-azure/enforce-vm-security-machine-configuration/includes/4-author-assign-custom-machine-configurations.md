Built-in security baselines cover industry-standard hardening controls, but every organization has specific requirements that fall outside these standard configurations. Custom machine configurations address organization-specific needs while maintaining the same audit-to-enforce workflow and compliance reporting as built-in policies.

| Workflow step | Tool/Action |
|---------------|-------------|
| **Author configuration** | Write PowerShell DSC (Windows) or Chef InSpec (cross-platform) definition |
| **Package configuration** | `New-GuestConfigurationPackage` creates .zip package |
| **Test locally** | `Get-GuestConfigurationPackageComplianceStatus` validates before publishing |
| **Publish to Azure** | Upload .zip to Azure Blob Storage (publicly accessible URL) |
| **Create policy definition** | `New-GuestConfigurationPolicy` generates custom policy JSON |
| **Import to Azure** | Add custom policy definition to management group or subscription |
| **Assign policy** | Standard Azure Policy assignment process |

## When to use custom configurations

Contoso Manufacturing has requirements that built-in baselines don't address. The factory automation software communicates with programmable logic controllers through a specific network protocol that requires a custom registry key value on each Windows Server VM. The manufacturing execution system relies on a Windows service—the "Contoso Manufacturing Scheduler"—that must always be running for production tracking to function. On Linux systems interfacing with factory equipment, specific TLS cipher suites must be enabled for secure communication with legacy industrial control systems.

Custom configurations fill these gaps. Use them when you need to enforce organization-specific registry values, and verify required services are running (or prohibited services are stopped). You can also validate custom application settings, check for existence and permissions of specific files or directories, or enforce security settings not covered by Microsoft baselines.

## Authoring tools and languages

The GuestConfiguration PowerShell module provides packaging and testing capabilities. Install it from the PowerShell Gallery: `Install-Module GuestConfiguration -Scope CurrentUser`. This module is required regardless of which authoring language you choose.

For Windows-focused configurations, PowerShell Desired State Configuration (DSC) provides the authoring syntax. DSC uses declarative configuration blocks that describe the desired state—a registry key must have a specific value. There must be a service must be running, and a file must exist with specific permissions. DSC resources handle the implementation details. Windows administrators familiar with DSC can apply that knowledge directly to Machine Configuration authoring.

For cross-platform configurations or audit-focused checks, Chef InSpec offers an alternative authoring approach. InSpec uses a Ruby-based domain-specific language that reads naturally: `describe registry_key('HKLM\Software\Contoso') do its('FactoryProtocol') { should eq 'Enabled' } end`. InSpec works on both Windows and Linux, making it valuable when the same security control applies across both operating systems.

## Author a PowerShell DSC configuration

A typical Windows configuration starts with a DSC configuration block. For Contoso's factory protocol registry requirement, the configuration declares that a specific registry value must exist with a specific data value:

```powershell
Configuration ContosoFactoryBaseline
{
    Import-DscResource -ModuleName 'PSDscResources'
    
    Node localhost
    {
        Registry FactoryProtocolEnabled
        {
            Key       = 'HKLM:\Software\Contoso\Factory'
            ValueName = 'ProtocolEnabled'
            ValueData = '1'
            ValueType = 'Dword'
            Ensure    = 'Present'
        }
        
        Service ManufacturingScheduler
        {
            Name   = 'ContosoScheduler'
            State  = 'Running'
            Ensure = 'Present'
        }
    }
}
```

Compile this configuration using `ContosoFactoryBaseline -OutputPath ./output`. DSC generates a `.mof` file containing the compiled configuration. The `.mof` becomes the input to the packaging step.

## Package and test locally

Create a guest configuration package using `New-GuestConfigurationPackage`. Specify the configuration name, the path to the compiled .mof file, and the type (Audit or AuditAndSet):

```powershell
New-GuestConfigurationPackage `
    -Name 'ContosoFactoryBaseline' `
    -Configuration './output/localhost.mof' `
    -Type Audit `
    -Path './packages'
```

The command creates `ContosoFactoryBaseline.zip` in the packages folder. The `.zip` contains the configuration definition, required DSC resources, and metadata.

Before publishing to Azure, test the package locally. Run `Get-GuestConfigurationPackageComplianceStatus -Path './packages/ContosoFactoryBaseline.zip'` on a test VM. The command evaluates the configuration and returns compliance status—compliant or noncompliant, with details about which resources passed or failed. This local testing catches errors before deployment and validates that the configuration detects the expected conditions.

## Publish to Azure Storage

Machine Configuration policies reference configuration packages by URL. Upload the .zip package to Azure Blob Storage in a publicly accessible container, or generate a shared access signature (SAS) URL with read permissions.

Create a storage account and container if you don't have one already. Upload the package using Azure Storage Explorer, the Azure portal, or Azure CLI: `az storage blob upload --account-name contosofactory --container-name configurations --name ContosoFactoryBaseline.zip --file ./packages/ContosoFactoryBaseline.zip`.

Record the blob URL—you need it for policy creation. The URL follows the pattern `https://contosofactory.blob.core.windows.net/configurations/ContosoFactoryBaseline.zip`. If using SAS, append the SAS token to the URL.

## Create and import the custom policy definition

The `New-GuestConfigurationPolicy` command generates a custom Azure Policy definition that references your configuration package. Provide the configuration name, the package URL, the platform (Windows or Linux), the policy version, and whether the policy should audit or enforce:

```powershell
New-GuestConfigurationPolicy `
    -PolicyId $(New-Guid) `
    -ContentUri 'https://contosofactory.blob.core.windows.net/configurations/ContosoFactoryBaseline.zip' `
    -DisplayName 'Factory VMs should meet Contoso baseline requirements' `
    -Description 'Validates registry settings and services required for factory automation software' `
    -Platform 'Windows' `
    -PolicyVersion '1.0.0' `
    -Mode Audit `
    -Path './policies' `
    -OutVariable Policy
```

The command generates a JSON policy definition file. This file contains the policy rule logic, the configuration package reference, and metadata. Import the definition to your management group or subscription using `New-AzPolicyDefinition -Name 'contoso-factory-baseline' -Policy $Policy.Path -ManagementGroupName 'Factory'`.

## Assign the custom policy

With the policy definition imported, assign it using the standard Azure Policy assignment process. Navigate to Azure Policy > Definitions, filter for your custom policy, and select Assign. Choose the management group scope that covers factory infrastructure, configure assignment settings, and deploy.

Like built-in baselines, assign custom policies in audit mode first. After the initial compliance evaluation, review findings, validate that the configuration detects the expected conditions, and address any unexpected noncompliance. Then, if automatic remediation is desired, create a new assignment with the enforce-mode policy definition (generated with `-Mode ApplyAndAutoCorrect` instead of `-Mode Audit`). The `-Mode` parameter controls the policy behavior: `Audit` generates an `AuditIfNotExists` definition that reports without acting; `ApplyAndAutoCorrect` generates a `DeployIfNotExists` definition that automatically corrects drift. This is distinct from the `-Type AuditAndSet` parameter on `New-GuestConfigurationPackage`, which determines whether the package itself can apply changes.

## Contoso's custom configuration application

Contoso creates three custom configurations. The first validates that the factory protocol registry key is set correctly on Windows Server VMs running the automation dashboard. The second ensures the manufacturing scheduler service is in a running state—noncompliance triggers alerts to the operations team. The third, authored in Chef InSpec for cross-platform coverage, validates specific TLS cipher suite configurations on both Windows and Linux systems that communicate with legacy industrial controllers.

All three configurations are published to the same Azure Storage container, imported as custom policy definitions, and assigned at the Factory Infrastructure management group scope. Compliance data flows into the same dashboard Contoso uses for built-in baselines, providing unified visibility across both Microsoft-curated and organization-specific security controls.

With both built-in and custom machine configurations deployed, Contoso closed the final gap in their server security posture—operating system configuration is now continuously audited and can be automatically enforced across their entire compute estate.
