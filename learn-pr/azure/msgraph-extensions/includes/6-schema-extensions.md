You've learned to use two types of extensions to store custom values, query the data, and use the data to define rules for dynamic groups. In this unit, you learn how to use the third type of extension, *schema extension*.

## Schema extension definitions

Before you can use a schema extension, you must define it. The following are the core components of a schema extension definition.

### Extension ID

A schema extension ID is generated during the Create operation and can follow one of two naming conventions:

- If you have a vanity .com, .net, .gov, .edu, or .org domain that you've verified with your tenant, use the domain name along with the schema name to define a unique ID in the format *{domainName}_{schemaName}*. For example, if your vanity domain is "contoso.com," you can define `contoso_teamBondingApp` as the ID. This option is highly recommended and makes the schema extension property more discoverable.

- Alternatively, specify only the schema ID (for example, `teamBondingApp`) in your request body. Microsoft Graph transforms this ID and prefixes it in the format *ext{8-random-alphanumeric-chars}_{schema-name}*. An example of a new schema ID might be `extkvbmkofy_teamBondingApp`.

The new schema extension ID becomes the name of the schema extension property on the target objects.

### Extension owner

A schema extension must have an owner app. This owner app is referenced by the **owner** property that's assigned the value of the app's **appId**. If you're using Graph Explorer for the exercise unit, you must explicitly specify the **owner** property in the request body for the Create request.

### Target objects

You must explicitly specify Microsoft Graph resources that can be assigned the schema extension. For our scenario, specify the *user* resource.

### Extension properties

You can define the properties of the extension in a Create or Update operation. The return type can be `Binary`, `Boolean`, `DateTime`, `Integer`, or `String`. You can't update existing properties, but you can add more properties through Update operations.

### Extension status

A schema extension definition has a lifecycle that affects how the property can be used. This lifecycle is managed through the **status** property and can be one of the following states: 

- `InDevelopment` - Initial state after creation. For a multi-tenant owner app, the ability to manage the schema extension properties is limited in other tenants.
- `Available` - If the owner app is a multi-tenant app, the schema extension is available for use by all apps in any tenant.
- `Deprecated` - The schema extension definition can no longer be read or modified.

## Manage schema extension definitions

Schema extension definitions are created and managed through the *schemaExtension* resource type and its associated methods. The following is an example of a schema extension definition:

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

## Use schema extension properties

Schema extension properties are presented as complex types in user objects. These properties are available for use throughout their existence and even when the definition is deleted. You manage the schema extension properties on user profiles through the same HTTP methods that are used to manage users.

### Supported query capabilities

Both schema extension definitions and the properties support query capabilities.

Schema extension definitions support the `$select` and `$filter` (`eq` and `startsWith` operators) OData query parameters to customize the responses.

Schema extension properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters and you can also filter by extension attributes that are empty (`null`). In specific usage of `$filter`, you must include the `$count=true` query parameter in the HTTP request and set the *ConsistencyLevel* header to `eventual`.

## Other Azure AD scenarios for custom data

Schema extension properties and the data they store aren't supported by any additional Azure AD scenarios. However, you can use the extensions and their data to support other app-specific scenarios for your organization.