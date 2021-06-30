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

   After you're done, your repository should look like the following:

   :::image type="content" source="../media/9-github-new-repository-details.png" alt-text="Screenshot of the GitHub interface showing the configuration for the repository to create." border="true":::

1. Select **Create repository**. GitHub creates a new Git repository for you.

1. On the confirmation page that appears, copy the repository's URL. You'll use this in the next step.

   :::image type="content" source="../media/9-github-new-repository-confirmation.png" alt-text="Screenshot of the GitHub interface showing the new repository's details, with the repository's URL highlighted." border="true":::

   Keep your browser open. You'll check on the GitHub repository again shortly.

::: zone-end

::: zone pivot="azure-repos"

## Create a repository in Azure Repos

1. TODO sign in to Azure DevOps

1. Create project and repo

1. Note the repo URL

   Keep your browser open. You'll check on the repository again shortly.

::: zone-end

## Configure your local Git repository

1. In the Visual Studio Code terminal, enter the following command to integrate your local repository with the remote repository that you just created. Make sure you replace `YOUR_REPOSITORY_URL` with the URL you copied in the previous step.

   ```bash
   git remote add origin YOUR_REPOSITORY_URL
   ```

   Notice that you're using the command `git remote add` to create a new reference to a remote repository. You name the reference `origin`, which is the standard name you use - but you can use any name you want.

## Push your changes by using the Git CLI

1. In the Visual Studio Code terminal, enter the following command:

   ```bash
   git push -u origin main
   ```

   Since your current local branch is **main**, this command tells Git that your local **main** branch _tracks_ the **main** branch in your remote repository. It also _pushes_ the commits from your local repository to the remote.

1. This is the first time you've used this repository, so the terminal prompts you to select how to authenticate. Choose the option to use the browser.

1. Follow the instructions in the browser to sign in.

1. GitHub asks you to authorize Git Credential Manager to access your repository. Review the request and select **Authorize GitCredentialManager**.
<!-- TODO check above for Azure Repos -->

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

## Push again by using Visual Studio Code

You just pushed all of your changes, so there's no need to push again. However, it's good to see how you push changes by using Visual Studio Code, so here you push an empty set of changes.

1. Open the **Source Control** panel in Visual Studio Code.

1. Select the icon with three dots on the right side of the **Source Control** panel's toolbar, then select **Push**:

   :::image type="content" source="../media/9-vscode-push.png" alt-text="Screenshot of Visual Studio Code showing the Source Control panel's menu, with the Push menu item highlighted." border="true":::

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

TODO

1. Open browser

1. Refresh page

1. Notice the files you created

::: zone-end
