In [Plan and discuss Azure deployments](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-deployment-plans), you learned that the organizing structure for resources in Azure has four levels: management groups, subscriptions, resource groups, and resources.

The beginning of any cloud governance implementation involves identifying a cloud organization structure that meets your business needs. This step often involves setting up a *cloud center of excellence team* (also referred to as a *cloud enablement team* or a *cloud custodian team*) and empowering this team to implement governance practices from a centralized location for the entire organization.

Teams often start their Azure governance strategy at the subscription level. There are three main aspects to consider when creating and managing subscriptions: billing, access control, and subscription limits.

Let's look at each of these aspects in more detail.

## Billing

You can create one billing report per subscription. If you have multiple departments and need to do a "chargeback" of cloud costs, one possible solution is to organize subscriptions by department or by project.

Resource tags can also help here, and you'll explore tags later in this module. When defining how many subscriptions you need and what to name them, take into account your internal billing requirements.

## Access control

A subscription is a deployment boundary for Azure resources. Every subscription is associated with an Azure Active Directory (Azure AD) tenant. Each tenant provides administrators the ability to set up granular access through defined roles by using Azure role-based access control (Azure RBAC).

When designing your subscription architecture, consider the deployment boundary factor. For example, do you need separate subscriptions for development and for production environments? Creating separate subscriptions enables you to control access to each one separately and therefore isolate their resources from one another.

## Subscription limits

Subscriptions also have some resource limitations. For example, the maximum number of network Express Route circuits per subscription is 10. Those limits should be considered during your design phase. If you will need to exceed those limits, then you may need to add additional subscriptions. If you hit a hard limit maximum, there is no flexibility to increase it.

Management groups are also available to assist with managing subscriptions. A management group manages access, policies, and compliance across multiple Azure subscriptions. You'll learn more about management groups later in this module.
