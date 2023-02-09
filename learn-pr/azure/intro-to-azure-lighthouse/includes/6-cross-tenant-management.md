So far, you've learned how Azure Lighthouse streamlines the onboarding of Contoso's new customers. Beyond onboarding, Azure Lighthouse improves the way that Contoso manages Azure resources for its customers. Let's start by exploring how both Contoso and its customers have visibility of the Azure delegated resource management that has been deployed.

## Viewing your customers

Staff from the service provider can list and manage customers with a current service offer, in the Azure portal of their own Azure subscription.
In the **My Customers** page of Azure Lighthouse, they can display the customer's subscriptions, offers and delegated access, as provided in the Azure Resource Manager templates.

:::image type="content" source="../media/6-my-customers.png" alt-text="Screenshot of the service provider view of customers in Azure Lighthouse.":::

## Viewing your service providers

Customers who have accepted a service offer through the Azure Marketplace or by deploying an Azure Resource Manager template from their service provider, can view their accepted offer details via the **Service Providers/Delegations** page of Azure Lighthouse.

:::image type="content" source="../media/6-my-service-providers.png" alt-text="Screenshot of the customer view of Service Providers in Azure Lighthouse.":::

## Auditing service provider activities inside the customer's subscription

The security and compliance of an Azure environment is the responsibility of the subscription owner, even if they outsource management tasks to a service provider. Beyond the contracted legal requirements of the service offer between the customer and the service provider, the customer may want visibility of what actions the service provider has taken inside their Azure environment.

With Azure delegated resource access, even when the service provider is executing tasks with credentials from their own Azure environment, those actions are still carried about by Azure Resource Manager inside the customer's subscription. It means that those actions are recorded in the customer's Activity log, visible to the customer, and able to be monitored and alerted on if necessary.
