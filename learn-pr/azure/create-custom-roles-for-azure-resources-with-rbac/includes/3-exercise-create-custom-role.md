With Role-Based Access Control (RBAC) in Azure, you use JSON to create and assign roles.

Suppose you're ready to create a new role for the employee who manages the company VMs. You want to create the new role based on the Virtual Machine Contributor role and you assume that the machines are all contained in the subscription that you manage.

In this unit, you'll create and assign an RBAC role.

## Create role

Create a custom role within Azure for the new employee.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Cloud Shell** from the top right-hand side menu bar.
1. Run the following command to get the subscription ID to use for your custom role definition. Copy the subscription ID.

   ```azurecli
    az account list  --output json | jq '.[] | .id, .name'
   ```
1. Type **Code** into Cloud Shell.
1. Paste the following role definition  into the editor. This is role definition we identified in the previous unit.

    ```JSON
   {
   "Name": "Virtual Machine Operator",
   "Id": "88888888-8888-8888-8888-888888888888",
   "IsCustom": true,
   "Description": "Can monitor and restart virtual machines.",
   "Actions": [
     "Microsoft.Storage/*/read",
     "Microsoft.Network/*/read",
     "Microsoft.Compute/*/read",
     "Microsoft.Compute/virtualMachines/start/action",
     "Microsoft.Compute/virtualMachines/restart/action",
     "Microsoft.Authorization/*/read",
     "Microsoft.ResourceHealth/availabilityStatuses/read",
     "Microsoft.Resources/subscriptions/resourceGroups/read",
     "Microsoft.Insights/alertRules/*",
     "Microsoft.Insights/diagnosticSettings/*",
     "Microsoft.Support/*"
   ],
   "NotActions": [],
   "DataActions": [],
   "NotDataActions": [],
   "AssignableScopes": [
      "/subscriptions/{subscriptionId1}"
   ]
   }
    ```

1. In the `AssignableScopes` section, replace **{subscriptionId}** with the value you got from the previous step.
1. Select **Save** from the three-dot menu on the top right-hand side of the Cloud Shell pane. 
1. Enter **vm-operator-role.json** as the filename.
1. Run the following command in the Cloud Shell to create the custom role:

   ```azurecli
   az role definition create --role-definition vm-operator-role.json
   ```

1. Run the following command to list all the custom roles and verify yours is listed.

   ```azurecli
   az role definition list --custom-role-only true
   ```

## Assign role

When the custom role is created, you can assign it to a user or group. For our scenario, assign the custom role to the new employee.

1. Run the following command to assign the custom role to the user.

   ```azurecli
   USER = az ad user list --output json | jq '.[0] | .userPrincipalName' 
   az role assignment create --assignee $USER --role "Virtual Machine Support"
   ```

1. Run the following command to list the role assignments and verify the you've assigned the new custom role.

   ```azurecli
   az role assignment list
   ```