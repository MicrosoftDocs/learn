## Exercise - Create custom role

Using the scenario, the first thing we need to establish are the required permissions for the employee to manage the virtual machines at the company. You can presume that the machines are all contained in the subscription you manage. 
When creating custom roles, it is recommended to start with an existing role. You will take the 'Virtual Machine Contributor' role as a starting point.

[!include[](../../../includes/azure-sandbox-activate.md)]

### Create role

You will now create a custom role within azure for the new employee

1. Firstly, we need to export the built in **Virtual Machine Contributor** permissions, by running the command:

        ```Azure CLI
        az role definition list --name "Virtual Machine Contributor" --output json | jq '.[] | .permissions[0].actions'
        ```

1. By taking the actions from this output and adding the required meta data, you will have the following role definition.

        ```JSON
         {   
            "name": "Virtual Machine Support",
            "description": "Lets you manage virtual machines",
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
1. You should also see the last two permissions are extra, this will allow the new employee to start and restart the Virtual Machines.
1. In the `AssignableScopes` section you will need to replace **{subscriptionId}** with the output of the following command

        ```Azure CLI
            az account list  --output json | jq '.[] | .id'
        ```

1. Type **Code** into the cloud shell
1. Paste the definition above into the editor, click **Save** from the three dot menu using a filename of  **VM-Support-Role.json**
1. To create the role, you will now need to run the following command in the cloud shell, which should return the same JSON back in the output, along with a few id fields added.

        ```Azure CLI
        az role definition create --role-definition VM-Support-Role.json
        ```

1. Finally, we can list all the custom roles to see if your new role is listed

        ```Azure CLI
        az role definition list --custom-role-only true
        ```

### Assigning roles

Once the custom role is created we need to assign it to the correct group of people/person. In the scenario we would now be assigning the custom role to the new employee

1. You can assign the custom role to the user, this can be done by:

        ```Azure CLI
          USER = az ad user list --output json | jq '.[0] | .userPrincipalName' 
          az role assignment create --assignee $USER --role "Virtual Machine Support"
        ```

1. You will now list the role assignments by typing the following into the cloud shell

        ```Azure CLI
            az role assignment list
        ```





