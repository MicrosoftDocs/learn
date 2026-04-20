You've learned about continuous deployment and delivery of software and services, but the two are actually part of a triad. DevOps practices are aimed at achieving continuous _integration, delivery, and deployment_. These practices are typically built up in that order, with each one depending on the one before it.

Now, it's time to back up and discuss the first of these: integration. This is part of the development process that comes prior to deployment. DevOps recommends a development practice in which team members frequently integrate code into a shared repository containing a singular "main" or "trunk" codebase. The goal is to have everyone contributing to the code that will be shipped vs. working off on their copy and only bringing everything together at the last minute.

Automated testing can then verify each team member's integration. This testing helps determine that the code is "healthy" after every change and addition made. The testing is part of what's commonly called a _pipeline_. The remainder of this unit focuses on integrated testing and delivery pipelines.

## The continuous delivery pipeline

To understand automated testing's role in the continuous delivery deployment model, you need to look at where it fits into the delivery pipeline. A continuous delivery pipeline is the implementation of the set of steps code goes through as changes are made during the development process prior to deploying it to production. Here's a graphic representation of sample steps in a simplified delivery pipeline:

:::image type="content" source="../media/pipeline-stages.png" alt-text="Diagram with eight stages of a pipeline: four grouped as Integration and four grouped as Deployment, with arrows highlighting the Test and Review stages where the pipeline can pause for automated checks or human approval.":::

Walk through this pipeline step by step:

- An instance of the pipeline starts as code or infrastructure changes are committed to a code repository, perhaps using a pull request.

- Next, unit tests run, often followed by integration or end-to-end tests. The results are communicated back to the developer who opened the pull request.

- At this stage, the code in the repository is often scanned for secrets, vulnerabilities, and misconfigurations.

- When everything checks out, the code is built and prepared for deployment.

- Next, the code is deployed to a test environment. A reviewer can be notified of the new deployment so they can examine the preproduction solution. The reviewer then approves or denies promotion to production, which starts the final part of the deployment process that releases the code to production.

In this pipeline, you can note the delineation between integration and deployment. The highlighted markers point out some logical places where you can stop the pipeline through included logic and automation, or potentially even human intervention.

## Tools for continuous integration and delivery: Azure Pipelines and GitHub Actions

To use continuous integration and continuous delivery, you need the right tools. Microsoft offers two first-party CI/CD options for building and deploying to Azure: **Azure Pipelines** (part of Azure DevOps) and **GitHub Actions**. Both can automate building and consistently testing your code, and both can deploy to Azure services, virtual machines, and other targets in the cloud and on premises. Many teams adopt GitHub Actions when their source code already lives in GitHub, while Azure Pipelines remains a strong choice for teams standardized on Azure DevOps.

The remainder of this unit focuses on Azure Pipelines, but GitHub Actions uses similar high-level ideas even though the terminology differs. In GitHub Actions, workflows contain jobs and steps, actions package reusable automation, runners execute the work, and environments can protect deployments.

The input to a pipeline (your code or configurations) resides in a version-control system such as GitHub or another Git provider.

Azure Pipelines runs on compute such as a virtual machine or a container, and offers Microsoft-hosted build agents running Windows, Linux, and macOS. You can also register your own self-hosted agents when you need full control over the build environment. It also offers integration with testing, security, and code quality plug-ins. Finally, it's easily extensible, so you can bring your own automation into Azure Pipelines.

Pipelines are defined using YAML syntax stored alongside your code in a Git repository. YAML pipelines are the recommended approach for new projects. A Classic user interface in Azure DevOps is also available for legacy pipelines, but most new functionality (including container jobs and many advanced features) is YAML-only. Pipelines also provide templates that you can use to easily create pipelines, such as a template for a Docker image or a Node.js project. You can also reuse an existing YAML file.

The basic steps for setting up a pipeline are:

1. Configure Azure Pipelines to use your Git repository.
2. Define your build by editing the _azure-pipelines.yml_ file (or, for legacy pipelines, by using the Classic editor).
3. Push your code to your version-control repository. This action triggers the pipeline to build and test your code.

Once the code has been updated, built, and tested, you can deploy it to whatever target you want.

## Azure Pipeline construction

Pipelines are structured into:

- **Jobs**: A job is a grouping of tasks or steps that runs on a single build agent. A job is the smallest component of work that you can schedule to run. All of the steps in a job run sequentially. Those steps can be any action you need, including building or compiling software, preparing sample data for testing, running specific tests, and so on.

- **Stages**: A stage is a logical grouping of related jobs.

Every pipeline has at least one stage. Use multiple stages to organize the pipeline into major divisions and mark the points in your pipeline where you can pause and perform checks.

Pipelines can be as simple or as complex as you need. For tutorials on pipeline construction and use, see the [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true) learning path.

## Environment traceability

There's one other aspect of pipelines related to reliability worth mentioning. You can construct your pipelines in such a way that it's possible to correlate what is running in production with a specific build instance. Ideally, you should be able to trace a build back to a specific pull request or code change. This traceability is invaluable during an incident, and afterwards during the post-incident review when you're trying to identify which change contributed to an issue. Some CI/CD systems (like Azure Pipelines and GitHub Actions) make this correlation straightforward, while others require you to manually construct a pipeline that propagates a build ID through every stage.
