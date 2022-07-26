## Open extensions

The Microsoft Graph open extensions are only available for use by specific resources in Microsoft Graph including the **user** resource.

Open extensions are loosely coupled to an application that's the "creator app". Unlike schema and directory extensions, the identifier of the creator app is undiscoverable when using open extensions.

Open extension definitions are created and managed on-the-fly on users. They're considered unique for each user and it's not required to apply a universally consistent pattern for all users. For example, in the same tenant:
+ The user object for Adele can have an open extension named **socialSettings** with three properties - **linkedInProfile**, **skypeId**, and **xboxGamertag**
+ The user object for Bruno can have no open extension property
+ The user object for Alex can have an open extension named **socialSettings** with five properties - **theme**, **color**, **language**, **font**, and **fontSize**

Open extensions and their associated data are created and managed through the **extensions** relationship of the target resource and the associated **openTypeExtension** resource type.

The extension is identified by a unique **id** that must be defined during the "Create extension" operation via one of the following ways:
+ Explicitly define the **id** property in the request body
+ Define an **extensionName** property in the request body  and Microsoft Graph will automatically assign the same value to the **id** property
    + In subsequent updates, you can change the **extensionName** to a different value from the **id**
    + In subsequent updates, specifying only the **id** property in the request body automatically deletes the **extensionName** property from the open extension

The **id** property is the only required property in an extension property. You can therefore create an empty open extension, that is, an open extension with only a name but no properties. For example:

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
+ Use POST to define a new open extension and store data in the open extension for an existing user
    + You must specify the **@odata.type** property with the value `microsoft.graph.openTypeExtension`
+ Use PATCH to either store data in the open extension property, update the stored data, or delete the existing data
    + To delete data from a property in the open extension object, set its value to `null`
    + To update any property in the open extension object, you *must* specify *all* properties in the request body; otherwise, Microsoft Graph will delete the unspecified properties. Therefore, while you may want to update only the **xboxGamertag**, you must also specify both the **linkedInProfile** and **skypeId** so that the properties and their associated values aren't deleted.
    + To delete a property from the open extension object, don't pass it in the PATCH request body or set it's value to `null`
    + To delete data from all properties in the open extension object but keep the open extension object, update the values of the properties to `null`
+ Use the DELETE method to delete an open extension object from the user

During their use, maintain the [Considerations for using open extensions](#considerations-for-using-open-extensions).

#### Query capabilities supported by open extension properties

Open extensions don't support any OData query parameters.

Your app must retrieve the open extension and all it's related values then apply client-side filtering and matching to find matches in the data.

### Considerations for using open extensions

For users and other Microsoft Graph directory objects, you can only have two open extensions per creator app and a maximum of 2 Kb of data per open extension.

Deleting a creator app doesn't affect the open extension and the data it stores.