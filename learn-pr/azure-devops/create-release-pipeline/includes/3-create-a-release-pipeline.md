In this section, you follow along with Andy and Mara as they plan their basic CD pipeline that runs on Azure Pipelines.

Andy and Mara are going to create a basic CD pipeline to demo to the rest of the team. The pipeline will serve as a proof of concept that they'll improve on and expand as they learn more and get feedback from Tim and Amita. Andy and Mara are sitting in a conference room, ready to get started.

**Andy:** I've never built a CD pipeline before. Have you?

**Mara:** I've worked with a few of the CD pipeline tools we discussed earlier, but I haven't set one up.

**Andy:** Given we're both new to this, I think that we already have a working automated pipeline: our build pipeline. We could start with that.

**Mara:** Great minds think alike. We could probably extend our existing build configuration. But what do we need to turn our build pipeline into a CD pipeline?

## What makes up a basic CD pipeline?

A basic CD pipeline contains a _trigger_ to get the process going and at least one stage, or deployment phase. A stage is made up of tasks.

Let's follow along with Andy and Mara as they plan their proof of concept.

**Andy:** Here's what I think we need to start.

Andy draws a diagram on the whiteboard.

![A hand-drawn illustration of an artifact moving to a deployment environment](../media/3-whiteboard-1.png)

**Andy:** We already have the ![Callout 1](../../shared/media/callout-01.png) build artifact: the _zip_ file that's produced by our exiting build pipeline. But how do we deploy it to some ![Callout 2](../../shared/media/callout-02.png) live environment?

**Mara:** In the CD pipelines I've worked with, we used stages to define each phase of the deployment process, such as building the artifact and deploying the artifact to the various testing and production environments. Each stage breaks down into tasks, just like the ones we use in our existing build pipeline.

## What is a pipeline stage?

A _stage_ is a part of the pipeline that can run independently and be triggered by different mechanisms, such as the success of the previous stage, a schedule, or even manually. You learn more about these mechanisms in the next module.

**Mara:** I think that's a great start and pretty straightforward. Let's define a *stage* as a major division in a pipeline. Every stage is independent of every other stage. We could have a stage that builds the app and another stage that runs tests. There are many possibilities. But we want to keep it simple so what about two stages?

Mara updates the diagram on the whiteboard.

![A hand-drawn illustration of a deployment pipeline that contains two stages](../media/3-whiteboard-3.png)

**Mara:** We've already defined the tasks for the ![Callout 1](../../shared/media/callout-01.png) build stage in our pipeline. For the ![Callout 2](../../shared/media/callout-02.png) deployment stage, we can create a similar stage that includes tasks that deploy the build to some environment.

The question is, where should we deploy the artifact?

## Where can I host my deployments?

Azure Pipelines enables you to deploy to just about any kind of environment &mdash; whether it's on-premises or in the cloud. Let's listen in and see what the team decides.

**Andy:** At a really high level, do you want to deploy on-premises or to the cloud?

**Mara:** We could ask Tim to create a VM for us in the lab, but he's always running out of hardware. It'll be super fast and easy to set up a POC ourselves if we use the cloud.

**Andy:** I agree. But there are so many cloud options to consider, and we can use Azure Pipelines to deploy to any of them. Which should we try?

**Mara:** The teams who are developing the games are using Azure to host some of their backend systems. They were able to get set up quickly and they seem to like it. I think we should try that.

**Andy:** OK. Let's try it! We are making progress on the plan, but Azure provides so many compute options. Which should we pick?

Andy lists these options on the whiteboard:

* Virtual machines (VMs)
* Containers
* Azure App Service
* Serverless computing

> [!Note]
> More information on each of these options can be found in the summary of this module.

**Mara:** I know containers and serverless computing are really popular right now. Compared to VMs, they're both lightweight in terms of resources. I also know that they're easy to replace and scale up. They're both interesting but I'm nervous learning about two new technologies at the same time. I'd rather concentrate just on building the pipeline.

**Andy:** I'm with you. That leaves VMs or Azure App Service. I think VMs would be a better choice if we were moving some line-of-business app, one that needs its own particular environment, to the cloud. We're not doing anything that big.

**Mara:** That leaves App Service. That would be my choice. It's designed to work with Azure DevOps and it comes with a lot of advantages. It's a platform-as-a-service (PaaS) environment for web apps so it takes a lot of the burden off of us. We won't have to worry about infrastructure. It also comes with security features and enables us to perform load balancing, and automatic scaling.

**Andy:** That sounds like what we need. Let's use App Service. This is just a proof of concept anyway. We can always change it if we want to try something else.

## How does Azure Pipelines perform deployment steps?

For Azure Pipelines to deploy your software, it needs to authenticate with the target environment. Azure Pipelines provides different authentication mechanisms, and the one you use depends on the target environment you're deploying to. You'll find more information on these mechanisms at the end of this module.

**Andy:** We have our build artifact, and we know we will do the build and deployment in steps. We've also defined the target environment for our deployment. My question now is, how does Azure Pipelines authenticate with the target environment? I know this will be one of Tim's concerns. We need to ensure the process is secure.

After a bit of research, Andy and Mara come up with the general steps they need to allow Azure Pipelines to deploy to App Service.

1. Specify the target deployment environment in the build configuration.
1. Provide a way for Azure Pipelines to authenticate access to that environment.
1. Use Azure Pipelines tasks to deploy the build artifact to that environment.

**Mara:** According to our research, we need to create what's called a _service connection_ to specify the target environment and authenticate access to it. Once we define the service connection, it will be available for all of our tasks to use.

Then we need to use the built-in tasks [DownloadBuildArtifacts@0](https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/download-build-artifacts?azure-portal=true) and [AzureRmWebAppDeployment@4](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment?azure-portal=true).

**Andy:** I have the tasks here. Let's see what they do for us.

### DownloadBuildArtifacts@0

You use the `DownloadBuildArtifacts@0` task to download artifacts. We need this task to get the artifact to deploy from the pipeline.

This task requires a few inputs. They are:

* `buildType`: This specifies whether we want the artifacts from the current build or a specific build. For now, we want to deploy the current build.
* `downloadType`: This specifies whether to download a single artifact or all the artifacts associated with this build. We want to download the _zip_ file that contains the web application package.
* `artifactName`: This specifies the name of the artifact to download. We need this because we need to specify the name of the _zip_ file.
* `downloadPath`: This specifies where to find the artifact on the build agent.

### AzureRmWebAppDeployment@4

You use the `AzureRmWebAppDeployment@4` task to deploy a web application to App Service. This task works with a number of programming languages and frameworks, including ASP.NET, ASP.NET Core, PHP, Java, Python, Go, and Node.js. We use this task to perform the deployment. To use it, though, we have to have App Service running on our Azure subscription.

This task also requires a few inputs. They are:

* `azureSubscription`: This is the service connection we talked about earlier. We need this to authenticate with the target environment.
* `appType`: This specifies the App Service environment. These include Linux, Windows, containers, and serverless environments. We're deploying to Linux.
* `webAppName`: This specifies the name of our App Service.
* `startupCommand`: This specifies the command to run to launch the web application. We need this to make sure our web app is started. Because our web application uses .NET Core, our startup command is `dotnet Tailspin.SpaceGame.Web.dll`.
* `package`: This specifies where to find the package to deploy.

### How does Azure Pipelines connect to Azure?

The team mentioned how a _service connection_ would enable them to more easily connect to Azure resources from Azure DevOps.

You can use Azure Pipelines to deploy to just about any type of environment. That environment can run in the cloud or in your datacenter. Your environment can be:

* A virtual machine
* A containerized environment such as Kubernetes
* A managed service such as App Service
* A serverless environment such as Azure Functions

To deploy your app to an Azure resource, such as a virtual machine or App Service, you need what's called a _service connection_.

A service connection provides secure access to your Azure subscription by using one of two methods:

* Service Principal Authentication
* Managed identities for Azure resources

You can learn more about these security models at the end of this module, but in short:

* A _service principal_ is an identity with a limited role that can access Azure resources. Think of a service principal as a service account that can perform automated tasks on your behalf.
* Managed identities for Azure resources is a feature of Azure Active Directory (Azure AD). Managed identities simplify the process of working with service principals. Because managed identities exist on the Azure AD tenant, Azure infrastructure can automatically take care of authenticating the service and managing the account for you.

Although managed identities simplify the process of working with service principals, in this module you use service principal authentication because a service connection can automatically discover your Azure resources and assign the appropriate service principal roles for you.

## The plan

Andy and Mara are ready to begin. They're going to:

* Build upon their existing Azure Pipelines build configuration.
* Define a build stage that creates the artifact.
* Define a deployment stage that deploys the artifact to App Service.

![A hand-drawn illustration of a deployment pipeline that contains two stages](../media/3-whiteboard-4.png)

**Andy:** We will use ![Callout 1](../../shared/media/callout-01.png) Azure Pipelines to deploy to ![Callout 2](../../shared/media/callout-02.png) App Service. We take the existing ![Callout 3](../../shared/media/callout-03.png) build artifact as the input to the ![Callout 4](../../shared/media/callout-04.png) deployment stage. The tasks in the deployment stage ![Callout 5](../../shared/media/callout-05.png) download the artifact and ![Callout 6](../../shared/media/callout-06.png) deploy the artifact to the App Service by using a service connection.

**Mara:** That about sums it up. Let's get started.