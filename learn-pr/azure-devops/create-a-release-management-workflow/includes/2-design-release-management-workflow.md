NOTES:

* Have some team discussion here -
  * Perhaps Andy and Mara demo the deployment to the Dev environment to the team.
  * Amita and Tim wonder how this relates to them. It's great that they have a Dev environment set up, but what about Test and Pre-production?
  * This opens up a conversation around how changes move from one stage to the next (deployment cadence, schedules, & triggers)

## What release management tools can I use?

References:
* Choosing the Right Release Management Tool > Overview Release Management Tools
* Choosing the Right Release Management Tool > Release Management Tools Comparison

Summarize and compare the landscape, similar to what we've done in earlier modules.

## What are deployment stages?

References:
* Release Strategy Recommendations > Release Strategy - Introduction and Overview
* [Stages](https://docs.microsoft.com/azure/devops/pipelines/process/stages?view=azure-devops&tabs=yaml)

A _stage_ is ...

Walk through top half of first ref.

## How often do you need to release?

References:
* Release Strategy Recommendations > Delivery and Deployment Cadence, Schedules and Triggers

Tasks:
* Define release cadence
* Lift from bottom part of ref

## How do changes move from one stage to the next?

References:
* Release Strategy Recommendations > Release Strategy - Introduction and Overview
* Release Strategy Recommendations > Delivery and Deployment Cadence, Schedules and Triggers
* Release Strategy Recommendations > Demo - Selecting your Delivery and Deployment Cadence

Discuss triggers

* Lift from top of first ref.
* Lift from top of second ref.
* See what's good in the third ref (the demo).

## What considerations make up a release workflow?

References:
* Release Strategy Recommendations > Considerations for Release Approvals
* Automate Inspection of Health > Release gates (defines release gates)

Define _release approvals_ and _release gates_.

Scrap from random ILT page:

Release gates allow automatic collection of health signals from external services and then promote the release when all the signals are successful at the same time or stop the deployment on timeout. Typically, gates are used in connection with incident management, problem management, change management, monitoring, and external approval systems.

## What does the team decide?

The team decides to:

* Create a Dev environment (stage) that is triggered when each build succeeds. This provides a central place for Andy and Mara to deploy builds to and see the app running in a production-like environment.
* Create a Test environment (stage) that is triggered at 3 AM each morning. This gives Amita a place to test out new builds, manually at first, and later through more automated tests.
  * This is sorta huge for Amita because in the previous LP she was picking up drops by hand and installing them in her QA lab. This level of automation does the work for her and provides a consistent environment for her to do her tests.
* Create a Preproduction (or is it Pre-production?) environment that is triggered manually once Amita is satisfied with the test build. Although we don't have a Production environment just yet, the team can later coordinate with leadership to set up approvals to move from Preproduction to Production.
* Be sure to talk about: As you mature, you can further automate the stages so that deployments can happen faster. But for now, some deployment steps are still manual so the team can become comfortable with the process.
