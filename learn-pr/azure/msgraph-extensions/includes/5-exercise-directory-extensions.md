In this exercise, you use [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the directory extension definitions and associated properties on the *user* resource. The commands in this exercise emulate the API calls that the team-bonding app makes on behalf of a signed-in user.

## Authenticate your session

1. Sign in to Graph Explorer by using a work or school account that has global administrator privileges in the tenant.

1. To perform the API operations in this exercise, consent to the *User.ReadWrite.All*, *Group.ReadWrite.All*, and *Application.ReadWrite.All* Microsoft Graph permissions.

In the team-bonding app, employees will sign in with their Azure AD profile and must consent to *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Identify the owner app

Retrieve the **id** and **appId** for an app that has a service principal in your tenant. You'll define the directory extension on this app.

The object shown here has been shortened for readability.

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
    "id": "da489504-01b0-4754-bf9d-8ed05422ba2f",
    "appId": "5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb",
    "displayName": "Contoso extensions app - DO NOT DELETE",
    "description": "Contoso extensions app. Reserved for directory extensions. DO NOT DELETE. Used by Contoso for storing user data.",
    "publisherDomain": "contoso.com",
    "signInAudience": "AzureADMyOrg",
    "tags": [
        "Directory extensions",
        "Extensions",
        "Extension attributes"
    ]
}
```

## Create a directory extension definition

In this step, you create directory extension definitions on the "Contoso extensions app."

### Request

The following request creates a directory extension definition named **linkedInProfile**. Run the request two more times, changing the extension name first to **skypeId** and then to **xboxGamertag**.

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/applications/da489504-01b0-4754-bf9d-8ed05422ba2f/extensionProperties
Content-type: application/json

{
    "name": "linkedInProfile",
    "dataType": "String",
    "targetObjects": [
        "User"
    ]
}
```

### Response

In the following response object, take note of the new extension name `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`.

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

Running the preceding request two more times with different names will give you other response objects. Assume that you're using the following names for the three directory extension definitions:
+ `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag`
+ `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId`
+ `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile`

## Store user data

In this step, you store the LinkedIn profile URL, Skype ID, and Xbox gamertag for *Adele Vance* of user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`, in the three new directory extension properties that you created.

### Request

```http
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a
Content-type: application/json

{
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId": "AdeleV",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele"
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose another employee wants to discover colleagues who have shared their Xbox and LinkedIn profiles. The app calls Microsoft Graph as follows:

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId,extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag&$filter=extension_5bfc8fdacfc943a9a6de214ea9d15fdb_linkedInProfile ne null or extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag ne null&$count=true
ConsistencyLevel: eventual
```

### Response

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

## Update and delete user data

Suppose Adele has crossed the 1,000,000 *gamerscore* mark and, to show off the milestone, has changed her Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the value in the internal profile as well. Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of **extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId** to `null`.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a
Content-type: application/json

{
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_skypeId": null
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Dynamically add users to groups based on their extension data

Assume that you created the dynamic *xBoxers* group in the preceding exercise. In this step, you update the group **membershipRule** setting to configure the rule so that only users with Xbox gamer tags can be members of the group.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/groups/d61efd38-0b40-488a-8e4d-ed7508504b27
Content-type: application/json

{
    "membershipRule": "(user.extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag -ne null)"
}
```

### Response

```http
HTTP/1.1 204 No Content
```

After a few seconds to allow Azure AD to complete synchronization, the users who match the dynamic membership rule, such as Adele, are added as members of the group.