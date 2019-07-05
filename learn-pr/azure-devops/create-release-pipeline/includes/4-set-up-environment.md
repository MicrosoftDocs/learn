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

### Create the initial build pipeline

Here we will create the same basic build pipeline we create in **(Create Build Pipeline module link here)**. This will give us a place to start for our multistage release pipeline.

1. From Visual Studio Code, select **File > New File**. Then select **File > Save** to save the blank file as **azure-pipelines.yml** in your project's root directory, such as `~/mslearn-tailspin-spacegame-web`.

    > [!IMPORTANT]
    > On Windows, ensure that you select **YAML** from the **Save as type** field.
1. From Visual Studio Code, modify **azure-pipelines.yml** like this.

  ```yml
  pool:
      vmImage: 'Ubuntu-16.04'
      demands:
      - npm
  
  steps:
  - task: DotNetCoreInstaller@0
      displayName: 'Use .NET Core SDK 2.1.505'
      inputs:
      version: 2.1.505
  
  - task: Npm@1
      displayName: 'Run npm install'
      inputs:
      verbose: false
  
  - script: './node_modules/.bin/node-sass Tailspin.SpaceGame.Web/wwwroot --output Tailspin.SpaceGame.Web/wwwroot'
      displayName: 'Compile Sass assets'
  
  - task: gulp@1
      displayName: 'Run gulp tasks'
  
  - script: 'echo "$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" > buildinfo.txt'
      displayName: 'Write build info'
      workingDirectory: Tailspin.SpaceGame.Web/wwwroot
  
  - task: DotNetCoreCLI@2
      displayName: 'Restore project dependencies'
      inputs:
      command: 'restore'
      projects: '**/*.csproj'
  
  - task: DotNetCoreCLI@2
      displayName: 'Build the project - Release'
      inputs:
      command: 'build'
      arguments: '--no-restore --configuration Release'
      projects: '**/*.csproj'
  
  - task: DotNetCoreCLI@2
      displayName: 'Publish the project - Release'
      inputs:
      command: 'publish'
      projects: '**/*.csproj'
      publishWebProjects: false
      arguments: '--no-build --configuration Release --output $(Build.ArtifactStagingDirectory)/Release'
      zipAfterPublish: true
  
  - task: PublishBuildArtifacts@1
      displayName: 'Publish Artifact: drop'
      condition: succeeded()
  ```

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add build pipeline"
    git push origin 
    ```
 
### Get the Azure Devops project
    (generator)

  * `git commit --allow-empty`
  * `git push` - watch it build in the pipeline

1. From Azure Pipelines, trace the build through each of the steps.

    When the build completes, you see the **Artifacts** button appear.

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
