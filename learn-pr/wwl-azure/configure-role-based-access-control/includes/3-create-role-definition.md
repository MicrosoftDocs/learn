Each role is a set of properties defined in a JSON file. For example, Actions, NotActions., and DataActions. 

:::image type="content" source="../media/role-definition-bf297cac.png" alt-text="The built-in Contributor role has actions, notactions, and dataactions.":::


In this next example, the Owner role means all (asterisk) actions, no denied actions, and all (/) scopes.

```PowerShell
Name: Owner
ID: 8e3af657-a8ff-443c-a75c-2fe8c4bcb65
IsCustom: False
Description: Manage everything, including access to resources
Actions: {*}
NotActions: {}
AssignableScopes: {/}

```

## Actions and NotActions

The Actions and NotActions properties can be tailored to grant and deny the exact permissions you need. This table defines the Owner, Contributor, and Reader roles.

:::row:::
  :::column:::
    **Built-in Role**
  :::column-end:::
  :::column:::
    **Action**
  :::column-end:::
  :::column:::
    **NotActions**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Owner (allow all actions)
  :::column-end:::
  :::column:::
    \*
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Contributor (allow all actions except writing or deleting role assignment)
  :::column-end:::
  :::column:::
    \*
  :::column-end:::
  :::column:::
    Microsoft.Authorization/\*/Delete, ‎Microsoft.Authorization/\*/Write, Microsoft.Authorization/elevateAccess/Action‎
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Reader (allow all read actions)
  :::column-end:::
  :::column:::
    \*/read
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::


## Scope your role

After defining the Actions and NotActions properties, you must scope the role.

The AssignableScopes property of the role specifies the role scope. The scope can be subscriptions, resource groups, or resources.

```
* /subscriptions/[subscription id]
* /subscriptions/[subscription id]/resourceGroups/[resource group name]
* /subscriptions/[subscription id]/resourceGroups/[resource group name]/[resource]

```

## Example 1

Make a role available for assignment in two subscriptions.

```
“/subscriptions/c276fc76-9cd4-44c9-99a7-4fd71546436e”, “/subscriptions/e91d47c4-76f3-4271-a796-21b4ecfe3624”

```

## Example 2

Makes a role available for assignment only in the Network resource group.

```
“/subscriptions/c276fc76-9cd4-44c9-99a7-4fd71546436e/resourceGroups/Network”

```
