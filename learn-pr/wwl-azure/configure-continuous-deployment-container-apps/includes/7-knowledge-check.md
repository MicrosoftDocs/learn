## Multiple Choice
What does Azure Pipelines provide to support continuous integration and delivery of applications?
(x) Build and release services. {{Correct. Azure Pipelines provides build and release services to support continuous integration and delivery of applications.}}
( ) Provides Git repositories or Team Foundation Version Control (TFVC) for source control of your code. {{Incorrect. This is a description of Azure Repos, not Azure Pipelines.}}
( ) Provides a suite of Agile tools to support planning and tracking work, code defects, and issues using Kanban and Scrum methods. {{Incorrect. This is a description of Azure Boards, not Azure Pipelines.}}

## Multiple Choice
What is a pipeline in Azure Pipelines?
( ) A collection of files or packages published by a run. {{Incorrect. This is the definition of an artifact.}}
(x) Defines the continuous integration and deployment process for your app, made up of one or more stages. {{Correct. A pipeline defines the continuous integration and deployment process for your app. It's made up of one or more stages.}}
( ) A set of deployment target machines that have agents installed. {{Incorrect. This is the definition of a deployment group.}}

## Multiple Choice
What is the purpose of an agent in Azure Pipelines?
( ) To manage and host pipelines for Microsoft. {{Incorrect. Agents are not used to manage and host pipelines for Microsoft.}}
( ) To provide additional security measures for Azure Pipelines. {{Incorrect. Agents are not used to provide additional security measures for Azure Pipelines.}}
(x) To run one or more jobs during pipeline execution. {{Correct. Agents are computing infrastructure with installed agent software that runs one job at a time during pipeline execution.}}

## Multiple Choice
What is the most common use of variables in Azure Pipelines?
(x) To define a value that you can then use in your pipeline. {{Correct. Variables give you a convenient way to get key bits of data into various parts of the pipeline.}}
( ) To define a value that can only be used at the pipeline root level. {{Incorrect. Variables can be defined at the root, stage, and job level. A variable set in the pipeline root level overrides a variable set in the Pipeline settings UI.}}
( ) To define a value that cannot be changed from run to run or job to job of your pipeline. {{Incorrect. Variables are mutable and their value can change from run to run or job to job of your pipeline.}}

## Multiple Choice
A software development team wants to automate their build and testing process. Which Azure DevOps service can they use to achieve this?
( ) Azure Boards. {{Incorrect. Azure Boards provides Agile tools for planning and tracking work, code defects, and issues using Kanban and Scrum methods.}}
( ) Azure Test Plans. {{Incorrect. Azure Test Plans provides several tools to test your apps, including manual/exploratory testing and continuous testing.}}
(x) Azure Pipelines. {{Correct. Azure Pipelines provides build and release services to support continuous integration and delivery of your applications.}}

## Multiple Choice
What is the purpose of a trigger in Azure Pipelines?
(x) A trigger is something that's set up to tell the pipeline when to run. {{Correct. A trigger is used to initiate the pipeline and can be configured to run upon a push to a repository, at scheduled times, or upon the completion of another build.}}
( ) A trigger is a pre-packaged script that performs an action. {{Incorrect. This describes the purpose of a task, not a trigger.}}
( ) A trigger is a way of organizing jobs in a pipeline. {{Incorrect. This describes the purpose of a stage, not a trigger.}}
