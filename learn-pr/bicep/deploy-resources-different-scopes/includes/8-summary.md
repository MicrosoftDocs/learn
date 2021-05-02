Your R&D team have asked for a dedicated Azure subscription for their secret project. The subscription needs some Azure Policy resources, as well as a virtual network. You decided to create a reusable Bicep template so that you can quickly provision more subscriptions for the R&D team in the future.

In this module you learned about how you can provision resources at different scopes: tenant, management group, subscription, and resource group. While most Azure resources must be deployed into a resource group, there are some important situations where you need to use higher-level scopes. These include working with Azure IAM role definitions and assignments, deploying Azure Policy definitions and assignments, and creating resource groups.

By using the `targetScope` keyword and `scope` property on modules, you can easily create reusable Bicep templates that deploy resources throughout your Azure environment. This means you can apply all of the benefits of infrastructure as code to every part of your cloud deployment process.

## Learn more

- [Language spec](https://github.com/Azure/bicep/blob/main/docs/spec/resource-scopes.md)
- [What are Azure management groups?](/azure/governance/management-groups/overview)
- Scopes for deployment:
  - [Tenant](/azure/azure-resource-manager/templates/deploy-to-tenant)
  - [Management group](/azure/azure-resource-manager/templates/deploy-to-management-group)
  - [Subscription](/azure/azure-resource-manager/templates/deploy-to-subscription)
