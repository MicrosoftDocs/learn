The team has been slowly integrating a DevOps strategy into their processes. In this section, you make sure that your environment reflects the team's efforts so far.

To do this, you:

> [!div class="checklist"]
> * Add a user to ensure Azure DevOps can connect to your Azure subscription.
> * Set up an Azure DevOps project for this module.
> * Add the build pipeline.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

Although you don't need an Azure subscription to work with Azure DevOps, here you'll use Azure DevOps to deploy to Azure resources that exist in your Azure subscription. To simplify the process, sign in to both your Azure subscription and your Azure DevOps organization under the same Microsoft account.

If you use different Microsoft accounts to sign in to Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account you use to sign in to Azure. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser). When you add the user, choose the **Basic** access level.

Then sign out of Azure DevOps and sign in again under the Microsoft account you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Make sure your Azure DevOps organization is set up to complete the rest of this module. You do this by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression as you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up everything for you in your Azure DevOps organization.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=create-release-pipeline&azure-portal=true)

From the Azure DevOps Demo Generator site, follow these steps to run the template:

1. Select **Sign In** and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization and enter a project name, such as *Space Game - web - Release*.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Screenshot of the Azure DevOps Demo Generator web site showing the process to create the project.":::

1. Select **Yes, I want to fork this repository** > **Authorize**.

    If a window appears, authorize access to your GitHub account.

    > [!IMPORTANT]
    > You need to select this option so the template will connect to your GitHub repository. Select it even if you've already forked the _Space Game_ website project. The template uses your existing fork.

1. Select **Create Project**.

    The template takes a few moments to run.

1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-release-pipeline/8-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

## Prepare Visual Studio Code

Set up Visual Studio Code so you can build the website locally and work with source files.

Visual Studio Code comes with an integrated terminal so you can edit files and work from the command line, all from one place.

1. Start Visual Studio Code.
1. On the **View** menu, select **Terminal**.
1. In the drop-down list, select **bash**. If you're familiar with another Unix shell that you prefer to use, such as Zsh, select that shell instead.

    :::image type="content" source="../../shared/media/vscode-terminal-bash.png" alt-text="Screenshot of Visual Studio Code showing where to locate the Bash shell.":::

    The terminal window lets you choose any shell that's installed on your system, like Bash, Zsh, and PowerShell.

    Here you'll use Bash. Git for Windows provides Git Bash, which makes it easy to run Git commands.

    [!include[](../../shared/includes/troubleshoot-code-terminal.md)]

1. Run the `cd` command to navigate to the directory you want to work from, like your home directory (`~`). You can choose a different directory if you want.

    ```bash
    cd ~
    ```

### Configure Git

If you're new to Git and GitHub, you'll first need to run a few commands to associate your identity with Git and authenticate with GitHub. For more information, see [Set up Git](https://help.github.com/articles/set-up-git?azure-portal=true).

At a minimum, you'll need to complete the following steps. Run these commands from the Visual Studio Code integrated terminal:

1. [Set your username](https://help.github.com/articles/setting-your-username-in-git?azure-portal=true).
1. [Set your commit email address](https://help.github.com/articles/setting-your-commit-email-address-in-git?azure-portal=true).
1. [Cache your GitHub password](https://help.github.com/articles/caching-your-github-password-in-git?azure-portal=true).

> [!NOTE]
> If you're already using two-factor authentication with GitHub, [create a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line?azure-portal=true). Use your token in place of your password when you're prompted later.
>
> Treat your access token like you would treat a password. Keep it in a safe place.

## Set up your project in Visual Studio Code

In the [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true) learning path, you forked and then cloned a Git repository that contains the source code for the _Space Game_ website. Your fork was connected to your projects in Azure DevOps so that the build runs when you push changes to GitHub.

> [!IMPORTANT]
> In this learning path, we switch to a different Git repository, [mslearn-tailspin-spacegame-web-deploy](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy?azure-portal=true). When you ran the template to set up your Azure DevOps project, the process forked the repository automatically for you.

In this part, you clone your fork locally so that you can make changes and build out your pipeline configuration.

### Clone your fork locally

You now have a copy of the *Space Game* web project in your GitHub account. Now you'll download, or *clone*, a copy to your computer so you can work with it.

A clone, just like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify they work as you expect, and then upload those changes back to GitHub. You can also synchronize your local copy with changes that other authenticated users have made to GitHub's copy of your repository.

To clone the *Space Game* web project to your computer:

1. On [GitHub](https://github.com?azure-portal=true), go to your fork of the *Space Game* web project (**mslearn-tailspin-spacegame-web-deploy**).
1. Select **Code**. Then, from the **HTTPS** tab, select the button next to the URL that's shown to copy the URL to your clipboard.

    :::image type="content" source="../../shared/media/github-clone-button.png" alt-text="Locating the URL and copy button from the GitHub repository.":::
1. In Visual Studio Code, go to the terminal window.
1. In the terminal, move to the directory you want to work from, like your home directory (`~`). You can choose a different directory if you want.

    ```bash
    cd ~
    ```

1. Run the `git clone` command. Replace the URL that's shown here with the contents of your clipboard:

    ```bash
    git clone https://github.com/your-name/mslearn-tailspin-spacegame-web-deploy.git
    ```

1. Move to the *mslearn-tailspin-spacegame-web-deploy* directory. This directory is the root of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web-deploy
    ```

### Set the upstream remote

A *remote* is a Git repository where team members collaborate (like a repository on GitHub). Here you list your remotes and add a remote that points to Microsoft's copy of the repository so that you can get the latest sample code.

1. Run this `git remote` command to list your remotes:

    ```bash
    git remote -v
    ```

    You see that you have both fetch (download) and push (upload) access to your repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (push)
    ```

    *Origin* specifies your repository on GitHub. When you fork code from another repository, the original remote (the one you forked from) is commonly named *upstream*.

1. Run this `git remote add` command to create a remote named *upstream* that points to the Microsoft repository:

    ```bash
    git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy.git
    ```

1. Run `git remote` a second time to see the changes:

    ```bash
    git remote -v
    ```

    You see that you still have both fetch (download) and push (upload) access to your repository. You also now have fetch access from the Microsoft repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (push)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy.git (fetch)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy.git (push)
    ```

### Open the project in the file explorer

In Visual Studio Code, your terminal window points to the root directory of the *Space Game* web project. To view its structure and work with files, from the file explorer, you'll now open the project.

1. The easiest way to open the project is to reopen Visual Studio Code in the current directory. To do so, run the following command from the integrated terminal:

    ```bash
    code -r .
    ```

    You see the directory and file tree in the file explorer.
1. Reopen the integrated terminal. The terminal places you at the root of your web project.

If the `code` command fails, you need to add Visual Studio Code to your system PATH. To do so:

1. In Visual Studio Code, select <kbd>F1</kbd> or select **View** > **Command Palette** to access the command palette.
1. In the command palette, enter *Shell Command: Install 'code' command in PATH*.
1. Repeat the previous procedure to open the project in the file explorer.

You're now set up to work with the _Space Game_ source code and your Azure Pipelines configuration from your local development environment.

### Fetch the branch from GitHub

Here you fetch the `release-pipeline` branch from GitHub and check out, or switch to, that branch.

This branch contains the _Space Game_ project that you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.

1. Run the following `git` commands to fetch a branch named `release-pipeline` from the Microsoft repository, and then switch to that branch.

    ```bash
    git fetch upstream release-pipeline
    git checkout -B release-pipeline upstream/release-pipeline
    ```

    The format of this command enables you to get starter code from the Microsoft GitHub repository, known as `upstream`. Shortly, you'll push this branch to your GitHub repository, known as `origin`.

1. As an optional step, in Visual Studio Code, open the *azure-pipelines.yml* file and familiarize yourself with the initial configuration.

    The configuration resembles the basic one you created in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline/6-create-the-pipeline?azure-portal=true) module. It builds only the application's Release configuration.

    [!include[](../../shared/includes/pipeline-branches-note.md)]

## Run the pipeline

At this point, you have:

* A fork of the **mslearn-tailspin-spacegame-web-deploy** repository in your GitHub account.
* The **mslearn-tailspin-spacegame-web-deploy** repository cloned locally.
* A branch named `release-pipeline` that contains the web site source code and an initial Azure Pipelines configuration.

Next, you'll manually trigger the pipeline to run. This step ensures that your project is set up to build from your GitHub repository. The initial pipeline configuration builds the application and produces a builds artifact. Shortly, you'll add a stage that deploys the build artifact to Azure App Service.

1. In Azure DevOps, go to your project.

1. Select **Pipelines** from the resource menu.

1. You see that your pipeline has not yet been run.

    :::image type="content" source="../media/4-pipeline-no-runs.png" alt-text="Screenshot of Azure Pipelines showing the pipeline for this project. The pipeline has no runs.":::

1. Select your pipeline, **mslearn-tailspin-spacegame-web-deploy**.

1. Select **Run pipeline**.

    :::image type="content" source="../media/4-pipeline-run-first.png" alt-text="Screenshot of Azure Pipelines showing the location of the Run pipeline button.":::

1. From the **Run pipeline** window that appears, set **Branch/tag** to *release-pipeline*. Then select **Run**.

1. In Azure Pipelines, go to the build and trace it as it runs.

    :::image type="content" source="../../shared/media/pipeline-trace-build.png" alt-text="Screenshot of Azure Pipelines showing the running job.":::

1. After the build finishes, select the back button to return to the summary page.

    :::image type="content" source="../../shared/media/pipeline-navigate-pipeline-summary.png" alt-text="Screenshot of Azure Pipelines showing how to navigate to the summary page.":::

1. On the summary page, select your published artifact.

    :::image type="content" source="../../shared/media/pipeline-navigate-published-artifact.png" alt-text="Screenshot of Azure Pipelines showing the location of the link to the published artifact.":::

1. From the **Published artifacts** page, expand the **drop** folder.

    You see a _.zip_ file that contains your built application and its dependencies. This is your build artifact.

    :::image type="content" source="../../shared/media/pipeline-view-published-artifact.png" alt-text="Screenshot of Azure Pipelines showing the published artifact. The artifact includes a .zip file.":::

    You can manually download and install the build artifact in your own environment, just as Amita did in the previous learning path. In this module, you add a deployment stage that automatically deploys the build artifact to Azure App Service.

You now have a build pipeline for the _Space Game_ web project. Next you add the deployment stage to the pipeline.
