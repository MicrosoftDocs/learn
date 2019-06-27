The team has decided to build a release pipeline to release the website to an Azure AppService first. After the pipeline is created and tested, the team will evaluate whether or not to continue with Azure AppServices or move to a VM deployment pipeline. (Tim will be involved and will want (need) full control over the server)

Here you'll follow the team as they create a release pipeline using multistage pipelines. To do this you will:

> [!div class="checklist"]
> * Create an App Service in Azure to host the website
> * Get the website code from GitHub and create the initial build pipeline (**Move this to the setup unit?**)
> * Use multistage pipelines to create a build and release pipeline 
> * See the website deployed to an Azure AppService

## Create the AppService

1. Sandbox - 
    * Create an App Service, I have the CLI template. Core 2.1 Sku and Size F1
    * My Notes - 

    ```bash
    webappname=TailspinGame$RANDOM
    az group create --location westus --name TailspinResourceGroup
    az appservice plan create --name myAppServicePlan --resource-group TailspinResourceGroup --sku FREE
    az webapp create --name $webappname --resource-group TailspinResourceGroup --plan myAppServicePlan
    az webapp create --name
              --plan
              --resource-group
              [--deployment-container-image-name]
              [--deployment-local-git]
              [--deployment-source-branch]
              [--deployment-source-url]
              [--multicontainer-config-file]
              [--multicontainer-config-type {COMPOSE, KUBE}]
              [--runtime]
              [--startup-file]
              [--subscription]
              [--tags]
    --runtime -r
    Canonicalized web runtime in the format of Framework|Version, e.g. "PHP|5.6". Use 'az webapp list-runtimes' for available list.
    ```

(How do we reconcile the tennet?)

TODO - Link to the MSLearn module on creating an AppService

## Get the source code from GitHub (Move this to the setup unit?)

Here you'll set up Visual Studio Code so you can work with source files.

Visual Studio Code comes with an integrated terminal so you can edit files and work from the command line all from one place.

1. Launch Visual Studio Code.
1. From the **View** menu, select **Terminal**.
1. From the drop-down box, select **bash**.

    ![Selecting the Bash shell in Visual Studio Code](../media/3-vscode-bash.png)

    The terminal window enables you to choose among any shell that's installed on your system, such as Bash, Zsh, and PowerShell.

    Here you'll use Bash. Git for Windows provides Git Bash, which makes it easy to run Git commands.

1. Run the `cd` command to navigate to the directory you want to work from, such as your home directory (`~`). You can choose a different directory if you prefer.

    ```bash
    cd ~
    ```

### Configure Git

If you're new to Git and GitHub, you'll need to first run a few commands to prepare associate your identity with Git and authenticate with GitHub.

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

    ![The Fork button on GitHub](../media/3-github-fork-button.png)
1. Follow the instructions to fork the repository into your account.

#### Clone your fork locally

You now have a copy of the _Space Game_ web project in your GitHub account. Here you'll download, or _clone_, a copy to your computer so you can work with it.

A clone, just a like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify they work as you expect, and then upload those changes back to GitHub. You can also synchronize your local copy with changes other authenticated users have made to GitHub's copy of your repository.

To clone the _Space Game_ web project to your computer:

1. Navigate to your fork of the _Space Game_ web project on GitHub.
1. Click the **Clone or download** button. Then click the button next to the URL that's shown to copy the URL to your clipboard.

    ![The Clone or download button on GitHub](../media/3-github-clone-button.png)
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

1. From Azure Pipelines, trace the build through each of the steps.

    When the build completes, you see the **Artifacts** button appear.

    ![Azure Pipelines showing the Artifacts button](../media/7-artifacts-button.png)

1. Click the **Artifacts** button, then click **drop**. The **Artifacts explorer** appears.
1. From the **Artifacts explorer**, expand the **drop** folder.

    You see a .zip file that contains your built application and its dependencies.

    ![The Artifacts explorer showing the packaged application](../media/7-artifacts-explorer.png)

## Create the multistage pipeline

The team has been using a build pipeline to automate their build processes. Now, we will edit the pipeline to use multistage pipelines and add the deployment stage to our pipeline. We will first deploy to Amita's test environment as an Azure AppService and then the team will get together to evaluate the process.

### Turn on multistage pipelines in Azure DevOps and create a service connection

1. From your Azure DevOps portal:
      1. Right click your profile
      1. Select Preview features
      1. Turn on Multi Stage Pipelines **(screenshot)**
1. Create Service connection to the AppService (tennet issue?)
    1. Navigate to the project page for your Tailspin-SpaceGame-Web project.
    1. Click `Settings` in the bottom left of the page.
    1. Choose `Service connections`
    1. (TODO - try the rest with the sandbox setup and add screenshots)

### Add stages and deployment tasks to the pipeline

1. Add stages and variables and release tasks to azure-pipelines.yml
    1. TODO - Highlight new parts
    1. TODO - Explain the tasks and stages (mostly done in the previous unit)
    1. TODO - Add variables
    
    ```yml
        trigger:
        - master
        
        stages:
        - stage: 'Build'
          displayName: 'Build Stage'
          jobs: 
          - job: Build
            displayName: 'Build job'
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
                arguments: '--no-build --configuration Release --output $(Build.ArtifactStagingDirectory)'
                zipAfterPublish: true
        
            - task: PublishBuildArtifacts@1
              displayName: 'Publish Artifact: drop'
              condition: succeeded()
              inputs:
                pathtoPublish: '$(Build.ArtifactStagingDirectory)'
                ArtifactName: 'drop'
        - stage: 'Deploy'
          displayName: 'Deploy Testing Stage'
          dependsOn: Build
          jobs:
          - job: DeployTest
            displayName: 'Deploy test job'
            pool:
              vmImage: 'Ubuntu-16.04'
            steps: 
            - task: DownloadBuildArtifacts@0
              inputs:
                buildType: 'current'
                downloadType: 'single'
                artifactName: 'drop'
                downloadPath: '$(Build.ArtifactStagingDirectory)'
            - task: AzureRmWebAppDeployment@4
              displayName: 'Azure App Service Deploy: website'
              inputs:
                azureSubscription: 'service connection here'
                appType: 'webAppLinux'
                WebAppName: 'TailspinAsTest'
                StartupCommand: 'dotnet Tailspin.SpaceGame.Web.dll'
                Package: $(System.ArtifactsDirectory)/**/*.zip
    ```

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

> [!TIP]
> Remember to save **azure-pipelines.yml** before running these Git commands.

  ```bash
  git add azure-pipelines.yml
  git commit -m "Add multistage pipeline"
  git push origin 
  ```

2. (run pipeline see build and deploy)
3. (may need to authorize - use button)

## See your website deployed

1. (Back to sandbox to get URL)
    1. (go to web URL and see it was deployed)