Sometimes you need to deploy across multiple levels of your hierarchy. Here are some situations where you might want to do this:

- You need to deploy resources in two different resource groups.
- You create a resource group, which is a subscription-scoped resource, and then want to deploy a storage account and other Azure resources into that resource group.
- You create a subscription within a management group, and then want to create a resource group in the newly created subscription with some key resources like a virtual network.
- You create a management group hierarchy by using a tenant-scoped deployment, and then you want to create subscriptions within that hierarchy.

Bicep enables you to create a deployment that works across different scopes by using Bicep modules.

## Specify the scope for a module

- The `scope` keyword on modules
- Allowed combinations

| Parent | RG child | Subscription child | MG child | Tenant child |
|-|-|-|-|-|
| RG | Yes (same or different) | Yes | No (BCP116) | Yes |
| Subscription | Yes | Yes (same or different) | No (BCP115) | Yes |
| MG | Yes | Yes | Yes (same or different) | Yes |
| Tenant | Yes | Yes | Yes | Yes (same tenant only) |

## Deploy across multiple resource groups

TODO
