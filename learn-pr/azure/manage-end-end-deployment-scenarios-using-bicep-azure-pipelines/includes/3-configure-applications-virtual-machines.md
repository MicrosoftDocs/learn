It's common to build apps and other custom code for your Azure solution. Custom apps might include websites, APIs, and background apps that run without any human interaction. In this unit, you learn how to design a pipeline to build and deploy an app alongside its infrastructure.

## Build apps

Many types of apps need to be *compiled* or *built* before they can be used. The build process takes the source code for the app, performs a sequence of activities on it, and then creates a set of deployable files.

The build process compiles the source code into binary files or executables, but it ordinarily includes other activities as well:

- Compressing the image files that are served to your website's users.
- *Linting* your code to verify that it follows good coding practices.
- Running *unit tests* that verify the behavior of individual pieces of your app.

In addition to these steps, you might also perform steps such as digitally signing the files to help ensure that they can't be modified.

Whatever the series of steps might be, the output of the build process is a deployable *artifact*. The artifact is ordinarily saved to the pipeline agent's file system. Later stages of your pipeline need to work with the artifact to deploy it through your environments, and test it as it progresses through the quality gates you define in your pipeline definition.

> [!NOTE]
> You might have heard of the terms *continuous integration* and *continuous deployment*, or *CI* and *CD*. A build process sits within the continuous integration part of your pipeline.

### Pipeline artifacts

The artifacts that are generated in your pipeline aren't stored in your Git repository. They're derived from the source code but aren't code themselves, and so they don't belong in a source control repository. They're created on the pipeline agent's file system. A new agent is created for each pipeline job, so you need a way to share the files between jobs and agents.

*Pipeline artifacts* provide a way to store files in Azure Pipelines, and they're associated with the particular run of your pipeline. You use the `PublishBuildArtifacts` built-in pipeline task to instruct Azure Pipelines to publish a file or folder from the agent's file system as a pipeline artifact:

```yaml
- task: PublishBuildArtifacts@1
  displayName: Publish folder as a pipeline artifact
  inputs:
    artifactName: my-artifact-name
    pathToPublish: '$(Build.ArtifactStagingDirectory)/my-folder'
```

The `pathToPublish` property is the location that contains your compiled code or output files on the pipeline agent's file system. The contents at this location are published to the artifact. You can specify a single file or a folder.

Each artifact has a name, which you specify by using the `artifactName` task property. You use the artifact name to refer to it later in the pipeline. Subsequent pipeline jobs and stages can download the artifact so that they can work with it to, for example, deploy the website to the server that hosts it:

:::image type="content" source="../media/3-website-pipeline-artifact.png" alt-text="Diagram that shows pipeline stages to build and deploy that refer to an artifact named Website." border="false":::

When you use deployment jobs, pipeline artifacts are automatically downloaded by default. If you use regular jobs, use the `DownloadBuildArtifacts` task to download a pipeline artifact:

```yaml
- task: DownloadBuildArtifacts@0
  inputs:
    buildType: current
    downloadType: single
    artifactName: my-artifact-name
    downloadPath: '$(System.ArtifactsDirectory)'
```

## Deploy apps

The build process for an app generates and publishes a deployable artifact. Later stages of the pipeline deploy the artifact. The way that you deploy an app depends on the service you use to host it.

### Deploy to Azure App Service

Your toy company uses Azure App Service to host its website. You can create and configure an App Service app by using Bicep. But when it comes time to deploy the app, you have several options to get the compiled app onto the hosting infrastructure. These options are managed as part of the App Service data plane.

The most common approach is to use the `AzureRmWebAppDeployment` Azure Pipelines task:

```yaml
- task: AzureRmWebAppDeployment@4
  inputs:
    azureSubscription: MyServiceConnection
    ResourceGroupName: MyResourceGroup
    WebAppName: my-app-service
    Package: '$(Pipeline.Workspace)/my-artifact-name/website.zip'
```

You need to provide several pieces of information to deploy your app to App Service. This information includes the resource group and resource name of the App Service app, which you specify by using the `ResourceGroupName` and `WebAppName` inputs. As you learned in the preceding unit, you should add an output to your Bicep file and use a pipeline variable to propagate the app name through your pipeline. You also need to specify a *.zip* file with the app to deploy by using the `Package` input, which is usually the path to a pipeline artifact.

App Service has its own data plane authentication system that it uses for deployments. The `AzureRmWebAppDeployment` task handles the authentication process automatically for you:

:::image type="content" source="../media/3-credential-exchange.png" alt-text="Diagram that shows the credential exchange process." border="false":::

The `AzureRmWebAppDeployment` task uses the service principal associated with your service connection:::image type="icon" source="../media/callout-01.png"::: to automatically create and download the necessary credentials for deployment:::image type="icon" source="../media/callout-02.png":::. It then uses the deployment credentials when it communicates with the App Service data plane API:::image type="icon" source="../media/callout-03.png":::.

App Service also provides a few other deployment-related features, including *deployment slots*. Slots help you safely deploy new versions of your apps with no downtime. They also help you prepare and warm up the new version of your application before you send production traffic to it. We don't use slots in this module, but we provide a link to more information about them on the Summary page at the end of the module.

### Deploy apps to other Azure services

Azure provides many other options for hosting your apps, each of which has its own approach to deployment.

Azure Functions is built on App Service, and it uses a deployment process that's similar to the one described earlier.

If you deploy to a virtual machine, you ordinarily need to connect to the virtual machine instance to install your app. You often need to use specialized tooling, such as Chef, Puppet, or Ansible, to orchestrate a deployment to virtual machines.

If you use Kubernetes or Azure Kubernetes Service (AKS), you would use a slightly different approach to build and deploy your solution. After your app is built, your pipeline creates a *container image* and publishes it to a *container registry*, which your Kubernetes cluster then reads from. Because your container registry keeps the compiled application, you don't generally use a pipeline artifact.

In this module, we focus on Azure App Service to illustrate the pipeline concepts involved. On the Summary page at the end of the module, we provide links to more information about deploying to other hosting services.

## Test apps in your pipeline

In a previous module, you learned about the value and importance of running automated tests from your pipeline. When you deploy an app, it's a good practice for the pipeline to run some tests that invoke the app's code. Such tests reduce the risk that an app or deployment error might cause downtime. In more advanced scenarios, you might even perform a set of test cases against your app, such as invoking APIs or submitting and monitoring a synthetic transaction.

Many apps implement *health check endpoints*. When a health check endpoint receives a request, it performs a series of checks against the website, such as ensuring that databases and network services are reachable from the app environment. The response that the site returns indicates whether the app is healthy. Developers can write and customize their own health checks to suit the app's requirements. If your app has a health check endpoint, it often makes sense to monitor it from your pipeline after the deployment stage finishes.

## Your deployment pipeline

In the next exercise, you update your deployment pipeline to add new jobs to build your website's application and deploy it to each environment:

:::image type="content" source="../media/3-pipeline-application.svg" alt-text="Diagram that shows the revised pipeline, including a new build stage and an application deployment step." border="false":::
