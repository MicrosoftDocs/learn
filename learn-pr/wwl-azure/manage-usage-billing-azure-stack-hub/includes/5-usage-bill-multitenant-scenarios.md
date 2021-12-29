This unit describes how to register Azure Stack Hub as a Cloud Solution Provider (CSP) and how to add customers.

As a CSP, you work with diverse customers using your Azure Stack Hub. Each customer has a CSP subscription in Azure. Direct usage from your Azure Stack Hub to each user subscription.

The following figure shows the required steps to choose your shared services account, and to register the Azure account with the Azure Stack Hub account. Once registered, you can onboard your end customers:

:::image type="content" source="../media/cloud-solution-provider-add-user-1-22a36b50.png" alt-text="Image showing normalized relational tables.":::


## Create a CSP or APSS subscription

Choose the type of shared services account that you use for Azure Stack Hub. The types of subscriptions that can be used for registration of a multi-tenant Azure Stack Hub are:

 -  Cloud Solution Provider
 -  Partner Shared Services subscription

### Azure Partner Shared Services

Azure Partner Shared Services (APSS) subscriptions are the preferred choice for registration when a direct CSP or a CSP distributor operates Azure Stack Hub.

APSS subscriptions are associated with a shared-services tenant. When you register Azure Stack Hub, you provide credentials for an account that's an owner of the subscription. The account you use to register Azure Stack Hub can be different from the admin account that you use for deployment. Furthermore, the two accounts do not need to belong to the same domain; you can deploy using the tenant that you already use. For example, you can use ContosoCSP.onmicrosoft.com, then register using a different tenant; for example, IURContosoCSP.onmicrosoft.com. Remember to sign in using ContosoCSP.onmicrosoft.com when you perform daily Azure Stack Hub administration. You sign in to Azure using IURContosoCSP.onmicrosoft.com when you need to perform registration operations.

## CSP subscriptions

CSP subscriptions are the preferred choice for registration when a CSP reseller or an end customer operates Azure Stack Hub.

## Add end customer

To configure Azure Stack Hub so that a new tenant's resource usage is reported to their CSP subscription, refer to the following unit.

## Charge the right subscriptions

Azure Stack Hub uses a feature called registration. A registration is an object stored in Azure. The registration object documents which Azure subscription(s) to use to charge for a given Azure Stack Hub. This section addresses the importance of registration.

Using registration, Azure Stack Hub can:

 -  Forward Azure Stack Hub usage data to Azure Commerce and bill an Azure subscription.
 -  Report each customer's usage on a different subscription with a multi-tenant Azure Stack Hub deployment. Multi-tenancy enables Azure Stack Hub to support different organizations on the same Azure Stack Hub instance.

For each Azure Stack Hub, there is one default subscription and many tenant subscriptions. The default subscription is an Azure subscription that is charged if there's no tenant-specific subscription. It must be the first subscription to be registered. For multi-tenant usage reporting to work, the subscription must be a CSP or APSS subscription.

Then, the registration is updated with an Azure subscription for each tenant that uses Azure Stack Hub. Tenant subscriptions must be of the CSP type, and must roll up to the partner who owns the default subscription. You cannot register someone else's customers.

When Azure Stack Hub forwards usage info to global Azure, a service in Azure consults the registration and maps each tenant's usage to the appropriate tenant subscription. If a tenant has not been registered, that usage goes to the default subscription for the Azure Stack Hub instance from which it originated.

Because tenant subscriptions are CSP subscriptions, their bill is sent to the CSP partner, and usage info is not visible to the end customer.
