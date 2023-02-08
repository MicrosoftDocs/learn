You've learned to use extension attributes to store custom values, query the data, and use the data to define rules for dynamic groups. Here, you learn to use the second type of extension, *directory extension*.

## Directory extension definitions

Before you can use directory extensions, you must define them in an application that becomes the directory extension *owner app*.

A directory extension definition must explicitly specify the Microsoft Graph resources that can be assigned the directory extension. For our scenario, you'll specify the *user* resource.

Directory extension definitions are managed through the *extensionProperties* relationship on an application object and the associated *extensionProperty* resource type, and can be read using one of the following syntaxes.

```http
GET https://graph.microsoft.com/v1.0/applications/{applicationId}/extensionProperties

GET https://graph.microsoft.com/v1.0/applications/{applicationId}?$expand=extensionProperties
```

When you create a directory extension definition, Microsoft Graph transforms the extension name you provided by adding a prefix to create a new extension name. This name becomes the name of the directory extension property on the target objects.

The directory extension properties are named following the naming convention *extension_{appId-without-hyphens}_{extensionProperty-name}*, where `{appId-without-hyphens}` is the stripped version of the owner app's *appId*, which contains only letters (`a`-`z`) and numbers (`0`-`9`).

For example, when you specify `linkedInProfile` as an extension name in the request body, and your app's appId is `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb`, the new extension name can be `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`. This is one way that directory extensions are closely linked to the owner app.

A directory extension definition maps to *only* one directory extension property with a primitive return type. To store the three pieces of data, you therefore create three directory extension definitions.

After you create the directory extension definition, it's available for use after a tenant admin grants consent for the app to be used in the tenant, and a service principal is created. When you create more directory extensions, these extensions are immediately available in the tenant where the app is homed. If the owner app is a multi-tenant app, the directory extensions will also be available for use in other tenants where the app has been consented to.

## Use directory extension properties

After you define the directory extension, it's available for use on user profiles. You manage the directory extension properties for users through the same HTTP methods that you use to manage users.

### Supported query capabilities

Directory extension definitions support the `$select` and `$filter` (`eq` operator) OData query parameters to customize the responses.

Directory extension properties support both the `$select` and `$filter` (`eq` and `ne` operators) OData query parameters and you can also filter by extension attributes that are empty (`null`). In specific usage of `$filter`, you must include the `$count=true` query parameter in the HTTP request and set the *ConsistencyLevel* header to `eventual`.

## Other Azure AD scenarios for the custom data

Similar to extension attributes in the previous unit, Azure AD also supports the following other use cases for directory extension properties:

- Use extensions data as rules for dynamic groups memberships.
- Use extensions data to customize claims.