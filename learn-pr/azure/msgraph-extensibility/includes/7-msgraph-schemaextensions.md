You've learnt to use two types of extensions to store custom values, query the data, and use the data to define rules for dynamic groups. Here, you'll learn to use the third type of extension, **schema extensions**.

## Schema extension definitions

Before you can use schema extension, you must define them. The following are the core components of a schema extension definition.

### Extension ID

A schema extension ID is generated during the Create operation and can follow one of two naming conventions.

+ If you have a vanity `.com`,`.net`, `.gov`, `.edu` or a `.org` domain that you've verified with your tenant, use the domain name along with the schema name to define a unique ID in the format *{domainName}_{schemaName}*. For example, if your vanity domain is "contoso.com", you can define `contoso_teamBondingApp` as the ID. This option is highly recommended and makes the schema extension property more discoverable.
+ If you don't have a verified vanity domain, specify only the schema ID, for example, `teamBondingApp` in your request body. Microsoft Graph will transform this ID and prefix it in this format: *ext{8-random-alphanumeric-chars}_{schema-name}*. For example, the new schema ID may be `extkvbmkofy_teamBondingApp`.

The new schema extension ID becomes the name of schema extension property on the target objects.

### Extension owner

A schema extension must have an owner app. This owner app is referenced by the **owner** property that's assigned the value of the app's **appId**.

The **owner** of the schema definition must be explicitly specified during the Create and Update operations or it will be implied and auto-assigned by Azure AD as follows:
1. In delegated access:
    1. The signed-in user must be the owner of the app that calls Microsoft Graph to create the schema extension definition.
    1. If the signed-in user isn't the owner of the calling app, they must explicitly specify the **owner** property, and assign it the **appId** of an app that they own.
1. In app-only access, the **owner** property isn't required in the request body. Instead, the calling app will be assigned ownership of the schema extension.

You can't change ownership of the schema extension.

If you're using Graph Explorer for the exercise unit, you must therefore explicitly specify the **owner** property in the request body for the Create request.

### Target objects

You must explicitly specify Microsoft Graph resources that can be assigned the schema extension. For our scenario, you'll specify the **user** resource.

### Extension properties

You can define the properties of the extension in a Create or Update operation. The return type can be one of `Binary`, `Boolean`, `DateTime`, `Integer` or `String`. You can't update existing properties but can add more properties through Update operations.

### Extension status

A schema extension definition has a lifecycle that affects how the property can be used. This lifecycle is managed through the **status** property and can be one of the following states: `InDevelopment`, `Available`, `Deprecated`.

|State |Lifecycle state behavior |
|:-------------|:------------|
| InDevelopment | <ul><li>Initial state after creation. The owner app is still developing the schema extension. </li><li>In this state, any app in the same directory where the owner app is registered can extend resource instances with this schema definition (if the app has permissions to that resource). </li><li>For an owner app that's multi-tenant, only the instance of the owner app that's in a different directory from the home directory can extend resource instances with this schema definition (if the app has permissions to that resource), or read the extension data. </li><li>Only the owner app can update the extension definition with additive changes. </li><li>Only the owner app can delete the extension definition. </li><li>The owner app can move the extension from **InDevelopment** to the **Available** state.</li></ul> |
| Available | <ul><li>The schema extension is available for use by all apps in any tenant. </li><li>After the owner app sets the extension to **Available**, any app can add custom data to instances of those resource types specified in the extension (if the app has permissions to that resource). The app can assign custom data when creating a new instance or updating an existing instance. </li><li>Only the owner app can update the extension definition with additive changes. No app can delete the extension definition in this state. </li><li>The owner app can move the schema extension from **Available** to the **Deprecated** state.</li></ul> |
| Deprecated | <ul><li>The schema extension definition can no longer be read or modified. </li><li>No app can view, update, add new properties, or delete the extension. </li><li>Apps can, however, still read, update, or delete existing extension _property values_. </li></ul> |

## Manage schema extension definitions

Schema extension definitions are created and managed through the **schemaExtension** resource type and its associated methods. The following is an example of a schema extension definition:

```http
{
    "id": "contoso_teamBondingApp",
    "description": "Extensions for custom properties used by the team bonding app",
    "targetTypes": [
        "user"
    ],
    "status": "InDevelopment",
    "owner": "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb",
    "properties": [
        {
            "name": "linkedInProfile",
            "type": "String"
        },
        {
            "name": "skypeId",
            "type": "String"
        },
        {
            "name": "xboxGamertag",
            "type": "String"
        }
    ]
}
```

## Schema extensions and multi-tenant apps

Schema extensions are loosely coupled to their owner apps but are also available for use by other tenants where the app has been consented to. For more information, see the [Schema extension status](#extension-status).

## Manage schema extension definitions

You manage the schema extension definitions as follows.
+ Use POST to create a new definition and its associated schema extension property.
+ Use GET to retrieve one or all schema extension definitions for an app or across the tenant.
+ Use PATCH to update the description, status, target types, or add more properties to the schema extension definition.
+ Use the DELETE method to delete a schema extension definition.

## Use schema extension properties

Schema extension properties are presented as complex types in user objects. These properties are available for use throughout their existence and even when the definition is deleted.

You manage the schema extension properties on user profiles through the same HTTP methods used to manage users.
+ Use POST to store data in the schema extension property when creating a new user.
+ Use PATCH to either store data in the schema extension property or update or delete the stored data.
    + To delete data from a property, set its value to `null`.
    + To delete data from *all* properties, set its value to `null`. If all properties are `null`, the schema extension object is also deleted.
    + To update any property, you must specify all properties in the request body; otherwise, Microsoft Graph will update the unspecified properties to `null`.
+ Use GET to read the schema extension properties for all users or individual users in the tenant.

### Query capabilities supported by schema extensions

Schema extension definitions support the `$filter` OData query parameter with the `eq` operator for matching against the **id**, **owner**, and **status** properties. You can also use `startsWith` to match against the **owner** property.

In the Microsoft Graph `v1.0` endpoint, the schema extension properties aren't returned by default and you must use the `$select` query parameter to read the properties.

Schema extension properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters.You can also filter the results to return only users whose specific extension attributes are empty (`null`). Filtering using the `ne` operator or on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the **ConsistencyLevel** header set to `eventual`.

## Other Azure AD scenarios for custom data in directory extension properties

Schema extension properties and the data they store aren't supported by any additional Azure AD scenarios. However, you can use the extensions and their data to support other app-specific scenarios for your organization.

## Considerations for using schema extensions

An app can own up to five schema extension definitions.

You can use up to 100 schema extensions per user.

Deleting a schema extension definition without setting the schema extension to `null` makes the property and its associated user data undiscoverable.

Deleting an owner app doesn't delete the associated schema extension definition or the property and the data it stores. The schema extension property can still be read, deleted, or updated for users. However, the schema extension definition can't be updated.