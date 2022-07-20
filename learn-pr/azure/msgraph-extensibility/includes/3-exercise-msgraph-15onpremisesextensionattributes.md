In the team bonding app scenario, you need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag.

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the extension attribute properties on the **user** resource. The commands in this exercise emulate the API calls that the team bonding app would make on behalf of a signed-in user.

## Authenticate your session

Sign in to Graph Explorer as an administrator with both the *User Administrator* and *Groups Administrator* Azure AD role.

Consent to the *User.ReadWrite.All* and *Group.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions to allow them to discover their colleagues and update their own profile information.

## Define the extension attributes

Because the extension attributes are predefined, we can only manage them. Run the following request to read them and identify the attributes that already store data.

### Request
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
```

### Response
The following is a sample response. The response object has been shortened for readability to show only one user object.

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,userPrincipalName,onPremisesExtensionAttributes)",
    "value": [
        {
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "displayName": "Adele Vance",
            "userPrincipalName": "AdeleV@M365EDU334089.OnMicrosoft.com",
            "onPremisesExtensionAttributes": {
                "extensionAttribute1": null,
                "extensionAttribute2": null,
                "extensionAttribute3": null,
                "extensionAttribute4": null,
                "extensionAttribute5": null,
                "extensionAttribute6": null,
                "extensionAttribute7": null,
                "extensionAttribute8": null,
                "extensionAttribute9": null,
                "extensionAttribute10": null,
                "extensionAttribute11": null,
                "extensionAttribute12": null,
                "extensionAttribute13": null,
                "extensionAttribute14": null,
                "extensionAttribute15": null
            }
        }
    ]
}
```

## Store user data in extension attributes

In this exercise, you'll store these pieces of data for **Adele Vance**.

### Request

In the team bonding app, Adele can use a user interface to update the three properties. The app will then call Microsoft Graph as follows:

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute13": "www.linkedin.com/in/adelevanceonlinkedIn",
        "extensionAttribute14": "AdeleV",
        "extensionAttribute15": "AwesomeAdele"
    }
}
```

### Response

If the update is successful, Microsoft Graph returns a `204 No Content` response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose another employee wants to discover their colleagues who have shared their Xbox and LinkedIn profiles. This capability can be achieved through a search bar and a drop-down filter in the team bonding app to allow anyone to perform a quick discovery.

### Request

When the employee uses the user interface to find colleagues who have shared their Xbox gamertag or LinkedIn profiles, the app will call Microsoft Graph as follows:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$filter=onPremisesExtensionAttributes/extensionAttribute13 ne null or onPremisesExtensionAttributes/extensionAttribute15 ne null&$count=true&$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
ConsistencyLevel: eventual
```

### Response

The request will return all users who have shared their LinkedIn profile or their Xbox gamertag, including Adele, as follows:

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,userPrincipalName,onPremisesExtensionAttributes)",
    "@odata.count": 1,
    "value": [
        {
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "displayName": "Adele Vance",
            "userPrincipalName": "AdeleV@M365EDU334089.OnMicrosoft.com",
            "onPremisesExtensionAttributes": {
                "extensionAttribute1": null,
                "extensionAttribute2": null,
                "extensionAttribute3": null,
                "extensionAttribute4": null,
                "extensionAttribute5": null,
                "extensionAttribute6": null,
                "extensionAttribute7": null,
                "extensionAttribute8": null,
                "extensionAttribute9": null,
                "extensionAttribute10": null,
                "extensionAttribute11": null,
                "extensionAttribute12": null,
                "extensionAttribute13": "www.linkedin.com/in/adelevanceonlinkedIn",
                "extensionAttribute14": "AdeleV",
                "extensionAttribute15": "AwesomeAdele"
            }
        }
    ]
}
```

Because Microsoft Graph doesn't support retrieving a subset of the 15 extension attribute properties, the team bonding app should include a logic to strip down the properties it doesn't need to read and only display to the end user the data in the properties that the app requires.

## Update and delete user data in an extension attribute property

Suppose Adele has crossed the 1,000,000 gamerscore mark and to show off the milestone, has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in the app profile so colleagues can discover the new gamertag.

Adele also no longer uses the Skype app and now uses Teams instead. Adele wants to remove the Skype ID from the user profile. When Adele initiates the update from the team bonding app's user interface, the app will call Microsoft Graph and set the value of the **extensionAttribute14** property to `null`.

The app will update Adele's profile by calling Microsoft Graph as follows.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute14": null,
        "extensionAttribute15": "AtalantaAdele"
    }
}
```

### Response

If the update is successful, Microsoft Graph returns a `204 No Content` HTTP response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

## Dynamically add users internal groups based on their user profile data

In this exercise, you create a Microsoft 365 group and specify that its membership is dynamically calculated. You configure a rule that only users with Xbox gamer tags can be members of the group. You also specify a Teams team and a Yammer community to be provisioned when you create the group.

### Request

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/groups

{
    "description": "Xbox gamers group - Have fun, compete, grow, build connections!",
    "displayName": "Xbox gamers",
    "groupTypes": [
        "Unified",
        "DynamicMembership"
    ],
    "creationOptions": [
        "YammerProvisioning"
    ],
    "mailEnabled": true,
    "mailNickname": "Xboxers",
    "securityEnabled": false,
    "membershipRule": "(user.extensionAttribute15 -ne null)",
    "membershipRuleProcessingState": "On",
    "resourceProvisioningOptions": [
        "Team"
    ]
}
```


### Response

The request returns a `201 Created` HTTP response code and a Microsoft Graph **group** object in the response body as follows.

>**Note:** The response object shown here has been shortened for readability.

```
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#groups/$entity",
    "id": "d61efd38-0b40-488a-8e4d-ed7508504b27",
    "description": "Xbox gamers group - Have fun, compete, grow, build connections!",
    "displayName": "Xbox gamers",
    "groupTypes": [
        "Unified",
        "DynamicMembership"
    ],
    "creationOptions": [
        "YammerProvisioning"
    ],
    "mail": "Xboxers@M365EDU334089.onmicrosoft.com",
    "mailEnabled": true,
    "mailNickname": "Xboxers",
    "membershipRule": "(user.extensionAttribute15 -ne null)",
    "membershipRuleProcessingState": "On",
    "proxyAddresses": [
        "SMTP:Xboxers@M365EDU334089.onmicrosoft.com"
    ],
    "resourceProvisioningOptions": [
        "Team"
    ],
    "renewedDateTime": "2022-07-07T10:06:47Z",
    "securityEnabled": false,
    "securityIdentifier": "S-1-12-1-3592355128-1217006400-1978486158-659247112",
    "visibility": "Public"
}
```

After a few seconds to up to 24 hours of Azure AD synchronization, the users who match the dynamic membership rule, such as Adele, are added as members of the group and a team is also provisioned for the group.

You can confirm that Microsoft Graph works by retrieving the members of the Xboxers group as follows.

##### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/groups/d61efd38-0b40-488a-8e4d-ed7508504b27/members
```

##### Response

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#directoryObjects",
    "value": [
        {
            "@odata.type": "#microsoft.graph.user",
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "businessPhones": [],
            "displayName": "Adele Vance",
            "givenName": "Adele",
            "jobTitle": "Student",
            "mail": "AdeleV@M365EDU334089.OnMicrosoft.com",
            "mobilePhone": null,
            "officeLocation": null,
            "preferredLanguage": null,
            "surname": "Vance",
            "userPrincipalName": "AdeleV@M365EDU334089.OnMicrosoft.com"
        }
    ]
}
```

The Xboxers group is now open for collaboration!

## Conclusion

You have used Microsoft Graph extension attribute properties to store three custom values. You've seen how to:
+ Retrieve those values or remove any values from the properties.
+ Implement a custom search so employees in the company can discover each other's external social profiles.
+ Use the extension attribute values for dynamic group memberships

After this exercise, Adele's profile has only the LinkedIn profile URL and Xbox gamer tag that can be discovered through the team bonding app. Other users may decide to share all three pieces of data or none. For each type of operation, you should implement the appropriate logic in the team bonding app to translate successful HTTP response codes to user-friendly response messages in the user interface.