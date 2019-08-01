In this part, you plan the simple Azure Pipelines CD pipeline.

Andy and Mara are going to create a simple CD pipeline to demo to the rest of the team. The pipeline will be a Proof of concept that they'll improve on and expand as they learn more and get feedback from Tim and Amita. They're sitting in a conference room, ready to get started.

**Andy:** I've never built a CD pipeline before. Have you?

**Mara:** I've worked with CD pipelines, but I haven't set one up.

**Andy:** Given we're both newbies, I was thinking that we already have a working automated pipeline--our build pipeline. We could start with that.

**Mara:** Great minds think alike. We could probably extend our existing build configuration. But what do we need to turn our build pipeline into a CD pipeline?

## What makes up a basic pipeline?

A basic pipeline contains a trigger to get the pipeline going, at least one stage, and tasks for each stage.

Let's follow along with Andy and Mara as they plan their proof of concept.

**Andy:** Here's what I think we need to start.

He draws a diagram on the whiteboard.

![A hand-drawn illustration of an artifact to a deployment environment](../media/3-whiteboard-1.png)

**Andy:** We already have the ![Callout 1](../../shared/media/callout-01.png) build artifact - the .zip file that's produced by our exiting build pipeline. But how do we deploy it to some ![Callout 2](../../shared/media/callout-02.png) live environment?

**Mara:** In the CD pipelines I've worked with, we used stages to define each phase of the deployment process, such as building the artifact and deploying the artifact to the various testing and production environments. Each stage breaks down into tasks, just like the ones we use in our existing build pipeline.

## What is a stage?

A _stage_ is a part of the pipeline that can run independently and be triggered by different mechanisms such as the success of the previous stage, or a schedule, or even manually. You learn more about this in the next module.

**Mara:** I think that's a great start and pretty straightforward. Lets define a *stage* as a major division in a pipeline. Every stage is independent of every other stage. We could have a stage that builds the app, another that runs some tests, there's lots of possibilities. But we want to keep it simple so what about two stages?

Mara updates the diagram on the whiteboard.

![A hand-drawn illustration of a deployment pipeline with 2 stages](../media/3-whiteboard-3.png)

**Mara:** We've already defined the tasks for the ![Callout 1](../../shared/media/callout-01.png) build stage in our pipeline. For the ![Callout 2](../../shared/media/callout-02.png) deployment stage, we can create a similar stage that includes tasks that deploy the build to some environment.

The question is, where should we deploy the artifact?

## Where can I host my deployments?

Azure Pipelines enables you to deploy to just about any kind of environment &mdash; whether it's on-prem or in the cloud. Let's listen in and see what the team decides.

**Andy:** At a really high level, do you want to deploy on premises or to Azure?

**Mara:** We could ask Tim to create a VM for us in the lab, but I vote for the cloud. It'll be super fast and easy to set up a POC ourselves.

**Andy:** I agree. But there are so many cloud options to consider, and we can use Azure Pipelines to deploy to any of them. Which should we try?

**Mara:** The teams who are developing the games are using Azure to host some of their backend systems. They were able to get set up quickly and they seem to like it. I think we should try that.

**Andy:** OK. Let's try it! We are making progress on the plan, but Azure provides so many compute options. Which should we pick?

Andy lists these options on the whiteboard:

* Virtual machines
* Containers
* Azure App Service
* Serverless computing

> [!Note]
> More information on each of these options can be found in the summary of this module.

**Mara:** I know containers and serverless computing are really popular right now. Compared to VMs, they're both lightweight in terms of resources. I also know that they're easy to replace and scale up. They're both interesting but I'm nervous learning about two new technologies at once. I'd rather just concentrate on building the pipeline.

**Andy:** I'm with you. That leaves VMs or Azure App Service. I think VMs would be a better choice if we were moving some line-of-business app that needed it's own particular environment to the cloud. We're not doing anything that big.

**Mara:** That leaves Azure App Service. That would be my choice. It's designed to work with Azure DevOps and it comes with a lot of advantages. It's a platform-as-a-service (PaaS) environment for web apps so it takes a lot of the burden off of us. We won't have to worry about infrastructure and we get a lot of benefits, like security, load balancing, and auto-scaling.

**Andy:** That sounds like what we need. Let's use Azure App Service. This is just a proof of concept anyway. We can always change it if we want to try something else.

## How does Azure Pipelines perform deployment steps?

In order for Azure Pipelines to deploy your software, it will need to authenticate onto the target environment. Different authentication mechanisms are employed depending on the the target you're deploying. More information on the mechanisms used are in the summary at the end of this module.

**Andy:** So we have our artifact, and we know we will do the build and deployment in steps. We have also defined the target environment for our deployment. My question now is, how does Azure Pipelines authenticate on to the target environment? I know this will be a concern of Tim's. We need to be sure it is secure.

After a bit of research, Andy and Mara come up with the general steps they will need to allow Azure Pipelines to deploy to their App Service environment.

1. Specify the target deployment environment in your build configuration.
1. Provide a way for Azure Pipelines to authenticate access to that environment.
1. Use Azure Pipelines tasks to deploy the build artifact to that environment.

**Mara:** According to our research, we will need to create what's called a _service connection_ to specify the target environment and authenticate access to it. Once we define the service connection, it will be available for all of our tasks to use. 

Then we need to use the built-in tasks [DownloadBuildArtifacts@0](https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/download-build-artifacts?azure-portal=true) and [AzureRmWebAppDeployment@4](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-deployment?azure-portal=true).

**Andy:** I have the tasks here. Let's see what they do for us.

The `DownloadBuildArtifacts@0` task is used to download artifacts. We'll need to do this to get the artifact to deploy.

We'll need these inputs:

* `buildType:` We can use this to say if we want the current build, or name a project as a specific build.
* `downloadType:` We use this to specify a single artifact, or all the artifacts associated with this build.
* `artifactName:` We need this if we use `single` in the downloadType.
* `downloadPath:` Where to find the artifact on the agent machine.

The `AzureRmWebAppDeployment@4` task is used to deploy a range of App Services on Azure and works for ASP.NET, ASP.NET Core, PHP, Java, Python, Go, and Node.js based web applications. We'll use this to do the actual deployment. To use it, though, we have to have an App Service instance and an Azure subscription.

We'll need these inputs:

* `azureSubscription:` This is the service connection we talked about. We need this to authenticate to the target environment.
* `appType:` What kind of webApp are we deploying
* `WebAppName:` Our App Service Name
* `StartupCommand:` We'll need this to make sure our web app is started. Our is: `dotnet Tailspin.SpaceGame.Web.dll`
* `Package:` This is where to find the package to deploy. It should be in a standard location depending on the download task.

## The plan

Andy and Mara are ready to start. They're going to:

* Use the existing build configuration running on Azure Pipelines as the basis of the CD pipeline
* Have a build stage that creates the artifact
* Have a deploy stage that deploys the artifact to Azure App Service

![A hand-drawn illustration of a deployment pipeline with 2 stages](../media/3-whiteboard-4.png)

**Andy:** So we will use ![Callout 1](../../shared/media/callout-01.png) Azure Pipelines to deploy to an ![Callout 2](../../shared/media/callout-02.png) Azure AppService. We will take the existing ![Callout 3](../../shared/media/callout-03.png) build artifact as the source for the ![Callout 4](../../shared/media/callout-04.png) deploy stage. The tasks in the deploy stage will ![Callout 5](../../shared/media/callout-05.png) download the artifact and ![Callout 6](../../shared/media/callout-06.png) deploy the build to the Azure App Service using a service connection.

**Mara:** That about sums it up. Let's get started.