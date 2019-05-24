Here you'll get the team's new code for the **Tailspin.SpaceGame.Web.Models** project that is now separate from the **Tailspin.SpaceGame.Web** project. You'll create an Azure pipeline for the Models project and see the new Azure Artifact with a version number of `1.0.0` in your feed.

## Prepare Visual Studio Code

Here you'll set up Visual Studio Code so you can work with source files.

1. From Visual Studio Code, open the integrated terminal.
1. Navigate to a directory to work from, such as your home directory (`~`). We suggest using the parent directory from where your **mslearn-tailspin-spacegame-web** project is located.

    ```bash
    cd ~
    ```

## Get the source code

Here you'll get the source code from GitHub and set up Visual Studio Code so you can work with the files.

### Create a fork

The first step is to fork the **mslearn-tailspin-spacegame-web-models** project so you can work with and modify the source files. Recall that Mara put the **Models** directory in a new project and removed it from the web project.

To fork the **mslearn-tailspin-spacegame-web-models** project into your GitHub account:

1. From a web browser, navigate to [GitHub](https://github.com?azure-portal=true) and sign in.
1. Navigate to the [mslearn-tailspin-spacegame-web-models](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-models?azure-portal=true) project.
1. Click the **Fork** button.
1. Follow the instructions to fork the repository into your account.

### Clone your fork locally

To clone the **mslearn-tailspin-spacegame-web-models** projects to your computer:

1. Navigate to your fork of the **mslearn-tailspin-spacegame-web-models** project on GitHub.
1. Click the **Clone or download** button. Then click the button next to the URL that's shown to copy the URL to your clipboard.
1. From Visual Studio Code, navigate to the terminal window and run this `git clone` command. Replace the URL that's shown with the contents of your clipboard.

    ```bash
    git clone --branch master --single-branch https://github.com/your-name/mslearn-tailspin-spacegame-web-models.git
    ```

1. Move to the **mslearn-tailspin-spacegame-web-modules** directory. This is the root directory of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web-modules
    ```

### Open the project and examine the configuration

In Visual Studio Code, your terminal window points to the root directory of the **mslearn-tailspin-spacegame-web-modules** project. Here you'll open the project from the file explorer so that you can view its structure and work with files.

1. From the **File** menu, select **Open**.
1. Navigate to the root directory of the **mslearn-tailspin-spacegame-web-modules** project.

    You see the directory and file tree in the file explorer.

1. Open the **azure-pipelines.yml** file.

    You see the steps where the package is built, the version is set, and the package is added to Azure Artifacts.

    This code builds the project:

    ``` yml
    - task: DotNetCoreCLI@2
      displayName: 'Build the project - $(buildConfiguration)'
      inputs:
        command: 'build'
        arguments: '--no-restore --configuration $(buildConfiguration)'
        projects: '**/*.csproj'
    ```

    This code packages the project with a version of `1.0.0`:

    ``` yml
    - task: DotNetCoreCLI@2
      displayName: 'Pack the project - $(buildConfiguration)'
      inputs:
        command: 'pack'
        projects: '**/*.csproj'
        arguments: '--no-build --configuration $(buildConfiguration)'
        versioningScheme: byPrereleaseNumber
        majorVersion: '1'
        minorVersion: '0'
        patchVersion: '0'
    ```

    This code pushes the package to your **Tailspin.SpaceGame.Web.Models** Azure Artifacts feed:

    ```yml
    - task: NuGetCommand@2
      displayName: 'Publish NuGet package'
      inputs:
        command: push
        publishVstsFeed: 'Tailspin.SpaceGame.Web.Models'
        allowPackageConflicts: true
      condition: succeeded()
    ```

## Create the pipeline in Azure Pipelines

You learned how to set up Azure Pipelines in an earlier module. We won't go into as much detail here since you've done this before, but if you need a refresher, head over to [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline-azure-pipelines?azure-portal=true).

Here you'll set up a second pipeline to build the package and put it in Azure Artifacts.

1. From Azure DevOps, navigate to the **SpaceGame-Web** project.
1. Select **Pipelines**, either from the project page or from the menu on the left.
1. Select **+ New** and then **New build pipeline**.
1. From the **Where is your code?** pane, select **GitHub**.
1. From **Select a repository**, select **mslearn-tailspin-spacegame-web-models**

    1. You'll see the new pipeline's **azure-pipelines.yml** file.
    1. Click the **Run** button.
1. Watch the pipeline run.
1. Navigate to your Azure Artifacts tab.

    You see your new **Tailspin.SpaceGame.Web.Models** Azure Artifact. Note the version number.