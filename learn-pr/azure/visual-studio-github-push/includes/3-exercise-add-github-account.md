<!-- Guidance on writing the opening to an exercise unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

Signing in to a GitHub account via Visual Studio will allow you to access your GitHub resources within Visual Studio. You can still use the basic Git tooling in Visual Studio without signing in to GitHub. But to create new repositories and push to GitHub, you'll need to sign in.
In this exercise, you'll add a GitHub account to your Visual Studio keychain and authenticate to use GitHub resources with Visual Studio 2019.

<!-- 

See here for general guidance on exercise units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-exercise-content?branch=master

The titles of exercise units specified in the YAML should be prefixed with "Exercise - ".

If your module uses sample code or other supporting resources, talk to your contact on the Learn team about creating an official GitHub repository for the module in the MicrosoftDocs organization. Check with your contact before using code or resources from any other source, including official Microsoft sources.

SANDBOXES: There's lots to know about sandbox restrictions, limitations and initial setup - it's best to talk to your contact on the Learn team. The following guidance focuses on actually using the sandbox within your content:

- YAML and resource group referencing: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-use-sandbox?branch=master
- Cloud shell: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-use-the-cloudshell?branch=master
- Azure portal: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-use-azure-portal?branch=master
- Task validation - confirming resource creation and configuration: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-add-task-validation?branch=master

-->

1. Make sure you have the latest version of Visual Studio 2019 installed. Launch Visual Studio, go to the **Help** menu, and **Check for Updates**. 

2. If you're not already signed in to Visual Studio, select the **Sign in** button in the top right corner of the Visual Studio window. Continue to sign in with your work or personal account.

3. Once you're signed in to Visual Studio, you'll see an avatar button in the top right corner. Select it and select **Account settings..** from the dropdown.

4. In the Account Settings window, select the **Add** button next to All Accounts. Select **GitHub**.

5. You'll be redirected to your default browser to the GitHub login page. Enter your GitHub credentials and select **Sign in**. You may be required to enter an authentication code for Two-factor authentication.

6. You'll get a success message, and you're signed in, that's it!

You can verify by going back to Visual Studio. The Account Settings window will now show your GitHub account added under the All Accounts section.
