Microsoft Graph provides four types of extensions for storing custom user data. The second type of extensions is the **directory extensions**, also called **Azure AD** extensions.

In the team bonding app scenario, you want to store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag in their user profiles.

Here, you'll learn how to use directory extensions to store the three pieces of user data about the employees.

## Directory (Azure AD) extensions

The Microsoft Graph directory extensions are only available for use by specific resources in Azure Active Directory (Azure AD), including the **user** resource.

Directory extensions are closely tied to the application that creates them. To use directory extensions:
1. First create the directory extension definition in an app and explicitly define the resource types that can be assigned the directory extensions. You *can't* update the directory extension definition later. Microsoft Graph will transform the name of the directory extension to create a directory extension property.
1. Manage the directory extension property and its associated values on instances of the target resource objects.
1. During the lifecycle of their use, maintain the [Considerations for using directory extensions](#considerations-for-using-directory-extensions).

### Directory extension definitions

Before you can use directory extensions, you must define them in an application. This app becomes the directory extension "owner app".

A **directory extension definition** is a simple structure of the directory extension. The definition includes the name and return type and also explicitly allowlists the Azure AD resource types that be assigned the directory extensions. To allow directory extensions to be used to store the three custom data on the user profile, you must specify the **user** resource as a target object.

Directory extension definitions are managed through the **extensionProperties** relationship on an application object and the associated **extensionProperty** resource type.

When you create a directory extension definition, Microsoft Graph transforms the extension name that you specified and adds a prefix to create a new extension name. This extension name becomes the name of directory extension property on the target objects. For example, when you specify `linkedInProfile` as an extension name in the request body, the new extension name can be `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

Microsoft Graph directory extensions are named following the naming convention:

*extension_{appId-without-hyphens}_{extensionProperty-name}*

Where `{appId-without-hyphens}` is the stripped version of the owner app's **appId** that includes only characters 0-9 and A-Z. For example, if the **appId** is `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb`, then `{appId-without-hyphens}` becomes `5bfc8fdacfc943a9a6de214ea9d15fd`. This is one way in which directory extensions are closely linked to the owner app.

A directory extension definition maps to *only* one directory extension property with a primitive return type. Therefore, to store the three pieces of data using directory extensions, you must create three directory extension definitions, each with its unique name.

You can read the directory extension definitions in one of the following two ways:

```http
GET https://graph.microsoft.com/v1.0/applications/{applicationId}/extensionProperties

GET https://graph.microsoft.com/v1.0/applications/{applicationId}?$expand=extensionProperties
```

After the directory extension definition has been created, it's immediately available for use.

Directory extension definitions can't be updated to avoid breaking changes when the extensions are in use. However, they can be deleted. When deleted, they immediately become inaccessible on the target object. For more information, see the [Considerations for using directory extensions](#considerations-for-using-directory-extensions).

#### Directory extensions and multi-tenant apps

Because directory extensions are closely tied to an owner app, they are also available for use by other tenants where the app has been consented to. If a multi-tenant application creates additional directory extensions in an app that has been consented to by other tenants, the associated directory extension properties become immediately available for use by the other tenants.

### Manage directory extension definitions

You manage the directory extension definitions as follows.
+ Using a POST request, you can create a new definition and its associated directory extension property
+ Using a GET request, you can retrieve one or all directory extension definitions for an app or across the tenant
+ Using a DELETE request, you can delete a directory extension definition

### Use directory extension properties

After you've defined the directory extension, it's now available for use in user profiles.

You manage the directory extension properties on user profiles through the same HTTP methods used to manage users.
+ Using a POST request, you can store data in the directory extension property when creating a new user
+ Using a PATCH request, you can either store data in the directory extension property, update the stored data, or delete the existing data
    + To delete data from the directory extension property, set its value to `null`
+ Using a GET request, you can read the directory extension properties for all users or individual users in the tenant

#### Query capabilities supported by directory extensions

Directory extensions support querying at two levels: Matching against the directory extension definitions and matching against the directory extension properties.

##### Query capabilities supported by directory extension definitions

Directory extension properties support the `$select` and `$filter` OData query parameters to customize the responses. Only the `eq` operator for `$filter` is supported for matching against the **name** property.

##### Query capabilities supported by directory extension properties

In the Microsoft Graph `v1.0` endpoint, the directory extension properties aren't returned by default and you must therefore use the `$select` query parameter to read the properties.

Directory extension properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` and `ne` operators. You can also filter the results to return only users whose specific directory extension properties are empty (`null`). Filtering using the `ne` operator or on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the **ConsistencyLevel** header set to `eventual`.

### Other Azure AD scenarios for custom data in directory extension properties

While you'll use the directory extension properties to store data required by the team bonding app, Azure AD also supports the following use cases for the custom data.
+ Use extensions data as rules for dynamic groups memberships
+ Use extensions data to customize claims

#### Dynamically add users to internal groups based on their user profile data

Suppose you want to seamlessly bring together employees with shared interests. For example, you want Xbox gamers to interact with each other through Yammer communities, Teams chats, and email, share tips, plan team playoffs and have fun together.

Microsoft Graph groups allow an organization to bring together users with common interests. You can create an Xbox gamers group to bring together all Xbox enthusiasts through one alias.

To avoid manually updating the membership of the group, Microsoft Graph supports creating and managing groups with **dynamic membership**. You create a dynamic group for Xbox gamers within the company. The membership of the employees to the group depends on whether they've shared their Xbox gamertag. If an employee stops sharing their Xbox gamertag, they're automatically removed from the group. An employee who is a member of the Xbox gamers group will be able to interact with other gamers through Yammer, Teams, and email.

#### Customize tokens using data in directory extension properties

Another Azure AD use case for the directory extension properties and their data is customizing tokens with claims.

<!--Placeholder: TO-DO See more: https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-optional-claims#configuring-directory-extension-optional-claims -->

### Considerations for using directory extensions

Directory extension definitions cannot be restored once deleted. Delete any data from the associated directory extension property before deleting the definition. If you delete a definition before deleting the data in the associated property, the directory extension property and its associated data become undiscoverable in user objects.

You can use up to 100 directory extensions per user. When the definition object is deleted before the corresponding extension property is updated to `null`, the property will still count against the 100-limit for the user. 

When the definition is deleted before data in the associated extension property is deleted, there's no way to know the existence of the extension property via Microsoft Graph - even though the undiscoverable property counts against the 100-limit.

Deleting an owner app deletes the associated directory extension properties and the data they store for users. Restoring an owner app restores the directory extension definitions *but not* the directory extension properties or the data they store. This is because restoring an app doesn't automatically restore the associated service principal in the tenant. Either create a new service principal or restore the deleted service principal to restore the directory extension properties and the data they store for users.

<!-- Q: Can you protect an app that defines directory extensions from accidental deletion?  Restrict management of the app for example?
-->