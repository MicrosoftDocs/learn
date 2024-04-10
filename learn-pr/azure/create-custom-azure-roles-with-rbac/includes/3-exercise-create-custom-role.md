In this unit, you'll create a custom role for Virtual Machine Operator and assign it to yourself in Azure.

This exercise is optional. To complete it, you need access to an Azure subscription where you have the User Access Administrator or Owner role for your account. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create role

Create a custom role within Azure for the new employee.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the account where you have the User Access Administrator or Owner role.
1. Select **Cloud Shell** from the top right-hand side menu bar.
1. Select **Bash**.
1. Run the following command to get the subscription ID to use for your custom role definition. Copy the subscription ID.

   ```azurecli
    az account list  --output json | jq '.[] | .id, .name'
   ```

1. Type **code** into Cloud Shell.
1. Paste the following role definition into the editor. This is the role definition we identified in the previous unit.

    ```JSON
   {
     "Name": "Virtual Machine Operator",
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
       "Microsoft.Support/*"
     ], 
     "NotActions": [],
     "DataActions": [],
     "NotDataActions": [],
     "AssignableScopes": [
       "/subscriptions/subscriptionId"
     ]
   }
    ```

1. In the `AssignableScopes` section, replace **subscriptionId** with the value you got from the previous step.
1. Select **Save** from the three-dot menu on the top right-hand side of the Cloud Shell pane (or press <kbd>CTRL + S</kbd> in Windows or <kbd>CMD + S</kbd> in macOS).
1. Enter **vm-operator-role.json** as the filename and **Save**.
1. Select **Close Editor** from the three-dot menu on the top right-hand side of the Cloud Shell pane (or press <kbd>CTRL + Q</kbd> in Windows or <kbd>CMD + Q</kbd> in macOS).
1. Run the following command in the Cloud Shell to create the custom role:

   ```azurecli
   az role definition create --role-definition vm-operator-role.json
   ```

## Assign role

When the custom role is created, you can assign it to a user or group. To make things simple for our scenario, assign the custom role to yourself.

1. Run the following command to get your user principal name. Replace "your display name" with the name that appears on your profile card at the top right-hand side of the Azure portal. Your display name is likely your first and last name.

    ```azurecli
    USER=$(az ad user list --display-name "your display name" --query [0].userPrincipalName --output tsv)
    echo $USER
    ```

1. Run the following command to assign the custom role to yourself, replacing "your subscription id" with the subscription ID you coped previously:

    ```azurecli
    az role assignment create --assignee $USER --role "Virtual Machine Operator"  --scope /subscriptions/"your subscription id"
    ```

1. Close Cloud Shell.
