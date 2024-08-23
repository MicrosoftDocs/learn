Once you've enabled Permissions Management, you can connect it to your Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP) platforms.

> [!NOTE]
> To complete this task, you must have at least [*Billing Administrator*](https://go.microsoft.com/fwlink/?linkid=2248574) permissions. You can't enable Permissions Management as a user from another tenant who has signed in via B2B or via Azure Lighthouse.

## Prerequisites

To enable Permissions Management in your organization:

 -  You must have a Microsoft Entra tenant. If you don't already have one, create a free account.<br>
 -  You must be eligible for or have an active assignment to the Permissions Management Administrator role as a user in that tenant.

## How to enable Permissions Management on your Microsoft Entra tenant<br>

In your browser:

 -  In your browser:
    
    
     -  Browse to the [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview) as at least a Billing Administrator.
     -  If needed, activate the *Permissions Management Administrator* role in your Microsoft Entra tenant.
     -  In the Azure portal, select **Microsoft Entra Permissions Management**, then select the link to purchase a license or begin a trial.

## Activate a free trial or paid license<br>

There are two ways to activate a trial or a full product license.

1.  The first way is to go to the [Microsoft 365 admin center](https://admin.microsoft.com/).
    
    
     -  Sign in as a *Global Administrator* for your tenant.
     -  Go to Setup and sign up for a Microsoft Entra Permissions Management trial.
     -  For self-service, Go to the [Microsoft 365 portal](https://aka.ms/TryPermissionsManagement) to sign up for a 45-day free trial or to purchase licenses.
2.  The second way is through Volume Licensing or Enterprise agreements.
    
    
     -  If your organization falls under a volume license or enterprise agreement scenario, contact your Microsoft representative.

Permissions Management launches with the **Data Collectors** dashboard.

## Configure data collection settings

Use the Data Collectors dashboard in Permissions Management to configure data collection settings for your authorization system.

1.  If the Data Collectors dashboard isn't displayed when Permissions Management launches:
    
    
     -  In the Permissions Management home page, select Settings (the gear icon), then select the Data Collectors subtab.
2.  Select the authorization system you want: AWS, Azure, or GCP.
3.  For information on how to onboard an AWS account, Azure subscription, or GCP project into Permissions Management, select one of the following articles and follow the instructions:
    
    
     -  [Onboard an AWS account](/entra/permissions-management/onboard-aws)
     -  [Onboard an Azure subscription](/entra/permissions-management/onboard-azure)
     -  [Onboard a GCP project](/entra/permissions-management/onboard-gcp)
