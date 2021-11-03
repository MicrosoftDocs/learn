It's common to build applications and other custom code for your Azure solution. Custom applications might include websites, APIs, and background applications that run without any human interaction. In this unit, you'll learn about how to design a workflow to build and deploy an application alongside its infrastructure.

## Build applications

Many types of applications need to be *compiled* or *built* before they can be used. The build process takes the source code for the application, performs a sequence of activities on it, and then creates a set of deployable files.

The build process compiles the source code into binary files or executables. Typically a build process also includes other activities, including compressing the image files that will be served to your website's users, *linting* your code to verify it follows good coding practices, and running *unit tests* that verify the behavior of individual pieces of your application. You might also perform steps like digitally signing the files to ensure they can't be modified.

Whatever the series of steps might be, the output of the build process is a deployable *artifact* that's saved to the workflow runner's file system. Later parts of your workflow need to work with the artifact to deploy it through your environments, and test it as it progresses through the quality gates you define in your workflow definition.

> [!NOTE]
> You might have heard of the terms *continuous integration* and *continuous deployment*, or *CI* and *CD*. A build process sits within the continuous integration part of your workflow.

### Workflow artifacts

The artifacts generated in your workflow aren't stored in your Git repository. They're derived from the source code, but they aren't code themselves and so they don't belong in a source control repository. They're created on the workflow runner's file system, which only is maintained for the duration of the workflow job.

*Workflow artifacts* provide a way to store files in GitHub Actions, and they're associated with the particular run of your workflow. You use the `actions/upload-artifact` workflow action to instruct GitHub Actions to upload a file or folder from the runner's file system as a workflow artifact:

```yaml
- name: Publish folder as a workflow artifact
  uses: actions/upload-artifact@v2
  with:
    name: my-artifact-name
    path: ./my-folder
```
<!-- TODO verify the above snippet works and publishes a folder -->

The `path` property is the location on the job runner's file system. The contents at this location will be published to the artifact. You can specify a single file, multiple times, or a folder.

Each artifact has a name, which you specify by using the `name` property. You use the artifact name to refer to it later in the workflow. Later jobs in the workflow can download the artifact so that they can work with them, such as to deploy the website to the server that hosts it:

:::image type="content" source="../media/3-website-workflow-artifact.png" alt-text="Diagram showing a workflow publishing and then referring to an artifact named 'Website'." border="false":::

You use the `actions/download-artifact` action to download a workflow artifact:

```yaml
- uses: actions/download-artifact@v2
  with:
    name: my-artifact-name
```
<!-- TODO verify the above snippet works and downloads the artifact -->

If you omit the `name` property, GitHub Actions downloads all of the workflow run's artifacts.

## Deploy applications

The build process for an application generates and publishes a deployable artifact. Later jobs in the workflow then deploy the artifact. The way that you deploy an application depends on the service you use to host it.

### Deploy to Azure App Service

Your toy company uses Azure App Service to host their website. An App Service app can be created and configured by using Bicep, but when it comes time to deploy the application itself, there are several options to get the compiled application onto the hosting infrastructure. These are all managed as part of the App Service data plane.

The most common approach is to use the `azure/webapps-deploy` action:

```yaml
- uses: azure/webapps-deploy@v2
  with:
    app-name: my-app-service
    package: my-artifact-name/website.zip
```
<!-- TODO verify the above snippet works and publishes the app -->

You need to provide the resource name of the App Service app, which you specify by using the `app-name` property. As you learned in the previous unit, you should add an output to your Bicep file, and use a workflow variable to propagate the application name through your workflow. You also need to specify a Zip file with the application to deploy by using the `package` input. Typically this is the path to a workflow artifact.

App Service has its own data plane authentication system that it uses for deployments. The `azure/webapps-deploy` action handles the authentication process automatically for you:

:::image type="content" source="../media/3-credential-exchange.png" alt-text="Diagram illustrating the credential exchange process." border="false":::

The `azure/webapps-deploy` action assumes the identity of the service principal associated with your active Azure session, which you signed in by using a secret (:::image type="icon" source="../media/callout-01.png":::). The action create and download the necessary credentials for deployment (:::image type="icon" source="../media/callout-02.png":::). Then, it uses the deployment credentials when it communicates with the App Service data plane API (:::image type="icon" source="../media/callout-03.png":::).

App Service also provides a number of other deployment-related features, including *deployment slots*. Slots help you to safely deploy new versions of your applications, and to prepare the new version to receive production traffic so that you have no downtime. We don't use slots in this module, but we provide more information in the summary.

### Deploy applications to other Azure services

Azure provides many other options for hosting your applications, each of which has its own approach for deployment.

Azure Functions is built on App Service, and uses a similar deployment process to the one described above.

If you deploy to a virtual machines, you typically need to connect to the virtual machine instance to install your application. You often need to use specialized tooling, like Chef, Puppet, or Ansible, to orchestrate deployment to virtual machines.

If you use Kubernetes or AKS, you typically use a slightly different approach to build and deploy your solution. After your application is built, your workflow creates a *container image* and publishes it to a *container registry*, which your Kubernetes cluster then reads from.

In this module, we focus on Azure App Service to illustrate the workflow concepts involved. We provide links to more information about deploying to other hosting services in the summary.

## Test applications in your workflow

In a previous module, you learned about the value and importance of running automated tests from your workflow. When you deploy an application, it's a good practice for the workflow to run some tests that invoke the application's code. This reduces the risk of an application or deployment error causing downtime. In more advanced scenarios, you might even perform a set of test cases against your application, such as invoking APIs or submitting and monitoring a synthetic transaction.

Many applications implement *health check endpoints*. When a health check endpoint receives a request, it perform a series of checks against the website, such as ensuring that databases and network services are reachable from the application environment. The response it returns indicates whether the application is healthy. Developers can write and customize their own health checks to suit the application's requirements. If your application has a health check endpoint, it often makes sense to monitor it from your workflow after the deployment job completes.
