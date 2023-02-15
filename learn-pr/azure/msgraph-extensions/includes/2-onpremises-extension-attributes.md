Microsoft Graph provides four types of extensions for storing custom user data. The first type is *extension attributes*.

In this unit, you learn how to use the extension attributes to store the three pieces of user data about the employees.

## How extension attributes are presented in user objects

The Microsoft Graph *user* resource includes a predefined property called **onPremisesExtensionAttributes**. It's a complex type that defines 15 extension attribute properties with the following naming convention: *extensionAttribute{x}*, where *{x}* is an integer from 1 to 15. You can then use *extensionAttribute{x}* to store string data values.

The following is a JSON representation of the **onPremisesExtensionAttributes** object with no values assigned to the 15 properties.

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

You manage the extension attribute properties on user profiles through the same HTTP methods that are used to manage user objects. Because the extension attributes are predefined, you can only read and update their values.

To store the employees' public LinkedIn profile URL, Skype ID, and Xbox *gamertag*, you can choose to use **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15**.

### Supported query capabilities

The **onPremisesExtensionAttributes** property isn't returned by default. You must use the `$select` query parameter to read it. This property also supports the `$filter` (`eq` and `ne` operators) query parameter and you can also filter by extension attributes that are empty (`null`). When you use `$filter`, you must include the `$count=true` query parameter in the HTTP request and set the *ConsistencyLevel* header to `eventual`.

## Other Azure AD scenarios for the custom data

Although you'll use the extension attribute properties to store data that's required by the team-bonding app, Azure AD also supports the following use cases for the custom data:

- Use extensions data as rules for dynamic group memberships.
- Use extensions data to customize claims.

### Dynamically add users to groups

Suppose you want to help Xbox gamers interact with each other through Yammer communities, Teams chats, and email, to share tips and plan team playoffs. You can create an Xbox gamers group with all Xbox enthusiasts as members.

To avoid having to manually update the membership of the group, you can create the group to have dynamic membership. Employees are automatically added as members of the group only when they share their Xbox gamertag, and automatically removed when they stop sharing. Members of the Xbox gamers group can interact with other gamers through Teams and email. You can also create a Yammer community for the group.

### Customize tokens

Another Azure AD use case for the extension attribute properties and their data is the ability to customize tokens with custom claims.

An app might require some additional user information that's not available in token claims by default. For example, the app might require a user's LinkedIn profile URL in the authorization claims for redirection to the user's LinkedIn profile.

Extension attributes can be used in custom claims to achieve this customized configuration.