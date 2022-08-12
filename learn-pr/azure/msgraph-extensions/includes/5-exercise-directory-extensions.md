In this exercise, you'll use a client app such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the directory extension definitions and associated properties on the *user* resource. The commands in this exercise emulate the API calls that the team-bonding app makes on behalf of a signed-in user.

## Authenticate your session

Sign in to Graph Explorer by using a work or school account that has global administrator privileges in the tenant.

Consent to the *User.ReadWrite.All*, *Group.ReadWrite.All*, and *Application.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team-bonding app, employees will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Identify the owner app

Retrieve the values of **id** and **appId** of the app you own and that has a service principal in the tenant. You'll use these values in this exercise. Assume that the following object represents your application.

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

The following request creates a directory extension definition named **linkedInProfile**. Run the request two more times, changing the name first to **skypeId** and then to **xboxGamertag**.

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

Consider a user named "Adele Vance," who's identified by the user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`. In this step, you store Adele Vance's LinkedIn profile URL, Skype ID, and Xbox gamertag on the three new directory extension properties that you created.

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

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose that another employee wants to discover colleagues who have shared their Xbox and LinkedIn profiles. The app calls Microsoft Graph as follows:

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

Suppose further that user Adele has crossed the 1,000,000 *gamerscore* mark and, to show off the milestone, she has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the value in the internal profile as well, so that colleagues can discover her new gamertag.

Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of `extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag` to `null`.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": "AwesomeAdele",
    "extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag": null
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Dynamically add users to groups based on their extension data

Assume that you created the dynamic *xBoxers* group in the preceding exercise. In this exercise, you update the group **membershipRule** setting to configure the rule so that only users with Xbox gamer tags can be members of the group.

Because Adele is already a member of the *xBoxers* group, you can choose to reset the group and remove all memberships. To achieve this, do the following:

1. Update **groupTypes** to `Unified` only, and update **membershipRuleProcessingState** and **membershipRule** to `null`.
1. Remove the current group members from the *xBoxers* group.

You can alternatively choose to create a new dynamic group for this part of the exercise.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/groups/d61efd38-0b40-488a-8e4d-ed7508504b27

{
    "membershipRule": "(user.extension_5bfc8fdacfc943a9a6de214ea9d15fdb_xboxGamertag -ne null)"
}
```

### Response

```http
HTTP/1.1 204 No Content
```

After a few seconds to allow Azure AD to complete synchronization, the users who match the dynamic membership rule, such as Adele, are added as members of the group.

## Conclusion

In this unit, you used Microsoft Graph directory extension properties to store three custom values. You've seen how to:
+ Retrieve those values or remove any values from the properties.
+ Implement a custom search so that employees in the company can discover each other's external social profiles.
+ Use the directory extension values for dynamic group memberships.

After this exercise is complete, Adele's profile has only the LinkedIn profile URL and Xbox gamer tag, which can be discovered by other users through the team-bonding app. These users may decide to share all three pieces of data or none. For each type of operation, you should implement the appropriate logic in the team-bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.