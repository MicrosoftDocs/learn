Get ready to start building a CI pipeline with Microsoft Azure Pipelines. The first step is to build and run the *Space Game* web app. Understanding how to build software manually will prepare you to repeat the process in the pipeline.

Mara is going to do exactly that, and by following the procedures, you can do the same thing.

::: zone pivot="github-codespaces-agent"  

### Create an Azure DevOps personal access token

1. Sign in to your organization (```https://dev.azure.com/{yourorganization}```). If you don't already have an Azure DevOps organization, create a [free organization](/azure/devops/pipelines/get-started/pipelines-sign-up) before you begin. After you sign in, if you have more than one organization, choose **Azure DevOps** and go to the organization that you plan to use to complete this module. In this example, the name of the organization is `fabrikam`.

    :::image type="content" source="../media/3-choose-organization.png" alt-text="Screenshot of choosing your Azure DevOps organization.":::
  
1. From your home page, open user settings :::image type="icon" source="../media/3-user-settings-gear.png" border="false"::: and select **Personal access tokens**.

1. Select **+ New Token**.

1. Name your token using any name that you prefer. The token is used when the Codespace registers its agent with your Azure DevOps organiation, so you can keep the default expiration.

1. Choose **Show all scopes**.

    :::image type="content" source="../media/3-show-all-scopes.png" alt-text="Screenshot of viewing all scopes for a personal access token.":::

1. Select the following scope: **Agent Pools (Read & manage)**, and choose **Create**.

    :::image type="content" source="../media/3-agent-pools-read-and-manage.png" alt-text="Screenshot of selecting aget pool permissions for a personal access token.":::

1. When you're done, copy the token and store it in a secure location. For your security, it won't be shown again.

> [!WARNING]
> Treat and use a PAT like your password and keep it a secret.

### Create a fork

The first step to using a project in Git is to create a fork so you can work with and modify the source files. A *fork* is a copy of a GitHub repository. The copy exists in your account and lets you make any changes you want without affecting the original project.

Although you can propose changes to the original project, in this lesson, you'll work with the *Space Game* web project as though it was the original project owned by Mara and her team.

> [!NOTE]
> If you have previously forked this repository, for example if you have previously completed this module or another Tailspin Toys training module, we recommend that you [delete your fork](https://docs.github.com/repositories/creating-and-managing-repositories/deleting-a-repository) and create a new fork using the following steps. If you don't want to delete your fork, ensuring that you [sync your fork](https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork).

Let's fork the *Space Game* web project into your GitHub account:

1. In a web browser, go to [GitHub](https://github.com?azure-portal=true), and sign in.

1. Go to the [Space Game](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web?azure-portal=true) web project.

1. Select **Fork**:

    :::image type="content" source="../media/3-github-fork-button.png" alt-text="Screenshot of GitHub showing the location of the Fork button.":::

1. To fork the repository into your account, follow the instructions.


## Set up secrets for self-hosted agent

Before you create your Codespace, you'll create three passwords that help your self-hosted Azure DevOps agent run. In production, you wouldn't want to use a self-hosted agent in GitHub Codespaces. However, since your team is using Codespaces for testing, this is a good temporary solution when you are building your pipelines.  

1. Go to your forked GitGub repository and select **Settings** > **Secrets and variables** > **Codespaces**.

    :::image type="content" source="../media/3-add-codespaces-secret.png" alt-text="Screenshot of GitHub Codespaces secrets. ":::

1. Create three new Codespaces Repository secrets.
    
    |Name  |Value  |
    |---------|---------|
    |ADO_ORG     |   Name of the Azure DevOps organization you're using to complete this module. In this example, `fabrikam` is the name of the orgnization.    |
    |ADO_PAT     |   Personal Access Token value      |
    |ADO_POOL_NAME     |   Name of agent pool. Specify `Default` to use the default agent pool. If you use a name other than `Default`, you need to [create a new agent pool](/azure/devops/pipelines/agents/pools-queues) and provide tha name of the new agent pool for this value. | 
    
## Set up Codespaces

Next, you'll set up Codespaces so that you can build the website, work with source files, and run your pipeline using a self-hosted agent.

1. In your forked GitHub repository, select **Code**, select **Code** again, choose the **Codespaces** tab, and choose **+** to create a new Codespace.

    :::image type="content" source="../media/3-create-new-options-codespaces.png" alt-text="Screenshot of create a new Codespace with options. ":::

1. Wait for your Codespace to build. When the build completes, you'll be redirected to an online version of Visual Studio Code. Your Codespace comes with a fresh installation of Visual Studio Code, similar to if you had just installed Visual Studio Code on your local machine. When the Codespace first starts, Visual Studio Code online may prompt you to provide certain configuration or ask you about preferences. You may choose the preferences that suit your Visua Studio Code usage style.

### Set the upstream remote

A *remote* is a Git repository where team members collaborate (similar to a repository on GitHub). Let's list your remotes and add a remote that points to Microsoft's copy of the repository so you can get the latest sample code.

1. In the Visual Studio Code online editor, go to the terminal window, and choose **bash** from the right-hand side.

    :::image type="content" source="../media/3-terminal-window.png" alt-text="Screenshot of terminal window in Visual Studio Code online editor. ":::

1. To list your remotes, run the `git remote` command:

    ```bash
    git remote -v
    ```

    You have both fetch (download) and push (upload) access to your repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    ```

    *Origin* specifies your repository on GitHub. When you fork code from another repository, it's common to name the original remote (the one you forked from) *upstream*.

1. To create a remote named *upstream* that points to the Microsoft repository, run this `git remote add` command:

    ```bash
    git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git
    ```

1. Run `git remote` a second time to see the changes:

    ```bash
    git remote -v
    ```

    You see that you still have both fetch (download) and push (upload) access to your repository. You also now have fetch access from the Microsoft repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git (fetch)
    ```

## Build and run the web app

1. In the Visual Studio Code online editor, navigate to the terminal window, and to build the app, run this `dotnet build` command:

    ```dotnetcli
    dotnet build --configuration Release
    ```

1. From the terminal window, to run the app, run this `dotnet run` command:

    ```dotnetcli
    dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web
    ```

    .NET solution files can contain more than one project. The `--project` argument specifies the project for the *Space Game* web app.

## Verify the application is running

In development mode, the *Space Game* website is configured to run on port 5000.

You'll see a new message in the Visual Studio editor that your application is running on port 5000 is available. Select **Open in Browser** to go to the app running.

:::image type="content" source="../media/3-port-forwarding-message.png" alt-text="Screenshot of port forwarding Codespaces message. ":::

In the new browser window, you'll see this:

:::image type="content" source="../media/3-space-game-top.png" alt-text="Screenshot of a web browser showing the Space Game web site.":::

You can interact with the page, including the leaderboard. When you select a player's name, you see details about that player:

:::image type="content" source="../media/3-space-game-leaderboard-profile.png" alt-text="Screenshot of a web browser showing the Space Game leaderboard.":::

When you're finished, return to the terminal window, and to stop the running app, select Ctrl+C.

::: zone-end  

::: zone pivot="ms-hosted-agents"

## Prepare Visual Studio Code

First, you'll set up Visual Studio Code so you can build the website locally and work with source files.

Visual Studio Code comes with an integrated terminal, so you can edit files and work from the command line all in one place.

1. Start Visual Studio Code.
1. On the **View** menu, select **Terminal**.
1. In the dropdown, select **bash**:

    :::image type="content" source="../../shared/media/vscode-terminal-bash.png" alt-text="Screenshot of selecting the Bash shell in Visual Studio Code.":::

    The terminal window lets you select any shell that's installed on your system, like Bash, Zsh, and PowerShell.

    Here, you'll use Bash. Git for Windows provides Git Bash, which makes it easy to run Git commands.

    [!include[](../../shared/includes/troubleshoot-code-terminal.md)]

1. To navigate to the directory you want to work from, like your home directory (`~`), run the `cd` command. You can select a different directory if you want.

    ```bash
    cd ~
    ```

## Configure Git

If you're new to Git and GitHub, to associate your identity with Git and authenticate with GitHub, you'll first need to run a few commands.

[Set up Git](https://help.github.com/articles/set-up-git?azure-portal=true) explains the process in greater detail.

At a minimum, you'll need to complete the following steps. From the Visual Studio Code integrated terminal, run these commands.

1. [Set your username](https://help.github.com/articles/setting-your-username-in-git?azure-portal=true).
1. [Set your commit email address](https://help.github.com/articles/setting-your-commit-email-address-in-git?azure-portal=true).
1. [Cache your GitHub password](https://help.github.com/articles/caching-your-github-password-in-git?azure-portal=true).

> [!NOTE]
> If you're already using two-factor authentication with GitHub, [create a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line?azure-portal=true), and use your token in place of your password when prompted later.
>
> Treat your access token like you would a password. Keep it in a safe place.

## Get the source code

Now, you'll get the source code from GitHub and set up Visual Studio Code so that you can run the app and work with source code files.

### Create a fork

The first step to using a project in Git is to create a fork so you can work with and modify the source files. A *fork* is a copy of a GitHub repository. The copy exists in your account and lets you make any changes you want without affecting the original project.

Although you can propose changes to the original project, in this lesson, you'll work with the *Space Game* web project as though it was the original project owned by Mara and her team.

Let's fork the *Space Game* web project into your GitHub account:

1. In a web browser, go to [GitHub](https://github.com?azure-portal=true), and sign in.

1. Go to the [Space Game](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web?azure-portal=true) web project.

1. Select **Fork**:

    :::image type="content" source="../media/3-github-fork-button.png" alt-text="Screenshot of GitHub showing the location of the Fork button.":::

1. To fork the repository into your account, follow the instructions.

### Clone your fork locally

Now that you have a copy of the *Space Game* web project in your GitHub account, you can download, or *clone*, a copy to your computer so you can work with it locally.

A clone, like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify they work as you expect, and then upload those changes back to GitHub. You can also synchronize your local copy with changes other authenticated users have made to GitHub's copy of your repository.

To clone the *Space Game* web project to your computer:

1. Go to your fork of the *Space Game* web project on GitHub.

1. In the command bar, select **Code**. A pane displays showing the Clone option with tabs for types of cloning. From the **HTTPS** tab, select the copy icon next to the URL to copy the URL to your clipboard.

    :::image type="content" source="../../shared/media/github-clone-button.png" alt-text="Screenshot of locating the URL and copy button from the GitHub repository.":::

1. In Visual Studio Code, go to the terminal window and enter `git clone`, then paste the URL from your clipboard. It should look similar to:

    ```bash
    git clone https://github.com/username/mslearn-tailspin-spacegame-web.git
    ```

1. After the `Cloning 'mslearn-tailspin-spacegame-web'...` operation completes, enter the following command to change to the `mslearn-tailspin-spacegame-web`directory. This is the root directory of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web
    ```

### Set the upstream remote

A *remote* is a Git repository where team members collaborate (similar to a repository on GitHub). Let's list your remotes and add a remote that points to Microsoft's copy of the repository so you can get the latest sample code.

1. To list your remotes, run the `git remote` command:

    ```bash
    git remote -v
    ```

    You have both fetch (download) and push (upload) access to your repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    ```

    *Origin* specifies your repository on GitHub. When you fork code from another repository, it's common to name the original remote (the one you forked from) *upstream*.

1. To create a remote named *upstream* that points to the Microsoft repository, run this `git remote add` command:

    ```bash
    git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git
    ```

1. Run `git remote` a second time to see the changes:

    ```bash
    git remote -v
    ```

    You see that you still have both fetch (download) and push (upload) access to your repository. You also now have fetch access from the Microsoft repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git (fetch)
    ```

### Open the project in the file explorer

In Visual Studio Code, your terminal window points to the root directory of the *Space Game* web project. Let's open the project to view its structure and work with files.

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

## Build and run the web app

Now that you have the web app, you can build and run it locally.

1. In Visual Studio Code, navigate to the terminal window, and to build the app, run this `dotnet build` command:

    ```dotnetcli
    dotnet build --configuration Release
    ```

    > [!NOTE]
    > If the `dotnet` command isn't found, review the prerequisites at the start of this module. You might need to install the .NET SDK.

    .NET projects typically come with two build configurations: Debug and Release. Debug builds aren't optimized for performance. They make it easier for you to trace through your program and troubleshoot issues. Here, you select the Release configuration just to see the web app in action.

1. From the terminal window, to run the app, run this `dotnet run` command:

    ```dotnetcli
    dotnet run --configuration Release --no-build --project Tailspin.SpaceGame.Web
    ```

    .NET solution files can contain more than one project. The `--project` argument specifies the project for the *Space Game* web app.

## Verify the application is running

In development mode, the *Space Game* website is configured to run on port 5000.

From a new browser tab, to see the running app, navigate to `http://localhost:5000`.

You see this:

:::image type="content" source="../media/3-space-game-top.png" alt-text="Screenshot of a web browser showing the Space Game web site.":::

> [!TIP]
> If you see an error in your browser that's related to a privacy or certificate error, to stop the running app, select Ctrl+C from your terminal.
> 
> Next, run `dotnet dev-certs https --trust` and select **Yes** when prompted. For more information, [see this blog post](https://www.hanselman.com/blog/DevelopingLocallyWithASPNETCoreUnderHTTPSSSLAndSelfSignedCerts.aspx?azure-portal=true).
>
> After your computer trusts your local SSL certificate, to see the running app, run the `dotnet run` command a second time and go to `http://localhost:5000` from a new browser tab.

You can interact with the page, including the leaderboard. When you select a player's name, you see details about that player:

:::image type="content" source="../media/3-space-game-leaderboard-profile.png" alt-text="Screenshot of a web browser showing the Space Game leaderboard.":::

When you're finished, return to the terminal window, and to stop the running app, select Ctrl+C.

::: zone-end