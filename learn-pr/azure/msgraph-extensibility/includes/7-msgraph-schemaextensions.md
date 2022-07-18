The third type of extensibility option available for storing custom data in Microsoft Graph is **schema extensions**.

In the team bonding app scenario, you want to store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag in their user profiles.

Here, you'll learn how to use schema extensions to store the three pieces of user data about the employees.

## Schema extensions

The Microsoft Graph schema extensions are only available for use by specific resources in Microsoft Graph including the **user** resource.

Just like schema extensions, schema extensions are also closely tied to the application that creates them. To use schema extensions:
1. First create the schema extension definition. The app that creates the definition becomes the "owner app" for the schema extension. You must also explicitly define the resource types that can be assigned the schema extension.
1. Manage the schema extension property and its associated values on instances of the target resource objects.
1. During the lifecycle of their use, maintain the [Considerations for using schema extensions](#considerations-for-using-schema-extensions).

### schema extension definitions

Before you can use schema extension, you must define them. The following are the core components of a schema extension definition.

#### Extension id

You must provide a schema extension ID during the Create operation. Use one of the following two methods to define the schema extension ID.

+ If you already have a vanity `.com`,`.net`, `.gov`, `.edu` or a `.org` domain that you've verified with your tenant, you can use the domain name along with the schema name to define a unique name in the format *{domainName}_{schemaName}*. For example, if your vanity domain is "contoso.com", you can define `contoso_teamBondingApp` as the ID. This option is highly recommended and makes the schema extension property more discoverable.
+ If you don't have a verified vanity domain, you can specify only the schema name, for example, `teamBondingApp`, as the ID. Microsoft Graph will tranform this ID and prefix it with an eight-character alphanumeric value in this format: *ext{8-random-alphanumeric-chars}_{schema-name}*. For example, the new schema name may be `extkvbmkofy_teamBondingApp`.

The new schema extension ID becomes the name of schema extension property on the target objects.

#### Extension owner

A schema extension must have an owner app. This is the app that creates the schema extension definition and is defined in the **owner** property of the definition.

The **owner** property of the schema definition must either be explicitly specified during the Create request or it'll be implied and auto-assigned by Azure AD as follows:
1. In delegated access:
    1. The signed-in user must be the owner of the app that calls Microsoft Graph to create the schema extension definition
    1. If the signed-in user isn't the owner of the calling app, they must explicitly specify the **owner** property and assign it the **appId** of an app that they own.
1. In app-only access: <!-- Dan to confirm -->

You cannot change ownership of the schema extension.

If you're using Graph Explorer for the exercise unit, you must therefore explicitly specify the **owner** property in the request body for the Create request.

#### Target objects

You must explicitly allow list the Microsoft Graph resource types that be assigned the schema extensions. To allow schema extensions to be used to store the three custom data on the user profile, you must specify the **user** resource as a target object.

#### Extension properties

The definition includes the properties that make up the schema extension. Each property must have a defined return type which can be one of the following primitive types: `Binary`, `Boolean`, `DateTime`, `Integer` or `String`. You can't update existing properties but can add more properties through Update operations.

In the team bonding app scenario, you'll define three properties of String types to store the users' LinkedIn profile URL, Skype ID, and Xbox gamertag.

#### Extension status

A schema extension definition has a lifecycle that affects the use of the associated schema extension property. This lifecycle is managed through the **status** property of the definition and can be one of the following states: `InDevelopment`, `Available`, `Deprecated`.

|State |Lifecycle state behavior |
|:-------------|:------------|
| InDevelopment | <ul><li>Initial state after creation. The owner app is still developing the schema extension. </li><li>In this state, any app in the same directory where the owner app is registered can extend resource instances with this schema definition (if the app has permissions to that resource). </li><li>For an owner app that's multi-tenant, only the instance of the owner app that's in a different directory from the home directory can extend resource instances with this schema definition (if the app has permissions to that resource), or read the extension data. </li><li>Only the owner app can update the extension definition with additive changes. </li><li>Only the owner app can delete the extension definition. </li><li>The owner app can move the extension from **InDevelopment** to the **Available** state.</li></ul> |
| Available | <ul><li>The schema extension is available for use by all apps in any tenant. </li><li>After the owner app sets the extension to **Available**, any app can simply add custom data to instances of those resource types specified in the extension (if the app has permissions to that resource). The app can assign custom data when creating a new instance or updating an existing instance. </li><li>Only the owner app can update the extension definition with additive changes. No app can delete the extension definition in this state. </li><li>The owner app can move the schema extension from **Available** to the **Deprecated** state.</li></ul> |
| Deprecated | <ul><li>The schema extension definition can no longer be read or modified. </li><li>No app can view, update, add new properties, or delete the extension. </li><li>Apps can, however, still read, update, or delete existing extension _property values_. </li></ul> |

### Manage schema extension definitions

schema extension definitions are created and managed through the **schemaExtension** resource type and its associated methods. The following is an example of a schema extension definition:

```http
{
    "id": "extroow2sik_teamBondingApp",
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

### Schema extensions and multi-tenant apps

Because schema extensions are closely tied to an owner app, they are also available for use by other tenants where the app has been consented to. For more information about schema extensions owned by multi-tenant apps, see the [Schema extension status](#extension-status).

### Use schema extensions

Schema extension properties are presented as complex types on the target resource instance. Throughout their existence and even when the definition is deleted, the schema extension properties are available for use on the target resource instances.

You manage the schema extension properties on user profiles through the same HTTP methods used to manage users.
+ Using a POST request, you can store data in the schema extension property when creating a new user
+ Using a PATCH request, you can either store data in the schema extension property, update the stored data, or delete the existing data
    + To delete data from a property in the schema extension object, set its value to `null`
    + To delete data from *all* properties in the schema extension object, set its value to `null`
    + To update any property in the schema extension object, you must specify all properties in the request body; otherwise, Microsoft Graph will update the unspecified properties to `null`. Therefore, while you may want to update only the **xboxGamertag**, you must also specify both the **linkedInProfile** and **skypeId**  so that their values aren't deleted.
+ Using a GET request, you can read the schema extension properties for all users or individual users in the tenant

#### Query capabilities supported by schema extensions

Schema extensions support querying at two levels: Matching against the schema extension definitions and matching against the schema extension properties.

##### Query capabilities supported by schema extension definitions

Schema extension properties support both `$filter` OData query parameter with the `eq` operator for matching against the **id**, **owner**, and **status** properties.

##### Query capabilities supported by schema extension properties

In the Microsoft Graph `v1.0` endpoint, the schema extension properties aren't returned by default and you must therefore use the `$select` query parameter to read the properties.

Schema extension properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` and `ne` operators. You can also filter the results to return only users whose specific extension attributes are empty (`null`). Filtering using the `ne` operator or on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the **ConsistencyLevel** header set to `eventual`.

Schema extension properties are specially indexed in Microsoft Graph for advanced querying.

### Considerations for using schema extensions

Deleting a schema extension definition deletes the associated schema extension property and the data it stores.

<!-- This statement below leaves a schema extension that references a non-existent owner??-->
Deleting an owner app does not delete the associated schema extension definition or the schema extension property and the data it stores. The schema extension property can still be read from the resource instances. However, the values that the schema extension object stores cannot be updated.