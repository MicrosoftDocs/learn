Custom Script Extension downloads and runs scripts inside Azure VMs for post-deployment configuration and software installation. You can deploy it through Azure Resource Manager templates, Azure CLI, Azure PowerShell, the REST API, or the Azure portal.

Use this extension for a one-time task, such as installing the IIS role. It doesn't continuously monitor or repair configuration drift. Use a compatible Machine Configuration package and assignment when you need ongoing compliance and correction.

## Requirements

Use a supported Windows Server image and a healthy Azure VM agent. This module uses Windows Server 2025. The current Windows Custom Script Extension support matrix includes these server releases:

| Windows Server release | Installation options |
| --- | --- |
| Windows Server 2016 | Desktop Experience or Server Core |
| Windows Server 2019 | Desktop Experience or Server Core |
| Windows Server 2022 | Desktop Experience or Server Core |
| Windows Server 2025 | Desktop Experience or Server Core |

Confirm extension compatibility and operating-system lifecycle requirements for the image you use. This matrix doesn't describe support for other Azure agents or extensions.

> [!IMPORTANT]
> Windows Custom Script Extension runs noninteractive commands as LocalSystem. Write idempotent scripts that complete within 90 minutes. Don't restart the VM or stop or update its agent from inside the script. Schedule any required restart separately after extension processing.

## Prepare a one-time IIS installation script

Save the following code as `Install-Iis.ps1` on your administration computer. The extension runs it with Windows PowerShell inside the Windows Server VM, where the ServerManager module is available. The runtime of a cloud runbook doesn't supply that local server module.

```powershell
$ErrorActionPreference = 'Stop'
Import-Module ServerManager -ErrorAction Stop

$feature = Get-WindowsFeature -Name 'Web-Server'

if (-not $feature.Installed) {
    $result = Install-WindowsFeature -Name 'Web-Server'
    if (-not $result.Success) {
        throw 'IIS installation did not succeed.'
    }

    if ($result.RestartNeeded -eq 'Yes') {
        throw 'A restart is required. Schedule it separately, then rerun the configuration.'
    }
}

if (-not (Get-WindowsFeature -Name 'Web-Server').Installed) {
    throw 'The IIS role is not installed.'
}

Write-Output 'The IIS role is installed. This script does not monitor future drift.'
```

The script skips installation when the role is already present, so an intentional rerun is safe. Its verified outcome is role presence, not service availability or complete website health. If it reports that a restart is required, don't treat that failure as a completed configuration. Arrange the restart separately, then rerun and verify.

## Deliver the script from a private blob

> [!CAUTION]
> Before enabling a system-assigned identity on a reused VM, check applications that request a managed identity token without selecting an identity. If the VM previously had only one user-assigned identity, adding a system-assigned identity changes that default token selection. Preserve the existing identities and configure affected applications to select their intended user-assigned identity explicitly, or use a clean lab VM. Don't copy their permissions to the new identity.

Prepare the existing isolated lab VM and script location before deploying the extension:

1. Enable the VM's system-assigned managed identity without removing any existing user-assigned identities.
1. Upload `Install-Iis.ps1` to an approved private Azure Blob Storage container with anonymous access disabled.
1. Grant the **VM's system-assigned identity** the **Storage Blob Data Reader** role at the appropriate container or storage scope. The operator preparing this access needs permission to upload the blob and assign that role.
1. Permit the VM to reach the blob over HTTPS on port 443. Configure storage firewall rules, network security groups, routing, and DNS as required, including private-endpoint DNS if used. Identity authorization doesn't bypass network restrictions. For public Storage endpoints, the `Storage` service tag can help scope network rules.

Use an authenticated Azure PowerShell session in the lab subscription with permission to update VM extensions. Replace the resource group, VM, storage account, and container placeholders in the following example.

For a VM without an existing Windows Custom Script Extension, use the example's `ContosoIisInstall` instance name. If the VM already has one, set `$extensionName` to that instance's name and update it instead of adding a competing second instance.

```powershell
$resourceGroupName = '<lab-resource-group>'
$vmName = '<lab-vm-name>'
$extensionName = 'ContosoIisInstall'
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

$protectedSettings = @{
    fileUris = @('https://<storage-account>.blob.core.windows.net/<container>/Install-Iis.ps1')
    commandToExecute = 'powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File .\Install-Iis.ps1'
    managedIdentity = @{}
}

Set-AzVMExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Location $vm.Location `
    -Name $extensionName `
    -Publisher 'Microsoft.Compute' `
    -ExtensionType 'CustomScriptExtension' `
    -TypeHandlerVersion '1.10' `
    -Settings @{ timestamp = 1 } `
    -ProtectedSettings $protectedSettings
```

The empty `managedIdentity` object selects the Azure VM's system-assigned identity for downloading the private blob. It doesn't automatically authenticate arbitrary Azure API calls made by the script. The command, file URI, and identity option are supplied through `protectedSettings`.

> [!CAUTION]
> Keep commands or URLs containing secrets in protected settings, and don't write secrets to output or logs. If a different design uses storage credentials, both `storageAccountName` and `storageAccountKey` belong in protected settings. Don't combine either property with `managedIdentity`.

## Rerun and troubleshoot

Repeating an unchanged deployment request doesn't rerun the script. For an intentional rerun, update the existing extension configuration, for example by changing `timestamp` from `1` to `2`. Keep the script idempotent and reuse the same extension instance.

Check the extension's provisioning status and returned output after deployment. In the same administration session, use:

```powershell
Get-AzVMExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Name $extensionName `
    -Status
```

For troubleshooting, inspect the logs under `C:\WindowsAzure\Logs\Plugins\Microsoft.Compute.CustomScriptExtension`. Returned output is limited to the last 4,096 bytes, so persist useful script diagnostics without secrets when you need more detail. A successful extension result confirms only the script's declared checks.

## Check HTTP separately

If the demonstration also requires a working website, check the service and HTTP response separately inside the VM. For the default local IIS endpoint, run the following in a Windows PowerShell session in the guest, using an approved access method such as the preceding unit's Action Run Command:

```powershell
Get-Service -Name 'W3SVC'
Invoke-WebRequest -Uri 'http://localhost' -UseBasicParsing |
    Select-Object -Property StatusCode
```

A local HTTP check doesn't require public inbound access. For an external browser check, allow HTTP only from the required test source if needed. That inbound access is separate from the outbound connectivity used to download the script. Neither a one-time HTTP response nor role installation demonstrates automatic drift correction.

## Additional reading

Use these references for extension settings, constraints, and one-time deployment:

- [Custom Script Extension for Windows](/azure/virtual-machines/extensions/custom-script-windows).
- [Deploy applications to a Windows VM with Custom Script Extension](/azure/virtual-machines/windows/tutorial-automate-vm-deployment).
