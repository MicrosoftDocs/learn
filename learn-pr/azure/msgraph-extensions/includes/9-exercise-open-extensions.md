In this exercise, you use a client app such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the open extensions on the *user* resource. The commands in this exercise emulate the API calls that the team-bonding app makes on behalf of a signed-in user.

## Authenticate your session

Sign in to Graph Explorer by using a work or school account that has global administrator privileges in the tenant.

To perform the API operations in this exercise, consent to the *User.ReadWrite.All* Microsoft Graph permission.

In the team-bonding app, employees will sign in with their Azure Active Directory (Azure AD) profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. When they grant this consent, the employees can discover their colleagues and update their own profile information.

## Create and store data

In this step, you create an open extension called *socialSettings* with three properties and simultaneously store data in the properties.

### Request

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a/extensions

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

Suppose user "Adele" has crossed the 1,000,000 *gamerscore* mark and, to show off the milestone, she has changed her Xbox *gamertag* from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in her app profile so that her colleagues can discover it.

Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of **skypeId** to `null`.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a/extensions/socialSettings

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

## Conclusion

You've used Microsoft Graph open extension properties to store three custom values. You've seen how to retrieve, update, or remove any values from the open extension properties.

For each type of operation, you should implement the appropriate logic in the team-bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.
