Before you start deploying or changing the infrastructure, it's essential to understand the concepts behind what you're going to build.

Let's explore some of the concepts behind continuous integration (CI) and continuous deployment (CD). Understand what a pipeline is and how to apply all of this to GitHub Actions.

## Before continuous integration (CI)

Before the technological advancements that allowed us to have tools to do CI and CD, all the process was done "by hand". There were automated test suites, but they needed to be run manually or at scheduled times.

One of the most significant problems – that is also one of the root causes for CI to exist – was the day called "merge day". Since most teams consist in several developers working on the same code in different branches, the merge day was that one day where all code changes were integrated back into the main branch.

This caused "the integration hell" because several parts of a team's work intersected with others and caused this day to be entirely dedicated to solving possible integration issues until CI came in.

## What is CI and CD?

CI and CD are a set of operating practices that aims to make teams more productive by introducing continuous automation and monitoring for all the phases of software development, testing, and deployment.

CI is short for **C**ontinuous **I**ntegration, while CD is short for **C**ontinuous **D**elivery. Both are names for techniques that aim to reduce the problems caused when integrating new code into an existing codebase.

### Continuous integration

CI is a set of practices that dictates that teams should frequently implement and integrate the smallest changes in the code, which means constant testing, compiling, deployment, and testing.

One of the most critical CI principles is to merge all the newest changes back into the main branch as often as possible, avoiding the _Integration Hell_, which happens when many developers combine their changes all at once in one single day.

CI's goal is to avoid production problems caused by code changes, detecting them before they can cause real damage.

### Continuous delivery

Continuous delivery picks up from where CI ends and automates the delivery process to the selected infrastructure environment. This way, you can release new changes to your customers quickly and sustainably.

In continuous delivery, you decide whether you deploy the changes daily, weekly, monthly, or whatever suits your business requirements.

### Continuous deployment

There's a third option in the CI/CD process, the continuous deployment – which is also abbreviated as CD – goes one step further than continuous delivery. In this philosophy, every change that passes all the stages of your CI pipeline is automatically released to customers.

Continuous deployment is one of the most advanced processes in software development. It requires that coded tests cover all the application aspects to test the application's coded functionality without human intervention.

## Continuous integration pipelines

A CI pipeline is the name we give to processes that run when a new code change is detected. Every time a recent change triggers a CI run, all the pipeline steps are executed. If there's an error in one of these steps, then the pipeline stops execution.

An event triggers pipelines. Events are many, and the CI provider needs to support them. After an event is triggered, all the listeners for this particular event are triggered and start the first stage of the process. In most cases, it consists of cloning or downloading the source code. Then, the first step triggers other steps when it's finished.

Workflows can also contain logic jumps, so a stage isn't executed if certain conditions are met.

### GitHub Actions

GitHub Actions are among the most popular providers for CI platforms because of their presence in the open-source world. With GitHub Actions, you can seamlessly integrate all your hosted code in GitHub with an automation workflow that can do several tasks and integrate code into several environments.

GitHub actions support all of GitHub's events. Each step is defined as an "action" that can either be JavaScript code or a Docker container. Actions allow the users to use each other's actions without installing or confining anything else since actions are simple repositories like all the code in the platform.

Actions are the most important piece of the pipeline. They're the building blocks of the stages and are easy to create. The ability to share these actions among each other is what makes GitHub Actions so great. Because you don't need to rewrite repeated code or stages, use someone's action, or create your own.

In the next steps, you'll define your deployment pipeline to implement _continuous deployment_ in our application.
