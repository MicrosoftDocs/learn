TODO

During the process, you'll: 

> [!div class="checklist"]
> * Create a remote repository.
> * Configure your local Git repository to integrate with the remote repository.
> * Push your changes from your local repository to the remote repository.
> * Verify that the changes appear in the remote repository.

::: zone pivot="github"

## Create a repository in GitHub

1. In a browser, navigate to [GitHub](https://www.github.com?azure-portal=true). Sign in using your GitHub account, or create a new account if you don't already have one.

1. Once you're signed in to GitHub, select the + icon in the top right of the window, and select **New repository**.

   :::image type="content" source="../media/9-github-new-repository-menu.png" alt-text="Screenshot of the GitHub interface showing the menu with the 'New repository' item highlighted." border="true":::

1. Enter the details of your new repository:

   - **Repository name**: Use a meaningful but short name. Here, you use `toy-website`.
   - **Description**: Include a description to help others understand what the repository is for.
   - **Private**: You can use GitHub to create public and private repositories. Create a private repository, since your toy website's files should only be accessed by people inside your organization. You can grant access to others later.
   - Leave the repository initialization checkboxes unselected.

   After you're done, your repository configuration should look like the following:

   :::image type="content" source="../media/9-github-new-repository-details.png" alt-text="Screenshot of the GitHub interface showing the configuration for the repository to create." border="true":::

1. Select **Create repository**.

1. On the confirmation page that appears, copy the repository's URL. You'll use this in the next step.

   :::image type="content" source="../media/9-github-new-repository-confirmation.png" alt-text="Screenshot of the GitHub interface showing the new repository's details, with the repository's URL highlighted." border="true":::

   Keep your browser open. You'll check on the GitHub repository again shortly.

::: zone-end

::: zone pivot="azure-repos"

## Create a repository in Azure Repos

1. In a browser, navigate to [dev.azure.com](https://dev.azure.com?azure-portal=true). Sign in or create a new account.

1. If you're creating a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then asks you to create a new project. Continue to the next step.

   If you signed in to an existing Azure DevOps organization, select the **New project** button to create a new project.

   :::image type="content" source="../media/9-azure-devops-create-project.png" alt-text="Screenshot of the Azure DevOps interface showing the button to create a new project. border="true":::

1. Enter the details of your new project:

   - **Project name**: Use a meaningful but short name. Here, you use `toy-website`.
   - **Visibility**: You can use Azure DevOps to create public and private repositories. Create a private repository, since your toy website's files should only be accessed by people inside your organization. You can grant access to others later.

   After you're done, your project configuration should look like the following:

   :::image type="content" source="../media/9-azure-devops-new-project-details.png" alt-text="Screenshot of the Azure DevOps interface showing the configuration for the project to create." border="true":::

1. Select **Create project**.

1. On the project page that appears, select the **Repos** menu item.

   :::image type="content" source="../media/9-azure-devops-repos-menu.png" alt-text="Screenshot of the Azure DevOps interface showing the menu, with the Repos item highlighted." border="true":::

1. Copy the repository's URL. You'll use this in the next step.

   :::image type="content" source="../media/9-azure-devops-repo-details.png" alt-text="Screenshot of the Azure Repos interface showing the repository's details, with the repository's URL highlighted." border="true":::

   Keep your browser open. You'll check on the repository again shortly.

::: zone-end

## Configure your local Git repository

1. In the Visual Studio Code terminal, enter the following command to integrate your local repository with the remote repository that you just created. Make sure you replace `YOUR_REPOSITORY_URL` with the URL you copied in the previous step.

   ```bash
   git remote add origin YOUR_REPOSITORY_URL
   ```

   Notice that you're using the command `git remote add` to create a new reference to a remote repository. You name the reference `origin`, which is the standard name you use - but you can use any name you want.

## Push your changes by using the Git CLI

::: zone pivot="github"

1. In the Visual Studio Code terminal, enter the following command:

   ```bash
   git push -u origin main
   ```

   Since your current local branch is **main**, this command tells Git that your local **main** branch _tracks_ the **main** branch in your remote repository. It also _pushes_ the commits from your local repository to the remote.

1. This is the first time you've used this repository, so the terminal prompts you to select how to authenticate. Choose the option to use the browser.

1. Follow the instructions in the browser to sign in.

1. GitHub asks you to authorize Git Credential Manager to access your repository. Review the request and select **Authorize GitCredentialManager**.

   :::image type="content" source="../media/9-github-vscode-authorize.png" alt-text="Screenshot of the GitHub interface showing a prompt to authorize Git Credential Manager to access the repository." border="true":::

1. In your terminal window, Git displays output similar to the following:

   ```output
   Enumerating objects: 10, done.
   Counting objects: 100% (10/10), done.
   Delta compression using up to 4 threads
   Compressing objects: 100% (4/4), done.
   Writing objects: 100% (10/10), 1.01 KiB | 515.00 KiB/s, done.
   Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
   To https://github.com/mygithubuser/toy-website.git
    * [new branch]      main -> main
   Branch 'main' set up to track remote branch 'main' from 'origin'.
   ```

   This indicates that Git successfully pushed the contents of your repository to the remote.

::: zone-end

::: zone pivot="azure-repos"

1. In the Visual Studio Code terminal, enter the following command:

   ```bash
   git push -u origin main
   ```

   Since your current local branch is **main**, this command tells Git that your local **main** branch _tracks_ the **main** branch in your remote repository. It also _pushes_ the commits from your local repository to the remote.

1. This is the first time you've used this repository, you are prompted to sign in. Enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

1. In your terminal window, Git displays output similar to the following:

   ```output
   Enumerating objects: 10, done.
   Counting objects: 100% (10/10), done.
   Delta compression using up to 4 threads
   Compressing objects: 100% (4/4), done.
   Writing objects: 100% (10/10), 1.01 KiB | 343.00 KiB/s, done.
   Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
   remote: Analyzing objects... (10/10) (5 ms)
   remote: Storing packfile... done (165 ms)
   remote: Storing index... done (75 ms)
   To https://dev.azure.com/myuser/toy-website/_git/toy-website
    * [new branch]      main -> main
   Branch 'main' set up to track remote branch 'main' from 'origin'.
   ```

   This indicates that Git successfully pushed the contents of your repository to the remote.

::: zone-end

## Push again by using Visual Studio Code

You just pushed all of your changes, so there's no need to push again. However, it's good to see how you push changes by using Visual Studio Code, so here you push an empty set of changes.

1. Open the **Source Control** panel in Visual Studio Code.

1. Select the icon with three dots on the right side of the **Source Control** panel's toolbar, then select **Push**:

   :::image type="content" source="../media/9-vscode-push.png" alt-text="Screenshot of Visual Studio Code showing the Source Control panel's menu, with the Push menu item highlighted." border="true":::

   Notice that you're not prompted to sign in again. Your Git credentials are shared between the Git CLI and Visual Studio Code.
   <!-- TODO check that applies to macOS -->

::: zone pivot="github"

## Verify that the changes show in GitHub

Now that you've pushed your changes to your remote repository, you can inspect the contents of the repository on GitHub.

1. In your browser, refresh the repository's page.

1. Notice the files you created are now listed:

   :::image type="content" source="../media/9-github-final.png" alt-text="Screenshot of the GitHub interface showing the repository, including the folder and file structure." border="true":::

1. Navigate through the GitHub interface to explore the files, and notice your changes are all displayed. Since GitHub has the full list of changes to each file, you can even view the history of a file, just like you can when you work in Visual Studio Code.

::: zone-end

::: zone pivot="azure-repos"

## Verify that the changes show in Azure Repos

Now that you've pushed your changes to your remote repository, you can inspect the contents of the repository on Azure Repos.

1. In your browser, refresh the **Repos** page.

1. Notice the files you created are now listed:

   :::image type="content" source="../media/9-azure-repos-final.png" alt-text="Screenshot of the Azure DevOps interface showing the repository, including the folder and file structure." border="true":::

1. Navigate through the GitHub interface to explore the files, and notice your changes are all displayed. Since GitHub has the full list of changes to each file, you can even view the history of a file, just like you can when you work in Visual Studio Code.

::: zone-end
