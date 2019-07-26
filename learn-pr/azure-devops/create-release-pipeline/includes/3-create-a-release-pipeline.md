SCRAPS:

* A trigger
* At least one stage 
* Tasks for each stage

The artifact will be the .zip file we already create in the build pipeline. The trigger can also stay the same. When there's a change in version control, the pipeline starts.

## How to gain visibility

**Andy:** Great. Did we forget anything?

**Mara:** We got some visibility into the build pipeline by adding a dashboard that shows build history. I don't want to lose that insight. Let's add a dashboard that keeps track of our release health and history.

**Andy:** You got it.

(This was part of "the plan")

* Have a dashboard that shows the release health and history

-----

Andy and Mara are going to create a simple CD pipeline to demo to the rest of the team. The pipeline will be a POC that they'll improve on and expand as they learn more and get feedback from Tim and Amita. They're sitting in a conference room, ready to get started.

**Andy:** I've never built a CD pipeline before. Have you?

**Mara:** I've worked with CD pipelines, but I haven't set one up.

**Andy:** Given we're both newbies, I was thinking that we already have a working automated pipeline--our build pipeline. We could start with that.

**Mara:** Great minds think alike. We could probably extend our existing build configuration. But what do we need to turn our build pipeline into a CD pipeline?

## What makes up a basic pipeline?

A basic pipeline contains X, Y, and Z. Let's follow along with Andy and Mara as they ...

**Andy:** Here's what I think we need to start.

He draws a diagram on the whiteboard.

(The diagram shows a package, an environment, an arrow between them, and a question mark over the arrow.)

(Andy says we already have the build artifact - the .zip file that's produced by our exiting build pipeline. But how to we deploy it to some live environment?)

**Mara:** (In the CD pipelines I've worked with, we used stages to define each phase of the deployment process, such as building the artifact and deploying the artifact to the various testing and production environments. Each stage breaks down into tasks, just like the ones we use in our existing build pipeline.)

## What is a stage?

A _stage_ is a XYZ.

**Mara:** I think that's a great start and pretty straightforward. Lets define a *stage* as a major division in a pipeline. Every stage is independent of every other stage. We could have a stage that builds the app, another that runs some tests, there's lots of possibilities. But we want to keep it simple so what about two stages?

Mara updates the diagram on the whiteboard.

(The diagram now shows two stages. The first represents the build stage; the second the deploy stage.)

**Mara:** We've already defined the tasks for the build stage in our pipeline. (We can create a similar stage that includes tasks that deploy the build to some environment.)

The question is, where should we deploy the artifact?

## Where can I host my deployments?

Azure Pipelines enables you to deploy to just about any kind of environment &mdash; whether it's on-prem or in the cloud. Let's ...

**Andy:** At a really high level, do you want to deploy on premises or to Azure?

**Mara:** We could ask Tim to create a VM for us in the lab, but I vote for the cloud. It'll be super fast and easy to set up a POC ourselves.

**Andy:** I agree. There are so many cloud options to consider, and we can use Azure Pipelines to deploy to any of them. Which should we try?

**Mara:** The teams who are developing the games are using Azure to host some of their backend systems. (They were able to get set up quickly and they seem to like it. I'm sure they can help us if we need it.)

**Andy:** OK. Let's try it! Azure provides so many compute options. Which should we pick?

Andy lists these options on the whiteboard:

* Virtual machines
* Containers
* Azure App Service
* Serverless computing

(Say how we'll point you to more info at the end?)

**Mara:** I know containers and serverless computing are really popular right now. Compared to VMs, they're both lightweight in terms of resources. I also know that they're easy to replace and scale up. They're both interesting but I'm nervous learning about two new technologies at once. I'd rather just concentrate on building the pipeline.

**Andy:** I'm with you. That leaves VMs or Azure App Service. I think VMs would be a better choice if we were moving some line-of-business app that needed it's own particular environment to the cloud. We're not doing anything that big.

**Mara:** That leaves Azure App Service. That would be my choice. It's designed to work with Azure DevOps and it comes with a lot of advantages. It's a platform-as-a-service (PaaS) environment for web apps so it takes a lot of the burden off of us. We won't have to worry about infrastructure and we get a lot of benefits, like security, load balancing, and auto-scaling.

**Andy:** (OK)

## How does Azure Pipelines perform deployment steps?

(Perhaps Andy and Mara question how Azure Pipelines connects to and authenticates with the target environment.)

Notes:
  * It depends on what you're deploying and where you're deploying to.
  * We'll point you to more resources at the end of this module.

General steps:

1. Specify the target deployment environment in your build configuration.
1. Provide a way for Azure Pipelines to authenticate access to that environment.
1. Use Azure Pipelines tasks to deploy the build artifact to that environment.

To do those on App Service, you need to:

1. Create what's called a _service connection_ to specify the target environment and authenticate access to it. (maybe explain service connection a bit more.)
1. Use the built-in tasks **DownloadBuildArtifacts@0** and **AzureRmWebAppDeployment@4**. (explain these briefly.)

## The plan

Andy and Mara are ready to start. They're going to:

* Use the existing build configuration running on Azure Pipelines as the basis of the CD pipeline
* Have a build stage that creates the artifact
* Have a deploy stage that deploys the artifact to Azure App Service

(Possibly add a final diagram here that extends the previous one with more specific details. Add "Azure Pipelines" to the top. Label the environment with "Azure App Service".)