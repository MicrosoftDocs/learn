In this module, you learned how to handle the governance of Azure resources to different levels of granularity. You experienced the creation and maintenance of custom Azure roles through scripting and using the portal.

In the scenario, you wanted to give the new employee access to monitor and troubleshoot the VMs that host your website in Azure. To maximize security, you wanted to prevent that employee from taking any other actions. By creating a custom role in a JSON file, and then applying it using the Azure CLI, you satisfied those requirements.

The built-in Azure roles are versatile and work for many organizations. You might not need to create a custom role. However, if you have specific requirements or want to closely control permissions, consider using custom roles.

## Learn More

- [Built-in roles for Azure resources](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles)
- [Azure Resource Manager resource provider operations](https://docs.microsoft.com/azure/role-based-access-control/resource-provider-operations)
- [Custom roles for Azure resources](https://docs.microsoft.com/azure/role-based-access-control/custom-roles)