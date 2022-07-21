In the team bonding app scenario, you need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag.

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the open extensions on the **user** resource. The commands in this exercise emulate the API calls that the team bonding app makes on behalf of a signed-in user.

## Authenticate your session

Sign in to Graph Explorer using a work or school account that has global administrator privileges in the tenant.

Consent to the *User.ReadWrite.All* Microsoft Graph permission to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Create and store data in an open extension object

In this step, you'll create an open extension with the following properties:
+ The identifier is `socialSettings`
+ You'll create the open extension and store data in the open extension properties at the same time.

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

## Update and delete user data in an open extension attribute

Suppose Adele has crossed the 1,000,000 gamerscore mark and to show off the milestone, has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in the app profile so colleagues can discover the new gamertag.

Adele also no longer uses the Skype app and now uses Teams instead. Adele wants to remove the Skype ID from the user profile. When Adele initiates the update from the team bonding app's user interface, the app will call Microsoft Graph and set the value of the **skypeId** property to `null`.

When Adele initiates the update from the team bonding app's user interface, the app will call Microsoft Graph and can perform one of the following operations:
    + Update the **xboxGamertag**, **linkedInProfile**, and **skypeId** to `null` but keep the open extension object
    + Update the **socialSettings** object to `null` and delete the open extension object

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

If the update is successful, Microsoft Graph returns a `204 No Content` HTTP response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

### Other Azure AD scenarios for custom data in directory extension properties

Open extensions and the data they store aren't supported by any other Azure AD scenarios. However, you can use the extensions and their data to support other custom app-specific scenarios for your organization.

## Conclusion

You have used Microsoft Graph open extension properties to store three custom values. You've seen how to retrieve, update or remove any values from the open extension properties.

For each type of operation, you should implement the appropriate logic in the team bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.
