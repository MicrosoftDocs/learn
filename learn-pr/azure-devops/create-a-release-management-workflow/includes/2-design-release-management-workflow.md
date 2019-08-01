In this part, you follow the Tailspin web team as they define their release management workflow for the _Space Game_ web site. You identify the various stages you need and see how triggers, approvals, and gates enable you to control how build artifacts flow from one stage to the next.

## The meeting

The entire Tailspin web team is gathered together. In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), the team planned their tasks for the current sprint. Each task relates to building their release pipeline for the _Space Game_ web site.

Recall that the team decided on these three tasks:

* **Define a release management workflow**
* **Automate quality tests**
* **Improve release cadence**

The team meets to talk about the first task, **Define a release management workflow**. By defining a clear release management process, the team moves from their basic proof of concept to a more complete release pipeline that includes additional quality checks and approvals.

Amita and Tim are watching Andy and Mara demo the release pipeline a second time. They see that the artifact gets built and deployed to Azure App Service. The dashboard gives them the release history.

## What deployment stages do you need?

Recall that a _stage_ is a major division in a pipeline. The team's current pipeline has two stages. The first stage builds the artifact and the second stage deploys the web app to Azure App Service.

When defining a release management process, it's important to first identify which stages you need. The stages you choose depend on your requirements. Let's follow along with the team as they discuss their requirements.

**Tim:** OK. I understand the idea of an automated pipeline. I like how easy it is to deploy to Azure. But where do we go from here?

**Amita:** Right. We need to add some other pieces. There's no place for test, for example.

**Tim:** Plus we need a place where we can show new features to management. I can't send anything to production without their approval.

**Andy:** Absolutely. Now that we're all up to speed on what a CD pipeline does, what do we need to do to make this a pipeline that suits our needs?

**Mara:** Let's sketch out our requirements on the whiteboard. That might help us plan out next steps. Let's start with what we have.

Mara moves to the whiteboard and sketches their existing pipeline.

**TODO:** SHOW BUILD AND DEPLOY STAGES

**Mara:** It's clear that we need to add at least two more stages. One stage is where Amita can test the app, so that's the test stage. Another stage is where we can demo the release to management to get their approval. Let's call that staging.

**Andy:** I think we need to add one more. We need a dev stage, which will be the first stop for the artifact after it's built. As Mara and I push code changes to GitHub, the dev stage will automatically deploy the build to App Service. We can use this environment to spot check our work.

**Andy:** Also, let's make clear that a *release* is a package that holds a versioned set of artifacts created by a release pipeline. A release includes all the information you need to carry out the tasks and actions in the release pipeline, such as what to do for each stage. Releases are *deployed* to stages.

**Mara:** Got it. So here are the four deployment stages for our pipeline:

**TODO:** Build > Dev > Test > Staging

**Amita:** Is this going to be hard to do? It seems like a lot of work.

**Mara:** I don't think it will be too bad. Every stage is separate from every other stage. Stages are discrete environments where we deploy the app. Each stage has its own set of tasks. What happens in the test stage, for example, stays in the test stage.

**Mara:** Every stage also has its own environment. For example, in our pipeline, during the build stage, the environment is the build agent. When we deploy the app to a different stage, such as test or production, the environment can be something else. It could be a VM, a container, or a managed service like App Service, which is what we're using.

**Mara:** Finally, we only ever test one release at a time. We never change releases in the middle of the pipeline. We use the same release in the dev stage as in the production stage and every release has its own version number. If the release breaks in one of the stages, we fix it and build it again with a new version number. That new release then goes through the pipeline from the very beginning.

## How do changes move from one stage to the next?

After you define which stages you need, you need to consider how changes move from one stage to the next. Each stage can define its own success criteria that promotes the build to the next stage. Azure Pipelines provides several ways to help you control how changes move through the pipeline.

**Tim:** My next question is, how do we move from one stage to the next? It seems like the dev stage automatically gets the output of the build stage and that's fine for you two but automatic deployments won't work for me, and I don't think they work for Amita either. We need control.

Tim looks at Amita.

**Amita:** I agree. I run manual tests and I don't know how long they'll take. And Tim has to wait for approval from management before anything goes to production.

**Andy:** We can give you all the control you need. Let's first figure out a *release cadence*, which defines when and how often we deploy to each stage. Then, we can use *triggers*, *release approvals*, and *release gates* to implement the cadence.

### How to define a release cadence

*Release cadence* defines how often you deploy new features. You might start by deploying multiple changes to internal environments, such as dev, test, and staging before deploying to a production environment that's available to your users. As your process matures, you can deploy changes to production more frequently.

**Andy:** When and how often do we want to deploy the _Space Game_ web site, taking each stage separately? We already automatically build the source code whenever we push a code change to GitHub. I think we want to keep that, don't we Mara?

**Mara:** That works for me. I'm fine with automatically deploying to dev whenever there's a successful build.

**Andy:** Now, what about when we send something to test? That means the code has passed all of the unit and quality tests and we have a build artifact that's ready for additional testing.

Andy looks at Amita.

**Amita:** I think I'd like to see a build once a day. Maybe it can be there when I get come in to the office. Can we do that?

**Andy:** Sure. Why don't we deploy to test during off-hours? Let's say we send you a build every day at 3 A.M.

**Amita:** Great. Let's promote the latest build from the dev stage to test each morning. Can I control when I deploy the release to staging?

**Andy:** You can. I think you need manual control for that. A deployment happens only when you say so.

**Amita:** I'm feeling better. However, what do we use to control when each stage runs?

### What are triggers?

A *trigger* defines when a stage runs. Azure Pipelines provides a few different types of triggers to help you control when each stage runs.

**Mara:** In Azure Pipelines, we can use triggers to control our release cadence. Here are our choices:

* A manual trigger
* A scheduled trigger
* A continuous deployment (CD) trigger

**Mara:** A manual trigger is where people deploy a release by hand. A scheduled trigger starts a deployment at a specific time. A continuous deployment trigger is where an event triggers a deployment.

**Mara:** I think we need a CI trigger to move from build to dev. To move from dev to test, let's use a scheduled trigger that deploys to test at 3 A.M. Finally, we can use a manual trigger to enable Amita to deploy to staging after she verifies the build.

Mara adds the triggers to the whiteboard.

**TODO:** add triggers

**Amita:** I like this. I don't even have to pick up the release by hand anymore and install it. It'll be all ready for me.

**Andy:** And remember, if we want to make things more automated later on, we can always do it. Nothing's written in stone. The pipeline evolves as we improve and learn more.

### What are release approvals and release gates?

A *release approval* is a way to pause the pipeline until an approver accepts or rejects the release. A *release gate* is an automated way to query an external service before promoting from one stage to the next. You can combine approvals, gates, and triggers to define your release cadence.

Tim clears his throat.

**Tim:** What about me? I still need some way to deploy the app to my production environment and that depends on management signing off on new features. Those triggers won't work.

**Andy:** I see your point. I think what you're looking for is a *release approval* and maybe a *release gate*.

**Andy:** With a release approval attached to a stage, the pipeline deployment stops until someone signs off, like our management. We could enable a manual deployment approval to move from staging to production.

**Andy:** For quality control, we could use release gates. A gate would let us automatically collect health signals from external services and then promote the release only when all the signals are successful at the same time.

**Amita:** I'm interested in release gates as well. I'd like to automatically check whether we have any active bugs before I promote from test to staging.

**Mara:** Absolutely! Let's talk about it later.

## How does Azure Pipelines connect to Azure?

You can use Azure Pipelines to deploy to just about any type of environment. That environment can run in the cloud or in your datacenter. Your environment can be:

* A virtual machine
* A containerized environment such as Kubernetes
* A managed service such as Azure App Service
* A serverless environment such as Azure Functions

To deploy your app to an Azure resource, such as a virtual machine or Azure App Service, you need what's called a _service connection_.

A service connection provides secure access to your Azure subscription by using one of two methods:

* Service Principal Authentication
* Managed identities for Azure resources

You can learn more about these security models at the end of this module, but in short:

* A _service principal_ is an identity with a limited role that can access Azure resources. Think of a service principal as a service account that can perform automated tasks on your behalf.
* Managed identities for Azure resources is a feature of Azure Active Directory (Azure AD). Managed identities simplify the process of working with service principals. Because managed identities exist on the Azure AD tenant, Azure infrastructure can automatically take care of authenticating the service and managing the account for you.

Although managed identities simplify the process of working with service principals, in this module you use service principal authentication because a service connection can automatically discover your Azure resources and assign the appropriate service principal roles for you.

## Automate as little or as much as you need

Azure Pipelines gives you the flexibility to automate what you're able to, while maintaining control over parts that still require manual input.

**Tim:** I like how we can define the criteria that promotes changes from one stage to the next. But we've defined some manual criteria in our pipeline. I thought DevOps was about automating everything.

**Mara:** You raise a good point. DevOps is really about automating repetitive and error-prone tasks. There are times when human intervention is still necessary, for example, when gaining approval from management before we release new features.

**Mara:** As we gain experience with our automated deployments, we can automate more of our manual steps to speed up the process. For example, perhaps we can automate additional quality checks in the test stage so Amita doesn't have to approve each build.

**Tim:** Sounds great. Let's go with this plan for now and see how we can speed things up later.

**Amita:** Speaking of our plan, can we summarize what next steps we'll take?

## The plan

Let's review the Tailspin team's plan as they move towards next steps.

**Mara:** Here's the release pipeline we want to build.

Mara points to the whiteboard.

**TODO:** Show final pipeline.

**Mara:** To summarize, our steps are to:

1. Produce a build artifact each time we push a change to GitHub. This happens in the build stage.
1. Deploy the build artifact to the dev stage. This happens automatically when the build stage succeeds.
1. Deploy the build artifact to the test stage each morning at 3 A.M. This happens automatically by using a scheduled trigger.
1. Deploy the build artifact to staging after Amita tests and approves the build. This happens by using a manual trigger.
1. Deploy the build artifact to production after management approves the build. This happens by using a release approval.

The dev, test, staging, and production environments are each associated with its own App Service environment. Each stage specifies the tasks required within a division of a pipeline. The environment provides the location to deploy the build artifact.