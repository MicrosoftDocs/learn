<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
Validate the user experience by signing in as a test user



<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Here, you'll create an Azure AD user account for testing and enable it for Microsoft Authenticator. 

:::image type="content" border="true" source="../media/phone-sign-in-microsoft-authenticator-app.png" alt-text="Screenshot of Microsoft Authenticator sign-in.":::


<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
You'll confirm the test user can set up Microsoft Authenticator and have push notifications as the new default sign-in method. After confirming the experience for a test user, you can apply the policy to the remote employees group for your company. 

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

## Create a test user account
<!-- Introduction paragraph -->
Create a user account for the purposes of testing the Microsoft Authenticator registration campaign.

1. Sign in to the Azure portal, click **Azure Active Directory** > **Manage** > **Users**.
1. Select **New user** at the top of the pane.
1. In the **User name** field, enter the username of the user account. For example, `contosouser1@contoso.com`. Be sure to change `contoso.com` to the name of the tenant domain.
1. In the **Name** field, enter the name of the user of the account. For example, `contosouser1`.
1. Leave Auto-generate password selected, and then select **Show password**. Write down the value that's displayed in the **Password** box.
1. Select **Create**.

## Exercise: Enable Microsoft Authenticator for the test user

With the test user configured to sign in using Voice call, now let's enable Microsoft Authenticator push notifications as a sign-in option for the test user. You'll need to set the Authentication mode to **Push**. If it's set to **Passwordless**, the user won't get nudged to set up Authenticator.  

1. In Authentication methods, click **Policies**.
1. Under Microsoft Authenticator, choose the following options:
   
    - Enable - **Yes**
    - Target - Select the test user
    - Browse to **...** > **Configure**.
    - For Authentication mode - **Push**. 
      
1. To apply the new policy, click **Save**.

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
<!-- Introduction paragraph -->
Sign in as the test user from a device that hasn't already set up Microsoft Authenticator. The device must use the phone number that you enabled for authentication.  

1. Sign in to Azure and perform MFA. 
1. When prompted, set up the Microsoft Authenticator app to improve their sign-in experience. Only users who are allowed for the Microsoft Authenticator push notifications and do not have it currently set up will see the prompt. 

   :::image type="content" border="true" source="../media/how-to-nudge-authenticator-app/user-mfa.png" alt-text="Screenshot of a user who performs multifactor authentication.":::

1. Tap **Next** and step through Microsoft Authenticator setup. 
    1. First download the app.  
    1. See how to set up Microsoft Authenticator. 
    1. Scan the QR Code. 
    1. Approve the test notification.
    1. After the notification approved, Microsoft Authenticator is successfully set up as the user’s default sign-in method.

       :::image type="content" border="true" source="../media/how-to-nudge-authenticator-app/finish.png" alt-text="Screenshot of setup completion for Microsoft Authenticator.":::

1. If you don't want to install Microsoft Authenticator, tap **Not now** to snooze the prompt for up to 14 days. The snooze duration can be set by an admin. 


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
