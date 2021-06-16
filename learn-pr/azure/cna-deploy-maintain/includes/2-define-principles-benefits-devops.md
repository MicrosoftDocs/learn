As an IT professional with a programming background and operational support experience, you're familiar with the basic idea of DevOps, but want to find more about its principles, benefits, and the proper way to put them into practice. Your objective is to streamline the build, testing, and deployment of updates to components that constitute your cloud-native application. 

## What is DevOps?

DevOps has been one of the dominant trends in the software lifecycle management over the past several years. Its basic idea is to facilitate convergence between development and operational practices to optimize the process of developing, deploying, and maintaining software. DevOps represents patterns and practices that accelerate software releases to deliver value to the business, while, at the same time, increasing overall stability and reliability of your environment. 

## What are the main components of DevOps?

The main components of DevOps that you want to focus on include source control, continuous integration (CI), continuous delivery (CD), CI/CD pipelines, and Infrastructure as Code (IaC).

### What is source control?

Source control, also referred to as version control, is the practice of tracking and managing changes to code. Source control management systems, such as GitHub repositories or Azure Repos, maintain a history of code updates and facilitate conflict resolution when merging changes from multiple sources. Source control is an essential tool for multi-developer projects, allowing individuals and teams to collaborate when developing software within the same code repository. At the same time, to accommodate separation between development efforts, source control management systems allow for creation of different, independently tracked and maintained code repositories.

### What are CI/CD pipelines? 

Continuous integration is the process of automating the build and testing of code every time an update is committed to the target repository in a version control system. Continuous integration promotes frequent testing, which helps with early detection of code defects. The final product of a build process, including CI, is an artifact. An artifact typically constitutes a testable and deployable software package. 

Continuous deployment is the process of automating delivery of artifacts to the target environment that provides resources for deploying and running the corresponding software. CD helps software developers with delivering software updates to their customers at a rapid cadence. 

Pipelines, such as Azure Pipelines and GitHub Actions, allow you to create a well-defined structure that represents the build, test, and deployment processes. With Azure Pipelines, that structure is divided into stages, jobs, and tasks. Each stage consists of one or more jobs, with each job including one or more tasks. GitHub Actions consist of workflows that combine jobs and tasks, each performing individual actions.

### What is IaC?

IaC applies DevOps principles to managing and maintaining services that are traditionally the responsibility of infrastructure and platform teams within an IT organization. These services include compute, networking, and storage components that serve as the basis for deployment of software, which is the primary focus of development and operations teams. IaC started gaining prominence with the advent of cloud technologies, which practically eliminated dependency on physical, on-premises infrastructure.

IaC leverages automation to set up infrastructure services and control their configuration. By using IaC, you can automatically provision Azure Kubernetes Service (AKS) clusters into which you can subsequently deploy your containerized apps. This approach offers a range of benefits, including consistency, scalability, agility, and repeatability.

There are two ways to implement IaC:

- Declarative. Declarative code defines what the code should accomplish but does not define how to achieve the result. When operating in Azure, you can use such tools and techniques as Azure Resource Manager templates, Terraform, or Ansible for this purpose.
- Imperative. Imperative code defines both what the program should accomplish and how to achieve the result. When operating in Azure, you can use such tools and techniques as Azure PowerShell, Azure CLI, or Azure SDK for this purpose.

## What are the benefits of GitHub Actions?

GitHub Actions provide task automation and workflow functionality. You can use them to streamline your software development lifecycle and implement CI/CD pipelines.

GitHub Actions consist of the following components:

- workflow: an automated process that implements the pipeline.
- runner: a server that provides compute resources for running a workflow.
- event: an activity that triggers a workflow.
- job: a group of steps that execute on a runner.
- step: a task that can execute one or more actions.
- action: a standalone command that delivers a desired outcome.

You can configure GitHub Actions to trigger complex workflows whenever a developer commits a new version of source code into a designated repository branch or run them according to an arbitrary schedule. The result is a reliable and sustainable build and deployment process, which increases release cadency without negatively impacting the stability of your environment. You can also use GitHub Actions to implement your Azure infrastructure components by leveraging Azure Resource Manager templates.

> [!NOTE]
> GitHub Actions take the form of YAML-formatted files. Their syntax rules are fully documented on GitHub.
