You configure Azure Stack Hub to support users from multiple Microsoft Entra tenants, allowing them to use services in Azure Stack Hub. For example, consider the following scenario:

 -  You're the service administrator of `contoso.onmicrosoft.com`, where Azure Stack Hub is installed.
 -  You are the directory administrator of `fabrikam.onmicrosoft.com`, where guest users are located.
 -  Your company receives IaaS and PaaS services from your company and needs to allow users from the guest directory (`fabrikam.onmicrosoft.com`) to sign in and use Azure Stack Hub resources in `contoso.onmicrosoft.com`.
    
    :::image type="content" source="../media/multi-tenancy-a7b2a87d.png" alt-text="Image showing multi-tenancy and Microsoft Entra ID.":::
    

This unit provides the steps required to configure multi-tenancy in Azure Stack Hub. In the scenario below, you complete steps to enable users from Fabrikam to sign in and consume services from the Azure Stack Hub deployment in Contoso.

### Configure Azure Stack Hub directory.

In this section, you configure Azure Stack Hub to allow sign-ins from Fabrikam Microsoft Entra directory tenants.

Onboard the guest directory tenant (Fabrikam) to Azure Stack Hub by configuring Azure Resource Manager to accept users and service principals from the guest directory tenant.

The service admin of `contoso.onmicrosoft.com` runs the following commands:

```
## The following Azure Resource Manager endpoint is for the ASDK. If you're in a multinode environment, contact your operator or service provider to get the endpoint.
$adminARMEndpoint = "https://adminmanagement.local.azurestack.external"

## Replace the value below with the Azure Stack Hub directory
$azureStackDirectoryTenant = "contoso.onmicrosoft.com"

## Replace the value below with the guest tenant directory.
$guestDirectoryTenantToBeOnboarded = "fabrikam.onmicrosoft.com"

## Replace the value below with the name of the resource group in which the directory tenant registration resource should be created (resource group must already exist).
$ResourceGroupName = "system.local"

## Replace the value below with the region location of the resource group.
$location = "local"

# Subscription Name
$SubscriptionName = "Default Provider Subscription"

Register-AzSGuestDirectoryTenant -AdminResourceManagerEndpoint $adminARMEndpoint `
-DirectoryTenantName $azureStackDirectoryTenant `
-GuestDirectoryTenantName $guestDirectoryTenantToBeOnboarded `
-Location $location `
-ResourceGroupName $ResourceGroupName `
-SubscriptionName $SubscriptionName

```
