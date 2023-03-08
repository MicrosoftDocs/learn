You've learned to use three types of extensions to store custom values and query the data. You've also learned the additional scenarios that each extension option supports. In this unit, you learn how to use the fourth type of extension, *open extension*.

## Open extensions

The Microsoft Graph open extensions are available for use by specific resources in Microsoft Graph, including the *user* resource.

Open extensions are loosely coupled with an application that's the "creator app." Unlike schema and directory extensions, the identifier of the creator app is undiscoverable when you're using open extensions.

Open extension definitions are created and managed on the fly on user objects. They're considered unique for each user, and it's not required to apply a universally consistent pattern for all users.

Open extensions and their associated data are created and managed through the extensions relationship of the target resource and the associated *openTypeExtension* resource type.

The **id** property is the only required property in an extension property. You can therefore create an empty open extension. That is, you can create an open extension with only a name but no properties. For example:

```msgraph-interactive
POST https://graph.microsoft.com/beta/me/extensions
Content-type: application/json

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

### Supported query capabilities

Open extensions don't support any OData query parameters.

To find matches in the data, your app must retrieve the open extension and all its related values and then apply client-side filtering and matching.