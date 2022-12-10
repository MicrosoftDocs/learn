<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
When setting up your application's Azure Active Directory (Azure AD) test environment, you need to decide between using a dedicated test tenant or your production Azure AD tenant.  Using a production tenant can make some aspects of application testing easier, but it requires the right level of isolation between test and production resources. Isolation is especially important for high-privilege scenarios. If you can't safely constrain your test app in your production tenant, create a separate tenant for development and testing purposes.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Recall that in the sales team dashboard example, your development team chose to set up a test environment in a separate Azure AD tenant.  Here are some of the key factors the team reviewed while making this decision:

- You want to set up a CI/CD pipeline that automates building, testing, and deploying the web app.  Creating test users and test app registrations in the production tenant are high-privilege operations, since they require admin permissions.
- The administrators reviewed your request for automatically creating test users and test data in the production tenant and didn't approve.
- Multi-factor authentication is required for all users in the production tenant.  Automating sign-ins for integration testing won't be possible.
- After some investigation, your team decided that the integration tests need to use a non-interactive flow, called Resource Owner Password Credential Grant (ROPC), to automatically sign in users for testing. Microsoft recommends that you *don't* use the ROPC flow in a production environment.

<!-- TODO: add your scenario image -->

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
In this exercise, you will set up your test environment in Azure AD by creating a separate test tenant, adding a test user, and creating an app registration.  If you have access to the production tenant, it's also recommended that you populate the test tenant with policies that are in your production tenant. 

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

## Get a test tenant

If you don't already have a dedicated test tenant in Azure AD, you can create one for free.  You can [manually create a new tenant](/azure/active-directory/develop/quickstart-create-new-tenant), which will be empty upon creation and will have to be configured with test data and test users.  Microsoft recommends you join the Microsoft 365 Developer Program, which is free and can be used to easily set up an Azure AD tenant.  The Microsoft 365 Developer Program also includes a Microsoft 365 E5 developer subscription that you can use to create your own sandbox and develop solutions independent of your production environment. You can build Microsoft Teams apps, Office Add-ins for Word, Excel, PowerPoint, or Outlook, or SharePoint Add-ins, using Microsoft Graph, the SharePoint Framework, Power Apps, and more.

1. Go to the [Join the Microsoft 365 Developer Program](/office/developer-program/microsoft-365-developer-program#join-the-microsoft-365-developer-program) page.
1. Select the **Join now** button on the screen.
1. Sign in with a new Microsoft Account or use an existing (work) account you already have.
1. On the sign-up page select your region, enter a company name and accept the terms and conditions of the program before you select **Next**.
1. Select **Set Up Subscription**. Specify the region where you want to create your new tenant, create a username, domain, and enter a password. This will create a new tenant and the first administrator of the tenant.
1. Enter the security information, which is needed to protect the administrator account of your new tenant. This will set up multi-factor authentication for the account.

When you're finished setting up your subscription, you can optionally set up your Microsoft 365 E5 sandbox, which includes an Azure AD tenant, fictitious test users, a Microsoft Teams sample data pack, and data for Microsoft Graph, Sharepoint, and Office Add-ins development.

## Populate your tenant with users

If you didn't use a Microsoft 365 developer subscription to add test users to your tenant, or those test users don't meet your testing needs, you can add more yourself.  To create users, the account running the code needs Global Administrator or User Administrator role in the directory.

For convenience, you may want to invite yourself and other members of your development team to be guest users in the tenant. This will create separate guest objects in the test tenant, but means you only have to manage one set of credentials for your corporate account and your test account.

```azurepowershell-interactive
# Install the Microsoft Graph Identity Sign-ins and the Microsoft Graph Users modules
Install-Module -Name Microsoft.Graph.Identity.SignIns
Install-Module -Name Microsoft.Graph.Users

# Connect to the tenant domain.
Connect-MgGraph -Scopes user.readwrite.all

# Send an invitation to the email address specified.
New-MgInvitation -InvitedUserDisplayName "John Doe" -InvitedUserEmailAddress John@contoso.com -InviteRedirectUrl "https://myapplications.microsoft.com" -SendInvitationMessage:$true

# Verify that the invited user was added to Azure AD.
Get-MgUser -Filter "Mail eq 'John@contoso.com'"
```

You can also create test users in your test tenant. If you used one of the Microsoft 365 sample packs, you may already have some test users in your tenant. If you need more test users, you can create some yourself as the tenant administrator.

```azurecli-interactive
TESTUSERNAME="testuser1"
TESTUPN="${TESTUSERNAME}@contoso.onmicrosoft.com"

# Create a test user
TESTPASSWORD=$(openssl rand -base64 14)
az ad user create --display-name $TESTUSERNAME --password $TESTPASSWORD --user-principal-name $TESTUPN --force-change-password-next-sign-in false
echo "created user $TESTUSERNAME with password $TESTPASSWORD"
```

## Create and configure an app registration

You'll need to create an app registration for your web app to use in your test environment. This should be a separate registration from your eventual production app registration, to maintain security isolation between your test environment and your production environment.

How you configure your application depends on the type of app you're building.  For confidential client applications, you'll need to add a client secret. For public client applications, you can skip this step. A redirect URI, or reply URL, is the location where the authorization server sends the user once the app has been successfully authorized and granted an authorization code or access token. The authorization server sends the code or token to the redirect URI, so it's important you register the correct location as part of the app registration process. The identifier URI acts as the prefix for the scopes you'll reference in your API's code, and it must be globally unique.

The following script creates an app registration for a single tenant web app.  The signed-in user is given User.Read delegated permissions in Microsoft Graph. The web application can request an ID token using the OAuth 2.0 implicit flow.  To create an app registration, the account running the code needs Global Administrator or Application Administrator role in the directory.  

To find the tenant ID, sign into the [Azure portal](https://portal.azure.com) and select **Azure Active Directory**.  On your test tenant's **Overview** page, find the **tenant ID** value.

```azurecli-interactive
WEBAPPNAMETEST="mytestwebapp444"
TENANTID="11111111-1111-1111-1111-111111111111"

# Required resource access.  Microsoft Graph User.Read delegated permissions.
cat > manifest.json << EOF
[
    {
        "resourceAppId": "00000003-0000-0000-c000-000000000000",
        "resourceAccess": [
            {
                "id": "e1fe6dd8-ba31-4d61-89e7-88639da4683d",
                "type": "Scope"
            }
        ]
    }
]
EOF

# Create app registration for a web app
redirectUriTest="https://$WEBAPPNAMETEST.azurewebsites.net/auth/redirect"
homePageUrlTest="https://$WEBAPPNAMETEST.azurewebsites.net"
issuerTest="https://sts.windows.net/$TENANTID"

appIdTest=$(az ad app create --display-name $WEBAPPNAMETEST --sign-in-audience AzureADMyOrg --enable-id-token-issuance true --query appId --output tsv)
echo "Registered app: $appIdTest"

# Set identifier URI, homepage, redirect URI, and resource access
az ad app update --id $appIdTest --identifier-uris api://$appIdTest --web-redirect-uris $redirectUriTest  --web-home-page-url $homePageUrlTest --required-resource-accesses @manifest.json
echo "Updated app registration settings"

# Add client secret with expiration. The default is one year. 
# The client secret is saved in the variable and can be displayed with the echo command. Make a note of it as it isn't visible on the portal. 
clientsecretname="MyAppSecret"
clientsecretduration=1
clientsecret=$(az ad app credential reset --id $appIdTest --append --display-name $clientsecretname --years $clientsecretduration --query password --output tsv)
echo $clientsecret
```

## Get Azure AD premium features

If you want to fully test Azure AD premium features on your application, you'll need to sign up your tenant for a [Premium P1 or Premium P2 license](https://azure.microsoft.com/pricing/details/active-directory/).

If you signed up using the Microsoft 365 Developer program, your test tenant will come with Azure AD P2 licenses. If not, you can still enable a [free trial of Azure AD premium](https://azure.microsoft.com/free/active-directory/).

## Populate your tenant with policies (recommended)

If your app will primarily be used by a single organization (commonly referred to as single tenant), and you have access to that production tenant, then you should try to replicate the settings of your production tenant that can affect your app's behavior. That will lower the chances of unexpected errors when operating in production.

### Conditional Access policies

Replicating conditional access policies ensures you don't encounter unexpected blocked access when moving to production and your application can appropriately handle the errors it's likely to receive.

Viewing your production tenant conditional access policies may need to be performed by a company administrator.

1. Sign into the [Azure portal](https://portal.azure.com) using your production tenant Conditional Access Administrator, Security Administrator, or Global Administrator account.
1. Go to **Azure Active Directory** > **Enterprise applications** > **Conditional Access**.
1. View the list of policies in your tenant. Select the first policy.

   :::image type="content" source="../media/conditional-access-policies.png" alt-text="Screenshot of the 'Conditional Access policies' pane.":::

1. Navigate to **Cloud apps or actions**.
1. If the policy applies to all cloud apps, it will likely apply to your app when you move it from test to production.  Make note of the policy settings in order to copy the policy to your test tenant.  If the policy only applies to a select group of apps, then move on to the next policy and don't copy the policy to your test tenant.

   :::image type="content" source="../media/cloud-apps-or-actions.png" alt-text="Screenshot of the 'clout apps or actions' pane.":::

In a new tab or browser session, sign into the [Azure portal](https://portal.azure.com) using your test tenant Conditional Access Administrator, Security Administrator, or Global Administrator account.

1. Sign in to the Azure portal as a Conditional Access Administrator, Security Administrator, or Global Administrator.
1. Browse to **Azure Active Directory** > **Security** > **Conditional Access**.
Select **New policy**.
1. Copy the settings from the production tenant policy, identified through the previous steps, and create the new policy.

### Permission grant policies

Replicating permission grant policies ensures you don't encounter unexpected prompts for admin consent when moving to production.  To configure user consent settings, you need to sign in as a user with Global Administrator or Privileged Administrator roles.

1. Sign into the [Azure portal](https://portal.azure.com) using your production tenant Global Administrator account.
1. Select **Azure Active Directory** > **Enterprise applications** > **Consent and permissions** > **User consent settings**.
1. Under User **consent for applications**, view the consent settings for all users.

   :::image type="content" source="../media/setting-for-all-users.png" alt-text="Screenshot of the 'User consent settings' pane.":::

1. Make note of the settings you want to replicate to users of your test tenant.
1. Sign into the Azure portal using your test tenant Global Administrator account.
1. Select **Azure Active Directory** > **Enterprise applications** > **Consent and permissions** > **User consent settings**.
1. Under **User consent for applications**, select which consent setting you want to configure for all users.
1. Select **Save** to save your settings.

   :::image type="content" source="../media/setting-for-all-users-save.png" alt-text="Screenshot of the 'User consent for applications' pane.":::

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

## Check your work

At this point, you should have set up a separate tenant in Azure AD for application testing.  You should also have a test user created and an app registration you can use for testing a web app.  To verify:

1. In the Azure portal, select **Azure Active Directory** from the list of services.
1. Select **Users** from the left nav.
1. In the list of users, verify that the guest users you invited and any other test users you created appear in the list.
1. Close the **Users** view.
1. Select **App registrations** from the left nav.
1. Select the **All applications** tab.
1. Verify that the app registration you created appears in the list.


<!-- Do not add a unit summary or references/links -->
