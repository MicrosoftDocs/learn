By using GitHub Actions _workflows_, you can automate the steps in your deployment process. Each time you make a change to code and you commit the change to your Git repository, your workflow runs your predefined process. The workflow can verify whether your Bicep code meets your quality standards, and then automates the actions to deploy your resources to Azure. You describe this process by creating a _workflow definition_.

GitHub Actions is a feature of GitHub. GitHub also hosts the Git repositories you use to store and share your code with your collaborators. Once your Bicep code is stored on GitHub, GitHub Actions can access your code to automate your deployment processes. In this unit, you'll learn about GitHub Actions.

## What are workflows?

GitHub Actions enables you to describe the process that you follow to test and deploy your Bicep code. A GitHub Actions workflow includes all of the steps you want to execute, and the order in which you want them to happen.

When you work with GitHub Actions, you describe your workflow by using a YAML file. This YAML file needs to be stored in your repository in a folder called `.github/workflows`. A YAML file is a structured text file, a little like how Bicep is also a structured text file. You can create and edit YAML files using any text editor. In this module, you'll use Visual Studio Code, which includes an extension to help you edit GitHub Actions workflow YAML files. The GitHub web interface also provides some tools to view and edit your workflow YAML files.

Because workflow YAML files are code, they're stored alongside your Bicep code in your Git repository. You use Git's features to collaborate on your workflow definition, and you can manage different versions of your workflow file by using commits and branches. 

## Runners

Until now, you've deployed your Bicep files from your local computer. After you write a Bicep template, you deploy it to Azure by using the Azure CLI or Azure PowerShell. These tools use your computer's resources to submit the template to Azure, and they use your personal identity to authenticate you to Azure to verify that you're allowed to deploy the resources.

So how does this translate to a GitHub Actions workflow? The workflow needs access to a computer so that it can execute the deployment steps. GitHub Actions workflows uses a machine called a _runner_. A runner is a computer that's configured to run the steps in your workflow. Each runner already has the Bicep and Azure tooling you used in the previous modules installed, so it's able to do the same things that you do from your own computer. Instead of a human executing commands, the GitHub service instructs the runner to perform the actions you've defined.

GitHub Actions provides multiple types of runners with different operating systems, like Ubuntu or Windows, and sets of tools. GitHub runs these runners so you don't have to maintain any compute infrastructure. They're sometimes called _GitHub-hosted runners_ since they're hosted on your behalf. When your workflow runs, a GitHub-hosted runner is automatically created, and it's automatically deleted after your workflow runs. You can't access GitHub-hosted runners directly, so it's important that your workflow contains all the steps necessary to deploy your solution.

:::image type="content" source="../media/2-runner.png" alt-text="Diagram that shows a pipeline that runs on an runner." border="false":::

> [!NOTE]
> You can also create your own custom runners. These are called _self-hosted runners_. You might do this if you have specific software you need to run as part of your workflow, or if you need to have a lot of control over exactly how the runner is configured. We don't discuss self-hosted runners in this module, but we provide a link to more information in the summary.

## Triggers

You need to instruct GitHub Actions _when_ to run your workflow by using a _trigger_. There are multiple types of trigger available. For now, you'll just use a _manual trigger_, which means you'll manually tell GitHub Actions when to start running your workflow. Later in this module, you'll learn about the other triggers you can use.

:::image type="content" source="../media/2-trigger.png" alt-text="Diagram that shows a trigger initiating a workflow." border="false":::

## Steps

A step represents a single operation that the pipeline will perform. Think of a step as being like the individual command you execute in Bash or PowerShell. For most deployments, you execute several steps in a sequence. You define the sequence, and all of the details of each step, in your workflow YAML file.

There are two types of steps in GitHub Actions:

- _Run steps_ enable you to run a command.
- _Action steps_ combine multiple run steps for ease of use. You can create your own actions, or pick an action from the multitude of actions that have been created by the GitHub community. 

Some people prefer to use run steps rather than pre-defined actions, because they provide more control over exactly what is executed. Other people prefer to use pre-defined actions so they don't need to write and manage individual run commands. In this module, we use a mixture of both approaches.

## Jobs

In GitHub Actions, you create groups of steps called _jobs_. Each job represents an ordered set of steps. You always have at least one job in a workflow, and when you create complex deployments it's common to have more than one job.

> [!NOTE]
> Each job can run on a different runner if you want it to. This is useful when you build and deploy solutions that need to use different operating systems in different parts of their workflow. For example, imagine you're building an iOS app and its backend service. You might have one job that runs on a macOS runner to build the iOS app, and another job that runs on a Ubuntu or Windows runner to build the backend. You might even tell the workflow to run the two jobs simultaneously, which speeds up your workflows' execution.

:::image type="content" source="../media/2-steps.png" alt-text="Diagram that shows a workflow with two steps, both within one job." border="false":::

## Basic workflow example

Now that you know the basic concepts behind GitHub Actions, let's look at a simple workflow definition in YAML:

:::code language="yaml" source="code/2-simple.yaml" :::

Let's look at each part in detail.

- `name` is the name of your workflow. It determines how the workflow will be shown on the GitHub web interface.
- `on` tells your workflow when it should execute. In this case, `on: [workflow_dispatch]` tells GitHub Actions that you want to manually trigger the workflow.
- `jobs` groups together all the jobs in your workflow.
- `say-hello` is the name of your first and only job in this workflow. 
- `runs-on` indicates which type of runner you want to use for your job. In this case we use the latest Ubuntu runner.
- `steps` lists the sequence of actions to run within the job. This example includes two steps, both of which run a simple command to echo some text. Each step has a `name`, which is a human-readable name for the step. You'll see the display name when you look at the workflow logs. You can use the pipe character (`|`) to create a multi-line command. After your step executes, you'll see the outputs in the workflow log.

> [!IMPORTANT]
> In YAML files, indentation is important. Take a look at the example above: some lines are indented by two or four spaces. The number of spaces you use is important, and if you don't indent your file correctly then GitHub Actions won't be able to interpret it. Visual Studio Code helps you to find and fix errors in your YAML file indentation.
