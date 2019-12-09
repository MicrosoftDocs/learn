With Role-Based Access Control (RBAC) in Azure, you use JSON to create and assign roles.

Suppose you're ready to create a new role for the employee who manages the company VMs. You want to create the new role based on the Virtual Machine Contributor role and you assume that the machines are all contained in the subscription that you manage.

In this unit, you'll create and assign an RBAC role.

## Create role

Create a custom role within Azure for the new employee:

1. First, export the built-in **Virtual Machine Contributor** permissions, by running the following command:

   ```Azure CLI
   az role definition list --name "Virtual Machine Contributor" --output json | jq '.[] | .permissions[0].actions'
   ```

1. By taking the actions from this output and adding the required metadata, you'll have the following role definition:

   ```JSON
        {   
        "Name": "Virtual Machine Support",
        "Description": "Lets you manage virtual machines",
        "IsCustom": true,
        "Actions": [
          "Microsoft.Authorization/*/read",
          "Microsoft.Compute/availabilitySets/*",
          "Microsoft.Compute/locations/*",
          "Microsoft.Compute/virtualMachines/*",
          "Microsoft.Compute/virtualMachineScaleSets/*",
          "Microsoft.DevTestLab/schedules/*",
          "Microsoft.Insights/alertRules/*",
          "Microsoft.Network/applicationGateways/backendAddressPools/join/action",
          "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
          "Microsoft.Network/loadBalancers/inboundNatPools/join/action",
          "Microsoft.Network/loadBalancers/inboundNatRules/join/action",
          "Microsoft.Network/loadBalancers/probes/join/action",
          "Microsoft.Network/loadBalancers/read",
          "Microsoft.Network/locations/*",
          "Microsoft.Network/networkInterfaces/*",
          "Microsoft.Network/networkSecurityGroups/join/action",
          "Microsoft.Network/networkSecurityGroups/read",
          "Microsoft.Network/publicIPAddresses/join/action",
          "Microsoft.Network/publicIPAddresses/read",
          "Microsoft.Network/virtualNetworks/read",
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.RecoveryServices/locations/*",
          "Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/write",
          "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/*/read",
          "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/read",
          "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/write",
          "Microsoft.RecoveryServices/Vaults/backupPolicies/read",
          "Microsoft.RecoveryServices/Vaults/backupPolicies/write",
          "Microsoft.RecoveryServices/Vaults/read",
          "Microsoft.RecoveryServices/Vaults/usages/read",
          "Microsoft.RecoveryServices/Vaults/write",
          "Microsoft.ResourceHealth/availabilityStatuses/read",
          "Microsoft.Resources/deployments/*",
          "Microsoft.Resources/subscriptions/resourceGroups/read",
          "Microsoft.SqlVirtualMachine/*",
          "Microsoft.Storage/storageAccounts/listKeys/action",
          "Microsoft.Storage/storageAccounts/read",
          "Microsoft.Support/*",
          "Microsoft.Compute/virtualMachines/start/action",
          "Microsoft.Compute/virtualMachines/restart/action"
        ],
        "NotActions": [],
        "DataActions": [],
        "NotDataActions": [],
        "assignableScopes": [
          "/subscriptions/{subscriptionId}"
        ]
        }
   ```

1. You should also see the last two permissions are extra, which allows the new employee to start and restart the VMs.
1. In the `AssignableScopes` section, you'll need to replace **{subscriptionId}** with the output of the following command:

   ```Azure CLI
   az account list  --output json | jq '.[] | .id'
   ```

1. Type **Code** into the cloud shell. Paste the definition above into the editor, then select **Save** from the three-dot menu using **VM-Support-Role.json** as the filename.
1. To create the role, you now run the following command in the cloud shell, which should return the same JSON back in the output – a few ID fields are added:

   ```Azure CLI
   az role definition create --role-definition VM-Support-Role.json
   ```

1. Finally, you list all the custom roles to see if your new role is listed.

   ```Azure CLI
   az role definition list --custom-role-only true
   ```

## Assigning roles

When the custom role is created, you assign it to the correct group of people/person. In the scenario, you would now assign the custom role to the new employee.

1. You can assign the custom role to the user as follows:

   ```Azure CLI
   USER = az ad user list --output json | jq '.[0] | .userPrincipalName' 
   az role assignment create --assignee $USER --role "Virtual Machine Support"
   ```

1. You'll now list the role assignments by typing the following command into the cloud shell:

   ```Azure CLI
   az role assignment list
   ```