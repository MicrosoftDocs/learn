## Exercise

The engineering team at First Up Consultants needs very specific permissions for virtual machines that is not available with one of the [built-in roles](/azure/role-based-access-control/built-in-roles). Instead of granting them broad access, you decide to create a [custom role](/azure/role-based-access-control/custom-roles). Since you currently can't create custom roles in the Azure portal, you'll create the custom role using Azure PowerShell.

In this exercise, you learn how to:

> [!div class="checklist"]
> * Create a custom role
> * List custom roles
> * Delete a custom role

## Prerequisites

- Permissions to create custom roles, such as [Owner](/azure/role-based-access-control/built-in-roles#owner) or [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator)

## Sign in to Azure PowerShell

Sign in to [Azure PowerShell](/powershell/azure/authenticate-azureps).

## Create a custom role

The easiest way to create a custom role is to start with a built-in role, edit it, and then create a new role.

1. In PowerShell, use the [Get-AzureRmProviderOperation](/powershell/module/azurerm.resources/get-azurermprovideroperation) command to get the list of operations for the Microsoft.Support resource provider. It's helpful to know the operations that are available to create your permissions. You can also see a list of all the operations at [Azure Resource Manager resource provider operations](/azure/role-based-access-control/resource-provider-operations#microsoftsupport).

    ```azurepowershell-interactive
    Get-AzureRMProviderOperation "Microsoft.Support/*" | FT Operation, Description -AutoSize
    ```
    
    ```Output
    Operation                              Description
    ---------                              -----------
    Microsoft.Support/register/action      Registers to Support Resource Provider
    Microsoft.Support/supportTickets/read  Gets Support Ticket details (including status, severity, contact ...
    Microsoft.Support/supportTickets/write Creates or Updates a Support Ticket. You can create a Support Tic...
    ```

1. Change to your home directory.

    ```azurepowershell-interactive
    cd $HOME
    ```

1. Use the [Get-AzureRmRoleDefinition](/powershell/module/azurerm.resources/get-azurermroledefinition) command to output the [Reader](/azure/role-based-access-control/built-in-roles#reader) role in JSON format.

    ```azurepowershell-interactive
    Get-AzureRmRoleDefinition -Name "Reader" | ConvertTo-Json | Out-File ReaderSupportRole.json
    ```

1. Open the **ReaderSupportRole.json** file in the code editor.

    ```azurepowershell-interactive
    code ./ReaderSupportRole.json
    ```

    The following shows the JSON output. For information about the different properties, see [Custom roles](/azure/role-based-access-control/custom-roles).

    ```json
    {
        "Name": "Reader",
        "Id": "acdd72a7-3385-48ef-bd42-f606fba81ae7",
        "IsCustom": false,
        "Description": "Lets you view everything, but not make any changes.",
        "Actions": [
          "*/read"
        ],
        "NotActions": [],
        "DataActions": [],
        "NotDataActions": [],
        "AssignableScopes": [
          "/"
        ]
    }
    ```
    
1. Edit the JSON file to add the `"Microsoft.Support/*"` operation to the `Actions` property. Be sure to include a comma after the read operation. This action will allow the user to create support tickets.

1. Get the ID of your subscription using the [Get-AzureRmSubscription](/powershell/module/azurerm.resources/get-azurermsubscription) command.

    ```azurepowershell-interactive
    Get-AzureRmSubscription
    ```

1. In `AssignableScopes`, add your subscription ID with the following format: `"/subscriptions/00000000-0000-0000-0000-000000000000"`

    You must add explicit subscription IDs, otherwise you won't be allowed to import the role into your subscription.

1. Delete the `Id` property line and change the `IsCustom` property to `true`.

1. Change the `Name` and `Description` properties to "Reader Support Tickets" and "View everything in the subscription and also open support tickets."

    Your JSON file should look like the following:

    ```json
    {
        "Name": "Reader Support Tickets",
        "IsCustom": true,
        "Description": "View everything in the subscription and also open support tickets.",
        "Actions": [
          "*/read",
          "Microsoft.Support/*"
        ],
        "NotActions": [],
        "DataActions": [],
        "NotDataActions": [],
        "AssignableScopes": [
          "/subscriptions/00000000-0000-0000-0000-000000000000"
        ]
    }
    ```

1. Save the file by pressing **Ctrl+S** or by clicking the ellipsis (**...**) in the upper right and then clicking **Save**.

1. Close the editor by pressing **Ctrl+Q** or by clicking **...** > **Close Editor**.

1. To create the new custom role, use the [New-AzureRmRoleDefinition](/powershell/module/azurerm.resources/new-azurermroledefinition) command and specify the JSON role definition file.

    ```azurepowershell-interactive
    New-AzureRmRoleDefinition -InputFile "./ReaderSupportRole.json"
    ```

    ```Output
    Name             : Reader Support Tickets
    Id               : 22222222-2222-2222-2222-222222222222
    IsCustom         : True
    Description      : View everything in the subscription and also open support tickets.
    Actions          : {*/read, Microsoft.Support/*}
    NotActions       : {}
    DataActions      : {}
    NotDataActions   : {}
    AssignableScopes : {/subscriptions/00000000-0000-0000-0000-000000000000}
    ```
        
    The new custom role is now available in the Azure portal and can be assigned to users, groups, or service principals just like built-in roles.

## List custom roles

- To list all your custom roles, use the [Get-AzureRmRoleDefinition](/powershell/module/azurerm.resources/get-azurermroledefinition) command.

    ```azurepowershell-interactive
    Get-AzureRmRoleDefinition | ? {$_.IsCustom -eq $true} | FT Name, IsCustom
    ```

    ```Output
    Name                   IsCustom
    ----                   --------
    Reader Support Tickets     True
    ```
    
    You can also see the custom role in the Azure portal.

    ![screenshot of custom role imported in the Azure portal](../images/5-custom-role-reader-support-tickets.png)
    
## Delete a custom role

1. Use the [Get-AzureRmRoleDefinition](/powershell/module/azurerm.resources/get-azurermroledefinition) command to get the ID of the custom role.

    ```azurepowershell-interactive
    Get-AzureRmRoleDefinition "Reader Support Tickets"
    ```

1. Use the [Remove-AzureRmRoleDefinition](/powershell/module/azurerm.resources/remove-azurermroledefinition) command and specify the role ID to delete the custom role.

    ```azurepowershell-interactive
    Remove-AzureRmRoleDefinition -Id "22222222-2222-2222-2222-222222222222"
    ```

    ```Output
    Confirm
    Are you sure you want to remove role definition with id '22222222-2222-2222-2222-222222222222'.
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
    ```

1. When asked to confirm, type **Y**.

## Summary
