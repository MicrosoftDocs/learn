Before you begin deploying anything or changing the company's infrastructure, it's essential that you understand the concepts behind what you're planning to build.

Let's explore some of the concepts behind CI and CD. In this unit, we learn what a pipeline is and how to apply CI and CD to GitHub Actions.

## What are CI and CD?

CI and CD are operating practices that can help make developer teams more productive by introducing continuous automation and monitoring into all the phases of software development, testing, and deployment. CI and CD aim to reduce problems that result when you integrate new code into an existing code base.

### Continuous integration (CI)

CI dictates that teams frequently implement and integrate the smallest changes in the code. Implementing this technique means that you constantly test, compile, deploy, and then test again in production.

One of the most critical CI principles is that you merge all the newest changes back into the main branch as often as possible. Continually merging changes helps you avoid "integration hell" and merge day, which often occur when many developers combine their changes all at once in a single day.

The goal of CI is to avoid production problems caused by code changes by detecting problems before they can cause real damage to you or your customers.

### Continuous delivery (CD)

CD picks up where CI ends. CD automates the delivery process to the selected infrastructure environment. You can use CD to release new changes to your customers quickly and sustainably.

When you use CD, you decide in advance whether you deploy the changes daily, weekly, monthly, or on another schedule that suits your business requirements.

### Continuous deployment

A variation to the CD process is *continuous deployment*. Continuous deployment goes one step further than continuous delivery. In this variation, every change that passes all the stages of your CI pipeline is automatically released to customers.

Continuous deployment is one of the most advanced processes in software development. It requires coded tests that cover all aspects of the application to test the application's functionality without human intervention.

## CI pipelines

A CI pipeline is collectively the processes that run when a new code change is detected. Every time a code change triggers a CI run, all steps in the pipeline execute. If there's an error in one of these steps, the pipeline stops.

An event triggers a pipeline. A large number of events are triggered during software development. The CI provider needs to support all related events. When an event is triggered, all the listeners for this specific event are triggered. The first stage of the process starts. 

In most cases, the process begins by cloning or downloading source code. Then, the next step is triggered, and so on.

Workflows can contain logic jumps so that a stage doesn't execute if certain conditions are met, but the pipeline continues to execute.

## GitHub Actions

GitHub Actions is one of the most popular providers for CI platforms because of its presence in the open-source world. You can use GitHub Actions to seamlessly integrate all your hosted code in GitHub by using an automation workflow. The workflow can do multiple tasks and integrate code into several environments.

GitHub Actions supports all GitHub events. Each step is defined as an action that can either be JavaScript code or a Docker container. Because actions are simple repositories like all the code in the platform, GitHub users can use each other's actions without installing or configuring anything else.

Actions are the most important piece of the pipeline. Actions are the building blocks of the stages, and they're easy to create. The ability to share actions among users is what makes GitHub Actions so great. You don't need to rewrite repeated code or stages—you can use someone's action or create your own.

In the next units, you'll define a deployment pipeline to implement *continuous deployment* in an application.

## Benefits of CI

Before technological advancements gave us tools that can implement CI and CD, the entire develop-test-deploy-test process was done "by hand." Automated test suites were available, but they had to be run manually or at scheduled times.

Before CI, one of the most significant problems software developers faced, and one that led to the development of CI, was merge day. Because most software development teams consist of several developers working on the same code in different branches, merge day was the day when all code changes were integrated back into the main branch. 

The entire day would be dedicated to solving integration issues as the team members' branches merged and intersected in the main branch.
