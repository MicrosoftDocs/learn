In this exercise, you'll use a client app such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the schema extension definitions and associated properties on the **user** resource. The commands in this exercise emulate the API calls that the team bonding app makes on behalf of a signed-in user.

## Prerequisites

Be an owner of an application and record its **appId**. This app will be the owner of the schema extension definition.

## Authenticate your session

Sign in to Graph Explorer using a work or school account that has global administrator privileges in the tenant.

Consent to the *User.ReadWrite.All* and *Application.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite.All* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Create schema extension definitions

The request in this section specifies the **owner** property. If you're using Graph Explorer, you must specify in the **owner** property an **appId** for an app that you own. In this example, you own the app that's identified by **appId** `5bfc8fda-cfc9-43a9-a6de-214ea9d15fdb`. If you're running this exercise while signed-in from an app that you own, you don't need to specify the **owner** property.

### Request

```msgraph-interactive
POST ttps://graph.microsoft.com/v1.0/schemaExtensions

{
    "id": "contoso_teamBondingApp",
    "description": "Extensions for custom properties used by the team bonding app",
    "targetTypes": [
        "user"
    ],
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

### Response

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#schemaExtensions/$entity",
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

## Store user data

In this step, you'll store the LinkedIn profile URL, Skype ID, and Xbox gamertag in the three new properties of the `contoso_teamBondingApp` extension for a user Adele identified by ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`.

### Request
```http
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "contoso_teamBondingApp": {
        "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
        "skypeId": "AdeleV",
        "xboxGamertag": "AwesomeAdele"
    }
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose another employee wants to discover their colleagues who have shared their Xbox and LinkedIn profiles. The app calls Microsoft Graph as follows.

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,contoso_teamBondingApp&$filter=contoso_teamBondingApp/xboxGamertag ne null or contoso_teamBondingApp/linkedInProfile ne null&$count=true
ConsistencyLevel: eventual
```

### Response

The following response object shows the sample response payload that Microsoft Graph returns to the app.

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,contoso_teamBondingApp)",
    "@odata.count": 1,
    "value": [
        {
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "displayName": "Adele Vance",
            "contoso_teamBondingApp": {
                "@odata.type": "#microsoft.graph.ComplexExtensionValue",
                "xboxGamertag": "AwesomeAdele",
                "skypeId": "AdeleV",
                "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn"
            }
        }
    ]
}
```

## Update and delete user data

Suppose Adele has crossed the 1,000,000 *gamerscore* mark and to show off the milestone, has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in the app profile so colleagues can discover the new *gamertag*.

Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of **skypeId** to `null`.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "contoso_teamBondingApp": {
        "xboxGamertag": "AtalantaAdele",
        "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
        "skypeId": null
    }
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Conclusion

You have used Microsoft Graph schema extension properties to store three custom values. You've seen how to:
+ Retrieve those values or remove any values from the properties.
+ Implement a custom search so employees in the company can discover each other's external social profiles.

After this exercise, Adele's social profiles are undiscoverable through the team bonding app. Other users may decide to share all three pieces of data or none. For each type of operation, you should implement the appropriate logic in the team bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.