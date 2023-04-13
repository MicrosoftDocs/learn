In this exercise, you use [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the extension attributes on the *user* resource. The commands in this exercise emulate the API calls that the team-bonding app makes on behalf of a signed-in user.

## Authenticate your session

1. Sign in to Graph Explorer by using a work or school account that has global administrator privileges in the tenant.

1. To perform the API operations in this exercise, consent to the *User.ReadWrite.All* and *Group.ReadWrite.All* Microsoft Graph permissions.

In the team-bonding app, employees will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permissions. Granting this consent will allow them to discover their colleagues and update their own profile information.

## Identify the extension attributes to use

Run the following request to read and identify the attributes that already store data and shouldn't be overwritten.

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
```

### Response

The following object is a sample response. The response object has been shortened for readability to show only one user object.

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,userPrincipalName,onPremisesExtensionAttributes)",
    "value": [
        {
            "id": "6e03a2db-564a-47ec-ba51-d0cd38af069a",
            "displayName": "Adele Vance",
            "userPrincipalName": "AdeleV@contoso.com",
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

## Store user data

In this exercise, you store the LinkedIn profile URL, Skype ID, and Xbox gamertag for *Adele Vance* in **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15** respectively.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a
Content-type: application/json

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute13": "www.linkedin.com/in/adelevanceonlinkedIn",
        "extensionAttribute14": "AdeleV",
        "extensionAttribute15": "AwesomeAdele"
    }
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Search for employees who have shared their LinkedIn profile and Xbox gamertag

Running the following request allows an employee to discover colleagues who have shared their Xbox and LinkedIn profiles.

### Request

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$filter=onPremisesExtensionAttributes/extensionAttribute13 ne null or onPremisesExtensionAttributes/extensionAttribute15 ne null&$count=true&$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
ConsistencyLevel: eventual
```

### Response

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
            "userPrincipalName": "AdeleV@contoso.com",
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

Microsoft Graph doesn't support retrieving a subset of the 15 extension attribute properties. Therefore, the team-bonding app should include logic to strip down the properties that it doesn't need and then display to the end user only the data that the app requires.

## Update and delete user data

Suppose Adele has crossed the 1,000,000 *gamerscore* mark and, to show off the milestone, has changed her Xbox gamertag from `AwesomeAdele` to `AtalantaAdele`. Adele wants to change the value in the internal profile as well.

Adele also no longer uses the Skype app and now uses Teams instead. The app calls Microsoft Graph to set the value of **extensionAttribute14** to `null`.

### Request

```msgraph-interactive
PATCH https://graph.microsoft.com/v1.0/users/6e03a2db-564a-47ec-ba51-d0cd38af069a
Content-type: application/json

{
    "onPremisesExtensionAttributes": {
        "extensionAttribute14": null,
        "extensionAttribute15": "AtalantaAdele"
    }
}
```

### Response

```http
HTTP/1.1 204 No Content
```

## Dynamically add users to groups based on their extension data

In this exercise, you create a Microsoft 365 group and specify that it has dynamic membership where only users with Xbox gamertags can be members of the group. You also specify a Teams team to be provisioned when you create the group.

### Request

```msgraph-interactive
POST https://graph.microsoft.com/v1.0/groups
Content-type: application/json

{
    "description": "Xbox gamers group - Have fun, compete, grow, build connections!",
    "displayName": "Xboxers",
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

The response object shown here has been shortened for readability.

```
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#groups/$entity",
    "id": "d61efd38-0b40-488a-8e4d-ed7508504b27",
    "description": "Xbox gamers group - Have fun, compete, grow, build connections!",
    "displayName": "Xboxers",
    "groupTypes": [
        "Unified",
        "DynamicMembership"
    ],
    "mail": "Xboxers@contoso.com",
    "mailEnabled": true,
    "mailNickname": "Xboxers",
    "membershipRule": "(user.extensionAttribute15 -ne null)",
    "membershipRuleProcessingState": "On",
    "proxyAddresses": [
        "SMTP:Xboxers@contoso.com"
    ],
    "resourceProvisioningOptions": [
        "Team"
    ],
    "securityEnabled": false,
    "securityIdentifier": "S-1-12-1-3592355128-1217006400-1978486158-659247112",
    "visibility": "Public"
}
```

After a few seconds to up to 24 hours of Azure AD synchronization, the users who match the dynamic membership rule, such as Adele, are added as members of the group, and a team is provisioned for the group. The Xboxers group is now open for collaboration.