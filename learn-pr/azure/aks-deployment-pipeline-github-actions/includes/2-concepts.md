Before we start deploying or changing the infrastructure, it's important to understand the concepts behind what you're going to build.

Let's explore a bit more of the concepts behind CI and CD. Understand what is a pipeline and how we can apply all of this to GitHub Actions.

## Before CI

Before the technological advancements that allowed us to have tools to do CI and CD, all the process was done "by hand". There were automated test suites, but they needed to be run manually or at scheduled times.

One of the greatest problems – that is also one of the root causes for CI to exist – was the day called "merge day". Since most teams consist in several developers working on the same code in different branches, the merge day was that one day where all code changes were integrated back into the main branch.

This caused what is called "the integration hell". Because several parts of a team's work intersected with others and caused this day to be entirely dedicated to solving possible integration issues. Until CI came in.

## What is CI and CD

CI is the short for **C**ontinuous **I**ntegration, while CD is the short for **C**ontinuous **D**elivery. Both are names for techniques that aim to reduce the problems caused when integrating new code into an existent codebase.

Specifically, the concepts of CI/CD introduce the continuous automation and monitoring during all the phases of the application development, testing, and deployment.

In short, CI/CD are the set of operating practices that aim to make teams more productive and able to deliver code changes more frequently through automation.

### Continuous Integration

CI is a set of practices, which dictates that teams should implement and integrate the smallest changes in the code frequently. Which means constant testing, compiling, and so on...

One of the most important principles of CI is to merge all the newest changes back into the main branch as often as possible, avoiding the _Integration Hell_. Which happens when many developers merge their changes all at once  in one single day.

The goal of CI is to avoid problems in production caused by code changes, detecting them before they can cause real damage.

### Continuous Delivery

Continuous delivery picks up from where CI ends and automates the delivery process to the selected infrastructure environment. This way you can release new changes to your customers quickly and in a sustainable way.

In continuous delivery, by the end of all the processes, you can decide whether you deploy the changes daily, weekly, monthly or whatever suits your business requirements.

### Continuous Deployment

There's a third option in the CI/CD process, the Continuous Deployment – which is also abbreviated as CD – goes one step further than continuous delivery. In this philosophy, every change that passes all the stages of your CI pipeline is automatically released to customers.

This is one of the most advanced processes in software development. It requires that all the tests cover all the aspects of the application, since there's no human intervention during the whole process.

## CI Pipelines

A CI pipeline (or workflow) is the name we give to the set of processes that will be run when a new code change is detected. Every time a new change triggers a CI run, all the stages in the pipeline will be executed. If by any reason, there's an error in one of these steps, then all the pipeline stops and finishes.

Pipelines are triggered by an event. Events are many and the CI provider needs to support them. After an event is triggered, all the listeners for this particular event are triggered and start the first stage of the process. In most cases, it consists in cloning or downloading the source code. Then, the first step triggers other steps when it's finished.

Workflows can also contain logic jumps so a stage is or isn't executed if certain condition is met.

### GitHub Actions

GitHub Actions is one of the most popular providers for CI platforms because of it's presence in the open-source world. With this feature, you can seamlessly integrate all your hosted code in GitHub with an automation workflow that can perform several tasks and integrate code into several environments.

GitHub actions supports all of GitHub's events. Each step is defined as an "action", which is either a JavaScript code or Docker container. Allowing the users to use each other's actions without needing to install or configure anything else, since actions are simple repositories like all the code in the platform.

Actions are the most important piece of the pipeline. They're the building blocks of the stages and every use can easily create one. The ability to share these actions among each other is what makes GitHub Actions so great. Because you don't need to rewrite repeated code or stages, just use someone's action or create your own.

In the next steps we'll define our deployment pipeline so we can implement continuous __deployment__ in our application.
