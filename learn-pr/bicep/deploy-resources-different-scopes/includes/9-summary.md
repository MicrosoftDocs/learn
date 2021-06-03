Your R&D team asked you for a dedicated Azure subscription for their secret project. The subscription needed to have some Azure Policy resources and a virtual network. You decided to create a reusable Bicep template so that you can quickly set up more subscriptions for the R&D team in the future.

In this module, you learned how to provision resources at various scopes: tenant, management group, subscription, and resource group. Although most Azure resources must be deployed to a resource group, some important situations require that you use higher-level scopes. These situations include working with Azure identity and access management (IAM) role definitions and assignments, deploying Azure Policy definitions and assignments, and creating resource groups.

By using the `targetScope` keyword and `scope` property on modules, you can easily create reusable Bicep templates that deploy resources throughout your Azure environment. This means that you can apply all of the benefits of infrastructure as code to every part of your cloud deployment process.

## Learn more

- [What are Azure management groups?](/azure/governance/management-groups/overview)
- Scopes for deployment:
  - [Tenant](/azure/azure-resource-manager/templates/deploy-to-tenant)
  - [Management group](/azure/azure-resource-manager/templates/deploy-to-management-group)
  - [Subscription](/azure/azure-resource-manager/templates/deploy-to-subscription)
- [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)
- [Language specification for resource scopes](https://github.com/Azure/bicep/blob/main/docs/spec/resource-scopes.md)
- [Enterprise-scale landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation)