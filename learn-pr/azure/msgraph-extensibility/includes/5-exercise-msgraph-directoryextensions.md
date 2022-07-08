Apart from extension attribute properties, Microsoft Graph also provides **directory extensions** for storing custom data. In the team bonding app scenario, you need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag. Employee profiles are represented in Azure AD, Microsoft 365, and Microsoft Graph as user profiles.

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and create directory extension definitions and manage the directory extensions on the **user** resource.

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->

## Authenticate your session

Sign in to Graph Explorer as an administrator with the following Azure AD roles: *User Administrator*, *Groups Administrator*, and *Application Administrator*.

Consent to the *User.ReadWrite.All*, *Group.ReadWrite.All*, and *Application.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permission to allow them to discover their colleagues and update their own profile information respectively.

## Create an application

Before you can use directory extensions, you must define them in an application.

In this step, you first create an application object that you'll reserve for creating directory extension definitions. This app will be your "owner app" for the directory extensions.

### Request
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

### Response
The following is a sample response. The response object has been shortened for readability to show only few properties.
```http
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

## Create directory extension definitions

Unlike the extension attribute properties in the previous unit, directory extensions can be defined and assigned custom names. In this step, you create directory extension definitions on the "Contoso extensions app" that's identified by the client object ID `da489504-01b0-4754-bf9d-8ed05422ba2f`.

Directory extension definitions are managed through the **extensionProperties** relationship on an application object and the associated **extensionProperty** resource type.

One directory extension definition represents only one directory extension property. To store all three values in the team bonding scenario, you must create three directory extension definitions, each with its unique name.

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

The following is the response object from the first request. Take note that while you specified `linkedInProfile` as the extension name in the request, Microsoft Graph transforms the extension name and adds a prefix. The new extension name is `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

```http
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

Microsoft Graph directory extensions are named following the naming convention: extension_{appId-without-hyphens}_{extensionProperty-name}. Where in your response, `{appId-without-hyphens}` is the stripped version of the **appId** for the "Contoso extensions app" application. In this case, the `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb` without the hyphens. This is one way in which directory extensions are closely linked to the creating app.

Running the previous request two more times with different names will give you other response objects where the ID and name property are different. Let's assume you're run the previous request two more times. To retrieve all directory extensions definitions for the app identified by ID `da489504-01b0-4754-bf9d-8ed05422ba2f`, run the following query:

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/applications/da489504-01b0-4754-bf9d-8ed05422ba2f/extensionProperties
```

### Response

The following response object shows the directory extension definitions you created.

```http
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

Now that you've defined the directory extensions, the directory extension properties to use on the user object are `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`, `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId`, and `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag`. We can use these properties to store the user's LinkedIn profile URL, Skype ID, and Xbox gamertag respectively.

## Assign directory extension properties to users

Assume we have a user named Adele Vance identified by the user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`. You'll store Adele's LinkedIn profile URL, Skype ID, and Xbox gamertag on the three new directory extension properties you created.

You store data in the directory extension properties by updating the user profile using an HTTP PATCH request. You'll store Adele's public LinkedIn profile URL, Skype ID, and Xbox gamertag in `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`, `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId`, and `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag` respectively.

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
If the update is successful, Microsoft Graph returns a `204 No Content` response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```