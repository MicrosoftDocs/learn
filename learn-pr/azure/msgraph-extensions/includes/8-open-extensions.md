You've learned to use three types of extensions to store custom values and query the data. You've also learned the additional scenarios that each extension option supports. In this unit, you learn how to use the fourth type of extension, *open extension*.

## Open extensions

The Microsoft Graph open extensions are available for use by specific resources in Microsoft Graph, including the *user* resource.

Open extensions are loosely coupled with an application that's the "creator app." Unlike schema and directory extensions, the identifier of the creator app is undiscoverable when you're using open extensions.

Open extension definitions are created and managed on the fly on user objects. They're considered unique for each user, and it's not required to apply a universally consistent pattern for all users. For example, in the same tenant:
+ The user object for Adele can have an open extension named *socialSettings* that has three properties: **linkedInProfile**, **skypeId**, and **xboxGamertag**.
+ The user object for Bruno can have no open extension property.
+ The user object for Alex can have an open extension named *socialSettings* with five properties: **theme**, **color**, **language**, **font**, and **fontSize**.

Open extensions and their associated data are created and managed through the extensions relationship of the target resource and the associated *openTypeExtension* resource type.

The extension is identified by a unique **id** that must be defined during the Create operation via one of the following ways:
+ Explicitly define the **id** property in the request body.
+ Define an **extensionName** property in the request body, and Microsoft Graph automatically assigns the same value to the **id** property.
    + In subsequent updates, you can change the **extensionName** property value to one that's different from the **id** value.
    + In subsequent updates, specifying only the **id** property in the request body automatically deletes the **extensionName** property from the open extension.

The **id** property is the only required property in an extension property. You can therefore create an empty open extension. That is, you can create an open extension with only a name but no properties. For example:

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

+ Use POST to define a new open extension and store data in the open extension for an existing user. You must specify the **@odata.type** property with the value `microsoft.graph.openTypeExtension`.
+ Use PATCH to either store data in the open extension property, update the stored data, or delete the existing data.
    + To update any property in the open extension object, you must specify *all* properties in the request body; otherwise, Microsoft Graph will delete the unspecified properties. Although you might want to update only the **xboxGamertag** property, you must also specify both the **linkedInProfile** and **skypeId** values, so that the properties and their associated values aren't deleted.
    + To delete data from a property in the open extension object, set its value to `null`.
    + To delete a property from the open extension object, don't pass it in the PATCH request body, and Microsoft Graph will delete it.
    + To delete data from all properties in the open extension object but keep the open extension object, update the values of the properties to `null`.
+ Use the DELETE method to delete an open extension object from the user.

### Supported query capabilities

Open extensions don't support any OData query parameters.

To find matches in the data, your app must retrieve the open extension and all its related values and then apply client-side filtering and matching.

