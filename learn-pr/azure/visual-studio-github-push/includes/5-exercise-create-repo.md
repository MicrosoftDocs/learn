<!-- Guidance on writing the opening to an exercise unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

Visual Studio can help you create a local Git repository and push it to GitHub.com with a single click. This automates many steps for you and makes it easy to backup and share your project. In this exercise, you'll create a new console application, and publish it to GitHub.

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
## Create a new project

The easiest way to start coding in Visual Studio, is with a project template. Visual Studio project templates provide the code scaffolding under Visual Studio solutions so that you can build and run your project easily. Here we'll create a new .NET console application project in C#.

1. In Visual Studio, go to **File > New > Project** to open the **Create a new project** dialog.

2. Type in 'console application' in the search box, and select the C# Console Application from the search results. 

3. Select **Next** to get to the **Configure your new project** page. You can keep the defaults and select **Next** again.

4. Keep the defaults in the **Additional information** page and click **Create**. 

Your new project will be created and you can see the contents in Solution Explorer.

## Push the project to GitHub

Now you will initialize a Git repository at the project root directory, create a new repository on GitHub, and push the repository contents to GitHub. To do this, Visual Studio has a **Create a Git repository** dialog box. You can access this window through the Git menu, the Git Changes window, or the status bar control. We'll use the Git Changes window.

1. In Visual Studio, go to **View > Git Changes** to activate the tool window. In its empty state, the Git Changes window provides you with entry points to create, clone, or open repositories. When populated, the window will show you the changes in your currently open repository and allow you to commit. 

Click the **Create Git Repository...** button.

2. In the Create a Git repository dialog, verify the local path of your project. The Account and Owner should already be populated since you are signed in to GitHub. Verify the repository name and Private repository checkbox. 

3. Click **Create and Push**

The dialog will close and you will see progress of your repository's creation in the Git Changes window and the Output window

## Verify creation of the new repository

You can validate the successful creation of your repository in two ways, locally and remotely. 

1. Go to **View > Git Repository** to open the Git Repository tool window. Here you can see all the local and remote branches of your repository, as well as the history of commits for each branch. 

2. Click on your default branch 'main' (yours may also be called master) to refresh the history graph for the branch. You will see the two initial commits that Visual Studio made to create your repository.

3. Now go to **Git > Manage remotes** to open the Settings dialog. Here you will see that one remote has been added to your repository under the name origin. This is the default remote that will be used for fetching, pulling, and pushing commits. You can also add multiple remotes here in case you use a repository that is forked from an upstream remote.

4. Click on **Edit** and copy the url link from the field. 

5. Go to your default web browser and paste the link. You will see the repository webpage on GitHub.com. 