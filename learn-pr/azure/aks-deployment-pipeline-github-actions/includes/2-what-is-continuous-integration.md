Before you change or deploy your the company's infrastructure, understand the concepts behind what you plan to build by exploring the concepts behind continuous integration (CI) and continuous delivery or deployment (CD). In this unit, you learn what a pipeline is and how to apply CI and CD to GitHub Actions.

CI and CD are operating practices that help make developer teams more productive by introducing continuous automation and monitoring into all the phases of software development, testing, and deployment. CI and CD aim to reduce problems that arise when you integrate new code into an existing code base.

## Continuous integration

CI requires that teams frequently implement and integrate the smallest changes in the code. Implementing this technique means that you constantly test, compile, deploy, and then test again in production.

One of the most critical CI principles is to merge all new changes back into the main branch as often as possible. Continually merging changes helps you avoid "integration hell" on merge day, which can occur when many developers combine their changes at once in a single day.

The goal of CI is to detect and avoid production problems caused by code changes before they can damage your code or your customers.

### Continuous delivery (CD)

CD picks up where CI ends. CD automates the delivery process to the selected infrastructure environment. You can use CD to release new changes to your customers quickly and sustainably.

When you use CD, you decide in advance whether you deploy the changes daily, weekly, monthly, or on another schedule that suits your business requirements.

### Continuous deployment

A variation to the CD process is *continuous deployment*. Continuous deployment goes one step further than continuous delivery. In this variation, every change that passes all the stages of your CI pipeline is automatically released to customers.

Continuous deployment is one of the most advanced processes in software development. It requires coded tests that cover all aspects of the application to test the application's functionality without human intervention.

## CI pipelines

A CI pipeline is collectively the processes that run when a new code change is detected. Every time a code change triggers a CI run, all steps in the pipeline execute. If there's an error in one of these steps, the pipeline stops.

A specified event triggers a pipeline, and a large number of events are part software development. The CI provider must support all related events. When an event is triggered, all the listeners for this specific event are triggered. The first stage of the process starts. 

In most cases, the process begins by cloning or downloading source code. Then, the next step is triggered, and so on. Workflows can contain logic jumps so that a stage doesn't execute if certain conditions are met, but the pipeline continues to execute.

## GitHub Actions

GitHub Actions is one of the most popular providers for CI platforms because of its presence in the open-source world. You use GitHub Actions to seamlessly integrate all your hosted code in GitHub with an automation workflow. The workflow handles multiple tasks to integrate your code across several environments.

GitHub Actions support all GitHub related events. Each step is defined as an action that is either in JavaScript or uses a Docker container. Because workflows are open source, they're stored in repositories available to anyone on the platform. GitHub users may use each other's actions without installing or configuring anything else.

Actions are the most important piece of the pipeline. Actions form the building blocks of the steps, and they're easy to create. The ability to share actions among users is what makes GitHub Actions so great. You don't need to rewrite repeated code or stages—you can use someone's action or create your own custom action.

Throughout the next couple units, you'll define a deployment pipeline to implement *continuous deployment* in an application.

## Benefits of CI

Before technological advancements gave us tools that can implement CI and CD, the entire develop-test-deploy-test process was done "by hand." Automated test suites were available, but they had to be run manually or at scheduled times by expert teams.

One of the most significant problems software developers face, which led to the development of CI is merge day. Merge day happens because most software development teams work on the same code in different branches with minimal tests. On merge day, all code changes would be integrated back into the main branch.

As a result, an entire day would be dedicated to solving integration issues as the team members' branches merged and intersected in the main branch.
