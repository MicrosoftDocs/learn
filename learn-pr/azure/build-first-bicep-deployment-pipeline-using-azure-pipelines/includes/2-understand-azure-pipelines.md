By using a _pipeline_, you can automate the steps in your deployment process. Each time you make a change to your code and commit the change to your Git repository, the pipeline runs your predefined process. The pipeline can verify whether your Bicep code meets your quality standards, and then automates the steps to deploy your resources to Azure. You describe this process by creating a _pipeline definition_.

Azure Pipelines is a feature of the Azure DevOps service. Azure DevOps also includes Azure Repos, which hosts the Git repositories you use to store and share your code with your collaborators. Once your Bicep code is stored in Git, Azure Pipelines can access your code to automate your deployment processes. In this unit, you'll learn about Azure Pipelines.

## What are pipelines?

Pipelines describe the process that you follow to test and deploy your Bicep code. A pipeline includes all of the steps you want to execute, and the order in which you want them to happen.

When you work with Azure Pipelines, you describe your pipeline by using a YAML file. A YAML file is a structured text file, a little like how Bicep is also a structured text file. You can create and edit YAML files using any text editor. In this module, you'll use Visual Studio Code, which includes an extension to help you edit Azure DevOps YAML pipeline files. The Azure DevOps web interface also provides some tools to view and edit your pipeline YAML files.

> [!NOTE]
> Azure Pipelines also includes _classic pipelines_, which are an older version of the pipelines feature. YAML-based pipelines have replaced classic pipelines, and in this module, we're only going to discuss YAML pipelines. We recommend you use YAML pipelines.

Because pipeline YAML files are code, they're stored alongside your Bicep code in your Git repository. You use Git's features to collaborate on your pipeline definition, and you can manage different versions of your pipeline file by using commits and branches. In a future module, you'll also learn about other advanced features of pipelines like _templates_, which make pipeline definitions easy to reuse.

## Agents and pools

Until now, you've deployed your Bicep files from your local computer. After you write a Bicep template, you deploy it to Azure by using the Azure CLI or Azure PowerShell. These tools use your computer's resources to submit the template to Azure, and they use your personal identity to authenticate you to Azure and to verify that you're allowed to deploy the resources.

So how does this translate to a pipeline? The pipeline also needs access to a computer so that it can execute the deployment steps. Azure Pipelines uses a machine called an _agent_. An agent is a computer that's configured to run deployment steps for a pipeline. Each agent already has the Bicep and Azure tooling you used in the previous modules, so it's able to do the same things that you do from your own computer. Instead of a human executing commands, the Azure Pipelines service instructs the agent to perform the steps that you've defined.

Azure Pipelines provides multiple types of agents with different operating systems, like Ubuntu or Windows, and sets of tools. Microsoft runs these agents so you don't have to maintain any compute infrastructure. They're sometimes called _Microsoft-hosted agents_ or _hosted agents_ since they're hosted on your behalf. When your pipeline runs, a hosted agent is automatically created, and it's automatically deleted after your pipeline runs. You can't access hosted agents directly, so it's important that your pipeline contains all the steps necessary to deploy your solution.

An _agent pool_ contains multiple agents of the same type. When you configure your pipeline, you tell Azure Pipelines which agent pool to use to execute each set of steps. When your pipeline runs, it waits for an agent to become available from the pool, and then it instructs the agent to run your deployment steps. You don't select a specific agent - any agent in the pool could be assigned to run your pipeline.

:::image type="content" source="../media/2-agent.png" alt-text="Diagram that shows a pipeline that runs on an agent within an agent pool." border="false":::

> [!NOTE]
> You can also create your own custom agents. These are called _self-hosted agents_. You might do this if you have specific software that you need to run as part of your pipeline, or if you need to have a lot of control over exactly how the agent is configured. We don't discuss self-hosted agents in this module, but we provide a link to more information in the summary.

## Triggers

You need to instruct Azure Pipelines _when_ to run your pipeline by using a _trigger_. There are multiple types of trigger available. For now, you'll just use a _manual trigger_, which means you'll manually tell Azure Pipelines when to start running your pipeline. Later in this module, you'll learn about other triggers.

:::image type="content" source="../media/2-trigger.png" alt-text="Diagram that shows a trigger initiating a pipeline." border="false":::

## Steps

A step represents a single operation that the pipeline will perform. Think of a step as being like the individual command that you run in Bash or PowerShell. For most deployments, you execute several steps in a sequence. You define the sequence, and all of the details of each step, in your pipeline YAML file.

There are two types of steps in Azure Pipelines:

- _Scripts_ enable you to run a script by using Bash, PowerShell, or the Windows command shell. You can run a single command or a sequence of commands in one script step.
- _Tasks_ give you a convenient way to access lots of different capabilities without writing script statements. For example, there are built-in tasks to run the Azure CLI and Azure PowerShell cmdlets, to test your code, to upload files to an FTP server, and many more. Additionally, anyone can write their own task and publish it to the Visual Studio Marketplace, so there's a large set of commercial and open-source tasks available, too.

Some people prefer to use script statements rather than built-in tasks, because they provide more control over exactly what is executed. Other people prefer to use tasks so they don't need to write and manage scripts. In this module, we use a mixture of both approaches.

## Jobs

In Azure Pipelines, a _job_ represents an ordered set of steps. You always have at least one job in a pipeline, and when you create complex deployments it's common to have more than one job.

> [!NOTE]
> Each job can run on a different agent pool if you want it to. This is useful when you build and deploy solutions that need to use different operating systems in different parts of their pipeline.
> 
> For example, suppose you're building an iOS app and its backend service. You might have one job that runs on a macOS agent pool to build the iOS app, and another job that runs on a Ubuntu or Windows agent pool to build the backend. You might even tell the pipeline to run the two jobs simultaneously, which speeds up your pipeline's execution.
>
> Throughout this module, we declare the agent pool at the root of the pipeline definition files. This means that all jobs in the pipelines use the same agent pool.

:::image type="content" source="../media/2-steps.png" alt-text="Diagram that shows a pipeline with two steps, both within one job." border="false":::

> [!NOTE]
> Azure Pipelines also has the concepts of _stages_, which enable you to divide your pipeline up into logical phases, and to add manual checks at various points in your pipeline's execution. You’ll learn more about stages in future modules.

## Basic pipeline example

Now that you know the basic concepts behind Azure Pipelines, let's look at a simple pipeline definition in YAML:

:::code language="yaml" source="code/2-simple.yml" :::

Let's look at each part in detail.

- `trigger` tells your pipeline when it should execute. In this case, `trigger: none` tells Azure Pipelines that you want to manually trigger the pipeline.
- `pool` instructs the pipeline which agent pool to use when it runs the pipeline steps. In this example, the pipeline will run on an agent running the Ubuntu operating system, which comes from the pool of Microsoft-hosted agents.
- `jobs` groups together all of the jobs in your pipeline.
- `job` tells your pipeline that you have a single job.
  > [!TIP]
  > When you only have one job in your pipeline you can omit the `jobs` and `job` keywords, but we've included it here to make it clear how the concepts work together in a pipeline.
- `steps` lists the sequence of actions to run within the job. This example includes two steps, both of which run a simple script to echo some text. Each step has a `displayName`, which is a human-readable name for the step. You'll see the display name when you look at the pipeline logs. You can use the pipe character (`|`) to create a multi-line script. After your step executes, you'll see the outputs in the pipeline log.

> [!IMPORTANT]
> In YAML files, indentation is important. Take a look at the example above: some lines are indented by two or four spaces. The number of spaces you use is important, and if you don't indent your file correctly then Azure Pipelines won't be able to interpret it. Visual Studio Code helps you to find and fix errors in your YAML file indentation.
