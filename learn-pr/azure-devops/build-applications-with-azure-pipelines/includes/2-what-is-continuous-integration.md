Talk track:

* Alice and Carol (from QA) sit down over coffee to catch up.
* Alice tells Carol she's going to set up an automated build pipeline for the Space Game web project.
* Carol seems a bit hesitant, but curious. Some questions she might have:
  * What are the benefits?
  * Will QA still be able to pick up builds?
    * Yes! And in fact, you can set things up to send email (and other kinds of) notifications when a build passes or fails. (This addresses one of Carol's concerns - QA doesn't always know when the build is ready.)
  * This sounds pretty big. What's your immediate goal?
    * To build the app and produce a deployable artifact.
* In the sections that follow, Alice gives Carol an overview of continuous integration and pipelines, with an emphasis on Azure Pipelines.

(Here are some starter ideas for sections.)

## What is continuous integration?

_Continuous integration_, or CI, is ...

## What are build artifacts?

A _build artifact_ is a file that you want your build to produce. Think of an artifact as the smallest compiled unit that your team needs to test or deploy your app.

Examples:

* A Java or .NET application packaged into a .jar or .zip file
* A C++ or JavaScript library
* A virtual machine, cloud, or Docker image

Build artifacts typically don't contain the development tools used to create the artifact. Those typically stay on the build server.

## What are pipelines?

A _pipeline_ defines the continuous integration and deployment process for your app. It's made up of steps called tasks. It can be thought of as a script that defines how your test, build, and deployment steps are run.

(more)

## What is Azure Pipelines?

(From the other module, perhaps tweak and expand - connect to value.)

Azure Pipelines allows you to build, test, and deploy with CI/CD that works with any language, platform, and cloud. Connect to GitHub or any other Git provider and deploy continuously.

(Talk about how you can use build agents that Microsoft provides for free (and what kinds you can choose from.))

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