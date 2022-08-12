Microsoft Graph provides four types of extensions for storing custom user data. The first type is *extension attributes*. In this unit, you learn how to use the extension attributes to store the three pieces of user data about the employees.

## How extension attributes are presented in user objects

The Microsoft Graph *user* resource includes a predefined property called **onPremisesExtensionAttributes**. This property was initially intended to allow tenants to sync data from on-premises Active Directory, hence the name. However, for users who aren't synced from on-premises Active Directory, you can use Microsoft Graph to store and manage the data in this property.

The **onPremisesExtensionAttributes** object is a complex type that defines the 15 extension attribute properties with the following naming convention: *extensionAttribute{x}*, where *{x}* is an integer from 1 to 15. You can then use *extensionAttribute{x}* to store string data values.

The following is a JSON representation of the **onPremisesExtensionAttributes** object with no values assigned to 15 properties.

```http
{
    "onPremisesExtensionAttributes": {
        "extensionAttribute1": null,
        "extensionAttribute2": null,
        "extensionAttribute3": null,
        "extensionAttribute4": null,
        "extensionAttribute5": null,
        "extensionAttribute6": null,
        "extensionAttribute7": null,
        "extensionAttribute8": null,
        "extensionAttribute9": null,
        "extensionAttribute10": null,
        "extensionAttribute11": null,
        "extensionAttribute12": null,
        "extensionAttribute13": null,
        "extensionAttribute14": null,
        "extensionAttribute15": null
    }
}
```

## Use extension attribute properties

You manage the extension attribute properties on user profiles through the same HTTP methods that are used to manage user objects.

+ Use POST to store data in an extension attribute property when you're creating a new user.
+ Use PATCH to either store data in the extension attribute property or update or delete the existing data. To delete data from an extension attribute property, set its value to `null`.
+ Use GET to read the extension attributes for all users or individual users in the tenant.

You don't need to store data in all extension attributes. You store data based only on your need, and unused extension attributes can remain as `null`.

You also don't need to use the extension attributes in their logical order. For example, you can choose to use **extensionAttribute14** only or **extensionAttribute1** and **extensionAttribute9** only. To store the employees' public LinkedIn profile URL, Skype ID, and Xbox *gamertag*, you can choose to use **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15**, respectively.

### Supported query capabilities

In the Microsoft Graph `v1.0` endpoint, the **onPremisesExtensionAttributes** property isn't returned by default. You must use the `$select` query parameter to read it.

Extension attribute properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters. You can also filter the results to return only users whose specific extension attributes are empty (`null`).

You can index extension attribute properties in Microsoft Graph for advanced querying specially by using `$filter`. This means that when you use `$filter`, you must include the `$count=true` query parameter in the HTTP request and set the *ConsistencyLevel* header to `eventual`.

Although Microsoft Graph supports the `$filter` and `$select` query parameters, it doesn't support directly retrieving only a subset of the 15 properties nested in the **onPremisesExtensionAttributes** object.

## Other Azure AD scenarios for the custom data

Although you'll use the extension attribute properties to store data that's required by the team-bonding app, Azure Active Directory (Azure AD) also supports the following use cases for the custom data:
+ Use extensions data as rules for dynamic group memberships.
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