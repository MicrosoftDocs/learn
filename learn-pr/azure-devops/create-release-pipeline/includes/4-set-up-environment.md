Over the pervious learning paths (Links here), the team has been slowly integrating an Azure DevOps strategy into their current processes. They have created Boards to help them begin using a more Agile aproach to development, and they have set up a build pipeline to automate their builds. 

Here you'll make sure that your environment reflects the team's efforts so far.

To do this you will:

> [!div class="checklist"]
> * Get the SpaceGame Web source code from GitHub
> * Set up your Azure DevOps project
> * Add the build pipeline

## Get the source code from GitHub

Here you'll set up Visual Studio Code so you can work with source files.

Visual Studio Code comes with an integrated terminal so you can edit files and work from the command line all from one place.

1. Launch Visual Studio Code.
1. From the **View** menu, select **Terminal**.
1. From the drop-down box, select **bash**.

    <!-- ![Selecting the Bash shell in Visual Studio Code](../media/3-vscode-bash.png) -->(Screenshot)
    The terminal window enables you to choose among any shell that's installed on your system, such as Bash, Zsh, and PowerShell.

    Here you'll use Bash. Git for Windows provides Git Bash, which makes it easy to run Git commands.

1. Run the `cd` command to navigate to the directory you want to work from, such as your home directory (`~`). You can choose a different directory if you prefer.

    ```bash
    cd ~
    ```

### Configure Git

If you're new to Git and GitHub, you'll need to first run a few commands to prepare, associate your identity with Git, and authenticate with GitHub.

[Set up Git](https://help.github.com/articles/set-up-git?azure-portal=true) explains the process in greater detail.

At a minimum, you'll need to perform these steps. Run these commands from Visual Studio Code's integrated terminal.

1. [Set your username](https://help.github.com/articles/setting-your-username-in-git?azure-portal=true)
1. [Set your commit email address](https://help.github.com/articles/setting-your-commit-email-address-in-git?azure-portal=true)
1. [Cache your GitHub password](https://help.github.com/articles/caching-your-github-password-in-git?azure-portal=true)

> [!NOTE]
> If you're already using two-factor authentication with GitHub, [Create a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line?azure-portal=true) and use your token in place of your password when prompted later.
> Treat your access token like you would a password and keep it in a safe place.

### Get the source code

Here you'll get the source code from GitHub and set up Visual Studio Code so that you can run the app and work with source code files.

#### Create a fork

The first step is to fork the _Space Game_ web project so you can work with and modify the source files.

A _fork_ is a copy of a GitHub repository. The copy exists in your account, and enables you to make any changes you want without affecting the original project.

Although you can propose changes to the original project, here you'll work with the _Space Game_ web project as though it were the original project owned by Mara and her team.

To fork the _Space Game_ web project into your GitHub account:

1. From a web browser, navigate to [GitHub](https://github.com?azure-portal=true) and sign in.
1. Navigate to the [Space Game](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web?azure-portal=true) web project.
1. Click the **Fork** button.

    <!-- ![The Fork button on GitHub](../media/3-github-fork-button.png) -->(screenshot)
1. Follow the instructions to fork the repository into your account.

#### Clone your fork locally

You now have a copy of the _Space Game_ web project in your GitHub account. Here you'll download, or _clone_, a copy to your computer so you can work with it.

A clone, just a like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify they work as you expect, and then upload those changes back to GitHub. You can also synchronize your local copy with changes other authenticated users have made to GitHub's copy of your repository.

To clone the _Space Game_ web project to your computer:

1. Navigate to your fork of the _Space Game_ web project on GitHub.
1. Click the **Clone or download** button. Then click the button next to the URL that's shown to copy the URL to your clipboard.

    <!-- ![The Clone or download button on GitHub](../media/3-github-clone-button.png) -->(screenshot)
1. From Visual Studio Code, navigate to the terminal window and run the `git clone` command. Replace the URL that's shown with the contents of your clipboard.

    ```bash
    git clone --branch master --single-branch https://github.com/your-name/mslearn-tailspin-spacegame-web.git
    ```

    You can typically omit the `--branch` and `--single-branch` arguments. We include them here to help you get starter code from Microsoft's repository in later modules.

1. Move to the `mslearn-tailspin-spacegame-web` directory. This is the root directory of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web
    ```

#### Set the upstream remote

A _remote_ is a Git repository where team members collaborate (such as on GitHub).

Run the following `git remote` command to list your remotes.

```bash
git remote -v
```

You see that you have both fetch (download) and push (upload) access to your repository.

```output
origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
```

Here, _origin_ specifies your repository on GitHub. When you fork code from another repository, it's common to name the original remote (the one you forked from) as _upstream_.

Run the following `git remote add` command to create a remote named _upstream_ which points to Microsoft's repository.

```bash
git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git
```

Run `git remote` a second time to see the changes.

```bash
git remote -v
```

You see that you still have both fetch (download) and push (upload) access to your repository. You also now have fetch access from Microsoft's repository.

```output
origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git (fetch)
```

#### Open the project in the file explorer

In Visual Studio Code, your terminal window points to the root directory of the _Space Game_ web project. Here you'll open the project from the file explorer so that you can view its structure and work with files.

1. From the **File** menu, select **Open** or **Open Folder**.
1. Navigate to the root directory of the _Space Game_ web project.

    (You can run the `pwd` command in the terminal window to see the full path if you need a refresher.)

You see the directory and file tree in the file explorer.

## Get the Azure Devops project

In this part, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey.

This learning path also builds on the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path. There, you set up your Azure DevOps organization and created a task backlog on Azure Boards using the Basic process.

### Run the template

At this point, you have two options:

1. Continue with the Azure DevOps project you created in the _Evolve your DevOps practices_ learning path.
1. Run a template that sets up everything for you in your Azure DevOps organization.

You can continue using your existing project if you completed the previous modules and have the Tailspin project set up in Azure DevOps. Run the template if you don't have the project set up or want to repeat this module from a fresh environment.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=create-build-pipeline&azure-portal=true)

From the Azure DevOps Demo Generator site, perform these steps to run the template.

1. Click **Sign In** and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization and enter a project name, such as **Space Game - web - Pipeline**. Then click **Create Project**.

    ![Creating a project through the Azure DevOps Demo Generator](../media/5-create-new-project.png)

    It takes a few moments for the template to run.
1. Click **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

### Move the work item to Doing

In this part, you'll assign a work item to yourself that relates to this module on Azure Boards. You'll also move the work item to the **Doing** state. In practice, you and your team would assign work items at the start of each Sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce Work in Progress, or WIP, limits so that the team doesn't take on too much work at one time.

Recall that the team settled on these seven top issues.

![Backlog of tasks](../../shared/media/build-all-tasks.png)

Here you'll move the first item, **Deploy to a test environment** to the **Doing** column and assign yourself to the work item.

Recall that **Deploy to a test environment** relates to fixing the team's existing build server, which runs on spare hardware in their office. The goal is to see if build services on Azure Pipelines can simplify build server maintenance.

![Work item details](../media/5-work-item-details.png)

To set up the work item:

1. From Azure DevOps, navigate to **Boards** and then select **Boards** from the menu.

    ![Azure DevOps showing the Boards menu](../../shared/media/azure-devops-boards-menu.png)

1. From the **Stabilize the build server** work item, click the down arrow at the bottom of the card. Then assign the work item to yourself.

    ![Assigning the work item to yourself](../../shared/media/azure-boards-down-chevron.png)
1. Move the work item from the **To Do** to the **Doing** column.

    ![Azure Boards showing the card in the Doing column](../media/5-azure-boards-wi1-doing.png)

At the end of this module, you'll move the card to the **Done** column after you've completed the task.

## Create the initial build pipeline

Here we will create the same basic build pipeline we create in **(Create Build Pipeline module link here)**. This will give us a place to start for our multistage release pipeline.

 Mulitstage pipelines are a preview feature. This means that they will shortly become integrated into the standard Azure DevOps experience, but for now we will need to turn on this feature.

### Turn on multistage pipelines in Azure DevOps

 From your Azure DevOps portal:

  1. Right-click your profile
  1. Select Preview features
  1. Turn on Multi Stage Pipelines **(screenshot)**
  1. Notice that separate **Pipelines** menu entries for **Release** and **Build** are now gone. This is because we will do our build and release from the same pipeline.

### Add the build pipeline 

1. From Visual Studio Code, select **File > New File**. Then select **File > Save** to save the blank file as **azure-pipelines.yml** in your project's root directory, such as `~/mslearn-tailspin-spacegame-web`.

    > [!IMPORTANT]
    > On Windows, ensure that you select **YAML** from the **Save as type** field.

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add build pipeline"
    git push origin 
    ```

1. From Visual Studio Code, modify **azure-pipelines.yml** like this.

    [!code-yml[](code/5-azure-pipelines-1.yml?highlight=01-06)]
You'll notice that we have set it up to use stages and jobs. For now, we only have one stage, the build stage. Next, we'll add the deployment stage.

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add stage to build pipeline"
    git push origin
    ```

1. From Azure Pipelines, trace the build through each of the steps. 

    When the build completes, you see the **Artifacts** button appear. We'll use this artifact as our source for the deploy stage.

    <!-- ![Azure Pipelines showing the Artifacts button](../media/7-artifacts-button.png) -->(screenshot)

1. Click the **Artifacts** button, then click **drop**. The **Artifacts explorer** appears.
1. From the **Artifacts explorer**, expand the **drop** folder.

    You see a .zip file that contains your built application and its dependencies.

    <!-- ![The Artifacts explorer showing the packaged application](../media/7-artifacts-explorer.png) -->(screenshot)

**Possible changes:**
Instead of creating a pipeline yml file, change this unit to :
* Fetch branch with starter build config (where you left off in previous LP)
* Get project from generator
  * `git commit --allow-empty`
  * `git push` - watch it build in the pipeline
