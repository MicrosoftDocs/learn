For this unit, you will create a custom role named *Customer Support Ticket*s using Azure PowerShell.

## Sign in to Azure PowerShell

Sign in to Azure PowerShell.

## Create a custom role

The easiest way to create a custom role is to start with a built-in role, edit it, and then create a new role.

1.  In PowerShell, use the **Get-AzProviderOperation** command to get the list of operations for the Microsoft.Support resource provider. It's helpful to know the operations that are available to create your permissions.

```
Get-AzProviderOperation "Microsoft.Support/*" | FT Operation, Description -AutoSize
```

```
Operation                              Description
---------                              -----------
Microsoft.Support/register/action      Registers to Support Resource Provider
Microsoft.Support/supportTickets/read  Gets Support Ticket details (including status, severity, contact ...
Microsoft.Support/supportTickets/write Creates or Updates a Support Ticket. You can create a Support Tic...

```

2.  Use the **Get-AzRoleDefinition** command to output the **Customer** role in JSON format.

```
Get-AzRoleDefinition -Name "Reader" | ConvertTo-Json | Out-File C:\CustomRoles\ReaderSupportRole.json

```

3.  Open the **CustomerSupportRole.json** file in an editor.

The script below shows the JSON output.

```
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

4.  Edit the JSON file to add the `"Microsoft.Support/*"` operation to the Actions property. Be sure to include a comma after the read operation. This action will allow the user to create support tickets.
5.  Get the ID of your subscription using the **Get-AzSubscription** command.

```
Get-AzSubscription

```

6.  In `AssignableScopes`, add your subscription ID with the following format: `"/subscriptions/00000000-0000-0000-0000-000000000000"`

Add explicit subscription IDs, otherwise you won't be allowed to import the role into your subscription.

7.  Delete the `Id` property line and change the `IsCustom` property to true.
8.  Change the `Name and Description` properties to "Customer Support Tickets" and "View everything in the subscription and also open support tickets."

The JSON file should look like the following:

```
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

9.  To create the new custom role, use the **New-AzRoleDefinition** command and specify the JSON role definition file.

```
New-AzRoleDefinition -InputFile "C:\CustomRoles\ReaderSupportRole.json"


```

The output is as follows:

```
Name            : Reader Support Tickets
Id              : 22222222-2222-2222-2222-222222222222
IsCustom        : True
Description     : View everything in the subscription and also open support tickets.
Actions         : {*/read, Microsoft.Support/*}
NotActions      : {}
DataActions     : {}
NotDataActions  : {}
AssignableScopes : {/subscriptions/00000000-0000-0000-0000-000000000000}


```

The new custom role is now available in the Azure portal and can be assigned to users, groups, or service principals just like built-in roles.
