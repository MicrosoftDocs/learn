In this module, you learned how to handle the governance of Azure resources to different levels of granularity. You experienced the creation and maintenance of custom roles through scripting and using the portal.

In the scenario, you wanted to give the new employee access to monitor and troubleshoot the VMs that host your website in Azure. To maximize security, you wanted to prevent that employee from taking any other actions. By creating a custom role in a JSON file, and then applying it using the Azure CLI, you satisfied those requirements.

The built-in RBAC roles in Azure are versatile and often satisfactory for many organizations. You might not need to create custom roles. However, if you have specific requirements or want to closely control permissions, consider using custom RBAC roles. These roles can be used to enable people to do their jobs and prevent malicious actions.

## Learn More

- [Built-in roles for Azure resources](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles)
- [Azure Resource Manager resource provider operations](https://docs.microsoft.com/azure/role-based-access-control/resource-provider-operations)
- [Resource providers for Azure services](https://docs.microsoft.com/azure/azure-resource-manager/azure-services-resource-providers)