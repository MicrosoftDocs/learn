Mara is excited about replicating the team's build process on Azure Pipelines. Amita, the tester, finally has some free time and she wants to catch up. Mara decides that now is a great time to tell her about her plan: setting up an automated build pipeline for _Space Game_ using Azure Pipelines. 

When she hears Mara's plan, Amita is a bit hesitant but since Mara's plan is to replicate the build process but not replace it, she's also curious. She knows the build process could use some improvements.

Amita: It sounds like an interesting exercise, but you must want to prove a DevOps point!

Alice: You already know me so well!

Amita: What improvements do you expect to see, especially since you're going to do what we already do.

Alice: I think that just moving to Azure Pipelines will bring a lot of benefits. Remember, Azure Pipelines is a cloud service that you can use to automatically build and test code and make it available to other users. It works with just about any language or project type.

Our build server has problems. Even keeping it up to date is hard. Since Azure Pipelines is a cloud service, it's always got the latest patches and security updates. We won't have to worry about maintaining the pipeline.

Also, we have all kinds of scripts written by different people. We don't even understand how some of them work. Azure Pipelines comes with a catalog of tasks. A task is a packaged script or procedure that has been abstracted with a set of inputs. I'm going to try and map what the scripts do to those tasks. At least we can standardize how things get done and increase the level of automation.

Finally, Azure Pipelines works with many different languages and application types. If we want to expand in those directions, we won't have to retool.

Amita: I know it's selfish but why do I care? One of my big problems is that I never know when a build is ready to test. Sometimes someone remembers to update the spreadsheet but a lot of times they forget. It seems like I'm the last person to know.

Mara: Right, that's a task on our board and we can fix it easily. We can set up the pipeline to notify you automatically, either through email or some other kind of notification when a build is ready. You'll never have to wait for someone to remember you again.

Amita: Okay, so your goal right now is to build the app and let me know when it's ready it?

Mara: Right! Of course, I've got bigger plans. I know you're all going to love this first step so I want to build on it to give us true continuous integration.

Amita: Give me the 5 minute rundown on continuous integration (CI).

Mara: Let me draw you a picture:

<!-- TO DO: get a diagram of the pipeline. It should be informal, handdrawn. It should include what we talk about below and start with source code and end with a build artifact. -->

This is my CI pipeline. Continuous Integration (CI) is the process of automating the build and testing of code every time a team member commits changes to version control. I know we don't do automated testing yet but give it time.

A _pipeline_ defines the continuous integration process for the app. It's made up of steps called tasks. It can be thought of as a script that defines how your test, build, and deployment steps are run. I'm going to try and map our scripts to tasks.

A _build agent_ builds or deploys the code. When your build or deployment runs, the system begins one or more jobs. An agent is installable software that runs one build or deployment job at a time. Because we're using Azure Pipelines, we can use a Microsoft-hosted agent. With Microsoft-hosted agents, maintenance and upgrades are taken care of for you. Each time you run a pipeline, you get a fresh virtual machine. There are 6 virtual machine images to choose from, including Ubuntu 16.04, which is what we use.

The final product of the pipeline is a _build artifact_. Think of an artifact as the smallest compiled unit that your team needs to test or deploy your app. For example, an artifact can be:

* A Java or .NET application packaged into a .jar or .zip file
* A C++ or JavaScript library
* A virtual machine, cloud, or Docker image

And that's it. I know we can do this.

Amita: It sounds great. Let's see what you have to do to get it to work and how long it takes you. You can give us all a demo.

Mara: Will do!

<!-- I think we should end the unit here. All the other stuff needs to get moved to a different unit or folded in where it's appropriate. It's wordy -->


## What options do we have?

(The JTA calls out "AppCenter, VSTS, Jenkins, CircleCI". Do we compare other options here?)

## Which should I choose?

(Call out that if you have something that's working, continue to use it! A benefit of Azure DevOps is that integration among components comes out of the box, but you can also integrate the pieces you need with what you already have. Make the case for Azure DevOps if you don't have an existing process.)

(Alice recommends Azure Pipelines because:

* They don't have an existing CI system, and Azure Pipelines seems to provide everything they need.
* Of particular interest is that it comes with free build agents, including Ubuntu, which is what they currently use. This makes it easy for Alice to get started and build a proof of concept (and possibly use in production!)

Carol seems to buy into the idea, and wishes Alice luck. Carol can't wait to see what Alice finds.)

## How does Azure Pipelines work?

Talk track:

* Lead in with something (TBD).
* You can choose from two different options when configuring your pipeline:
  * The visual designer
  * Define your pipeline using code (here, YAML files)
* Alice compares the two approaches and chooses code (YAML files) mainly because:
  * It's versionable (You can treat and manage the files like you can any other source code file. You can trace the history if something breaks or changes.)
  * It's easy to integrate. Just drop the YAML file at the root of your code repository and connect it to your Azure Pipelines project.
  * Any other reasons come to mind?

## How are pipelines structured?

Talk track:

* We'll point to more resources around learning YAML and the schema used to define pipelines at the end of this module.
* Here are some important parts of the pipeline you'll use in this module.

### Agent pools

Talk track:

* [Summarize this](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops). Key points used in this module are:
  * Defines the VM image to use (for us, Ubuntu 16.04)
  * Defines what build software you need running on the agent - for example, MSBuild or Visual Studio. Alice needs npm installed.

Here's an example that defines an agent pool that uses the Ubuntu 16.04 VM image that has npm, the Node.js package manager, installed.

```yml
pool:
  vmImage: 'Ubuntu-16.04'
  demands:
    - npm
```

### Variables

Variables enable you to define values one time and refer to those values throughout your pipeline. The system replaces each variable with its current value when the pipeline runs.

For example, ...

Just like with other programming languages, variables enable you to:

* Define values that may change from run to run of your pipeline.
* Store information that's repeated throughout your pipeline, such as a version number or a file path, in one place. That way, you don't need to update all occurrences when your needs change.

Azure Pipelines provides a number of built-in variables which describe aspects of the build process such as the build identifer and the directory names where your software is built and staged.

You can also define your own variables. Here's an example that shows a variable named `buildConfiguration` that defines the Release build configuration.

```yml
variables:
  buildConfiguration: 'Release'
```

### Tasks

A _task_ is a building block that defines a single build activity.

Azure Pipelines provides a number of built-in tasks. A built-in task abstracts away the underlying details, making it easier to run common build functions, such as downloading packages your app depends on or running Visual Studio or Xcode to build your project.

When a built-in task doesn't exist for what you need, you can run a shell command or a script, such as Bash or PowerShell.

Here's an example that uses the `DotNetCoreCLI@2` task to build a C# project that targets .NET Core.

```yml
task: DotNetCoreCLI@2
  displayName: 'Build the project'
  inputs:
    command: 'build'
    arguments: '--no-restore --configuration Release'
    projects: '**/*.csproj'
```

The pipeline might translate this task to this command:

```bash
dotnet build MyProject.csproj --no-restore --configuration Release
```

Let's break this down a bit more.

* The `DotNetCoreCLI@2` task maps to the `dotnet` command.
* `command` specifies to run the `dotnet build` subcommand.
* `arguments` specifies additional arguments to pass to the command.
* `projects` specifies which projects to build. This example uses the wildcard `**/*.csproj` which means all .csproj files in all directories beneath the current directory.
* The `displayName` argument defines the task name that's shown in the user interface. You'll see this in action shortly.

#### Task versions

The "@" in the task name, such as `DotNetCoreCLI@2`, refers to the task's version. As new task versions become available, you can gradually migrate to the latest version to take advantage of new features.

#### Conditions

You can also assign a _condition_ that defines when a build task is run. For example, you might want to run an additional logging task when the previous task has failed.

Most of the time you'll use the default behavior, which is to run each build task only when the previous task succeeds. You can also define your own custom conditions.

### Steps

Steps define your build procedure. A build step can run a built-in task or a script. Steps are run sequentially in the order you define.

For example, say your build process needs to:

1. Compile Sass or TypeScript files to standard CSS and JavaScript files.
1. Minimize all CSS and JavaScript files for faster downloading.
1. Compile the application's binary files from source code.
1. Copy the build results to a shared location.

You would define your build tasks in that order, and the pipeline will run them in the order you define. You'll map commands that build the _Space Game_ web site to pipeline tasks shortly.

### Templates

You can also define a series of build steps in a _template_. A template enables you to define common build tasks one time and reuse those tasks multiple times.

You call a template from the parent pipeline as a build step. You can pass parameters into a template from the parent pipeline.

(summary)