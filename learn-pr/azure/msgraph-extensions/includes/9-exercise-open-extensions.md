In this exercise, you use [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the open extensions on the *user* resource. The commands in this exercise emulate the API calls that the team-bonding app makes on behalf of a signed-in user.

## Authenticate your session

1. Sign in to Graph Explorer by using a work or school account that has global administrator privileges in the tenant.

1. To perform the API operations in this exercise, consent to the *User.ReadWrite.All* Microsoft Graph permission.

In the team-bonding app, employees will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. When they grant this consent, the employees can discover their colleagues and update their own profile information.

## Create and store data

In this step, you create an open extension called *socialSettings* with three properties and simultaneously store data in the properties.

### Request

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a/extensions
Content-type: application/json

{
    "@odata.type": "#microsoft.graph.openTypeExtension",
    "id": "socialSettings",
    "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
    "skypeId": "AdeleV",
    "xboxGamertag": "AwesomeAdele"
}
```

### Response

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users('6e03a2db-564a-47ec-ba51-d0cd38af069a')/extensions/$entity",
    "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
    "skypeId": "AdeleV",
    "xboxGamertag": "AwesomeAdele",
    "id": "socialSettings"
}
```

## Update and delete user data

Suppose Adele has crossed the 1,000,000 *gamerscore* mark and, to show off the milestone, has changed her Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the value in the internal profile as well. 

Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of the **skypeId** property to `null`.

To update any property in the open extension object, you must specify *all* properties in the request body; otherwise, Microsoft Graph will delete the unspecified properties.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a/extensions/socialSettings
Content-type: application/json

{
    "@odata.type": "#microsoft.graph.openTypeExtension",
    "id": "socialSettings",
    "linkedInProfile": "www.linkedin.com/in/adelevanceonlinkedIn",
    "skypeId": null,
    "xboxGamertag": "AtalantaAdele"
}
```

### Response

```http
HTTP/1.1 204 No Content
```

### Other Azure AD scenarios for custom data

Open extensions and the data that the extensions store aren't supported by any other Azure AD scenarios. However, you can use the extensions and their data to support other custom app-specific scenarios for your organization.