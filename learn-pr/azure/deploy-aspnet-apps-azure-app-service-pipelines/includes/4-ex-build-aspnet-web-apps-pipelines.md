As your company considers deploying their ASP.NET applications to the Azure App Service, you decide to test the process. In this exercise, you'll set up prerequisites for the deployment and build artifacts necessary to deploy a sample ASP.NET web app to an Azure App Service web app.

## Set up a GitHub account, an Azure DevOps organization, and create an Azure DevOps project

You'll start by creating a GitHub account, an Azure DevOps organization, and an Azure DevOps project.

> [!NOTE]
> You will need a valid email address, such as one associated with a Microsoft LiveID user account.

> [!NOTE]
> You can skip this task if you already have an existing Azure DevOps organization and a corresponding GitHub account that you can use for exercises in this module.

1. From your computer, start a web browser in the **private** mode and browse to [https://github.com](https://github.com).
1. On the GitHub home page, select **Sign up**.

   > [!NOTE]
   > The name of the **private** mode depends on the browser (such as *InPrivate* for Microsoft Edge, *Private* for Firefox, or *Incognito* for Chrome).

1. On the **Create your account** page, specify a username, email address, a password you want to associate with your new GitHub account, and any additional information necessary to complete this step, and select **Create account**.
1. On the **Welcome to GitHub** page, select **Complete setup**.
1. Open another web browser tab, sign in to your email account, locate the GitHub verification email, and follow instructions in the email to complete the email account verification process.
1. Open another web browser tab and browse to [https://dev.azure.com](https://dev.azure.com).
1. On the **Azure DevOps** page, select **Start free with GitHub**.
1. On the **Authorize Microsoft-Corporation** page, select **Authorize Microsoft-corp**.
1. If you're using a Microsoft account, on **Link your GitHub credentials to your Microsoft account**, select **Next**. When prompted, enter the code included in another email delivered to your email account, select **Sign in**, and, to complete the setup, select **Got it**.

   > ![NOTE] If prompted to set up your Azure DevOps organization details, verify your name, email address, and location, and then select **Continue**.

1. On the **Get started with Azure DevOps** page, select **Continue**.
1. On the **Create a project to get started** page, in the **Project name** text box, enter **Deploy ASP.NET web apps with Azure Pipelines**, leave the visibility set to **Private**, and select **+ Create project**.

## Create a GitHub repository from a template and generate an Azure DevOps build pipeline

Next, you will create your own repository from a GitHub template repository, containing the sample ASP.NET app, into your GitHub account and then generate an Azure DevOps build pipeline using it as its source.

1. Within the browser window displaying the Azure DevOps portal, open another tab and navigate to the [repository hosting the sample ASP.NET app](https://github.com/MicrosoftDocs/mslearn-deploy-aspnet-azure-pipelines) that you'll be using throughout the exercises in this module.
1. On the [repository hosting the sample ASP.NET app](https://github.com/MicrosoftDocs/mslearn-deploy-aspnet-azure-pipelines) page, follow instructions describing [Creating a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template).
1. Switch to the browser tab displaying the **Deploy ASP.NET web apps with Azure Pipelines** Azure DevOps project, in the vertical menu bar along the left edge of the project page, select the **Pipelines** icon and, on the **Create your first Pipeline** pane, select **Create Pipeline**.
1. On the **Where is your code?** pane, select **GitHub YAML**.

   :::image type="content" source="../media/4-where-is-your-code-github-yaml.png" alt-text="The New pipeline pane displaying the option to use the GitHub repository as the source for a YAML pipeline.":::

   > [!NOTE]
   > If prompted, select the **Authorize Azure Pipelines** button.

1. On the **Select a repository** pane, select the newly created repository.
1. On the **Approve & Install Azure Pipelines** pane, accept the **Only select repositories** option, and then select the **Approve & install** button.

   > [!NOTE]
   > If prompted to authenticate, enter the username and password for your GitHub and Azure DevOps user accounts.

1. In the Azure DevOps portal, on the **Configure your pipeline** pane, select **ASP.NET**.

## Review the auto-generated ASP.NET build pipeline

Now spend a few minutes reviewing the build pipeline generated based on the **ASP.NET** template.

On the **Review your pipeline YAML** pane, scroll down to the **steps:** section and review the list of auto-generated tasks by hovering with the mouse pointer over task headers and identify the purpose of each task:

- **NuGetToolInstaller@1** acquires a specific version of NuGet from the internet or the tools cache, and adds it to the PATH. You can use this task to change the version of NuGet used in the NuGet tasks.
- **NuGetCommand@2** performs restore of NuGet packages from NuGet.org.
- **VSBuild@1** leverages MSBuild to perform builds and set the Visual Studio version property.
- **VSTest@2** leverages Visual Studio Test runner to perform unit and functional tests.

## Customize the auto-generated ASP.NET build pipeline

Next, you'll customize the auto-generated pipeline to provide the additional functionality that will facilitate setting up the Azure DevOps pipeline that deploys the sample ASP.NET app.

> [!NOTE]
> By default, the pipeline is configured with continuous integration enabled. This would trigger its execution whenever we modify the **azure-pipelines.yaml** file. You'll temporarily disable this functionality and re-enable it once you finalize changes to the pipeline.

1. On the **Review your pipeline YAML** pane, to temporarily disable continuous integration, replace the following content with `trigger: none`:

   ```yaml
   trigger:
   - main
   ```

1. Because you won't be running tests in this exercise, scroll down to the bottom of the pipeline and remove the entire **VSTest@2** task section:

   ```yaml
   - task: VSTest@2
     inputs:
       platform: '$(buildPlatform)'
       configuration: '$(buildConfiguration)'
   ```

   > [!NOTE]
   > Next, you will add a step that will publish artifacts generated by the build.

1. On the **Review your pipeline YAML** pane, select **Show assistant**.
1. Position the cursor after the last task in the auto-generated pipeline. In the **Search tasks** text box, enter **Publish build artifacts**. From the list of results, select **Publish build artifacts** and then, on the **Publish build artifacts** pane, select **Add**.

   > [!NOTE]
   > At this point, the pipeline should have the following content.

   ```yaml
   # ASP.NET
   # Build and test ASP.NET projects.
   # Add steps that publish symbols, save build artifacts, deploy, and more:
   # https://docs.microsoft.com/azure/devops/pipelines/apps/aspnet/build-aspnet-4

   trigger: none

   pool:
     vmImage: 'windows-latest'

   variables:
     solution: '**/*.sln'
     buildPlatform: 'Any CPU'
     buildConfiguration: 'Release'

   steps:
   - task: NuGetToolInstaller@1

   - task: NuGetCommand@2
     inputs:
       restoreSolution: '$(solution)'

   - task: VSBuild@1
     inputs:
       solution: '$(solution)'
       msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactStagingDirectory)"'
       platform: '$(buildPlatform)'
       configuration: '$(buildConfiguration)'

   - task: PublishBuildArtifacts@1
     inputs:
       PathtoPublish: '$(Build.ArtifactStagingDirectory)'
       ArtifactName: 'drop'
       publishLocation: 'Container'
   ```

## Run the auto-generated ASP.NET build pipeline

1. On the **Review your pipeline YAML** pane, in the toolbar, select **Save & run** and, on the **Save and run** pane, select **Save and run**.
1. On the pipeline run pane, in the **Jobs** section, select **Job**, and then track the execution of the individual tasks in the newly created pipeline.
1. Verify that all tasks completed successfully.

:::image type="content" source="../media/4-completed-build-job.png" alt-text="The Azure DevOps Pipeline job execution logs displaying a successfully completed job.":::

## Results

In this exercise, you set up prerequisites and built artifacts necessary to deploy a sample ASP.NET web app to an Azure App Service web app.

## Keep your web browser windows open if continuing the module exercises

If you plan to perform the next exercises in this module, keep your web browser windows open.
