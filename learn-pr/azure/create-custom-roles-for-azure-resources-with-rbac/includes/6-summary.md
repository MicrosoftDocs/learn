## Summary
 
In this module you learnt how to handle the governance of azure resources to different levels of granularity. You experianced creation and maintenace of custom roles through scripting and utilising the portal.

In the scenario, you wanted to grant access to the new employee so that they could monitor and troubleshoot the VMs that host your website in Azure. However, to maximize security, you wanted to prevent that employee from taking any other actions. By creating a custom role in a JSON file, and then applying it using the Azure CLI, you've satisfied those requirements.

The built-in RBAC roles in Azure are versatile and often satisfactory for many organizations. You might not need to create custom roles. However, if you have very specific requirements or want to keep a close control of permissions, custom RBAC roles can be used to enable people to do their jobs and prevent malicious actions.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

### Learn More

https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations