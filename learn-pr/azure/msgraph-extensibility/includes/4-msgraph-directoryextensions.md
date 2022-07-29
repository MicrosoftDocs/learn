You've learnt to use extension attributes to store custom values, query the data, and use the data to define rules for dynamic groups. Here, you'll learn to use the second type of extension, **directory extensions**.

## Directory extension definitions

Before you can use directory extensions, you must define them in an application that becomes the directory extension "owner app".

A **directory extension definition** includes the name and return type and also explicitly allowlists the Microsoft Graph resources that can be assigned the directory extension. For our scenario, you'll specify the **user** resource.

Directory extension definitions are managed through the **extensionProperties** relationship on an application object and the associated **extensionProperty** resource type.

When you create a directory extension definition, Microsoft Graph transforms the extension name that you specified and adds a prefix to create a new extension name. This extension name becomes the name of directory extension property on the target objects. For example, when you specify `linkedInProfile` as an extension name in the request body, the new extension name can be `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

Microsoft Graph directory extensions are named following the naming convention:

*extension_{appId-without-hyphens}_{extensionProperty-name}*

Where `{appId-without-hyphens}` is the stripped version of the owner app's **appId** that includes only characters 0-9 and A-Z. For example, if the **appId** is `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb`, then `{appId-without-hyphens}` becomes `5bfc8fdacfc943a9a6de214ea9d15fd`. This is one way in which directory extensions are closely linked to the owner app.

A directory extension definition maps to *only* one directory extension property with a primitive return type. 

You can read the directory extension definitions in one of the following two ways:

```http
GET https://graph.microsoft.com/v1.0/applications/{applicationId}/extensionProperties

GET https://graph.microsoft.com/v1.0/applications/{applicationId}?$expand=extensionProperties
```

After the directory extension definition has been created, it's available for use after a tenant admin consents for the app to be used in the tenant and a service principal is created. When you create additional directory extensions on the owner app, these extensions are immediately available in the tenant where the app is homed.

To avoid breaking changes when the directory extension properties are in use, directory extension definitions can't be updated. For more information, see the [Considerations for using directory extensions](#considerations-for-using-directory-extensions).

Because directory extensions are closely tied to an owner app, they are also available for use by other tenants where the app has been consented to.

## Manage directory extension definitions

You manage the directory extension definitions as follows.
+ Use POST to create a new definition and its associated directory extension property.
+ Use GET to retrieve one or all directory extension definitions for an app or across the tenant.
+ Use the DELETE method to delete a directory extension definition.

## Use directory extension properties

After you've defined the directory extension, it's now available for use in user profiles. 

You manage the directory extension properties on user profiles through the same HTTP methods used to manage users.
+ Use POST to store data in the directory extension property when creating a new user.
+ Use PATCH to either store data in the directory extension property or update or delete the existing data. To delete data from the directory extension property, set its value to `null`.
+ Use GET to read the directory extension properties for all users or individual users in the tenant.

### Supported query capabilities

Directory extensions support querying at two levels: Matching against the directory extension definitions and matching against the directory extension properties.

Directory extension definitions support the `$select` and `$filter` (`eq` operator for the **name** property) OData query parameters to customize the responses.

In the Microsoft Graph `v1.0` endpoint, the directory extension properties aren't returned by default and you must use the `$select` query parameter to read the properties.

Directory extension properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters.You can also filter the results to return only users whose specific directory extension properties are empty (`null`). Filtering using the `ne` operator on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the **ConsistencyLevel** header set to `eventual`.

## Other Azure AD scenarios for the custom data

While you'll use the directory extension properties to store data required by the team bonding app, Azure AD also supports the following use cases for the custom data.
+ Use extensions data as rules for dynamic groups memberships
+ Use extensions data to customize claims

### Dynamically add users to groups

Suppose you want to seamlessly bring together employees with shared interests. For example, you want Xbox gamers to interact with each other through Yammer communities, Teams chats, and email, share tips and plan team playoffs.

Microsoft Graph groups allow an organization to bring together users with common interests. You can create an Xbox gamers group to bring together all Xbox enthusiasts through one alias.

To avoid manually updating the membership of the group, Microsoft Graph supports creating and managing groups with **dynamic membership**. You create a dynamic group for Xbox gamers within the company. The membership of the employees to the group depends on whether they've shared their Xbox gamertag. If an employee stops sharing their Xbox gamertag, they're automatically removed from the group. An employee who is a member of the Xbox gamers group will be able to interact with other gamers through Teams and email. You can also provision a Yammer community for the group.

### Customize tokens

Another Azure AD use case for the directory extensions is customizing tokens with custom claims.

An app may require some additional user information that's not available in token claims by default. For example, the app may require a user's LinkedIn profile URL in the authorization claims for redirection to the user's LinkedIn profile.

Directory extensions can therefore be used in custom claims to achieve this customized configuration.

## Considerations for using directory extensions

If you accidentally delete a directory extension definition, any data that's stored in the associated property becomes undiscoverable. To resolve this, create a new directory extension definition on the same owner app and with exactly the same name as the deleted definition.

You can use up to 100 directory extensions per user. When the definition object is deleted before the corresponding extension property is updated to `null`, the property will still count against the 100-limit for the user. 

When the definition is deleted before data in the associated extension property is deleted, there's no way to know the existence of the extension property via Microsoft Graph - even though the undiscoverable property counts against the 100-limit.

Deleting an owner app makes the associated directory extension properties and their data undiscoverable. Restoring an owner app restores the directory extension definitions *but doesn't* make the directory extension properties or their data immediately discoverable. This is because restoring an app doesn't automatically restore the associated service principal in the tenant. To make the directory extension properties and their data discoverable, either create a new service principal or restore the deleted service principal. NO changes are made to other tenants where the app has been consented to.

If a multi-tenant application creates additional directory extensions in an app that has been consented to by other tenants, the associated directory extension properties become immediately available for use by the other tenants.