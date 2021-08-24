As an IT professional with a programming background and operational support experience, you're familiar with the basic idea of DevOps. However, you want to find out more about its principles and benefits. You also want to determine the proper way to put DevOps principles into practice. Your objective is to streamline the build, testing, and deployment of updates to components that constitute your cloud-native application.

## What is DevOps?

DevOps has been one of the dominant trends in software lifecycle management over the past several years. Its basic purpose is to facilitate convergence between development and operational practices. This will optimize the process for developing, deploying, and maintaining software. DevOps represents patterns and practices that accelerate software releases to deliver value to the business. It also helps increase the overall stability and reliability of your environment.

## What are the main DevOps components?

The main DevOps components that you want to focus on include:

* Source control
* Continuous integration (CI)
* Continuous delivery (CD)
* CI/CD pipelines
* Infrastructure as Code (IaC)

### What is source control?

Source control, also referred to as *version control*, is the practice of tracking and managing changes to code. Source control management systems such as GitHub repositories or Azure Repos maintain a history of code updates. They also facilitate conflict resolution when merging changes from multiple sources. Source control is an essential tool for multiple-developer projects, allowing individuals and teams to collaborate when developing software within the same code repository. Source control management systems also provide separation between development efforts by enabling the creation of different, independently tracked and maintained code repositories.

### What are CI/CD pipelines?

*CI* is the process of automating the build and testing of code every time an update is committed to the target repository in a version control system. CI promotes frequent testing, which helps with early detection of code defects. The final product of a build process, including CI, is an artifact. An *artifact* typically constitutes a testable and deployable software package.

*CD* is the process of automating delivery of artifacts to the target environment that's providing resources for deploying and running the corresponding software. CD helps software developers with delivering software updates to their customers at a rapid cadence.

*Pipelines* such as Azure Pipelines and GitHub Actions, allow you to create a well-defined structure that represents the build, test, and deployment processes. With Azure Pipelines, that structure is divided into stages, jobs, and tasks. Each stage consists of one or more jobs, with each job including one or more tasks. GitHub Actions consist of workflows that combine jobs and tasks, each performing individual actions.

### What is IaC?

Infrastructure as Code (IaC) applies DevOps principles to managing and maintaining services that traditionally are the responsibility of infrastructure and platform teams within an IT organization. These services include compute, networking, and storage components that serve as the basis for software deployment&mdash;the primary focus of development and operations teams. IaC started gaining prominence with the advent of cloud technologies, which practically eliminated dependency on physical, on-premises infrastructures.

IaC uses automation to set up infrastructure services and control their configuration. By using IaC, you can automatically provision AKS clusters into which you can then deploy your containerized apps. This approach offers a range of benefits, including consistency, scalability, agility, and repeatability.

There are two ways to implement IaC:

* Declarative. Declarative code defines what the code should accomplish, not how to achieve the result. When operating in Azure, you can use tools and techniques such as Azure Resource Manager templates for this purpose.
* Imperative. Imperative code defines both what the program should accomplish and how to achieve the result. When operating in Azure, you can use tools and techniques such as Azure PowerShell, Azure Command-Line Interface (Azure CLI), or Azure SDK for this purpose.

## What are the benefits of GitHub Actions?

GitHub Actions provide task automation and workflow functionality. You can use it to streamline your software development lifecycle and implement CI/CD pipelines.

GitHub Actions consist of the following components:

* Workflow. An automated process that implements the pipeline.
* Runner. A server that provides compute resources for running a workflow.
* Event. An activity that triggers a workflow.
* Job. A group of steps that execute on a runner.
* Step. A task that can execute one or more actions.
* Action. A standalone command that delivers a desired outcome.

You can configure GitHub Actions to trigger complex workflows whenever a developer commits a new version of source code into a designated repository branch.  You can also configure it to run according to an arbitrary schedule. The result is a reliable and sustainable build and deployment process that increases release cadency without negatively impacting your environment's stability. You can also use GitHub Actions to implement your Azure infrastructure components by using Azure Resource Manager templates.

> [!NOTE]
> GitHub Actions take the form of yaml-formatted files. Their syntax rules are fully documented on GitHub.
