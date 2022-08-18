You've learned to use extension attributes to store custom values, query the data, and use the data to define rules for dynamic groups. Here, you learn to use the second type of extension, *directory extension*.

## Directory extension definitions

Before you can use directory extensions, you must define them in an application that becomes the directory extension *owner app*.

A directory extension definition includes the name and return type, and it explicitly adds to an allowlist the Microsoft Graph resources that can be assigned the directory extension. For our scenario, you'll specify the *user* resource.

Directory extension definitions are managed through the *extensionProperties* relationship on an application object and the associated *extensionProperty* resource type.

When you create a directory extension definition, Microsoft Graph transforms the extension name you provided by adding a prefix to create a new extension name. This extension name becomes the name of the directory extension property on the target objects. For example, when you specify `linkedInProfile` as an extension name in the request body, the new extension name can be `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

Microsoft Graph directory extensions are named following the naming convention *extension_{appId-without-hyphens}_{extensionProperty-name}*, where `{appId-without-hyphens}` is the stripped version of the owner app's *appId*, which contains only letters (`a`-`z`) and numbers (`0`-`9`). For example, if *appId* is `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb`, then `{appId-without-hyphens}` becomes `5bfc8fdacfc943a9a6de214ea9d15fd`. This is one way in which directory extensions are closely linked to the owner app.

A directory extension definition maps to *only* one directory extension property with a primitive return type. 

You can read the directory extension definitions in one of the following two ways:

```http
GET https://graph.microsoft.com/v1.0/applications/{applicationId}/extensionProperties

GET https://graph.microsoft.com/v1.0/applications/{applicationId}?$expand=extensionProperties
```

After the directory extension definition has been created, it's available for use after a tenant admin grants consent for the app to be used in the tenant, and a service principal is created. When you create additional directory extensions on the owner app, these extensions are immediately available in the tenant where the app is homed.

To avoid breaking changes when the directory extension properties are in use, directory extension definitions can't be updated.

Because directory extensions are closely tied to an owner app, they're also available for use by other tenants where the app has been consented to.

## Manage directory extension definitions

You manage the directory extension definitions as follows:
+ Use POST to create a new definition and its associated directory extension property.
+ Use GET to retrieve one or all directory extension definitions for an app or across the tenant.
+ Use the DELETE method to delete a directory extension definition.

## Use directory extension properties

After you've defined the directory extension, it's available for use in user profiles. 

You manage the directory extension properties on user profiles through the same HTTP methods that you use to manage users.
+ Use POST to store data in the directory extension property when you're creating a new user.
+ Use PATCH to either store data in the directory extension property or update or delete the existing data. To delete data from the directory extension property, set its value to `null`.
+ Use GET to read the directory extension properties for all users or individual users in the tenant.

### Supported query capabilities

Directory extensions support querying at two levels: matching against the directory extension definitions and matching against the directory extension properties.

Directory extension definitions support the `$select` and `$filter` (`eq` operator for the **name** property) OData query parameters to customize the responses.

In the Microsoft Graph `v1.0` endpoint, the directory extension properties aren't returned by default, and you must use the `$select` query parameter to read the properties.

Directory extension properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters. You can also filter the results to return only users whose specific directory extension properties are empty (`null`). Filtering by using the `ne` operator on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the *ConsistencyLevel* header set to `eventual`.

## Other Azure AD scenarios for the custom data

Although you'll use the directory extension properties to store data that's required by the team-bonding app, Azure AD also supports the following use cases for the custom data:
+ Use extensions data as rules for dynamic groups memberships.
+ Use extensions data to customize claims.

### Dynamically add users to groups

With Microsoft Graph groups, an organization can bring together employees who share common interests.

For example, suppose you want to help Xbox gamers interact with each other through Yammer communities, Teams chats, and email, to share tips and plan team playoffs.

You can create an Xbox gamers group to bring together all Xbox enthusiasts through one alias.

To help you avoid having to manually update the membership of the group, Microsoft Graph supports creating and managing groups with *dynamic membership*. To do so, you create a dynamic group for Xbox gamers within the company. Membership in the group depends on whether they're sharing their Xbox gamertag. Employees who stop sharing their Xbox gamertag are automatically removed from the group. Members of the Xbox gamers group can interact with other gamers through Teams and email. You can also create a Yammer community for the group.

### Customize tokens

Another Azure AD use case for the extension attribute properties and their data is the ability to customize tokens with custom claims.

An app might require some additional user information that's not available in token claims by default. For example, the app might require a user's LinkedIn profile URL in the authorization claims for redirection to the user's LinkedIn profile.

Extension attributes can therefore be used in custom claims to achieve this customized configuration.