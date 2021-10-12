It's common to build applications and other custom code for your Azure solution. Custom applications might include websites, APIs, and applications that run unattended. In this unit, you'll learn about how to design a pipeline to build and deploy an application alongside its infrastructure.

## Build applications

Many types of applications need to be *compiled* or *built* before they can be used. The build process takes the source code for your application, performs a sequence of activities on it, and then creates a set of deployable files.

The build process compiles the source code into binary files or executables. Typically a build process also includes other activities, including compressing the image files that will be served to your website's users, *linting* your code to verify it follows good coding practices, and running *unit tests* that verify the behavior of individual pieces of your application. You might even perform steps like digitally signing the files to verify they haven't been changed.

The output of the build process is a deployable *artifact* that's saved to the pipeline agent's file system. Later stages of your pipeline need to work with the artifact to deploy it through your environments, and test it as it progresses through the quality gates you define.

### Pipeline artifacts

The artifacts generated in your pipeline aren't stored in your Git repository. They're derived from the source code, but they aren't code themselves and so they don't belong in a source control repository. Instead, artifacts are stored by Azure Pipelines, and they're associated with the particular run of your pipeline.

Files that are created on the pipeline agent's file system aren't automatically published as pipeline artifacts. You use a built-in pipeline task to instruct Azure Pipelines to publish a file or folder as an artifact:

TODO

Each artifact has a name, which you use to refer to it later in the pipeline.

Later jobs and stages in the pipeline can download the artifact so that they can work with them, such as to deploy the website to the server that hosts it:

:::image type="content" source="../media/3-website-pipeline-artifact.png" alt-text="Diagram showing a pipeline publishing and then referring to an artifact named 'Website'." border="false":::

When you use deployment jobs, pipeline artifacts are automatically downloaded by default. If you use regular jobs, use the TODO task to download a pipeline artifact:

TODO

## Deploy applications

The build process for an application generates and publishes a deployable artifact. Later stages of the pipeline then deploy the artifact. The way that you deploy an application depends on the service you use to host it.

### Deploy to Azure App Service

Your toy company uses Azure App Service to host their website. An App Service app can be created and configured by using Bicep, but when it comes time to deploy the application itself, there are several options to get the compiled application onto your hosting infrastructure. The most common approach is to use the TODO Azure Pipelines task:

TODO

You need to provide several pieces of information to deploy your application to App Service. This includes the name of the App Service app. As you learned earlier in the module, you should add an output to your Bicep file, and use a pipeline variable to propagate the application name through your pipeline. You also need to specify a Zip file to deploy. Typically this is the path to a pipeline artifact.

App Service also needs you to authenticate before you can deploy. App Service has its own data plane authentication system that it uses for deployments. The TODO task uses the service principal associated with your service connection to create and download the necessary credentials for deployment.

> [!TIP]
> Azure Functions is built on App Service, and uses a similar deployment process.

> [!NOTE]
> App Service also provides a number of other deployment-related features, including *deployment slots*. Slots help you to safely deploy new versions of your applications, and to prepare the new version to receive production traffic so that you have no downtime. We don't use slots in this module, but we provide more information in the summary.

### Deploy applications to other Azure services

Azure provides many other options for hosting your applications, each of which has its own approach for deployment.

If you deploy to a virtual machines, you typically need to connect to the virtual machine instance to install your application. You often need to use specialized tooling, like Chef, Puppet, or Ansible, to orchestrate deployment. You can also configure your pipeline to deploy directly to the virtual machines if they have an Azure Pipelines agent installed and configured.

If you use Kubernetes or AKS, you typically use a slightly different approach to build and deploy your solution. After your application is built, your pipeline creates a *container image* and publishes it to a *container registry*, which your Kubernetes cluster then reads from.

In this module, we focus on Azure App Service, but we provide links to more information about deploying to other hosting services in the summary.
