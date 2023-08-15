In this section, you'll follow along with Andy and Mara as they plan a basic CD pipeline that runs on Azure Pipelines.

When it's done, they'll demo it to the rest of the team. The pipeline will serve as a POC that they'll improve on and expand as they learn more and get feedback from Tim and Amita.

## What are the parts of a basic CD pipeline?

A basic CD pipeline contains a _trigger_ to get the process going and at least one _stage_, or deployment phase. A stage is made up of _jobs_. A job is a series of steps that defines how to build, test, or deploy your application.

:::image type="content" source="../media/3-whiteboard-1.png" alt-text="Diagram that shows a hand-drawn illustration of an artifact moving to a deployment environment.":::

**Andy:** We already have the :::image type="icon" source="../../shared/media/callout-01.png"::: build artifact. It's the _.zip_ file that our existing build pipeline creates. But how do we deploy it to a :::image type="icon" source="../../shared/media/callout-02.png"::: live environment?

## What is a pipeline stage?

A _stage_ is a part of the pipeline that can run independently and be triggered by different mechanisms. A mechanism might be the success of the previous stage, a schedule, or even a manual trigger. You'll learn more about these mechanisms in the next module.

**Mara:** We could have a stage that builds the app and another stage that runs tests.

:::image type="content" source="../media/3-whiteboard-3.png" alt-text="Diagram that shows a hand-drawn illustration of a deployment pipeline that contains two stages, Build and Deploy.":::

**Mara:** We've already defined the tasks for the build stage :::image type="icon" source="../../shared/media/callout-01.png"::: in our pipeline. Our deployment stage :::image type="icon" source="../../shared/media/callout-02.png"::: can be similar, including tasks that deploy the build to an environment.

The question is, where should we deploy the artifact?

## What is an environment?

You've likely used the term _environment_ to refer to where your application or service is running. For example, your _production_ environment might be where your end users access your application.

Following this example, your production environment might be:

* A physical machine or virtual machine (VM).
* A containerized environment, such as Kubernetes.
* A managed service, such as Azure App Service.
* A serverless environment, such as Azure Functions.

An artifact is deployed to an environment. Azure Pipelines makes it easy to deploy to almost any kind of environment, whether it's on-premises or in the cloud.

In Azure Pipelines, the term environment has a second meaning. Here, an environment is an abstract representation of your deployment environment, such as a Kubernetes cluster, an App Service instance, or a virtual machine.

An Azure Pipelines environment records the deployment history to help you identify the source of changes. By using Azure Pipelines environments, you can also define security checks and ways to control how an artifact is promoted from one stage of a pipeline to another. What an environment includes depends on what you want to do with the artifact. An environment where you want to test the artifact will probably be defined differently than one where you want to deploy the artifact for your end users.

One way to define an Azure Pipelines environment is with a YAML file. Your YAML file includes an `environment` section, which specifies the Azure Pipelines environment, where you'll deploy your artifact.

As you plan your release pipeline, you'll need to decide where your application or service will run. Let's listen in and see what Andy and Mara decide.

**Andy:** At a high level, what type of environment do we want? Do we want to deploy on-premises or to the cloud?

**Mara:** We could ask Tim to create a VM for us in the lab, but he's always running out of hardware. It'll be fast and easy to set up a POC ourselves if we use the cloud.

**Andy:** I agree; but there are so many cloud options to consider, and we can use Azure Pipelines to deploy to any of them. Which should we try?

**Mara:** The teams that develop our games use Azure to host some of their back-end systems. They set it up quickly and seem to like it. I think we should stick with Azure for our cloud.

**Andy:** OK, that makes sense! But Azure provides so many compute options. Which should we pick?

Andy lists these options on the whiteboard:

* Virtual machines
* Containers
* Azure App Service
* Serverless computing

> [!NOTE]
> You'll find more information on each of these compute options at the end of this module.

**Mara:** I know containers and serverless computing are popular right now. Compared to VMs, they're both lightweight in terms of resources. They're also easy to replace and scale out. Both are interesting, but I'm nervous about learning two new technologies at the same time. I'd rather concentrate just on building the pipeline.

**Andy:** I'm with you. That leaves VMs or App Service. I think VMs would be a better choice if we were moving a line-of-business app—one that requires full access to some particular environment—to the cloud. We're not doing anything that significant.

**Mara:** That leaves App Service, which would be my choice. It's designed to work with Azure DevOps, and it comes with advantages. It's a platform as a service (PaaS) environment for web apps, so it takes a lot of the burden off us. We won't have to worry about infrastructure. It also comes with security features and lets us perform load balancing and automatic scaling.

**Andy:** App Service sounds like what we need. Let's use App Service. We're creating just a proof of concept anyway. We can always change the compute option if we want to try something else later.

## How does Azure Pipelines perform deployment steps?

To deploy your application, Azure Pipelines first needs to authenticate with the target environment. Azure Pipelines provides different authentication mechanisms. The one you use depends on the target environment to which you're deploying. You'll find more information about these mechanisms at the end of this module.

**Andy:** We have our build artifact, and we know we'll build and deploy in stages of the pipeline. We've also defined the target environment for our deployment. That's App Service. My question now is, how does Azure Pipelines authenticate with App Service? I know this will be one of Tim's concerns. We need to ensure the process is secure.

After a bit of research, Andy and Mara come up with the general steps that allow Azure Pipelines to deploy to App Service:

1. Specify the target deployment environment in the pipeline configuration.
1. Provide a way for Azure Pipelines to authenticate access to that environment.
1. Use Azure Pipelines tasks to deploy the build artifact to that environment.

**Mara:** According to our research, we need to create a _service connection_ to specify the target environment and authenticate access to it. After we define the service connection, it'll be available for all of our tasks to use. Then we need to use the built-in tasks [DownloadPipelineArtifact](/azure/devops/pipelines/tasks/utility/download-pipeline-artifact?azure-portal=true) to download the build artifact to the pipeline agent and [AzureWebApp](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app?azure-portal=true) to deploy our application to Azure App Service.

### What are jobs and strategies?

Your existing build pipeline defines a build agent, pipeline variables, and the tasks needed to build your software.

The deployment part of your pipeline contains these same elements. Your deployment configuration typically also defines one or more jobs, a pipeline environment, and strategies. You learned about pipeline environments earlier.

Here's an example configuration that you'll run later in this module. This configuration deploys the _Space Game_ website to Azure App Service.

[!code-yml[](code/3-azure-pipelines.yml?highlight=4-5,8,11-13)]

#### Jobs

A _job_ is a series of steps, or tasks, that run sequentially as a unit. Every pipeline stage has one job by default, even when that stage doesn't use the `job` keyword.

A job can run in an agent pool, on a container, or directly on the Azure DevOps server. The example job shown here runs on a Microsoft-hosted Ubuntu agent.

You can specify the conditions under which each job runs. The example job shown here doesn't define any conditions. By default, a job runs if it doesn't depend on any other job, or if all of the jobs on which it does depend have finished successfully.

You can also run jobs in parallel or sequentially. Using your existing build pipeline as an example, you can use parallel jobs to build your software on Windows, Linux, and macOS agents simultaneously.

A [deployment job](/azure/devops/pipelines/process/deployment-jobs) is a special type of job that plays an important role in your deployment stages. Deployment jobs record the status of your deployments in Azure Pipelines, providing you with an audit trail. Deployment jobs also help you define your deployment strategy, which we'll do shortly.

#### Strategies

A _strategy_ defines how your application is rolled out. You'll learn more about strategies such as blue-green and canary in a future module. For now, you'll use the **runOnce** strategy to download the _Space Game_ package from the pipeline and deploy it to Azure App Service.

### How does Azure Pipelines connect to Azure?

To deploy your app to an Azure resource, such as a virtual machine or App Service, you need a _service connection_. A service connection provides secure access to your Azure subscription by using one of the two methods:

* Service principal authentication
* Managed identities for Azure resources

You can learn more about these security models at the end of this module, but in short:

* A **service principal** is an identity with a limited role that can access Azure resources. Think of a service principal as a service account that can do automated tasks on your behalf.
* **Managed identities** for Azure resources are a feature of Azure Active Directory (Azure AD) that simplifies the process of working with service principals. Because managed identities exist on the Azure AD tenant, Azure infrastructure can automatically authenticate the service and manage the account for you.

Managed identities simplify the process of working with service principals; but in this module, we'll be using service principal authentication because a service connection can automatically discover your Azure resources and assign the appropriate service principal roles for you.

## The plan

Andy and Mara are ready to begin. They're going to:

* Build on their existing Azure Pipelines build configuration.
* Define a build stage that creates the artifact.
* Define a deployment stage that deploys the artifact to App Service.

:::image type="content" source="../media/3-whiteboard-4.png" alt-text="Diagram that shows a hand-drawn illustration of a deployment pipeline that contains two stages. The deployment stage deploys the artifact to App Service.":::

**Andy:** Is this drawing correct? We use Azure Pipelines :::image type="icon" source="../../shared/media/callout-01.png"::: to deploy to Azure App Service:::image type="icon" source="../../shared/media/callout-02.png":::. To do that, we take the build artifact :::image type="icon" source="../../shared/media/callout-03.png"::: as the input to the deployment stage :::image type="icon" source="../../shared/media/callout-04.png":::. The tasks in the deployment stage download the artifact :::image type="icon" source="../../shared/media/callout-05.png"::: and use a service connection to deploy the artifact to App Service :::image type="icon" source="../../shared/media/callout-06.png":::.

**Mara:** That about sums it up. Let's get started.
