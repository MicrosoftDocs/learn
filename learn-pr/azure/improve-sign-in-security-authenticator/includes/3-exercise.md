<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
Prepare your Azure AD environment by completing prerequisites. 

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Enable remote employees for Microsoft Authenticator and enable a registration campaign to nudge them to set up Microsoft Authenticator when they sign in.

:::image type="content" border="true" source="../media/registration-campaign.png" alt-text="Screenshot of how to enable a registration campaign for Microsoft Authenticator.":::

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
When you are finished, you'll be ready to validate the user experience. You'll create an Azure AD account for testing and add the account to the remote employees group. Then you'll sign in and perform MFA. After MFA completes, you'll set up Microsoft Authenticator as the default sign-in method. 

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

## Verify remote employees are enabled for Microsoft Authenticator

Before enabling a registration campaign, make sure prerequisites are complete. The users need to be enabled to use Microsoft Authenticator for authentication, and the Authentication mode must be set to **Any** or **Push**. 

1. In the Azure AD portal, click **Security** > **Authentication methods** > **Policies**. 
1. Click **Microsoft Authenticator**, click **Enabled**, select **Remote employees**.
1. In the contextual menu, click **Configure**, set **Authentication mode** to **Any** or **Push**, and click **Done**. 
1. Click **Save**.

## Exercise: Enable the registration campaign using the Azure AD portal

The easiest way to create the registration campaign is to use the Azure AD portal. You can also use Microsoft Graph API if you want to include the task of registering users for Microsoft Authenticator in any automation you use for adding new employees. 

Your company is concerned about sign-ins from users in your **Remote employees** security group. Let's use the portal to enable a registration campaign for that group. You'll want to nudge remote employees to set up Microsoft Authenticator every time they sign in, set the snooze to 0.

1. In the Azure AD portal, sign in as either authentication policy administrator or global administrator.
1. Click **Security** > **Authentication methods** > **Registration campaign**.
1. Change **State** to **Enabled**.
1. For **Day allowed to snooze**, select **0 days**. Remote employees will be prompted to set up Microsoft Authenticator every time they sign in. 
1. Click Add users and groups, search for **Remote employees**, click the group name, and click **Select**
1. When you are done, click **Save**.

   :::image type="content" border="true" source="../media/remote-employees.png" alt-text="Screenshot of adding remote employees group.":::


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

The next unit will help you walk through the user experience in more detail. 

1. Create an Azure AD user account for testing and add it to the remote employees group.
1. Enable the test user for Microsoft Authenticator. 
1. Sign in as the test user, perform MFA, and follow the steps to set up Microsoft Authenticator.
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
