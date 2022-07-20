In the team bonding app scenario, you need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag.

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the directory extension definitions and associated properties on the **user** resource. The commands in this exercise emulate the API calls that the team bonding app would make on behalf of a signed-in user.

## Authenticate your session

Sign in to Graph Explorer as an administrator with the following Azure AD roles: *User Administrator*, *Groups Administrator*, and *Application Administrator*.

Consent to the *User.ReadWrite.All*, *Group.ReadWrite.All*, and *Application.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Create an application and a service principal

Before you can use directory extensions, you must define them in an application.

### Create an application

In this step, you first create an application object that you'll reserve for creating directory extension definitions. This app will be your "owner app" for the directory extensions.

#### Request
```msgraph-interactive
POST https://graph.microsoft.com/v1.0/applications

{
    "displayName": "Contoso extensions app - DO NOT DELETE",
    "description": "Contoso extensions app. Reserved for directory extensions. DO NOT DELETE. Used by Contoso for storing user data.",
    "signInAudience": "AzureADMyOrg",
    "tags": [
        "Directory extensions",
        "Extensions",
        "Extension attributes"
    ]
}
```

#### Response
>**Note:** The response object shown here has been shortened for readability.
```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
    "id": "da489504-01b0-4754-bf9d-8ed05422ba2f",
    "appId": "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb",
    "createdDateTime": "2022-07-08T19:00:40.0659684Z",
    "displayName": "Contoso extensions app - DO NOT DELETE",
    "description": "Contoso extensions app. Reserved for directory extensions. DO NOT DELETE. Used by Contoso for storing user data.",
    "groupMembershipClaims": null,
    "publisherDomain": "M365EDU334089.onmicrosoft.com",
    "signInAudience": "AzureADMyOrg",
    "tags": [
        "Directory extensions",
        "Extensions",
        "Extension attributes"
    ],
    "optionalClaims": null
}
```

### Create a service principal

In this step, you'll instantiate the "Contoso extensions app" in your tenant.

#### Request

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/servicePrincipals

{
    "appId": "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb"
}
```

#### Response
>**Note:** The response object shown here has been shortened for readability.
```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity",
    "id": "5f214ccd-3f74-41d7-b683-9a6d845eea4d",
    "accountEnabled": true,
    "appDisplayName": "Contoso extensions app - DO NOT DELETE",
    "appDescription": "Contoso extensions app. Reserved for directory extensions. DO NOT DELETE. Used by Contoso for storing user data.",
    "appId": "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb",
    "appOwnerOrganizationId": "f0820ba7-ce6a-4a46-9787-e0b7ed727b30",
    "displayName": "Contoso extensions app - DO NOT DELETE",
    "servicePrincipalNames": [
        "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb"
    ],
    "servicePrincipalType": "Application",
    "signInAudience": "AzureADMyOrg",
    "tags": [
        "Extension attributes",
        "Extensions",
        "Directory extensions"
    ]
}
```

## Create directory extension definitions

In this step, you create directory extension definitions on the "Contoso extensions app".

### Request

The following request creates a directory extension definition named **linkedInProfile**. Run the request below two more times, changing the name to **skypeId** and **xboxGamertag** respectively in subsequent times.

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/applications/da489504-01b0-4754-bf9d-8ed05422ba2f/extensionProperties

{
    "name": "linkedInProfile",
    "dataType": "String",
    "targetObjects": [
        "User"
    ]
}
```

### Response

The following is the response object from the first request. Take note of the new extension name `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('da489504-01b0-4754-bf9d-8ed05422ba2f')/extensionProperties/$entity",
    "id": "554c66df-27ad-4852-9f37-5167f19b3e54",
    "deletedDateTime": null,
    "appDisplayName": "Contoso extensions app - DO NOT DELETE",
    "dataType": "String",
    "isSyncedFromOnPremises": false,
    "name": "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile",
    "targetObjects": [
        "User"
    ]
}
```

Running the previous request two more times with different names will give you other response objects. After creating all three definitions, retrieve the directory extensions definitions for the app by running the following query:

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/applications/da489504-01b0-4754-bf9d-8ed05422ba2f/extensionProperties
```

### Response

The following response object shows the directory extension definitions you created.

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('da489504-01b0-4754-bf9d-8ed05422ba2f')/extensionProperties",
    "value": [
        {
            "id": "fa65a07a-2d48-4218-b102-6435455156c8",
            "deletedDateTime": null,
            "appDisplayName": "",
            "dataType": "String",
            "isSyncedFromOnPremises": false,
            "name": "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag",
            "targetObjects": [
                "User"
            ]
        },
        {
            "id": "693b8410-fb9e-41bf-ac74-3e5ac2852808",
            "deletedDateTime": null,
            "appDisplayName": "",
            "dataType": "String",
            "isSyncedFromOnPremises": false,
            "name": "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId",
            "targetObjects": [
                "User"
            ]
        },
        {
            "id": "554c66df-27ad-4852-9f37-5167f19b3e54",
            "deletedDateTime": null,
            "appDisplayName": "",
            "dataType": "String",
            "isSyncedFromOnPremises": false,
            "name": "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile",
            "targetObjects": [
                "User"
            ]
        }
    ]
}
```

From the response object, the directory extension properties to use on the user object are `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`, `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId`, and `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag`. You'll use these properties to store the user's LinkedIn profile URL, Skype ID, and Xbox gamertag respectively.

You can also retrieve all directory extensions across all apps (including multi-tenant apps) in the tenant using the following query:

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/directoryObjects/getAvailableExtensionProperties

{
  "isSyncedFromOnPremises": false
}
```

## Store user data in directory extension properties

Consider a user named Adele Vance identified by the user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`. In this step, you'll store Adele's LinkedIn profile URL, Skype ID, and Xbox gamertag on the three new directory extension properties that you created.

In the team bonding app, Adele can use a user interface to update the three properties. The app will then call Microsoft Graph as follows:

### Request
```http
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId": "AdeleV",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele"
}
```

### Response
If the update is successful, Microsoft Graph returns a `204 No Content` HTTP response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose another employee wants to discover their colleagues who have shared their Xbox and LinkedIn profiles. This capability can be achieved through a search bar and a drop-down filter in the team bonding app to allow anyone to perform a quick discovery.

### Request

When the employee uses the user interface to find colleagues who have shared their Xbox gamertag or LinkedIn profiles, the app will call Microsoft Graph as follows:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag&$filter=extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile ne null or extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag ne null&$count=true
ConsistencyLevel: eventual
```

### Response

The request will return all users who have shared their LinkedIn profile or their Xbox gamertag, including Adele, as follows:

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag)",
    "@odata.count": 1,
    "value": [
        {
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "displayName": "Adele Vance",
            "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele",
            "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId": "AdeleV",
            "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn"
        }
    ]
}
```

## Update and delete user data in a directory extension property

Suppose Adele has crossed the 1,000,000 gamerscore mark and to show off the milestone, has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in the app profile so colleagues can discover the new gamertag.

Adele also no longer uses the Skype app and now uses Teams instead. Adele wants to remove the Skype ID from the user profile. When Adele initiates the update from the team bonding app's user interface, the app will call Microsoft Graph and set the value of the **extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag** property to `null`.

The app will update Adele's profile by calling Microsoft Graph as follows.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": null
}
```

### Response

If the update is successful, Microsoft Graph returns a `204 No Content` HTTP response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

## Dynamically add users to internal groups based on their user profile data

Assuming you created the dynamic "Xbox gamers" group in the previous exercise. In this exercise, you update the group **membershipRule** setting to configure the rule that only users with Xbox gamer tags can be members of the group.

> [!NOTE]
> Because Adele is already a member of the Xboxers gamers group due to the previous exercise, you can choose to reset the group and remove all memberships. To achieve this:
> 1. Update the **groupTypes** to `Unified` only, and the **membershipRuleProcessingState** and **membershipRule** to `null`.
> 1. Remove the current group members from the Xboxers group.
> 
> You can alternatively choose to create a new dynamic group for this part of the exercise.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/groups/d61efd38-0b40-488a-8e4d-ed7508504b27

{
    "membershipRule": "(user.extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag -ne null)"
}
```


### Response

If the update is successful, Microsoft Graph returns a `204 No Content` response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

After a few seconds to allow Azure AD to complete synchronization, the users who match the dynamic membership rule, such as Adele, are added as members of the group.


## Conclusion

You have used Microsoft Graph directory extension properties to store three custom values. You've seen how to:
+ Retrieve those values or remove any values from the properties.
+ Implement a custom search so employees in the company can discover each other's external social profiles.
+ Use the directory extension values for dynamic group memberships

After this exercise, Adele's profile has only the LinkedIn profile URL and Xbox gamer tag that can be discovered through the team bonding app. Other users may decide to share all three pieces of data or none. For each type of operation, you should implement the appropriate logic in the team bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.