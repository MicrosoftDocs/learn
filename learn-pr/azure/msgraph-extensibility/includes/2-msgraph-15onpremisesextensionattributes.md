Microsoft Graph provides four types of extensions for adding custom properties to users and storing custom data. The first type of extensions is the 15 predefined **extension attribute properties**.

In the team bonding app scenario, you want to store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag in their user profiles.

Here, you'll learn how to use the extension attribute properties to store the three pieces of user data about the employees.

## 15 Extension attribute properties

The Microsoft Graph **user** resource defines 15 predefined extension attribute properties for adding custom data. With these properties, you don't define custom names for the extension properties. Instead, you only update the properties to store user-specific data.

### How extension attribute properties are presented for use

On the Microsoft Graph **user** resource is a predefined property called **onPremisesExtensionAttributes**. This property was initially intended to allow tenants to sync data from on-premises Active Directory (AD), hence the name. However, its use has evolved to support storing custom data in the cloud.

The return type for the **onPremisesExtensionAttributes** property isn't a primitive data type. Instead, the return type is a complex type named **onPremisesExtensionAttributes**. The **onPremisesExtensionAttributes** complex type in turn defines the 15 extension attribute properties with the following naming convention: *extensionAttribute{x}* where *{x}* is an integer between 1 and 15. *extensionAttribute{x}* can then be used to store String data values.

The following is a JSON representation of the **onPremisesExtensionAttributes** property with no values assigned to the 15 nested extension attribute properties.

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

Therefore, because the 15 extension attributes are predefined on the **user** resource, you can't define them, assign them custom names, or delete them. You can only manage them by adding, updating, or deleting data from them.

### Use extension attribute properties

You manage the extension attribute properties on user profiles through the same HTTP methods used to manage users.

+ Using a POST request, you can store data in an extension attribute property when creating a new user
+ Using a PATCH request, you can either store data in the extension attribute property, update the stored data, or delete the existing data
    + To delete data from an extension attribute property, set its value to `null`
+ Using a GET request, you can read the directory extension properties for all users or individual users in the tenant

You don't need to store data in all extension attributes. You only store data based on your need and unused extension attributes can remain *null*.

You also don't need to use the extension attributes in their logical order. For example, you can choose to use **extensionAttribute14** only or **extensionAttribute1** and **extensionAttribute9** only. To store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag, you can choose to use **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15** respectively.

#### Query capabilities supported by extension attribute properties

In the Microsoft Graph `v1.0` endpoint, the **onPremisesExtensionAttributes** property isn't returned by default and you must therefore use the `$select` query parameter to read the property.

Extension attribute properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` and `ne` operators. You can also filter the results to return only users whose specific extension attributes are empty (`null`).

The extension attribute properties are specially indexed in Microsoft Graph for advanced querying. This means the HTTP request must include the `$count=true` query parameter and the **ConsistencyLevel** header set to `eventual`.

While Microsoft Graph supports the `$filter` and `$select` query parameters, it doesn't support directly retrieving only a subset of the 15 properties nested in the **onPremisesExtensionAttributes** object.

### Other Azure AD scenarios for custom data in extension attribute properties

While you'll use the extension attribute properties to store data required by the team bonding app, there are other different Azure AD use cases for this custom data in your organization.

#### Dynamically add users to internal groups based on their user profile data

Suppose you want to seamlessly allow employees with shared interests to communicate through one internal Teams channel and share tips or have fun. For example, you want Xbox gamers to interact with each other through Yammer communities, Teams chats, and email, share tips, plan team playoffs and have fun together.

Microsoft Graph groups allow an organization to bring other users with common interests. You can create an Xbox gamers group to bring together all Xbox enthusiasts through one alias.

To avoid manually updating the membership of the group, Microsoft Graph supports creating and managing groups with **dynamic membership**. You create a dynamic group for Xbox gamers within the company. The membership of the employees to the group depends on whether they've shared their Xbox gamertag. If an employee stops sharing their Xbox gamertag, they're automatically removed from the group. An employee who is a member of the Xbox gamers group will be able to interact with other gamers through a Teams channel and can receive emails sent to the group members.

#### Customize tokens using data in extension attribute properties

Another Azure AD use case for the extension attribute properties and their data is customizing tokens with claims.

<!--Placeholder: TO-DO See more: https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-optional-claims#configuring-directory-extension-optional-claims -->

### Considerations for using extension attribute properties

The 15 extension attributes already predefined in Microsoft Graph and their property names can't be changed. Therefore, you can't use custom names such as **SkypeId** for the extension attributes. This requires you and the organization to define the extension attribute properties that are in use so that the values aren't inadvertently overwritten by other apps.