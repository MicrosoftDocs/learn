DevOps is the union of people, process, and products that creates continuous delivery of value to end users. The contraction of "Dev" and "Ops" refers to replacing siloed *development* and *operations* teams with multidisciplinary teams that work together by using shared and efficient practices and tools. Essential DevOps practices include continuous integration and continuous delivery.

![Overview of the DevOps lifecycle](../../deploy-apps-to-azure/media/devops-overview.png)

**Continuous integration (CI)** is the practice development teams use to automate merging and testing code. Implementing CI helps your team detect bugs early in the development cycle. Early detection makes bugs less expensive to fix. Automated tests execute as part of the CI process to ensure quality. Artifacts are produced from CI systems and fed to release pipelines to drive frequent deployments.

- The Build service in Team Servies helps you set up and manage CI for your applications.

**Continuous delivery (CD)** is a process by which code is built, tested, and deployed to one or more test and production environments. Deploying and testing in multiple environments drives quality. CI systems produce deployable artifacts, including infrastructure and apps. Automated release pipelines consume these artifacts to release new versions and fixes to existing systems. Monitoring and alerting systems run continually to drive visibility into the entire CD process.

- The Release service in VSTS helps you set up and manage CD for your applications.

To explore how VSTS can help you benefit from these processes, select **Next**.