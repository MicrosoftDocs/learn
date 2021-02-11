In this section, you follow along with Andy and Mara as they plan a basic CD pipeline that runs on Azure Pipelines.

When it's done, they'll demo it to the rest of the team. The pipeline will serve as a POC that they'll improve on and expand as they learn more and get feedback from Tim and Amita.

Andy and Mara are sitting in a conference room, ready to get started.

**Andy:** I've never built a CD pipeline before. Have you?

**Mara:** I've worked with a few of the CD pipeline tools we discussed earlier, but I haven't set one up.

**Andy:** Because we're both new to this process, maybe we should start with the automated pipeline we already have: our build pipeline. 

**Mara:** Great minds think alike. We could probably extend our existing build configuration. But how do we turn our build pipeline into a CD pipeline?

## What are the parts of a basic CD pipeline?

A basic CD pipeline contains a _trigger_ to get the process going and at least one _stage_, or deployment phase. A stage is made up of jobs. A job is a series of steps that defines how to build, test, or deploy your software.

Let's follow along with Andy and Mara as they plan their POC.

**Andy:** Here's what I think we need to start.

Andy draws a diagram on the whiteboard.

![A hand-drawn illustration of an artifact moving to a deployment environment](../media/3-whiteboard-1.png)

**Andy:** We already have the ![Callout 1](../../shared/media/callout-01.png) build artifact. It's the _.zip_ file that our existing build pipeline creates. But how do we deploy it to a ![Callout 2](../../shared/media/callout-02.png) live environment?

**Mara:** In the CD pipelines I worked with, we defined the deployment process in stages, such as building the artifact and deploying the artifact to the various testing and production environments. Each stage breaks down into one or more jobs. Each job breaks down into tasks, just like the ones we use in our existing build pipeline.

## What is a pipeline stage?

A _stage_ is a part of the pipeline that can run independently and be triggered by different mechanisms. A mechanism might be the success of the previous stage, a schedule, or even a manual trigger. You'll learn more about these mechanisms in the next module.

**Mara:** I think that deciding on our stages is a great start and pretty straightforward. Let's define a _stage_ as a major division in a pipeline. Every stage is independent of every other stage. We could have a stage that builds the app and another stage that runs tests. There are many possibilities. Because we want to keep it simple, how about we start with two stages?

Mara updates the diagram on the whiteboard.

![A hand-drawn illustration of a deployment pipeline that contains two stages](../media/3-whiteboard-3.png)

**Mara:** We've already defined the tasks for the ![Callout 1](../../shared/media/callout-01.png) build stage in our pipeline. Our ![Callout 2](../../shared/media/callout-02.png) deployment stage can be similar, including tasks that deploy the build to an environment.

The question is, where should we deploy the artifact?

## What is an environment?

You've likely used the term _environment_ to refer to where your application or service is running. For example, your _production environment_ might be where your end users access your application.

Following this example, your production environment might be:

* A physical machine or virtual machine (VM).
* A containerized environment, such as Kubernetes.
* A managed service, such as Azure App Service.
* A serverless environment, such as Azure Functions.

An artifact is deployed to an environment. Azure Pipelines makes it easy to deploy to almost any kind of environment, whether it's on-premises or in the cloud.

In Azure Pipelines, the term _environment_ has a second meaning. Here, an _environment_ is an abstract representation of your deployment environment, such as a Kubernetes cluster, an App Service instance, or a virtual machine.

An Azure Pipelines environment records the deployment history to help you identify the source of changes. By using Azure Pipelines environments, you can also define security checks and ways to control how an artifact is promoted from one stage of a pipeline to another. What an environment includes depends on what you want to do with the artifact. An environment where you want to test the artifact will probably be defined differently than one where you want to deploy the artifact for your end users.

One way to define an Azure Pipelines environment is with a YAML file. Your YAML file includes an `environment` section, which specifies the Azure Pipelines environment where you'll deploy your artifact.

As you plan your release pipeline, you'll need to decide where your application or service will run. Let's listen in and see what Andy and Mara decide.

**Andy:** At a high level, what type of environment do we want? Do we want to deploy on-premises or to the cloud?

**Mara:** We could ask Tim to create a VM for us in the lab. But he's always running out of hardware. It'll be fast and easy to set up a POC ourselves if we use the cloud.

**Andy:** I agree. But there are so many cloud options to consider, and we can use Azure Pipelines to deploy to any of them. Which should we try?

**Mara:** The teams that develop our games use Azure to host some of their back-end systems. They set it up quickly and seem to like it. I think we should stick with Azure for our cloud.

**Andy:** OK. That makes sense! But Azure provides so many compute options. Which should we pick?

Andy lists these options on the whiteboard:

* Virtual machines
* Containers
* Azure App Service
* Serverless computing

> [!NOTE]
> You'll find more information on each of these compute options at the end of this module.

**Mara:** I know containers and serverless computing are popular right now. Compared to VMs, they're both lightweight in terms of resources. They're also easy to replace and scale out. Both are interesting, but I'm nervous about learning two new technologies at the same time. I'd rather concentrate just on building the pipeline.

**Andy:** I'm with you. That leaves VMs or App Service. I think VMs would be a better choice if we were moving a line-of-business app, one that requires full access to some particular environment, to the cloud. We're not doing anything that significant.

**Mara:** That leaves App Service, which would be my choice. It's designed to work with Azure DevOps, and it comes with advantages. It's a platform-as-a-service (PaaS) environment for web apps, so it takes a lot of the burden off of us. We won't have to worry about infrastructure. It also comes with security features and lets us perform load balancing and automatic scaling.

**Andy:** App Service sounds like what we need. Let's use App Service. We're creating just a proof of concept anyway. We can always change the compute option if we want to try something else later.

## How does Azure Pipelines perform deployment steps?

To deploy your software, Azure Pipelines first needs to authenticate with the target environment. Azure Pipelines provides different authentication mechanisms. The one you use depends on the target environment you're deploying to. You'll find more information about these mechanisms at the end of this module.

**Andy:** We have our build artifact, and we know we'll build and deploy in stages of the pipeline. We've also defined the target environment for our deployment. That's App Service. My question now is, how does Azure Pipelines authenticate with App Service? I know this will be one of Tim's concerns. We need to ensure the process is secure.

After a bit of research, Andy and Mara come up with the general steps that allow Azure Pipelines to deploy to App Service:

1. Specify the target deployment environment in the pipeline configuration.
1. Provide a way for Azure Pipelines to authenticate access to that environment.
1. Use Azure Pipelines tasks to deploy the build artifact to that environment.

**Mara:** According to our research, we need to create a _service connection_ to specify the target environment and authenticate access to it. After we define the service connection, it will be available for all of our tasks to use. Then we need to use the built-in tasks [DownloadPipelineArtifact@2](https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/download-pipeline-artifact?azure-portal=true) and [AzureWebApp@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-rm-web-app?azure-portal=true).

**Andy:** I have the tasks here. Let's see what they do for us.

### Download pipeline artifacts

In the previous learning path, you published build artifacts to the pipeline. These artifacts were _.zip_ files that contained the _Space Game_ website as a build package. Amita manually downloaded this package and installed it in her test environment.

To deploy a build artifact from the pipeline, you need a way to download it from the pipeline to the agent. You use the `DownloadPipelineArtifact@2` task to download artifacts.

This task requires a few inputs. The ones we need here are:

* `buildType`, which specifies whether we want the artifacts from the current build or a specific build. For now, we want to deploy the current build.
* `artifact`, which specifies the name of the artifact to download. We need this input to specify the name of the _.zip_ file.

This example downloads the latest package named "drop" from the pipeline to the build agent:

```yml
- task: DownloadPipelineArtifact@2
  inputs:
    buildType: current
    artifact: 'drop'
```

The `download` task is a shortcut for the `DownloadPipelineArtifact@2` task. Here's an example that uses the `download` task to download the same artifact from the pipeline:

```yml
- download: current
  artifact: drop
```

### Deploy a web application to App Service

You use the `AzureWebApp@1` task to deploy a web application to App Service. This task works with several programming languages and frameworks, including ASP.NET, ASP.NET Core, PHP, Java, Python, Go, and Node.js. We use this task to do the deployment. To use it, though, we have to have App Service running on our Azure subscription.

This task also requires a few inputs:

* `azureSubscription` is the service connection we talked about earlier. We need this input to authenticate with the target environment.
* `appName` specifies the name of our App Service instance.
* `package` specifies where on the build agent to find the package to deploy.

This example uses `AzureWebApp@1` to deploy the contents of _MyPackage.zip_ to an App Service instance named "MyWebApp":

```yml
- task: AzureWebApp@1
  inputs:
    azureSubscription: 'MyServiceConnection'
    appName: 'MyWebApp'
    package: '**/MyPackage.zip'
```

The `azureSubscription` part specifies the service connection that's named `MyServiceConnection`. You'll work with service connections shortly.

### What are jobs and strategies?

Your existing build pipeline defines a build agent, pipeline variables, and the tasks needed to build your software.

The deployment part of your pipeline contains these same elements. Your deployment configuration typically also defines one or more jobs, a pipeline environment, and strategies. You learned about pipeline environments earlier.

Here's an example configuration that you'll run later in this module. This configuration deploys the _Space Game_ website to App Service.

[!code-yml[](code/3-azure-pipelines.yml?highlight=4-5,8,11-13)]

#### Jobs

A _job_ is a series of steps, or tasks, that run sequentially as a unit. Every pipeline stage has one job by default, even when that stage doesn't use the `job` keyword.

A job can run in an agent pool, on a container, or directly on the Azure DevOps server. The example job shown here runs on a Microsoft-hosted Ubuntu agent.

You can specify the conditions under which each job runs. The example job shown here doesn't define any conditions. By default, a job runs if it doesn't depend on any other job or if all of the jobs that it does depend on have finished successfully.

You can also run jobs in parallel or sequentially. Using your existing build pipeline as an example, you can use parallel jobs to build your software on Windows, Linux, and macOS agents simultaneously.

A _deployment job_ is a special type of job that plays an important role in your deployment stages. Deployment jobs record the status of your deployments in Azure Pipelines, providing you with an audit trail. Deployment jobs also help you define your deployment strategy, which we'll do shortly.

#### Strategies

A _strategy_ defines how your application is rolled out. You'll learn more about strategies such as blue-green and canary in a future module. For now, you'll use the _runOnce_ strategy to download the _Space Game_ package from the pipeline and deploy it to App Service.

### How does Azure Pipelines connect to Azure?

To deploy your app to an Azure resource, such as a virtual machine or App Service, you need a _service connection_. A service connection provides secure access to your Azure subscription by using one of two methods:

* Service principal authentication
* Managed identities for Azure resources

You can learn more about these security models at the end of this module, but in short:

* A _service principal_ is an identity with a limited role that can access Azure resources. Think of a service principal as a service account that can do automated tasks on your behalf.
* _Managed identities_ for Azure resources are a feature of Azure Active Directory (Azure AD). Managed identities simplify the process of working with service principals. Because managed identities exist on the Azure AD tenant, Azure infrastructure can automatically authenticate the service and manage the account for you.

Managed identities simplify the process of working with service principals. But in this module you use service principal authentication because a service connection can automatically discover your Azure resources and assign the appropriate service principal roles for you.

## The plan

Andy and Mara are ready to begin. They're going to:

* Build on their existing Azure Pipelines build configuration.
* Define a build stage that creates the artifact.
* Define a deployment stage that deploys the artifact to App Service.

![A hand-drawn illustration of a deployment pipeline that contains two stages](../media/3-whiteboard-4.png)

**Andy:** Is this drawing correct? We use ![Callout 1](../../shared/media/callout-01.png) Azure Pipelines to deploy to ![Callout 2](../../shared/media/callout-02.png) App Service. To do that, we take the ![Callout 3](../../shared/media/callout-03.png) build artifact as the input to the ![Callout 4](../../shared/media/callout-04.png) deployment stage. The tasks in the deployment stage ![Callout 5](../../shared/media/callout-05.png) download the artifact and use a service connection to ![Callout 6](../../shared/media/callout-06.png) deploy the artifact to App Service.

**Mara:** That about sums it up. Let's get started.