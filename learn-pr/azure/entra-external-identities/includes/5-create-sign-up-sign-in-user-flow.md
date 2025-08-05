## Exercise - Create a sign-up and sign-in user flow

A [user flow](/entra/external-id/customers/how-to-user-flow-sign-up-sign-in-customers) defines the series of sign-up steps customers follow and the sign-in methods they can use (such as email and password, one-time passcodes, or social accounts from Google or Facebook). You can also collect information from customers during sign-up by selecting from a series of built-in user attributes or adding your own custom attributes. You can create multiple user flows if you have multiple applications that you want to offer to customers.

> [!NOTE]
> You'll need at least the [External ID User Flow Administrator](/entra/identity/role-based-access-control/permissions-reference#external-id-user-flow-administrator) directory role to create user flows.
>
> Do you have feedback? [Please let us know how your proof of concept project is going. We'd love to hear from you!](https://forms.microsoft.com/r/Um1E3Sexnk)

::: zone pivot="microsoft-entra-admin-center"

1. To create a sign-up and sign-in user flow, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) and browse to **Identity** > **External Identities**.

    [ ![Screenshot of Microsoft Entra admin center homepage with a left navigation item titled External Identities highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/1_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/1.png#lightbox)

1. From the menu, select **User flows**. Then, select **New user flow**.

    [ ![Screenshot of Microsoft Entra admin center homepage with a left navigation item titled External Identities highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/2_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/2.png#lightbox)

1. On the **Create** page, enter a **Name** for the user flow (for example, "SignUpSignIn"). Then, under **Identity providers**, select the **Email Accounts** check box, and then select one of these options. If you configured other identity providers, you can select them.

    [ ![Screenshot of Create blade in External Identities User flows that highlights the name of new user flow.](../media/create-a-sign-up-and-sign-in-user-flow/3_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/3.png#lightbox)

1. Under **User attributes**, choose the attributes you want to collect from the user during sign-up. Select **Show more** to choose from the full list of attributes, including Job Title, Display Name, and Postal Code and more. Then, select **Create** to create the user flow.

    [ ![Screenshot of Create blade in External Identities User flows that highlights checked items in checkboxes City, Country or Region, and Display Name as attributes to collect during sign up, and Show more link underneath for additional options. The button titled Create at the bottom is highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/4_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/4.png#lightbox)

1. From the list, select the user flow you created.

    [ ![Screenshot of External Identities User flows blade with a user flow titled SignUpSignIn highlighted in the gridlist.](../media/create-a-sign-up-and-sign-in-user-flow/5_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/5.png#lightbox)

1. The following steps activate the sign-up and sign-in experience (the user flow) for users who visit your application. In the left menu, under **Use**, select **Applications**.

    [ ![Screenshot of User flow Overview blade for the user flow titled SignUpSignIn, where left navigation item titled Applications is highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/6_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/6.png#lightbox)

1. Select **Add Application**

    [ ![Screenshot of Applications blade for the user flow titled SignUpSignIn that highlights a button in the toolbar titled Add application.](../media/create-a-sign-up-and-sign-in-user-flow/7_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/7.png#lightbox)

1. Select the application from the list. Or use the search box to find the application, and then select it. Choose **Select**.

    [ ![Screenshot of Select application pane that opens to the right and highlights an application selected titled Woodgrove Groceries. The button titled Select at the bottom is highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/8_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/8.png#lightbox)

1. The application is now linked to the user flow. Select **Run user flow** to preview the experience.

    [ ![Screenshot of an application titled Woodgrove Groceries showing up as an application associated with the user flow titled SignUpSignIn. A button labeled "Run user flow" is highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/9_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/9.png#lightbox)

1. In the *Run user flow* pane that opens to the right, make sure that the correct **Application** and **Reply URL** are selected. Then, select **Run user flow**. 

    [ ![Screenshot of Run user flow pane that opens to the right, with fields Application and Reply URL highlighted. At the bottom, a button labeled Run user flow is also highlighted.](../media/create-a-sign-up-and-sign-in-user-flow/10_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/10.png#lightbox)

1. **Well done!** You successfully created a user flow and linked an application! 
    > [!TIP]
    > You can always use the **Run user flow** button to preview the sign in experience.
    *When users sign in to the groceries website, they'll come across the sign-in and sign-up experience configured in the user flow.*
    >
    > [ ![Screenshot of sign in flow preview.](../media/create-a-sign-up-and-sign-in-user-flow/11_inline.png) ](../media/create-a-sign-up-and-sign-in-user-flow/11.png#lightbox)

::: zone-end

::: zone pivot="microsoft-graph-api"

#### 1. Create a user flow

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

#### 2. Add your application to the user flow
To [add or link an application to a user flow](/graph/api/authenticationconditionsapplications-post-includeapplications?view=graph-rest-beta&tabs=http), use the following Microsoft Graph request. Replace the **{user-flow-ID}** with your [user flow ID](/graph/api/identitycontainer-list-authenticationeventsflows?view=graph-rest-beta&tabs=http). Replace the **{app-ID}** with your [application ID](/graph/api/application-list?view=graph-rest-beta&tabs=http).

```json
POST https://graph.microsoft.com/beta/identity/authenticationEventsFlows/{user-flow-ID}/conditions/applications/includeApplications
{
    "@odata.type": "#microsoft.graph.authenticationConditionApplication",
    "appId": "{app-ID}"
}
```

::: zone-end
