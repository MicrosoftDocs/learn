




## Add a redirect URI

You configure settings for each application type, including redirect URIs, in the **Platform configurations** section. The redirect URI, also known as Reply URL, is the location where the identity platform redirects a user's client and sends security tokens after authentication. During development, this is the endpoint where you run your app locally. To add a redirect URI for your Python Flask web app, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
2. Under **Manage**, select **Authentication**.
3. Under **Platform configurations**, select **Add a platform** 
4. Under **Configure platforms**, select **Web**.
5. Upon selecting web as your app's platform, you'll be prompted to enter a redirect URI for your app. Add `http://localhost:5000/auth/redirect` as the redirect URI for your web app.  
6. Select **Configure**.

## Configure credentials

Credentials are used by confidential client applications, such as web apps, that access a web API. Credentials allow your application to authenticate as itself, requiring no interaction from a user at runtime. You can add certificates, client secrets, or federated credentials to your confidential client app registration. 

In this tutorial, we will use a client secret, also known as an application password. This is a string value that the app can use to prove its identity when requesting a token. To add a client secret, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **Certificates & secrets** 
1. In the **Client secrets** section, select **New client secret**.
1. Under **Add a client secret**, add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in your application's code. This secret value is only shown once when you create it. It will never be displayed again after you leave this page.

## Add app roles to your web application

App roles defined during the app registration process are used to securely enforce authorization in your application. When using app roles, an administrator grants permissions to roles and not to individual users or groups. The administrator can then assign roles to different users and groups to control who has access to what content and functionality. 

In this tutorial, one route requires an application-defined admin app role. To add this role, follow these steps:

1. In the Azure portal, in **App registrations**, select your application.
1. Under **Manage**, select **App roles** and then **Create app role**.
1. In the **Create app role** pane, enter the settings for the role.
    - For the **Display name**, enter `admin`
    - For **Allowed member types:**, select **Users/Groups**
    - For **Value**, enter `admin`
    - For **Description**, add a more detailed app role description such as `admin app role` 
1. Select the checkbox under to enable this app role.
1. Select **Apply** to complete creating the app role.
 

Once you've added the app roles in your application, you can assign users and groups to the roles. To assign users and groups to the created `admin role` using the Azure portal UI:

1. In the Azure portal, select Azure **Active Directory**. 
1. Under **Manage**, select **Enterprise applications**
1. Select **All applications** to view a list of all your applications. If your Python web app doesn't appear in the list, search using the application name or ID. You can also use the filters at the top of the **All applications** list to restrict the list, or scroll down the list to locate your application. 
1. Select the application you want to assign users or groups to roles. In this case, your Python-web-app
1. Under **Manage**, select **Users and groups**.
1. Select **Add user/group** to open the **Add Assignment** pane.
1. Select the **Users and groups** selector from the **Add Assignment** pane. A list of users and security groups is displayed. You can search for a certain user or group as well as select multiple users and groups that appear in the list. For this tutorial, add *yourself* and select the **Select** button to proceed.
1. On the **Select a role** in the **Add assignment** pane, chose the `admin role` you previously created.
1. Select the **Assign butto**n to finish the assignment of users and groups to the app.
1. Confirm that the users and groups you added appear in the **Users and groups** list.

##  Update the application to use your app registration details.

Open the default_settings.py file and modify the three Azure Active Directory configuration properties using the values from your app's registration in the Azure portal.

```Python
# 'Application (client) ID' of app registration in Azure portal - this value is a GUID
CLIENT_ID = ""

# Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
CLIENT_CREDENTIAL = ""

# Full directory URL, in the form of https://login.microsoftonline.com/<tenant>
AUTHORITY = ""
```

<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
TODO: add your scenario sub-task
TODO: add your scenario image

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
TODO: describe the end-state

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

## (Chunk 1 heading)
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## (Chunk 2 heading)
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## (Chunk n heading)
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

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
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
