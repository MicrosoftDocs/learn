The fourth type of extensibility option available for storing custom data in Microsoft Graph is **open extensions**.

In the team bonding app scenario, you want to store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag in their user profiles.

Here, you'll learn how to use the open extensions to store the three pieces of user data about the employees.

## Open extensions

The Microsoft Graph open extensions are only available for use by specific resources in Microsoft Graph including the **user** resource.

Unlike schema and directory extensions, open extensions aren't tied to any application as an "owner app". Instead, each resource instance can have its own open extension definition.

During their use, maintain the [Considerations for using open extensions](#considerations-for-using-open-extensions).

### Open extension definitions

Open extension definitions are created and managed on-the-fly against resource instances. There's no need to apply a universally consistent pattern for all resource instance. For example, a user object that references Adele can define an open extension with three properties while another user object that references Bruno can define no open extension.

Open extension definitions and their associated data are created and managed through the **extensions** relationship of the target resource. You can read the open extensions in one of the following two ways:

```http
GET https://graph.microsoft.com/v1.0/users/{id}/extensions

GET https://graph.microsoft.com/v1.0/users/{id}?$expand=extensions
```

You manage open extensions on resource instances as follows:
+ Using a POST request, you can store data in the open extension for an existing user
+ Using a PATCH request, you can either store data in the open extension property, update the stored data, or delete the existing data
    + To delete data from a property in the open extension object, set its value to `null`
    + To delete data from *all* properties in the open extension object and effectively the open extension definition, set its value to `null`

### Use open extensions

open extension properties are presented as complex types on the target resource instance. Throughout their existence and even when the definition is deleted, the open extension properties are available for use on the target resource instances.

You manage the open extension properties on user profiles through the same HTTP methods used to manage users.
+ Using a POST request, you can store data in the open extension property when creating a new user
+ Using a PATCH request, you can either store data in the open extension property, update the stored data, or delete the existing data
    + To delete data from a property in the open extension object, set its value to `null`
    + To delete data from *all* properties in the open extension object, set its value to `null`
    + To update any property in the open extension object, you must specify all properties in the request body; otherwise, Microsoft Graph will update the unspecified properties to `null`. Therefore, while you may want to update only the **xboxGamertag**, you must also specify both the **linkedInProfile** and **skypeId**  so that their values aren't deleted.
+ Using a GET request, you can read the open extension properties for all users or individual users in the tenant

#### Query capabilities supported by open extension properties

In the Microsoft Graph `v1.0` endpoint, the open extension properties aren't returned by default and you must therefore use the `$select` query parameter to read the properties.

open extension properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` and `ne` operators. You can also filter the results to return only users whose specific extension attributes are empty (`null`). Filtering using the `ne` operator or on `null` values is a specially indexed query capability that works only when you include the `$count=true` query parameter and add the **ConsistencyLevel** header set to `eventual`.

open extension properties are specially indexed in Microsoft Graph for advanced querying.

### Considerations for using open extensions

Deleting a open extension definition does not affect accessing custom data that has been added to resource instances based on that definition.

<!--To validate

Qs:

+ Can the open extension owner app be deleted while the definition still exists? If yes, what happens to the ownership requirement?

-->