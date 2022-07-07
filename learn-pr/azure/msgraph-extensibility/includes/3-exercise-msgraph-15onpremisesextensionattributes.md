<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
<!--TODO: add your topic sentences(s)-->

Microsoft Graph provides a set of 15 extension attributes for storing custom data. In the team bonding app scenario, we need to allow each employee to add their public LinkedIn profile URL, Skype ID, and Xbox gamertag. Employee profiles are represented in Azure AD, Microsoft 365, and Microsoft Graph as user profiles.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
<!--TODO: add your scenario sub-task
TODO: add your scenario image-->



<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
<!--TODO: describe the end-state-->

In this exercise, you'll use an API client such as [Graph Explorer](https://aka.ms/ge) to make REST API requests to Microsoft Graph and manage the extension attribute properties on the **user** resource. 

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->
<!--
## (Chunk 1 heading)
<!-- Introduction paragraph -->
<!--1. <!-- Step 1 -->
<!--1. <!-- Step 2 -->
<!--1. <!-- Step n -->

## Authenticate your session

Sign in to Graph Explorer as an administrator with both the *User Administrator* and *Groups Administrator* Azure AD role.

Consent to the *User.ReadWrite.All* and *Group.ReadWrite.All* Microsoft Graph permission to perform the API operations in this exercise.

In the team bonding app, the employee will sign in with their Azure AD profile and must consent to the *User.Read.All* and *User.ReadWrite* Microsoft Graph permission to allow them to discover their colleagues and update their own profile information.

## Define the extension attributes

Because the 15 extension attributes are predefined on the **user** resource, you can't define them, assign them custom names, or delete them. You can only manage them by adding, updating, or deleting data from them.

You retrieve user profiles by calling Microsoft Graph using an HTTP GET request. In the Microsoft Graph `v1.0` endpoint, the **onPremisesExtensionAttributes** property isn't returned by default and you must therefore use a `$select` query parameter to retrieve it and the data it stores.

### Request
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=id,displayName,userPrincipalName,onPremisesExtensionAttributes
```

### Response
The following is a sample response. The response object has been shortened for readability to show only two users.
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
        },
        {
            "id": "b41e9d71-0ef4-471e-b2c5-bdc9d84d57e4",
            "displayName": "Bruno (IT)",
            "userPrincipalName": "admin@M365EDU334089.onmicrosoft.com",
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

<!--
## (Chunk n heading)
<!-- Introduction paragraph -->
<!--1. <!-- Step 1 -->
<!--1. <!-- Step 2 -->
<!--1. <!-- Step n -->

## Add data to the extension attributes

With the extension attribute properties already predefined in Microsoft Graph, you can use them to the LinkedIn profile URL, Skype ID, and Xbox gamertag.

In this exercise, we'll store these pieces of data for the user named **Adele Vance** who is identified by user ID `6e03a2db-564a-47ec-ba51-d0cd38af069a`.

### Request

You store data in the existing **onPremisesExtensionAttributes** property by updating the user profile using an HTTP PATCH request and specifying the new values in the request body. We'll store Adele's public LinkedIn profile URL, Skype ID, and Xbox gamertag in **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15** respectively.

In the team bonding app, Adele would use a user interface to update the three properties. The app will then call Microsoft Graph as follows:

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

You can implement the appropriate logic in the team bonding app to translate this successful response code to a user friendly response message in the user interface.

## Use the data in the extension attributes for your application

After the data is stored in the user profile, you can now use it in your application.

In the team bonding app, Adele's user profile will include the LinkedIn profile URL, Skype ID, and Xbox gamertag. Any other employees in the company can now discover these external profiles belonging to Adele and connect with Adele in the respective social platforms.

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

## Other Azure AD scenarios for custom data in extension attribute properties

While you used the extension attribute properties to store data required by the team bonding app, there are other different ways you can use this custom data in your organization.

In this section, you'll explore and configure other Azure AD use cases for the extension attribute properties and they data they store.

### Dynamically add users internal groups based on their user profile data

Suppose you want to seamlessly allow employees with shared interests to communicate through one internal Teams channel and share tips or have fun. For example, you want Xbox gamers to interact with each other through Teams chats or email, share tips, plan team playoffs and have fun together.

Microsoft Graph groups allow an organization to bring other users with common interests. You can create an Xbox gamers group to bring together all Xbox enthusiasts through one alias.

To avoid manually updating the membership of the group, Microsoft Graph supports creating and managing groups with dynamic membership.

#### Create a dynamic group for employees based on their user profile data

You want to create a dynamic group for Xbox gamers within the company. The membership of the employees to the group depends on whether they've shared their Xbox gamertag. If an employee stops sharing their Xbox gamertag, they're automatically removed from the group. An employee who is a member of the Xbox gamers group will be able to interact with other gamers through a Teams channel and can receive emails sent to the group members.

As an administrator, call Microsoft Graph through an HTTP POST request to create a group. Microsoft 365 groups are the best group types for the internal collaboration you want to support for the Xbox gamers. Specify that membership to the group is dynamic and configure the rule that only users with Xbox gamer tags can be members of the group.

##### Request

In the following request body:
+ The **groupTypes** property specifies that we're creating a Microsoft 365 group with dynamic membership.
+ The **mailEnabled** and **mailNickname** properties specify that the group can receive mails through the specified mail alias.
+ The **membershipRuleProcessingState** property specifies that
+ The **membershipRule** property specifies the rule that is calculated to calculate users who should be members of the group. In this case, the rule specifies that members are users whose **extensionAttribute15** property in their isn't empty.

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
    "membershipRuleProcessingState": "On"
}
```


##### Response

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

And we've confirmed that the Xboxers group is now open for collaboration!

### Customize tokens using data in extension attribute properties

Another Azure AD use case for the extension attribute properties and their data is customizing tokens with claims.

<!--Placeholder: TO-DO See more: https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-optional-claims#configuring-directory-extension-optional-claims -->

## Conclusion

You have used Microsoft Graph extension attribute properties to store three custom values. You've seen how to retrieve those values or remove any values from the properties.

After this exercise, Adele's profile has only the LinkedIn profile URL and Xbox gamer tag that can be discovered through the team bonding app. Other users may decide to share all three pieces of data or none.

You've also learned how to use the extension attribute properties allow you to achieve the following extra organizational scenarios:

+ Create dynamic groups with membership that's based on user profiles
+ Customize claims using extension properties


<!-- 5. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. Feedback like this is critical for learning.

    Structure:
        1. A heading of "## Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->


<!-- Do not add a unit summary or references/links -->
