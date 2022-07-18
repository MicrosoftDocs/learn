The fourth type of extensibility option available for storing custom data in Microsoft Graph is **open extensions**.

In the team bonding app scenario, you want to store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag in their user profiles.

Here, you'll learn how to use open extensions to store the three pieces of user data about the employees.

## Open extensions

The Microsoft Graph open extensions are only available for use by specific resources in Microsoft Graph including the **user** resource.

Open extensions are also tied to an application that's the "creator app". However, unlike schema and directory extensions, the identifier of the creator app is undiscoverable when using open extensions.

During their use, maintain the [Considerations for using open extensions](#considerations-for-using-open-extensions).

### Use open extensions

Open extension definitions are created and managed on-the-fly against resource instances. There's no need to apply a universally consistent pattern for all resource instance. For example, a user object for Adele can have an open extension with three properties while another user object for Bruno can have no open extension property.

Open extension definitions and their associated data are created and managed through the **extensions** relationship of the target resource and the associated **openTypeExtension** resource type.

The extension is identified by a unique **id** that must be defined during the "Create extension" operation via one of the following ways:
+ Explicitly define the **id** property in the request body
+ Define an **extensionName** property in the request body  and Microsoft Graph will automatically assign the same value to the **id** property
    + In subsequent updates, you can change the **extensionName** to a different value from the **id**
    + In subsequent updates, specifying only the **id** property in the request body automatically deletes the **extensionName** property from the open extension

The **id** property is the only required property in an extension property. You can therefore create an empty open extension, that is, an open extensions with only a name but no properties. For example:

```msgraph-interactive
POST https://graph.microsoft.com/beta/me/extensions

{
    "@odata.type": "#microsoft.graph.openTypeExtension",
    "id": "socialSettings"
}
```

To retrieve all open extensions for all users in the tenant, use the `$expand` query parameter as follows:

```http
GET https://graph.microsoft.com/v1.0/users?$expand=extensions
```

To retrieve all open extensions for a single user, use the following request syntax:

```http
GET https://graph.microsoft.com/v1.0/users/{userId}/extensions
```

To read only one open extension for a user, use the following request syntax:

```http
GET https://graph.microsoft.com/v1.0/users/{userId}/extensions/{extensionId}
```

You manage open extensions for users as follows:
+ Using a POST request, you can define a new open extension and store data in the open extension for an existing user
+ Using a PATCH request, you can either store data in the open extension property, update the stored data, or delete the existing data
    + To delete data from a property in the open extension object, set its value to `null`
    + To delete data from *all* properties in the open extension object and effectively, the open extension, set its value to `null`
    + To update any property in the open extension object, you must specify all properties in the request body; otherwise, Microsoft Graph will delete the unspecified properties. Therefore, while you may want to update only the **xboxGamertag**, you must also specify both the **linkedInProfile** and **skypeId** so that the properties and their associated values aren't deleted.
+ Using the DELETE method, you can delete an open extension object from the user

#### Query capabilities supported by open extension properties

Open extensions do not support any OData query parameters.

### Considerations for using open extensions

For users and other Microsoft Graph directory objects, you can only have two open extensions per creator app and a maximum of 2Kb of data per open extension.

Deleting a open extension definition does not affect accessing custom data that has been added to resource instances based on that definition.

<!--To validate
Qs:
+ Can the open extension owner app be deleted while the open extension still exists?

-->