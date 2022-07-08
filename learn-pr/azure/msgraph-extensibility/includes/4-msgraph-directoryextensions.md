Microsoft Graph provides four types of extensions for adding custom properties to users and storing custom data. The second type of extensions is the **directory extensions**, also called **Azure AD** extensions.

In the team bonding app scenario, we want to store user-specific data about their public LinkedIn profile URL, Skype ID, and Xbox gamertag.

Here, you'll learn how to use the directory extensions to store the three pieces of user data about the employees.

## Directory (Azure AD) extensions

The Microsoft Graph directory extensions are only available for use by specific resources in Azure Active Directory (Azure AD) including the **user** and **group** resources.

Directory extensions are closely tied to the application that creates them. To use directory extensions:
1. First create the directory extension definition in an app and explicitly define the resource types that can be assigned the directory extensions. You *can't* update the directory extension definition later.
    1. The name of the directory extension becomes the directory extension property name.
1. Manage the directory extension property and its associated values on instances of the target resource objects.
1. During the lifecycle of their use, maintain the [Considerations for using directory extensions](#considerations-for-using-directory-extensions).

### Directory extension definitions

A directory extension definition is a simple structure of the directory extension. The definition includes the name and return type and also explicitly allowlists the Azure AD resource types that be assigned the directory extensions. To allow directory extensions to be used to store the three custom data, you must specify the user resource as a target object.

After the directory extension definition has been created, it's immediately available for use.

Directory extension definitions can't be updated to avoid breaking changes when the extensions are in use. However, they can be deleted.

### Use directory extensions

After you're defined the directory extension, it's now available for use in user profiles.

You manage the directory extension properties on user profiles through the same HTTP methods used to manage users.
+ Using a POST request, you can store data in the directory extension property when creating a new user
+ Using a PATCH request, you can either store data in the directory extension property, update the stored data, or delete the existing data
+ Using a GET request, you can read the directory extension properties for all users or individual users in the tenant

#### Query capabilities supported by directory extension properties

Directory extension properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` operator.

### Considerations for using directory extensions

<!--TO-DO

Qs:

+ Does deleting an app also delete it's directory extensions data?
+ Does restoring an app also restore the directory extensions properties and associated data on the resource instances?
+ Can you protect an app that defines directory extensions from accidental deletion?  Restrict management of the app for example?
-->