## Overview of continuous integration and continuous delivery (CI/CD)

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users. The contraction of "Dev" and "Ops" refers to replacing siloed *Development* and *Operations* to create multidisciplinary teams that now work together with shared and efficient practices and tools. Essential DevOps practices include continuous integration and continuous delivery.

![Overview of DevOps lifecycle](media/devops-overview.png)

Continuous Integration (CI) is the practice used by development teams to automate the merging and testing of code. Implementing CI helps to catch bugs early in the development cycle, which makes them less expensive to fix. Automated tests execute as part of the CI process to ensure quality. Artifacts are produced from CI systems and fed to release pipelines to drive frequent deployments.

- The *Build* service in Visual Studio Team Services (VSTS) helps you set up and manage CI for your applications.

Continuous Delivery (CD) is a process by which code is built, tested, and deployed to one or more test and production environments. Deploying and testing in multiple environments drives quality. CI systems produce the deployable artifacts including infrastructure and apps. Automated release pipelines consume these artifacts to release new versions and fixes to existing systems. Monitoring and alerting systems run continually to drive visibility into the entire CD process.

- The *Release* service in VSTS helps you set up and manage CD for your applications.