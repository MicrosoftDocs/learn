DevOps has been an emerging trend in software lifecycle management over the past several years. Its basic idea is to facilitate convergence between development and operational practices to optimize the process of developing, deploying, and maintaining software. As an IT professional with a programming background and operational support experience, you're familiar with DevOps principles, but want to find more about the proper way to put them into practice.

## What are Azure Pipelines and GitHub repositories?

To accomplish your objective, you're considering leveraging a mix of vendor-specific and open-source solutions. You've decided to focus on Azure DevOps and GitHub. Azure DevOps is a software-as-a-service (SaaS) offering from Microsoft that provides a range of different tools for developing and deploying software. Among them, Azure Pipelines drew your attention to perform software deployment in a language-, platform-, and cloud-agnostic manner. While Azure DevOps also offers Azure Repos, which provide cloud-hosted private and public code repositories, you've been a long-time GitHub user and would rather use that instead. Fortunately, Azure DevOps integrates with most common source-control products, including GitHub.

Source control, also referred to as version control, is the practice of tracking and managing changes to code. Source-control management systems, such as GitHub, maintain a history of code updates and facilitate conflict resolution when merging changes from multiple sources. Source control is an essential tool for multi-developer projects, allowing individuals and teams to collaborate when developing software within the same code repository. At the same time, to accommodate separation between development efforts, source-control management systems allow for creation of different, independently tracked and maintained code repositories.

> [!NOTE]
> Collaborative software development typically involves the use of branches, which facilitate working simultaneously on multiple versions of the same code. This topic is outside the scope of the current module. Instead, you'll be working exclusively with a single version of code and committing changes directly into the single, *main* branch.

With GitHub serving the role of code repository, you plan to use Azure Pipelines to build software packages (also referred to as artifacts) based on that code and deploy them to a target environment. While you choose to target Azure in your deployments, you realize that Azure Pipelines can deploy software to any environment with internet connectivity.

> [!NOTE]
> While GitHub and Azure Pipelines support close integration, they're independent of each other, and each has its own organization and user management. GitHub's structure consists of organization and user accounts that contain repositories. Azure DevOps' structure consists of organizations that contain projects.

## What is continuous integration and continuous deployment?

Azure Pipelines allow you to fully automate the software-release process, combining build and deployment tasks into a streamlined sequence of events. That sequence can include a combination of automated and manual checks and require explicit gated approvals to ensure compliance with your quality control and change governance requirements.

Continuous integration (CI) is the process of automating the build and testing of code every time an update is committed to the target repository in a version-control system. Continuous integration promotes frequent testing, which helps with early detection of code defects. The final product of a build process, including CI, is an artifact. An artifact typically constitutes a testable and deployable software package, such as a .NET app packaged into a .zip file. Continuous deployment (CD) is the process of automating delivery of artifacts to the target environment that provides resources for deploying and running the corresponding software. CD helps software developers with delivering software updates to their customers at a rapid cadence. By combining CI and CD, Azure Pipelines can automatically build and validate every update committed to a GitHub repository.

## What is the difference between classic and YAML-based authoring of Azure Pipelines?

When authoring Azure Pipelines, you have a choice between using either the classic or the YAML-based approach:

- With the classic approach, you rely on the visual designer included in the Azure DevOps web-based portal to define a build pipeline that builds your code, tests it, and publishes the resulting artifacts. You also use a similar graphical interface to define a release pipeline that consumes and deploys these artifacts to deployment targets. Neither of these pipelines resides in the code repository, but instead, they're hosted by Azure Pipelines.

    > [!NOTE]
    > When using the visual designer, you have the option of displaying the corresponding YAML content.

- With the YAML-based approach, your pipeline takes the form of a YAML-formatted file, which, by default, resides in the same repository as the code used to build deployable artifacts. You can define the build and deployment within the same file. Since the pipeline is part of your code, you benefit from the version control functionality, allowing you to track pipeline changes and simplifying the identification of potential issues related to these changes.

    > [!NOTE]
    > When using YAML-based authoring, you have access to the task assistant, which simplifies generating the task-specific YAML content.

## What are the basic structure and components of an Azure pipeline?

> [!NOTE]
> This isn't a comprehensive list of Azure Pipelines components. Its purpose is to introduce components that you'll be using throughout the exercises in this module.

Pipelines allow you to create a well-defined structure that represents the build, test, and deployment processes. At a high level, that structure consists of stages, jobs, and tasks. Each stage consists of one or more jobs, with each job including one or more tasks.

### Stages, tasks, and jobs

When you plan a pipeline, you usually begin by identifying its stages. Typically, a stage maps to an environment, but this isn't required. In the context of Azure Pipelines, an environment represents one or more deployment targets, such groups of development, testing, and production Azure App Service instances.

> [!NOTE]
> Typically, you promote changes from one stage to the next as part of your release-management strategy. Within each stage, you deploy build artifacts to the environment associated with that stage.

You can execute parts of the pipeline corresponding to individual stages independently. You can invoke this execution manually or configure it to take place automatically in response to a trigger. A trigger can be based on a predefined schedule or an event, such as a repository commit (in case of continuous integration) or successful completion of the build process (in case of continuous deployment).

To implement individual execution steps within an Azure pipeline, you'll use tasks. A task is a packaged script or procedure that abstracts the underlying implementation details. You can choose from ready-to-use tasks built into Azure Pipelines and those available from Visual Studio Marketplace. You also have the option to create your own custom tasks. In addition, there are tasks that allow you to run arbitrary scripts, either inline or by referencing a script file. When adding a task to a pipeline, you need to provide task-specific input parameters.

A job is a series of tasks that execute sequentially on the same underlying host. Azure Pipelines identifies the appropriate operating system and software to be included on this host based on the job setting that you specify.

> [!NOTE]
> You can export reusable elements of your pipeline into templates. Azure Pipelines includes several predefined templates. For example, in this module, you'll generate the build pipeline by using the **ASP.NET** template.

### Variables

Azure Pipeline variables serve the same role as in a standard programming language, allowing you to define values once and refer to them multiple times throughout the pipeline. The substitution of the variable name with its value takes place dynamically during pipeline execution. Azure Pipelines provides several built-in variables, which designate, for example, location of artifacts. You can also define your own variables. If you want to share variables across multiple stages and pipelines within the same project, you can use *variable groups*. Azure Pipelines supports secret variables, for which content is automatically encrypted.

> [!NOTE]
> When using inline scripts, reference variables by using the **$VARIABLE_NAME** syntax. For secret variables, use the **$(VARIABLE_NAME)** syntax.
