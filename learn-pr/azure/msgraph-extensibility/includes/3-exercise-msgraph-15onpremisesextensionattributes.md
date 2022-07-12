Microsoft Graph provides a set of 15 extension attributes for storing custom data. In the team bonding app scenario, you need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag. Employee profiles are represented in Azure AD, Microsoft 365, and Microsoft Graph as user profiles.

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the extension attribute properties on the **user** resource. 

## Authenticate your session

Sign in to Graph Explorer as an administrator with both the *User Administrator* and *Groups Administrator* Azure AD role.

Consent to the *User.ReadWrite.All* and *Group.ReadWrite.All* Microsoft Graph permissions to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permission to allow them to discover their colleagues and update their own profile information respectively.

## Define the extension attributes

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

## Add data to the extension attributes

In this exercise, you'll store these pieces of data for the user named **Adele Vance** who is identified by user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`.

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

## Use the data in the extension attributes for your application

After the data is stored in the user profile, you can now use it in your application.

### Search for employees who have shared their LinkedIn profile and Xbox gamertag

Suppose another employee wants to discover their colleagues who have shared their Xbox and LinkedIn profiles. This capability can be achieved through a search bar and a drop-down filter in the team bonding app to allow anyone to perform a quick discovery.

#### Request

When the employee uses the user interface to find colleagues who have shared their Xbox gamertag or LinkedIn profiles, the app will call Microsoft Graph as follows:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$filter=onPremisesExtensionAttributes/extensionAttribute13 ne null or onPremisesExtensionAttributes/extensionAttribute15 ne null&$count=true&$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
ConsistencyLevel: eventual
```

The HTTP request must include the `$count=true` query parameter and set the **ConsistencyLevel** header to `eventual`. This is because the *not equals to* (`ne`) operator used in the query is a specially indexed query capability that works with Azure AD advanced queries and requires both the `$count=true` query parameter and the **ConsistencyLevel** header.

#### Response

The request will return all users who have shared their LinkedIn profile or their Xbox gamertag, including Adele. The following response object shows the response payload that Microsoft Graph returns to the app.

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

Because Microsoft Graph doesn't support directly retrieving the 15 properties nested in **onPremisesExtensionAttributes**, the response object includes all 15 properties, including extensionAttribute1-12 that the team bonding app doesn't intend to use.

Therefore, the team bonding app should include a logic to strip down the unrequired 12 properties and only display the data in the three properties that it requires.

### Change the value of an extension attribute property

Suppose Adele has crossed the 1,000,000 gamerscore mark and to show off the milestone, has changed the Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the gamertag in app profile so colleagues can discover the new gamertag.

Through the team bonding app's user interface, Adele will change the Xbox gamertag. The app will update the user profile by calling Microsoft Graph through an HTTP PATCH request.

#### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute15": "AtalantaAdele"
    }
}
```

#### Response

If the update is successful, Microsoft Graph returns a `204 No Content` response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

You can implement the appropriate logic in the team bonding app to translate this successful response code to a user friendly response message in the user interface.

### Remove an existing value from an extension attribute property

Suppose Adele no longer uses the Skype app and now uses Teams instead. Adele wants to remove the Skype ID from the user profile.

When Adele initiates the update from the team bonding app's user interface, the app will call Microsoft Graph through an HTTP PATCH request. To remove the existing Skype ID from **extensionAttribute14**, the app will set the value of the property to `null`.

Run the following request to remove the Skype ID from Adele's profile.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute14": null
    }
}
```

#### Response

If the update is successful, Microsoft Graph returns a `204 No Content` response code to the app with no response body.

```http
HTTP/1.1 204 No Content
```

## Dynamically add users internal groups based on their user profile data

In this exercise, you create a Microsoft 365 group and specify that its membership is dynamically calculated. You configure a rule that only users with Xbox gamer tags can be members of the group. You also specify a Teams team to be provisioned when you create the group.

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

The request returns a `201 Created` response code and a Microsoft Graph **group** object in the response body as follows.

>**Note:** The response object shown here might be shortened for readability. 

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

After a few seconds to allow Azure AD to complete synchronization, the users who match the dynamic membership rule are added as members of the group and a team is also provisioned for the group.

In this exercise, Adele is automatically a member of the group.

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

And you've confirmed that the Xboxers group is now open for collaboration!

### Customize tokens using data in extension attribute properties



## Conclusion

You have used Microsoft Graph extension attribute properties to store three custom values. You've seen how to:
+ Retrieve those values or remove any values from the properties.
+ Implement a custom search so other employees in the company can discover the external profiles belonging to Adele and connect with Adele in the respective social platforms.
+ Use the extension attribute values for dynamic group memberships
+ Use the extension attribute values to customize claims

After this exercise, Adele's profile has only the LinkedIn profile URL and Xbox gamer tag that can be discovered through the team bonding app. Other users may decide to share all three pieces of data or none. For each type of operation, you can implement the appropriate logic in the team bonding app to translate successful response codes to user-friendly response messages in the user interface.
