
Notes:

The team plans the release workflow and decides on the tasks to add to the board (They will be in the new generated template) The tasks will correspond to the module exercises in this LP.

They plan their release and deployment to Amita's test environment as an AppService with one slot to start with.

Resources:

https://courses.microsoft.com/courses/course-v1:ELMS+AZ-400.3+2019_T1/course/

From this link, the relevant breadcrumbs are below:

Course > Design a Release Strategy > Introduction to Continuous Delivery > Why Continuous Delivery

Course > Design a Release Strategy > Introduction to Continuous Delivery > Releases and Deployments

Course > Design a Release Strategy > Introduction to Continuous Delivery > What is a release and what is a deployment

Course > Set Up a Release Managment Workflow > Create a Release Pipeline > Set up a Release Management Workflow

Course > Set Up a Release Managment Workflow > Create a Release Pipeline > Definitions and Glossary


## What is continuous delivery?

## Why should I use continuous delivery?

## What are releases versus deployments?

## How can I plan my release strategy?

## Notes - 7/2

ILT references:

(NOTE: Think about ordering)

* Create a Release Pipeline > Set up a Release Management Workflow
  * Create a Release Pipeline > Definitions and Glossary
  * Create a Release Pipeline > Build and Release Tasks
  * Create a Release Pipeline > Important Deployment Tasks
  * Manage And Modularize Tasks and Templates > Demo (NOTE: This is about task groups)
  * Manage And Modularize Tasks and Templates > Demo (NOTE: This is about variables)
* Create a Release Pipeline > Release Agent Jobs Introduction
  * Create a Release Pipeline > Using Release Jobs
  * Create a Release Pipeline > Discussion
* Release Strategy Recommendations > Artifacts and Artifact sources
  * Release Strategy Recommendations > Considerations for choosing the right artifact source
  * Release Strategy Recommendations > Selecting an artifact source
* Release Strategy Recommendations > Deployment Stages
  * Release Strategy Recommendations > Considerations for setting up Deployment Stages
  * Release Strategy Recommendations > Discussion
  * Release Strategy Recommendations > Demo - Setting up deployment stages
* Create a Release Pipeline > Release Variables
* Provision and Configure Environments > Demo
* Integrate Secrets with the Release Pipeline > Integrate Secrets within the release pipeline
  * Integrate Secrets with the Release Pipeline > Demo
  * Integrate Secrets with the Release Pipeline > Lab
* Automate Inspection of Health   Lab (NOTE: Setting up a dashboard)

(NOTE: Still not sure where these live. Think about it.)

* Create a Release Pipeline > Multi-Configuration and Multi-Agent

(NOTE: Review these and back port if needed)

* Create a Release Pipeline > Agents, Agent Pools and Queues

## Exercises

* Set up environment
  * Run template
  * Fork repo? Clone locally? Build locally?
* Initialize sandbox and create web app (with 1 slot?) through the portal
* Fetch branch with starter build config (where you left off in previous LP)
  * `git commit --allow-empty`
  * `git push` - watch it build in the pipeline
* Add in the `build` stage and the job.
  * `git commit && git push` - watch it build in the pipeline.
* Create service connection (subscription ID, endpoint, etc.)
* Add in deployment stage & tasks.
* `git commit && git push` - watch it build and DEPLOY in the pipeline.
* Add dashboard (one widget that shows overall success rates)