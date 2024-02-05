Microsoft Azure Pipelines is a cloud service you can use to automatically build, test, and deploy your code project. You can also make it available to other users, and it works with just about any language or project type.

Mara is excited about replicating the team's build process on Azure Pipelines. Amita, the tester, finally has some free time and wants to catch up. Mara decides that now is a great time to tell her about her plan: setting up an automated build pipeline for the *Space Game* web site by using Azure Pipelines.

When she hears Mara's plan, Amita is a bit hesitant. But because Mara's plan is to replicate the build process but not replace it, she's also curious. She knows the build process could use some improvements.

**Amita:** It sounds like an interesting exercise, but you must want to prove a DevOps point!

**Mara:** You already know me so well!

**Amita:** What improvements do you expect to see, especially because you're going to do what we already do?

**Mara:** I think that just moving to Azure Pipelines will bring many benefits. Remember, Azure Pipelines is a cloud service. We can use it to automatically build and test code. And it will be available to others as well. It works with just about any language or project type.

Our build server has problems, and even keeping it up-to-date is hard. Because Azure Pipelines provides build servers that Microsoft hosts and maintains, it always has the latest patches and security updates. We won't have to worry about maintaining build servers.

Also, we have all kinds of scripts written by different people. We don't even understand how some of them work. Azure Pipelines comes with a catalog of tasks. A *task* is a packaged script or procedure that's been abstracted with a set of inputs. I'm going to try to map what our build scripts do to those tasks. At least we can standardize how things get done and increase the level of automation.

And Azure Pipelines works with many different languages and app types. If we want to expand in those directions, we won't have to retool.

**Amita:** I know it's selfish, but why do I care? One of my big problems is that I never know when a build is ready to test. Sometimes someone remembers to update the spreadsheet, but many times they forget. It seems like I'm the last person to know.

**Mara:** Right, that's something we can easily fix. We can set up the pipeline to notify you automatically, either through email or some other notification, when a build is ready. You'll never have to wait for someone to remind you again.

**Amita:** Okay, so your goal right now is to build the app and let me know when it's ready?

**Mara:** Right! Of course, I've got bigger plans. I know you're all going to love this first step, so I want to build on it to give us true continuous integration.

**Amita:** Give me the 5-minute rundown on continuous integration.

**Mara:** Let me draw you a picture.

*Mara moves to the whiteboard and draws the pipeline.*

:::image type="content" source="../media/2-whiteboard-pipeline-with-callouts.png" alt-text="Screenshot of a hand-drawn illustration of a CI pipeline. The Build, Test, and Verify stages act on code. The build artifact is the output.":::

**Mara:** This is my CI pipeline. *CI* is the process of automating the building and testing of code every time a team member commits changes to version control. I know we don't do automated testing yet, but give it time.

A *pipeline* defines the continuous integration process for the app. It's made up of steps called *tasks* :::image type="icon" source="../../shared/media/callout-01.png":::. You can think of it as a script that defines how your build, test, and deployment steps are run. I'm going to try to map our scripts to tasks.

The pipeline runs when you submit code changes :::image type="icon" source="../../shared/media/callout-02.png":::. You can configure the pipeline to run automatically, or you can run it manually. You connect your pipeline to a source repository like GitHub, Bitbucket, or Subversion. One of our tasks for this sprint is to start using GitHub. So we'll use GitHub for this project.

A *build agent* :::image type="icon" source="../../shared/media/callout-03.png"::: builds or deploys the code. When your build or deployment runs, the system begins one or more jobs. An agent is an installable software that runs one build or deployment job at a time. Because we're using Azure Pipelines, we can use a Microsoft-hosted agent. With Microsoft-hosted agents, maintenance and upgrades are taken care of for us. Each time we run a pipeline, we'll get a fresh virtual machine. There are several virtual machine images to choose from, including Ubuntu 22.04, which is what we use.

The final product of the pipeline is a *build artifact* :::image type="icon" source="../../shared/media/callout-04.png":::. Think of an artifact as the smallest compiled unit that we need to test or deploy the app. For example, an artifact can be:

* A Java or .NET app packaged into a *.jar* or *.zip* file.
* A C++ or JavaScript library.
* A virtual machine, cloud, or Docker image.

And that's it. I know we can do this.

**Amita:** It sounds great. Let's see what you have to do to get it to work and how long it takes you. You can give us all a demo.

**Mara:** Will do!

## Manage build agents

Now that you and the team are familiar with Azure Pipelines, let's talk a bit more about build agents. A build agent is a piece of installable software that runs one build or deployment job at a time. To build your code or deploy your software, you need at least one agent. As you add more code and people, you'll eventually need more than one agent. There are two main categories of agents.

* **Microsoft-hosted agents** are agents managed by Microsoft, and maintenance and upgrades are taken care of for you. Each time you run a pipeline, you get a new agent for each job in the pipeline. In this module, when you choose **Local development environment using a Microsoft-hosted agent**, you are running your pipeline on a Microsoft-hosted agent. To run pipelines on a Microsoft-hosted agent, your organization must have at least one Microsoft-hosted parallel job. [Check your Microsoft-hosted parallel jobs count](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs) to ensure that you have at least one Microsoft-hosted parallel job. If your Microsoft-hosted parallel jobs count is zero (new Azure DevOps organizations typically have zero parallel jobs), you can [request a free grant](https://aka.ms/azpipelines-parallelism-request). The approval process for the free grant typically takes 2-3 business days.

* **Self-hosted agents** are agents that are managed by you. You configure the virtual machines or containers by installing the agent software and desired tools, and register the agents with Azure DevOps. In this module, when you choose **GitHub Codespaces development environment using a self-hosted agent**, you're using a self-hosted agent running in your GitHub Codespaces container. Self-hosting the agent on a GitHub Codespaces container is not a typical production scenario, but it does provide an environment for completing this training module.
