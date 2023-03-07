Get ready to start building a CI pipeline with Microsoft Azure Pipelines. The first step is to build and run the *Space Game* web app on your local machine. Understanding how to build software locally will prepare you to repeat the process in the pipeline.

Mara is going to do exactly that, and by following the procedures, you can do the same thing.

You'll use an Azure DevOps Linux self-hosted agent for this module instead of a Microsoft-hosted agent. The advantage of using a self-hosted agent is that you won't run into any parallel-job limits. By default, new Azure DevOps organization accounts do not include parallel jobs. To learn more about parallel jobs, see [Check your parallel jobs and request a free grant](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs).

## Create an Azure DevOps personal access token

1. Sign in to your organization (```https://dev.azure.com/{yourorganization}```).
  
1. From your home page, open user settings :::image type="icon" source="../media/3-user-settings-gear.png" border="false"::: and select **Personal access tokens**.

1. Select **+ New Token**.

1. Name your token, select the organization where you want to use the token, and then set your token to automatically expire after a set number of days.

1. Select the following scopes: **Agent Pools (Read & manage)** and **Deployment Groups (Read & manage)**.

1. When you're done, copy the token and store it in a secure location. For your security, it won't be shown again.

> [!WARNING]
> Treat and use a PAT like your password and keep it a secret.

### Create a fork

The first step to using a project in Git is to create a fork so you can work with and modify the source files. A *fork* is a copy of a GitHub repository. The copy exists in your account and lets you make any changes you want without affecting the original project.

Although you can propose changes to the original project, in this lesson, you'll work with the *Space Game* web project as though it was the original project owned by Mara and her team.

Let's fork the *Space Game* web project into your GitHub account:

1. In a web browser, go to [GitHub](https://github.com?azure-portal=true), and sign in.

1. Go to the [Space Game](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web?azure-portal=true) web project. (Temp URL: https://github.com/juliakm/pipelines-codespaces-tailspin)

1. Select **Fork**:

    :::image type="content" source="../media/3-github-fork-button.png" alt-text="Screenshot of GitHub showing the location of the Fork button.":::

1. To fork the repository into your account, follow the instructions.


## Set up secrets for self-hosted agent

Before you create your Codespace, you'll create three passwords that help your self-hosted Azure DevOps agent run. In production, you wouldn't want to use a self-hosted agent in a Codespaces. However, since your team is using Codespaces for testing, this is a good temporary solution when you are building your pipelines.  

1. In your GitHub repository, select **Settings** > **Secrets and variables** > **Codespaces**.

    :::image type="content" source="../media/3-add-codespaces-secret.png" alt-text="Screenshot of GitHub Codespaces secrets. ":::

1. Create three new Codespaces secrets.
    
    |Name  |Value  |
    |---------|---------|
    |ADO_ORG     |   Name of the Azure DevOps organization (Example: `fabrikam`)     |
    |ADO_PAT     |   Personal Access Token value      |
    |ADO_POOL_NAME     |   Name of agent pool (Example: `codespaces-agent-pool`)      | 
    
## Set up Codespaces

Next, you'll set up Codespaces so that you can build the website, work with source files, and set up a self-hosted agent.


1. In your forked GitHub repository, select **Code**.

1. Select the **Codespaces** tab.

1. Press **...** to create a new Codespace with options.

    :::image type="content" source="../media/3-create-new-options-codespaces.png" alt-text="Screenshot of create a new Codespace with options. ":::

1. Select the `AzurePipelines` Codespace option at `.devcontainer/ADOagent/devcontainer.json` and **Create codespace**. Leave the other default options. 

    :::image type="content" source="../media/3-select-azdo-codespace-option.png" alt-text="Screenshot of select Azure DevOps codespace as a configuration.":::

1. Wait for your Codespace to build. When the build completes, you'll be redirected to an online version of Visual Studio Code. 

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
