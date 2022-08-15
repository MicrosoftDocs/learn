The Operator Access Workstation (OAW) is used to deploy a virtual machine (VM) on an Azure Stack Hub's Hardware Lifecycle Host (HLH) or any other machine that runs Microsoft Hyper-V. It does require network connectivity to the Azure Stack Hub endpoints to be used for operator or user scenarios.

The OAW VM is an optional virtual machine that isn't required by Azure Stack Hub to function. Its purpose is to provide the latest tools to operators or user as they interact with Azure Stack Hub.

## OAW scenarios

The following tables list common scenarios for the OAW. Use Remote Desktop to connect to the OAW.

| **Scenario**                     | **Description**                                                                                                                                                     |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Access the Administration portal | Perform administrative operations.                                                                                                                                  |
| Access PEP                       | Log collection and upload: Create an SMB share on the HLH for file transfer from Azure Stack Hub. Use Azure Storage Explorer to upload logs saved to the SMB share. |
| Register Azure Stack Hub         | For re-registration, get previous Registration Name and Resource Group from the Administration portal.                                                              |
| Marketplace syndication          | Create an SMB share on the HLH to store the downloaded image or extension.                                                                                          |
| Create Virtual Machines          | Create virtual machines using Azure CLI.                                                                                                                            |
| Manage AKS                       | Manage AKS clusters, for example, scale or upgrade.                                                                                                                 |

## Pre-installed software

The following table lists the pre-installed software on the OAW VM.

| **Software Name**                  | **Location**                                                           |
| ---------------------------------- | ---------------------------------------------------------------------- |
| Microsoft Edge for Business        | \[SystemDrive\]\\Program Files (x86)\\Microsoft\\Edge\\Application     |
| Az Modules                         | \[SystemDrive\]\\ProgramFiles\\WindowsPowerShell\\Modules              |
| PowerShell 7                       | \[SystemDrive\]\\Program Files\\PowerShell\\7                          |
| Azure Command-Line Interface (CLI) | \[SystemDrive\]\\Program Files (x86)\\Microsoft SDKs\\Azure\\CLI2      |
| Microsoft Azure Storage Explorer   | \[SystemDrive\]\\Program Files (x86)\\Microsoft Azure Storage Explorer |
| AzCopy                             | \[SystemDrive\]\\VMSoftware\\azcopy\_windows\_amd64\_\*                |
| AzureStack-Tools                   | \[SystemDrive\]\\VMSoftware\\AzureStack-Tools                          |

## Download files

To get the files to create the OAW VM, [download here](https://aka.ms/OAWDownload).

Because of the stateless nature of the solution, there are no updates for the OAW VM. For each milestone, a new version of the VM image file is released. Use the latest version to create a new OAW VM. The image file is based on the latest Windows Server 2019 version. After installation, you can apply updates, including any critical updates, using Windows Update.

Validate the hash of the downloaded OAW.zip file to make sure it hasn't been modified before using it to create the OAW VM. Run the following PowerShell script. If the return value is True, you can use the downloaded OAW.zip:

```
param(
[Parameter(Mandatory=$True)]
[ValidateNotNullOrEmpty()]
[ValidateScript({Test-Path $_ -PathType Leaf})]
[string]
$DownloadedOAWZipFilePath
)
$expectedHash = '2F6242F122532E176A5FACD694C132D3DAFD50D0F17F5F23F26A8102C7BA6157'
$actualHash = (Get-FileHash -Path $DownloadedOAWZipFilePath).Hash
Write-Host "Expected hash: $expectedHash"
if ($expectedHash -eq $actualHash)
{
Write-Host 'SUCCESS: OAW.zip file hash matches.'
}
else
{
Write-Error "ERROR: OAW.zip file hash doesn't match! It isn't safe to use it, download it again. Actual hash: $actualHash"
}
```

Another way to copy this script to your environment is to use the Test-FileHash cmdlet that's offered in [AzureStack-Tools](https://github.com/Azure/AzureStack-Tools/tree/az/HashVerify/Test-FileHash.psm1) to verify the hash of the OAW.zip file:

1.  Download the [Test-FileHash.psm1](https://github.com/Azure/AzureStack-Tools/tree/az/HashVerify/Test-FileHash.psm1) file from GitHub, and then run:
    
    ```
    Import-Module .\Test-FileHash.psm1 -Force -Verbose
    ```
2.  After you import the Test-FileHash module, verify the hash of the OAW.zip file:
    
    ```
    Test-FileHash -ExpectedHash "2F6242F122532E176A5FACD694C132D3DAFD50D0F17F5F23F26A8102C7BA6157" -FilePath "<path to the OAW.zip file>"
    ```

## Check HLH version

This step is important to determine if you deploy the OAW on an HLH that was deployed using a Microsoft image or an OEM image. This PowerShell cmdlet isn't present on an HLH that was deployed using an OEM image. If you deploy the OAW on a general Microsoft Hyper-V, you can skip this step.

1.  Sign in to the HLH with your credentials.
2.  Open PowerShell ISE and run the following script:
    
    ```
    C:\Version\Get-Version.ps1
    ```
    
    For example:
    
    :::image type="content" source="https://github.com/MicrosoftDocs/azure-stack-docs/raw/main/azure-stack/operator/media/operator-access-workstation/check-operator-access-workstation-vm-version.png" alt-text="Screenshot of PowerShell cmdlet to check the version of the OAW VM.":::
    

## Create the OAW VM using a script

The following script prepares the virtual machine as the Operator Access Workstation (OAW), which is used to access Microsoft Azure Stack Hub.

1.  Sign in to the HLH with your credentials.
2.  Download OAW.zip and extract the files.
3.  Open an elevated PowerShell session.
4.  Navigate to the extracted contents of the **OAW.zip** file.
5.  Run the **New-OAW.ps1** script.

### Example: Deploy on HLH using a Microsoft Image

```
$oawRootPath = "D:\oawtest"
$securePassword = Read-Host -Prompt "Enter password for Azure Stack OAW's local administrator" -AsSecureString

if (Get-ChildItem -Path $oawRootPath -Recurse | Get-Item -Stream Zone* -ErrorAction SilentlyContinue | Select-Object FileName)
{ Write-Host "Execution failed, unblock the script files first" }
else { .\New-OAW.ps1 -LocalAdministratorPassword $securePassword }
```

### Example: Deploy on HLH using an OEM Image

```
$oawRootPath = "D:\oawtest"
$securePassword = Read-Host -Prompt "Enter password for Azure Stack OAW's local administrator" -AsSecureString

if (Get-ChildItem -Path $oawRootPath -Recurse | Get-Item -Stream Zone* -ErrorAction SilentlyContinue | Select-Object FileName)
{ Write-Host "Execution failed, unblock the script files first" }
else { .\New-OAW.ps1 -LocalAdministratorPassword $securePassword -AzureStackCertificatePath 'F:\certroot.cer' -DeploymentDataFilePath 'F:\DeploymentData.json' -AzSStampInfoFilePath 'F:\AzureStackStampInformation.json' }
```

If the AzureStackStampInformation.json file includes the naming prefix for OAW VM, that value will be used for the VirtualMachineName parameter. Otherwise, the default name is AzSOAW or whatever name specified is by the user. The AzureStackStampInformation.json can be re-created using the privileged endpoint in case it isn't present on the HLH.
