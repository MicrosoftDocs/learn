You can use the **Region management** tile to verify that the Azure Stack Hub registration was successful. This tile is available on the default dashboard in the administrator portal. The status can be registered, or not registered. If registered, it also shows the Azure subscription ID that you used to register your Azure Stack Hub along with the registration resource group and name.

1.  Sign in to the Azure Stack Hub administrator portal `https://adminportal.local.azurestack.external`.
2.  From the Dashboard, select **Region management**.
3.  Select **Properties**. This blade shows the status and details of your environment. The status can be **Registered, Not registered**, or **Expired**.
    
    :::image type="content" source="../media/registration-procedure-5057464e.png" alt-text="Image showing registration procedure":::
    
    
    If registered, the properties include:
    
     -  **Registration subscription ID**: The Azure subscription ID registered and associated to Azure Stack Hub.
     -  **Registration resource group**: The Azure resource group in the associated subscription containing the Azure Stack Hub resources.

4.  You can use the Azure portal to view Azure Stack Hub registration resources, and then verify that the registration succeeded. Sign in to the Azure portal using an account associated to the subscription you used to register Azure Stack Hub. Select **All resources**, enable the **Show hidden types** checkbox, and select the registration name.

Alternatively, you can verify if your registration was successful by using the Marketplace management feature. If you see a list of marketplace items in the Marketplace management blade, your registration was successful. However, in disconnected environments, you can't see marketplace items in Marketplace management.

Use the Azure Stack Hub Readiness Checker tool (**AzsReadinessChecker**) to validate that your Azure subscription is ready to use with Azure Stack Hub before you begin an Azure Stack Hub deployment. The readiness checker validates that:

 -  The Azure subscription you use is a supported type. Subscriptions must be a Cloud Solution Provider (CSP) or Enterprise Agreement (EA).
 -  The account you use to register your subscription with Azure can sign in to Azure and is a subscription owner.

## Get the Readiness Checker tool

Download the latest version of AzsReadinessChecker from the [PowerShell Gallery](https://aka.ms/AzsReadinessChecker).

### Az PowerShell modules

You will need to have the Az PowerShell modules installed.

<a name='azure-active-directory-aad-environment'></a>

### Microsoft Entra environment

 -  Identify the username and password for an account that's an owner for the Azure subscription you'll use with Azure Stack Hub.
 -  Identify the subscription ID for the Azure subscription you'll use.

### Steps to validate the Azure registration

1.  Open an elevated PowerShell prompt, and then run the following command to install **AzsReadinessChecker**:
    
    ```
    Install-Module -Name Az.BootStrapper -Force -AllowPrerelease
    Install-AzProfile -Profile 2019-03-01-hybrid -Force
    Install-Module -Name Microsoft.AzureStack.ReadinessChecker -AllowPrerelease
    
    ```

2.  From the PowerShell prompt, run the following command to set $subscriptionID as the Azure subscription to use. Replace xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx with your own subscription ID:
    
    ```
    $subscriptionID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    
    ```

3.  From the PowerShell prompt, run the following command:
    
    ```
    Connect-AzAccount -subscription $subscriptionID
    
    ```

4.  From the PowerShell prompt, run the following command to start validation of your subscription. Provide your Microsoft Entra administrator and your Microsoft Entra tenant name:
    
    ```
    Invoke-AzsRegistrationValidation  -RegistrationSubscriptionID $subscriptionID
    
    ```

5.  After the tool runs, review the output. Confirm the status is correct for both sign-in and the registration requirements. Successful validation output appears similar to the following example:
    
    ```
    Invoke-AzsRegistrationValidation v1.2005.1269 started.
    Checking Registration Requirements: OK
    
    Log location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessChecker.log
    Report location (contains PII): C:\Users\[*redacted*]\AppData\Local\Temp\AzsReadinessChecker\AzsReadinessCheckerReport.json
    Invoke-AzsRegistrationValidation Completed
    
    ```
