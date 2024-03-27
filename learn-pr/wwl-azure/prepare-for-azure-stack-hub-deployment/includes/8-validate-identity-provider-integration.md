Use the Azure Stack Hub Readiness Checker tool (**AzsReadinessChecker**) to validate that your Microsoft Entra ID is ready to use with Azure Stack Hub. Validate your Azure identity solution before you begin an Azure Stack Hub deployment.

The readiness checker validates:

 -  Microsoft Entra ID as an identity provider for Azure Stack Hub.
 -  The Microsoft Entra account that you plan to use can sign in as a global administrator of your Microsoft Entra ID.

Validation ensures your environment is ready for Azure Stack Hub to store information about users, applications, groups, and service principals from Azure Stack Hub in your Microsoft Entra ID.

Download the latest version of the Azure Stack Hub Readiness Checker tool (AzsReadinessChecker) from the [PowerShell Gallery](https://aka.ms/AzsReadinessChecker).

<a name='the-azure-active-directory-azure-ad-environment'></a>

## The Microsoft Entra environment

 -  Identify the Microsoft Entra account to use for Azure Stack Hub and ensure it's a Microsoft Entra Global Administrator.
 -  Identify your Microsoft Entra tenant name. The tenant name must be the primary domain name for your Microsoft Entra ID. For example, **contoso.onmicrosoft.com**.

## Steps to validate Azure identity

1.  On a computer that meets the prerequisites, open an elevated PowerShell command prompt, and then run the following command to install **AzsReadinessChecker**:
    
    ```
    Install-Module -Name Az.BootStrapper -Force -AllowPrerelease
    Install-AzProfile -Profile 2019-03-01-hybrid -Force
    Install-Module -Name Microsoft.AzureStack.ReadinessChecker -AllowPrerelease
    
    ```

2.  From the PowerShell prompt, run the following command. Replace contoso.onmicrosoft.com with your Microsoft Entra tenant name:
    
    ```
    Connect-AzAccount -tenant contoso.onmicrosoft.com
    
    ```

3.  From the PowerShell prompt, run the following command to start validation of your Microsoft Entra ID. Replace contoso.onmicrosoft.com with your Microsoft Entra tenant name:
    
    ```
    Invoke-AzsAzureIdentityValidation -AADDirectoryTenantName contoso.onmicrosoft.com
    
    ```

4.  After the tool runs, review the output. Confirm the status is **OK** for installation requirements. A successful validation appears like the following example:
    
    ```
    Invoke-AzsAzureIdentityValidation v1.2005.1269 started.
    Starting Azure Identity Validation
    
    Checking Installation Requirements: OK
    
    Finished Azure Identity Validation
    
    Log location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessChecker.log
    Report location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessCheckerReport.json
    Invoke-AzsAzureIdentityValidation Completed
    
    ```

## Report and log file

Each time validation runs, it logs results to **AzsReadinessChecker.log** and \*\*AzsReadinessCheckerReport.json. The location of these files displays with the validation results in PowerShell.

These files can help you share validation status before you deploy Azure Stack Hub or investigate validation problems. Both files persist the results of each subsequent validation check. The report provides your deployment team confirmation of the identity configuration. The log file can help your deployment or support team investigate validation issues.

By default, both files are written to `C:\Users\<username>\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessCheckerReport.json`.

 -  Use the `-OutputPath <path>` parameter at the end of the run command line to specify a different report location.
 -  Use the `-CleanReport` parameter at the end of the run command to clear information about previous runs of the tool from **AzsReadinessCheckerReport.json**.
