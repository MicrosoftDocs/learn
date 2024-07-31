Azure Lighthouse helps service providers simplify customer engagement and onboarding experiences, while managing delegated resources at scale with agility and precision. Authorized users, groups, and service principals can work directly in the context of a customer subscription without having an account in that customer's Microsoft Entra tenant or being a co-owner of the customer's tenant. The mechanism used to support this access is called Azure delegated resource management. 

## How delegation works

Azure delegated resource management creates a logical projection of resources from one tenant onto another tenant. This lets authorized service provider users sign in to their own tenant, with authorization to work in delegated customer subscriptions and resource groups with the roles they were granted during the onboarding process. Users in the service provider's tenant can then perform management operations on behalf of their customers, without having to sign in to each individual customer tenant.

The following diagram shows how Contoso might manage two customers through Azure Lighthouse. For Customer #1, Contoso users have access to one resource group, with roles that allow them to perform various monitoring and policy governance tasks. Customer #2 has delegated several subscriptions and resource groups to Contoso, with roles that allow them to perform monitoring and patching operations across all of the delegated scopes.

:::image type="content" source="../media/contoso-customers-delegation.png" alt-text="Diagram showing how Contoso might manage two customers through Azure Lighthouse.":::

## Process overview

Let's take a high-level look at how Azure Lighthouse works for a managing tenant such as Contoso to onboard and manage a customer.

### Planning

Contoso identifies the roles that it needs in order to perform specific management tasks for a customer's Azure resources. It then determines which users, groups, and/or service principals in its tenant should be granted those roles. Contoso notes that by assigning roles to user groups rather than individuals, it can add and remove specific members from those groups if access requirements change, without having to onboard the customer again.

### Onboarding

The customer is onboarded to Azure Lighthouse by deploying an Azure Resource Manager template that Contoso provides. This template specifies the customer scope that will be delegated (subscriptions and/or resource groups). It also specifies the access that will be granted to specific users, groups, and service principal entities in Contoso’s tenant.

Alternately, Contoso could onboard the customer by publishing a Managed Services offer to the commercial marketplace for the customer to accept.

Either way, once the customer is onboarded, two resources are created in the customer’s tenant: a registration definition, and a registration assignment.

### Managing

Once the customer has been onboarded, authorized users sign in to the Contoso tenant and perform tasks at the specified customer scope with the roles that they were granted during the onboarding process. Azure Resource Manager authenticates requests from users in the Contoso tenant, just as it does for requests made by users within the customer's own tenant. For Contoso’s users with access granted by Azure Lighthouse, Resource Manager confirms that the registration definition and the registration assignment are present in the customer's tenant and allow the requested access.

Users in Contoso's tenant can work directly in the individual delegated customer scope, using the access that they were granted. They could also perform common tasks across all delegated resources at scale.

The customer can review all actions taken by Contoso in their activity log. They can also remove Contoso's access at any time.
