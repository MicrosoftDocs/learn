By using _pipelines_, you can automate the steps in your deployment process. Each time you make a change to code and you check it into your Git repository, your pipeline runs a predefined process. The pipeline can verify your Bicep code meets your quality standards, and then automates the steps to deploy your resources to Azure. You describe this process by creating a pipeline definition.

Azure Pipelines is a feature of the Azure DevOps service. Azure DevOps also includes Azure Repos, which hosts the Git repositories you use to store and share your code with your collaborators. Once your Bicep code is stored in Git, Azure Pipelines can access your code to automate your deployment processes.

In this unit, you'll learn about Azure DevOps pipelines.

## What are pipelines?

Pipelines are used to describe the your process you follow to test and deploy your Bicep code. Pipelines include all of the steps you want to execute, and the order in which you want them to happen.

When you work with Azure Pipelines, you describe your pipeline by using a YAML file. A YAML file is a structured text file, a little like how Bicep is also a structured text file. You can create and edit YAML files using any text editor. In this module, you'll use Visual Studio Code, which includes an extension to help you edit Azure DevOps YAML pipeline files. The Azure DevOps web interface also provides some tools to view and edit your pipeline YAML files.

> [!NOTE]
> Azure Pipelines also has _classic pipelines_, which are an older version of the pipelines feature. YAML-based pipelines have replaced classic pipelines, and in this module, we're only going to discuss YAML pipelines. We recommend you use YAML pipelines.

Because pipeline YAML files are code, they are stored alongside your Bicep code in your Git repository. You use Git's features to collaborate on your pipeline, and you can manage different versions of your pipeline file by using commits and branches. In a future module, you'll also learn about other advanced features of pipelines like templates, which make pipelines easy to reuse.

## Agents and pools

Until now, you've deployed your Bicep files from your local computer. After you write the template, you deploy it to Azure by using the Azure CLI or Azure PowerShell. These tools use your computer's resources to submit the template to Azure, and they use your personal identity to authenticate you to Azure to verify you're allowed to deploy the file.

So how does this translate to a pipeline? The pipeline needs access to a computer so that it can execute the deployment steps. Azure Pipelines uses a machine called an _agent_. An agent is a computer that's configured to run the steps in your pipeline. Each agent already has the Bicep and Azure tooling you used in the previous modules, so it's able to do the same things that you do from your own computer.

Azure Pipelines provides multiple types of agents with different operating systems, like Ubuntu or Windows, and sets of tools. Microsoft runs these agents so you don't have to maintain any compute infrastructure. They are sometimes called _Microsoft-hosted agents_ or _hosted agents_ since they're hosted on your behalf.

An _agent pool_ contains multiple agents of the same type. When you configure your pipeline, you tell Azure Pipelines which agent pool to use to execute each set of steps. When your pipeline runs, it waits for an agent to become available from the pool, and then it instructs the agent to run your deployment steps.

:::image type="content" source="../media/2-agent.png" alt-text="Diagram that shows a pipeline that runs on an agent within an agent pool." border="false":::

> [!NOTE]
> You can also create your own custom agents. These are called _self-hosted agents_. You might do this if you have specific software you need to run as part of your pipeline, or if you need to have a lot of control over exactly how the agent is configured. We won't discuss self-hosted agents in this module, but we provide a link to more information in the summary.

## Service connections

When you deploy a Bicep file from your own computer, you use the Azure CLI or Azure PowerShell. Before you can deploy your code, you need to sign in to Azure. Usually the tools ask you to enter your email address and password in a browser. After verifying your credentials, the tools know who you are and can verify that you have permission to deploy your Bicep file.

Since pipelines are run without any human present, they need to authenticate to Azure by using a service principal. You typically create a service principal manually before you create your pipeline. A service principal's credentials consist of an _application ID_ and a secret, which is usually a key or a certificate. You use a _service connection_ in Azure Pipelines to securely store these credentials so that your pipeline can use them. A service connection also includes some other information to help your pipeline identify the Azure environment that you want to deploy to.

When you create a service connection, you give it a name. Your pipeline YAML file refers to the service connection by using this name. That way, your pipeline YAML code doesn't contain any secret information.

When your pipeline starts, the agent that's running your deployment steps will have access to the service connection, including its credentials. It uses the credentials to sign in to Azure, just like you do yourself. Then, any steps in your pipeline will run by using the service principal's _identity_.

You need to ensure that your service principal has the permissions it needs to be able to execute your deployment steps. For example, you might need to assign the service principal the contributor role for the resource group that it deploys your resources to.

:::image type="content" source="../media/2-service-connection.png" alt-text="Diagram that shows a pipeline that includes an Azure deployment step, which accesses a service connection and then deploys to Azure." border="false":::

> [!NOTE]
> Service connections can be used to enable your pipeline to access other resources outside of Azure, too. We don't need to use any other service connection types in this module, though.

## Triggers

You need to instruct Azure Pipelines _when_ to run your pipeline by using a _trigger_. There are multiple types of trigger available. For now, we'll just use a _manual trigger_, which means we'll manually tell Azure Pipelines when to start running our pipeline. Later in this module, you'll learn about the other triggers you can use.

:::image type="content" source="../media/2-trigger.png" alt-text="Diagram that shows a trigger initiating a pipeline." border="false":::

## Jobs

A pipeline consists of one or more _jobs_. Each job contains a set of _steps_ to follow in sequence. When you create basic pipelines, you typically use a single job. For more advanced pipelines, you use jobs to run multiple operations at the same time. In this module, we'll just use a single job.

A job is associated with an agent pool, which you learned about earlier. Some simple jobs can be run without an agent, but we won't cover that here.

## Steps

A step represents a single operation that the pipeline will perform. Think of a step as being like the individual command you execute against the Azure CLI or Azure PowerShell. For most deployments, you execute several steps in a sequence. You define the sequence, and all of the details of each step, in your pipeline YAML file.

There are two types of steps in Azure Pipelines:

- _Scripts_ enable you to run a script by using Bash, PowerShell, or the Windows command shell.
- _Tasks_ provide more advanced functionality and give you a convenient way to access lots of different capabilities without writing script statements. For example, there are built-in tasks to run the Azure CLI or Azure PowerShell, to test your code, to upload files to an FTP server, and many more. Additionally, anyone can write their own task and publish it to the Visual Studio Marketplace, so there's a large set of commercial and open-source tasks available, too.

:::image type="content" source="../media/2-job-step.png" alt-text="Diagram that shows a pipeline with one job, which contains two steps." border="false":::

> [!NOTE]
> Some people prefer to use script statements rather than built-in tasks, because they provide more control over what is going on. Other people prefer to use tasks so they don't need to write and manage scripts. In this module, we use a mixture of both approaches.

A pipeline step can be associated with a service connection so that it can authenticate to Azure, or to another external system.

## Basic pipeline example

Now that you know the basic concepts behind Azure Pipelines, let's look at a simple pipeline definition in YAML:

:::code language="yaml" source="code/2-simple.yaml" :::

Let's look at each part in detail.

- `trigger` tells your pipeline when it should execute. In this case, `trigger: none` is our way of telling Azure Pipelines that we want to manually trigger the pipeline.
- `pool` instructs our pipeline which agent pool to use when it runs the pipeline steps. In this example, we want to execute our pipeline on an Ubuntu agent machine from the pool of Microsoft hosted agents.
  > [!NOTE]
  > In this example, we define the `pool` for the whole pipeline. Sometimes, you might have different jobs that need to run on different agent pools. You can configure the `pool` for each job.
- `jobs` defines the list of jobs that our pipeline runs. In this example, we have a single `job`.
- `steps` lists the sequence of actions that we want to run. We have two steps, both of which run a simple script to echo some text. Each step has a `displayName`, which is a human-readable name for the step. You'll see the display name when you look at the pipeline logs. You'll also see any outputs from the commands in your steps.

> [!IMPORTANT]
> In YAML files, indentation is very important. Take a look at the example above: some lines are indented by two or four spaces. The number of spaces you use is important, and if you don't indent your file correctly then Azure Pipelines won't be able to interpret it. Visual Studio Code helps you to find and fix errors in your YAML file indentation.
