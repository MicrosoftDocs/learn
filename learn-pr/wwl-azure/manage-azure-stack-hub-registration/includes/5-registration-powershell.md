Below are the key PowerShell commands for registering Azure Stack Hub with Azure.

### Set-AzsRegistration

You can use **Set-AzsRegistration** to register Azure Stack Hub with Azure and enable or disable the offer of items in the marketplace and usage reporting.

To run the cmdlet, you need:

 -  A global Azure subscription of any type.
 -  To be signed in to Azure PowerShell with an account that's an owner or contributor to that subscription.

```powershell

Set-AzsRegistration [-PrivilegedEndpointCredential] <PSCredential> [-PrivilegedEndpoint] <String> [[-AzureContext]
    <PSObject>] [[-ResourceGroupName] <String>] [[-ResourceGroupLocation] <String>] [[-BillingModel] <String>]
    [-MarketplaceSyndicationEnabled] [-UsageReportingEnabled] [[-AgreementNumber] <String>] [[-RegistrationName]
    <String>] [<CommonParameters>]

```

### Get-AzsRegistrationToken

**Get-AzsRegistrationToken** generates a registration token from the input parameters.

```powershell

Get-AzsRegistrationToken [-PrivilegedEndpointCredential] <PSCredential> [-PrivilegedEndpoint] <String>
    [-BillingModel] <String> [[-TokenOutputFilePath] <String>] [-UsageReportingEnabled] [[-AgreementNumber] <String>]
    [<CommonParameters>]

```
