Visual Studio can help you create a local Git repository and push it to GitHub.com with a single click. The IDE automates many steps for you and makes it easy to back up and share your project. In this exercise, you'll create a console application and publish it to GitHub.

## Create a project

The easiest way to start coding in Visual Studio is with a project template. Visual Studio project templates provide the code scaffolding under Visual Studio solutions so that you can build and run your project easily. Here we'll create a .NET console application project in C#.

1. In Visual Studio, go to **File** > **New** > **Project**.

    :::image type="content" source="../media/5-create-new-project-menu.png" alt-text="Screenshot of the Visual Studio File menu and the selections for creating a project.":::

2. In the **Create a new project** dialog, enter **console application** in the search box, and select **C# Console Application** from the search results. Then select **Next**. 

    :::image type="content" source="../media/5-create-a-new-project-dialog.png" alt-text="Screenshot of the dialog for creating a project, with the search box and Next button highlighted.":::

3. On the **Configure your new project** page, keep the defaults and select **Next**.

    :::image type="content" source="../media/5-configure-project-screen.png" alt-text="Screenshot of the page for configuring your new project, with the Next button highlighted.":::

4. On the **Additional information** page, keep the defaults and select **Create**.

    :::image type="content" source="../media/5-additional-information-screen.png" alt-text="Screenshot of the page for additional information about the new project, with the Create button highlighted.":::

Your new project is created, and you can see the contents in Solution Explorer.

:::image type="content" source="../media/5-solution-explorer.png" alt-text="Screenshot of Solution Explorer.":::

## Push the project to GitHub

Now you'll initialize a Git repository at the project root directory, create a repository on GitHub, and push the repository's contents to GitHub. Visual Studio has a **Create a Git repository** dialog for these actions. You can access it through the **Git** menu, the **Git Changes** window, or the status bar control. We'll use the **Git Changes** window.

1. In Visual Studio, go to **View** > **Git Changes**.

    :::image type="content" source="../media/5-view-git-changes-menu.png" alt-text="Screenshot of the Visual Studio View menu with the Git Changes item highlighted.":::

    The **Git Changes** window opens. In its empty state, the window provides entry points where you can create, clone, or open repositories. When the window is populated, it shows you the changes in your currently open repository and allows you to commit.

2. Select the **Create Git Repository** button.

    :::image type="content" source="../media/5-git-changes-create-repo.png" alt-text="Screenshot of the empty Git Changes window with the Create Git Repository button highlighted.":::

3. In the **Create a Git repository** dialog, verify the local path of your project. Visual Studio automatically populates the **Account** and **Owner** boxes because you're signed in to GitHub. Verify the **Repository name** value, and make sure that the **Private repository** checkbox is selected. 

    :::image type="content" source="../media/5-create-repo-dialog.png" alt-text="Screenshot of the dialog for creating a new repository.":::

4. Select **Create and Push**.

The dialog closes. You can track the progress of your repository's creation in the **Git Changes** window and the **Output** window.

## Verify creation of the new repository

You can validate the successful creation of your repository locally and remotely.

1. Go to **View** > **Git Repository**.  

    :::image type="content" source="../media/5-view-git-repository.png" alt-text="Screenshot of the View menu with the Git Repository item highlighted.":::

    The **Git Repository** window opens. Here, you can see all the local and remote branches of your repository, along with the history of commits for each branch.

2. Select your default branch to refresh the history graph for the branch. You can now see the two initial commits that Visual Studio made to create your repository.

    :::image type="content" source="../media/5-git-repo-window.png" alt-text="Screenshot of the Git Repository window with the main branch.":::

3. Go to **Git** > **Manage Remotes**.

    :::image type="content" source="../media/5-git-manage-remotes.png" alt-text="Screenshot of the Git menu with the Manage Remotes item highlighted.":::

4. The **Options** dialog shows that Visual Studio has added one remote to your repository under the name **origin**. The **origin** remote is the default remote that will be used for fetching, pulling, and pushing commits. You can also add multiple remotes here, if you use a repository that's forked from an upstream remote. Select **Edit**.

    :::image type="content" source="../media/5-remotes-settings.png" alt-text="Screenshot of the Remotes page in settings, with the Edit button highlighted.":::

5. Copy the URL from the **Fetch** box.

    :::image type="content" source="../media/5-origin-url-link.png" alt-text="Screenshot of the dialog for editing the remote origin, with the fetch URL highlighted.":::

6. Go to your default web browser and paste the link. The repository webpage opens on GitHub.com.

    :::image type="content" source="../media/5-repo-in-browser.png" alt-text="Screenshot of the repository's GitHub webpage.":::

Your Git repository has been created and stored both locally and remotely.
