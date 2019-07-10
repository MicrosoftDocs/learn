NOTES:

* Have some team discussion here -
  * Perhaps Andy and Mara demo their POC (from the previous module) to the team.
  * Amita and Tim wonder how this relates to them. It's great that they have one environment set up, but what about the things that come before that, such as test and pre-production?
  * This opens up a conversation around how changes move from one stage to the next (deployment cadence, schedules, & triggers)

## What release management tools can I use?

(Use these references to define and compare tooling options. Summarize and compare the landscape, similar to what we've done in earlier modules. Then, optionally provide some team discussion/observations.)

References:
* Choosing the Right Release Management Tool > Overview Release Management Tools
* Choosing the Right Release Management Tool > Release Management Tools Comparison

## What are deployment stages?

(Use these references to define deployment stages. Then, optionally provide some team discussion/observations.)

References:
* Release Strategy Recommendations > Release Strategy - Introduction and Overview
* [Stages](https://docs.microsoft.com/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

A _deployment stage_, or simply stage, is ...

(This is from the Docs. Rephrase as necessary).

> You can organize the jobs in your pipeline into stages. Stages are the major divisions in a pipeline: "build this app", "run these tests", and "deploy to pre-production" are good examples of stages. They are a logical boundary in your pipeline at which you can pause the pipeline and perform various checks.
> Every pipeline has at least one stage even if you do not explicitly define it. Stages may be arranged into a dependency graph: "run this stage before that one".

Walk through top half of first ref.

Each stage in the pipeline typically maps to some environment. For example, during the build stage, the environment is the build agent. When deploying an application, such as to a test or production environment, that environment might be a virtual machine, a container, or a managed service such as App Service.

### What are deployment slots?

In the previous module, you deployed the _Space Game_ web application to Azure App Service. App Service provides a feature called _deployment slots_. A deployment slot is a running application with its own host name.

You can create a slot that maps to each stage in your pipeline. For example, you might define stages for the development, test, and pre-production phases of your deployment. The production slot is the slot where you run your live application. As a change moves through the pipeline, you can validate the change at each stage.

To deploy new features without incurring downtime, you can swap an application and its configuration between two deployment slots, which you'll do this in a future module. This process essentially swaps the IP addresses of both slots.

## How often do you need to release?

(Use these references to discuss release cadence. Then, optionally provide some team discussion/observations.)

References:
* Release Strategy Recommendations > Delivery and Deployment Cadence, Schedules and Triggers

Tasks:
* Define release cadence
* Lift from bottom part of ref

## How do changes move from one stage to the next?

(Use these references to discuss the various ways a change can move through the pipeline. Then, optionally provide some team discussion/observations.)

References:
* Release Strategy Recommendations > Release Strategy - Introduction and Overview
* Release Strategy Recommendations > Delivery and Deployment Cadence, Schedules and Triggers
* Release Strategy Recommendations > Demo - Selecting your Delivery and Deployment Cadence

Discuss triggers

* Lift from top of first ref.
* Lift from top of second ref.
* See what's good in the third ref (the demo).

## What considerations make up a release workflow?

(Use these references to discuss other considerations you'll need to make. Then, optionally provide some team discussion/observations.)

References:
* Release Strategy Recommendations > Considerations for Release Approvals
* Automate Inspection of Health > Release gates (defines release gates)

Define _release approvals_ and _release gates_.

Scrap from random ILT page:

> Release gates allow automatic collection of health signals from external services and then promote the release when all the signals are successful at the same time or stop the deployment on timeout. Typically, gates are used in connection with incident management, problem management, change management, monitoring, and external approval systems.

## What does the team decide?

The team decides to create a workflow based on these stages:

* Dev
* Test
* Pre-production

**TODO**: Draw the pipeline on a whiteboard and show a picture here.

* The Dev environment (stage) is triggered when each build succeeds. This provides a central place for Andy and Mara to deploy builds to and see the app running in a production-like environment.
* The Test environment (stage) is triggered at 3 AM each morning. This gives Amita a place to test out new builds, manually at first, and later through more automated tests.
  * This is sorta huge for Amita because in the previous LP she was picking up drops by hand and installing them in her QA lab. This level of automation does the work for her and provides a consistent environment for her to do her tests.
* The Pre-production environment (stage) is triggered manually once Amita is satisfied with the test build. Although we don't have a Production environment just yet, the team can later coordinate with leadership to set up approvals to move from Preproduction to Production.
* Be sure to talk about: As you mature, you can further automate the stages so that deployments can happen faster. But for now, some deployment steps are still manual so the team can become comfortable with the process.
