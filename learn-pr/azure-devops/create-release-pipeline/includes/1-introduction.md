Talk about CD and release pipeline.

## Learning objectives

In this module, you will:

- 
- 
- 
- 

## Prerequisites

If you don't already have an [Azure DevOps](https://dev.azure.com?azure-portal=true) organization, go through the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path before starting this module.

You'll also need to set up a development environment on your Windows, macOS, or Linux system. You'll need:

* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.

Roberta's notes:

The Tailspin team is starting to feel better about their build process. They’ve got an automated version running on Azure Pipelines, which means the build environment is stable. Amita knows immediately when there’s an artifact for her to test. She’s finding fewer bugs because Andy and Mara have started to add unit tests and code quality tests. Life is looking good. 

Everyone on the team is in the meeting room waiting for Irwin, who says he wants to talk to them. They’re looking forward to telling him about the progress they’ve made. But when Irwin walks in, he doesn’t look happy. He starts talking right away.

“I had a meeting this morning with the execs. They want to know why we’re taking so long to release our games and websites. Our closest competitors get new features and new games out there much faster than we do. We need to speed things up. I’m not just saying this to you. I’m saying it to all the teams. What can we do to help your team deploy faster?” He looks around. “Anyone?”

Andy clears his throat. “This is a little sudden but we’re a bit ahead of you. We’ve been automating our build process and that’s been helpful. Maybe now it’s time to extend our automation to how we deploy our apps.”

Irwin asks, “How do you do this?”

Mara says, “We created an automated build pipeline with Azure Pipelines. It builds an artifact that Amita can test. We could also use Azure Pipelines to build a continuous delivery pipeline (CD).”

“Which is what?”

“It’s a pipeline that not only builds the artifact but runs tests on it and deploys the code first to a some trial areas and then to production. Every code commit we make triggers the pipeline automatically. There’s a lot of data out there that shows how CD speeds up deployments.” 

“Can you give me some talking points I can take back to the exec? Just knowing we have a plan in place will take off some of the pressure.”

Andy says, “If you deploy a small amount of code, you have less to test, less to break and less to go wrong. And if something does go wrong, it’s much easier to understand what caused the problem because the changes to the environment were smaller.

“Also, since we’d be doing more releases, we’d actually get better at the process. The more you do something, the better you get at it.”

Mara adds, “Automation will really help us here. It’s much faster than manual releases and it’s self-documenting and repeatable.

"An automated deployment pipeline means that every time we change the code and build it, we also automatically test it in environments that are similar to production. We’d probably have more than one stage. We’d run our fastest tests first so we’d get feedback about how viable our code is right away. We’d do slower tests and even manual tests at the end. And like I said, we can set up a pipeline on Azure DevOps. Setting up an Azure Pipeline is pretty straightforward."

Irwin says, “I’m really impressed. You’ve anticipated our problems and I feel great being able to tell people that. So how long before you can show me a demo?"

Tim looks at the floor. He’s unhappy about something and Amita looks nervous, too. Andy and Mara look at each other. Andy says, “We’ve been trying to implement pipeline improvements every two weeks. I think we’ll have something to show then, although it certainly won’t be done.”

“Great. I’ll schedule a meeting for two weeks from today." Irwin gets a text and looks at his phone. "Gotta run! Can't wait to see your pipeline.” 

Andy looks around. “That was fun. I guess we should do some planning. Anyone for coffee?”

## Create a release pipeline with Azure Pipelines

This is where they can plan out an initial pipeline. In the intro, I put in that Tim looks unhappy because this may be where we want to talk about now releasing directly to production without some sort of approval process. Tim’s attitude isn’t as unreasonable as it may seem. Operations people are very protective of their release environments and they have good reasons for it. They’re completely responsible for what happens there and many of them will not agree to automatic deployments to production.

I think Amita would be unhappy because she does manual testing and they're talking about automated testing.

I think we decided they'd have the endpoint be either a VM or an App Service. 
Once they have a running pipeline they should be able to navigate to the IP address and see the website running. 

Questions:

What stages will there be (remember that this is a first attempt so it shouldn't be too complicated)?


## Create a release management workflow

What is the overall workflow to get to production?
There should be a formal process
Needs triggers to move from one stage to another
How do you handle secrets?
How do you add dashboards and monitoring?

## Run quality tests in your release pipeline

What tests do you run once the service is operational?
What are integration and functional tests?
What quality tests will we run? Will Amita write them? If not, who will. Can we show her using Azure Test Plan for manual tests? Is there any way to show her starting to learn to write automated tests?

## Manage release cadence using deployment patterns

How do you roll out new features safely?
How do you use progressive disclosure? 
One pattern is Green/Blue, where you toggle between test and production as tests are good. Should we use that? Should we use canary?







