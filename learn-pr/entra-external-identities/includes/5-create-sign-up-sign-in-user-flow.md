## Exercise - Create a sign-up an sign-in user flow

A [user flow](/entra/external-id/customers/how-to-user-flow-sign-up-sign-in-customers) defines the series of sign-up steps customers follow and the sign-in methods they can use (such as email and password, one-time passcodes, or social accounts from Google or Facebook). You can also collect information from customers during sign-up by selecting from a series of built-in user attributes or adding your own custom attributes. You can create multiple user flows if you have multiple applications that you want to offer to customers.

::: zone pivot="microsoft-entra-admin-center"

1. To create a sign-up and sign-in user flow, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) and browse to **Identity** > **External Identities**.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/1.png)
1. From the menu, select **User flows**. Then, select **New user flow**.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/2.png)
1. On the **Create** page, enter a **Name** for the user flow (for example, "SignUpSignIn"). Then, under **Identity providers**, select the **Email Accounts** check box, and then select one of these options. If you configured other identity providers, you can select them.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/3.png)
1. Under **User attributes**, choose the attributes you want to collect from the user during sign-up. Select **Show more** to choose from the full list of attributes, including Job Title, Display Name, and Postal Code and more. Then, select **Create** to create the user flow.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/4.png)
1. From the list, select the user flow you created.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/5.png)
1. The following steps activate the sign-up and sign-in experience (the user flow) for users who visit your application. In the left menu, under **Use**, select **Applications**.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/6.png)
1. Select **Add Application**
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/7.png)
1. Select the application from the list. Or use the search box to find the application, and then select it. Choose **Select**.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/8.png)
1. **Well done!** Your user flow is successfully created and the application is linked to the user flow.
    ![alt text](../media/create-a-sign-up-and-sign-in-user-flow/9.png)
    *When users sign in to the groceries website, they'll come across the sign-in and sign-up experience configured in the user flow.*

::: zone-end

::: zone pivot="microsoft-graph-api"

#### 1\. Create a user flow

To create a user flow, you create an [authentication events flow](/graph/api/identitycontainer-post-authenticationeventsflows?view=graph-rest-beta&tabs=http) object that is of the type specified in the request body.

```json
POST https://graph.microsoft.com/beta/identity/authenticationEventsFlows
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#identity/authenticationEventsFlows/$entity",
    "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",
    "displayName": "Default sign-up and sign-in",
    "description": "Woodgrove default sign-up and sign-in flow",
    "priority": 500,
    "conditions": {
        "applications": {
            "includeAllApplications": false
        }
    },
    "onInteractiveAuthFlowStart": {
        "@odata.type": "#microsoft.graph.onInteractiveAuthFlowStartExternalUsersSelfServiceSignUp",
        "isSignUpAllowed": true
    },
    "onAuthenticationMethodLoadStart": {
        "@odata.type": "#microsoft.graph.onAuthenticationMethodLoadStartExternalUsersSelfServiceSignUp",
        "identityProviders": [
            {
                "@odata.type": "#microsoft.graph.builtInIdentityProvider",
                "id": "EmailPassword-OAUTH"
            }
        ]
    },
    "onAttributeCollection": {
        "@odata.type": "#microsoft.graph.onAttributeCollectionExternalUsersSelfServiceSignUp",
        "accessPackages": [],
        "attributeCollectionPage": {
            "customStringsFileId": null,
            "views": [
                {
                    "title": null,
                    "description": null,
                    "inputs": [
                        {
                            "attribute": "email",
                            "label": "Email Address",
                            "inputType": "text",
                            "defaultValue": null,
                            "hidden": true,
                            "editable": false,
                            "writeToDirectory": true,
                            "required": true,
                            "validationRegEx": "^[a-zA-Z0-9.!#$%&amp;&#8217;'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$",
                            "options": []
                        },
                        {
                            "attribute": "displayName",
                            "label": "Display Name",
                            "inputType": "text",
                            "defaultValue": null,
                            "hidden": false,
                            "editable": true,
                            "writeToDirectory": true,
                            "required": true,
                            "validationRegEx": "^.*",
                            "options": []
                        },
                        {
                            "attribute": "country",
                            "label": "Country/Region",
                            "inputType": "radioSingleSelect",
                            "defaultValue": null,
                            "hidden": false,
                            "editable": true,
                            "writeToDirectory": true,
                            "required": false,
                            "validationRegEx": "^.*",
                            "options": [
                                {
                                    "label": "Australia",
                                    "value": "au"
                                },
                                {
                                    "label": "Spain",
                                    "value": "es"
                                },
                                {
                                    "label": "United States",
                                    "value": "us"
                                }
                            ]
                        },
                        {
                            "attribute": "city",
                            "label": "City",
                            "inputType": "text",
                            "defaultValue": null,
                            "hidden": false,
                            "editable": true,
                            "writeToDirectory": true,
                            "required": false,
                            "validationRegEx": "^.*",
                            "options": []
                        }
                    ]
                }
            ]
        },
        "attributes": [
            {
                "id": "email"
            },
            {
                "id": "city"
            },
            {
                "id": "country"
            },
            {
                "id": "displayName"
            }
        ]
    },
    "onUserCreateStart": {
        "@odata.type": "#microsoft.graph.onUserCreateStartExternalUsersSelfServiceSignUp",
        "userTypeToCreate": "member",
        "accessPackages": []
    }
}
```

##### 1.1 Copy the user flow ID

From the response, copy the value of the user flow **id**. For example:

```json
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#identity/authenticationEventsFlows/$entity",
    "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",
    "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
    "displayName": "Default sign-up and sign-in1",
    "description": "Woodgrove default sign-up and sign-in flow",
    ...
}      
```

#### 2\. Add your application to the user flow
To [add or link an application to a user flow](/graph/api/authenticationconditionsapplications-post-includeapplications?view=graph-rest-beta&tabs=http), use the following Microsoft Graph request. Replace the **{user-flow-ID}** with your [user flow ID](/graph/api/identitycontainer-list-authenticationeventsflows?view=graph-rest-beta&tabs=http). Replace the **{app-ID}** with your [application ID](/graph/api/application-list?view=graph-rest-beta&tabs=http).

```json
POST https://graph.microsoft.com/beta/identity/authenticationEventsFlows/{user-flow-ID}/conditions/applications/includeApplications
{
    "@odata.type": "#microsoft.graph.authenticationConditionApplication",
    "appId": "{app-ID}"
}
```

::: zone-end
