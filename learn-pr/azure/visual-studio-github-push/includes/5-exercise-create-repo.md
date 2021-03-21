<!-- Guidance on writing the opening to an exercise unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

Visual Studio can help you create a local Git repository and push it to GitHub.com with a single click. The IDE automates many steps for you and makes it easy to back up and share your project. In this exercise, you'll create a new console application, and publish it to GitHub.

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

:::image type="content" source="../media/5-create-new-project-menu.png" alt-text="Screenshot of Visual Studio File menu for new project":::

2. Type in 'console application' in the search box, and select the C# Console Application from the search results. Select **Next** to get to the next screen. 

:::image type="content" source="../media/5-create-a-new-project-dialog.png" alt-text="Screenshot of create a new project dialog":::

3. In the **Configure your new project** page, you can keep the defaults and select **Next** again.

:::image type="content" source="../media/5-configure-project-screen.png" alt-text="Screenshot of configure your new project screen":::

4. Keep the defaults in the **Additional information** page and select **Create**. 

:::image type="content" source="../media/5-additional-information-screen.png" alt-text="Screenshot of additional information for new project screen":::

Your new project will be created and you can see the contents in Solution Explorer.

:::image type="content" source="../media/5-solution-explorer.png" alt-text="Screenshot of Solution Explorer":::

## Push the project to GitHub

Now you'll initialize a Git repository at the project root directory, create a new repository on GitHub, and push the repository contents to GitHub. To do this, Visual Studio has a **Create a Git repository** dialog box. You can access this window through the Git menu, the Git Changes window, or the status bar control. We'll use the Git Changes window.

1. In Visual Studio, go to **View > Git Changes** to activate the tool window. 

:::image type="content" source="../media/5-view-git-changes-menu.png" alt-text="Screenshot of Visual Studio View menu":::

In its empty state, the Git Changes window provides you with entry points to create, clone, or open repositories. When populated, the window will show you the changes in your currently open repository and allow you to commit. 

2. Select the **Create Git Repository...** button.

:::image type="content" source="../media/5-git-changes-create-repo.png" alt-text="Screenshot of empty Git Changes window":::

3. In the Create a Git repository dialog, verify the local path of your project. Visual Studio will auto-populate the Account and Owner since you're signed in to GitHub. Verify the Repository name and Private repository checkbox. 

:::image type="content" source="../media/5-create-repo-dialog.png" alt-text="Screenshot of Create a new repository dialog":::

4. Select **Create and Push**

The dialog will close and you'll see progress of your repository's creation in the Git Changes window and the Output window.

## Verify creation of the new repository

You can validate the successful creation of your repository in two ways, locally and remotely. 

1. Go to **View > Git Repository** to open the Git Repository tool window. Here you can see all the local and remote branches of your repository, and the history of commits for each branch. 

2. Select your default branch 'main' to refresh the history graph for the branch. You'll see the two initial commits that Visual Studio made to create your repository.

3. Now go to **Git > Manage remotes** to open the Settings dialog. Here you'll see that Visual Studio has added one remote to your repository under the name origin. Origin is the default remote that will be used for fetching, pulling, and pushing commits. You can also add multiple remotes here in case you use a repository that is forked from an upstream remote.

4. Select **Edit** and copy the url link from the field. 

5. Go to your default web browser and paste the link. You'll see the repository webpage on GitHub.com. 