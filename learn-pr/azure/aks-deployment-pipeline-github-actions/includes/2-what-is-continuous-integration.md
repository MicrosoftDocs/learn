Before you change or deploy your the company's infrastructure, understand the concepts behind what you plan to build by exploring the concepts behind continuous integration (CI) and continuous delivery or deployment (CD). In this unit, you learn what a pipeline is and how to apply CI and CD to GitHub Actions.

CI and CD are operating practices that help make developer teams more productive by introducing continuous automation and monitoring into all the phases of software development, testing, and deployment. Teams use CI and CD to help reduce problems that can arise when integrating new code into an existing code base.

## Continuous integration

Before the development of CI/CD tools, the entire develop-test-deploy-test process was manual. Automated test suites were available, but they had to be run manually or at scheduled times by expert teams.

One of the most significant challenges software developers faced was merge day. Merge day happened because most software development teams worked on the same code in different branches with minimal tests. On merge day, all code changes were integrated back into the main branch. As a result, an entire day was dedicated to solving integration issues as the team members' branches merged and intersected in the main branch.

One of the most critical CI principles is to merge all new changes back into the main branch as often as possible. Continually merging changes helps avoid the "integration hell" that occurred when many developers combined their changes at once on merge day.

CI requires that teams frequently implement and integrate the smallest changes in the code. Implementing CI means that teams can constantly test, compile, deploy, and then test again in production. The goal of CI is to detect and avoid production problems caused by code changes before they can affect the main code branch or be deployed to customers.

## Continuous delivery and deployment

*Continuous delivery* picks up where CI ends, and automates the delivery process to the selected infrastructure environment. You can use continuous delivery to release changes quickly and sustainably. After you use continuous delivery, you decide in advance whether to deploy the changes daily, weekly, monthly, or on another schedule that suits your business requirements.

*Continuous deployment* goes one step farther by automatically releasing every change that passes all stages of the CI/CD pipeline to production. Continuous deployment is one of the most advanced processes in software development, requiring code that tests all aspects of the application's functionality without human intervention.

## CI/CD pipelines

A large number of events are part of software development. A CI/CD pipeline must support all related events. A specified event triggers the pipeline. When the event occurs, all the listeners for this specific event are triggered and the first stage of the process starts.

A CI/CD pipeline comprises the collective processes that run when a new code change is detected. In most cases, the process begins by cloning or downloading source code. Then the next step triggers, and so on.

Every time a code change triggers a CI/CD run, all steps in the pipeline execute. If there's an error in one of these steps, the pipeline stops. Workflows can contain logic jumps so that under certain conditions, a certain stage doesn't execute, but the overall pipeline continues to execute.

## GitHub Actions

GitHub Actions are the most important part of the CI/CD pipeline in this module. You can use GitHub Actions to seamlessly integrate all your GitHub hosted code with an automation workflow. The workflow handles multiple tasks to integrate the code across several environments.

GitHub Actions support all GitHub related events. Each step defines an action either in JavaScript or by using a Docker container. Actions form the building blocks of the steps, and they're easy to create.

GitHub Actions is one of the most popular providers for CI/CD pipelines because of its presence in the open-source world. Because workflows are open source, they're stored in repositories available to anyone on the platform. GitHub users may use each other's actions without installing or configuring anything else.

The ability to share actions among users means that you don't need to rewrite repeated code or stages. You can use someone's action or create your own custom action. In the next units, you use GitHub Actions in a Docker container to define a CI/CD pipeline that implements continuous deployment of an application.

