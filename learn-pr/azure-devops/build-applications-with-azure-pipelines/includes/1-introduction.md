The _Space Game_ team is being pulled in many different directions. Andy, the lead dev, is running from one meeting to another and never has any time. Amita, the QA person, is helping a tester on another team. Tim, who's in ops, is upgrading his servers and she hasn't seen him for days. Mara's dream of a true DevOps team is stalled (again). 

But she isn't giving up. She remembers that she and Andy made a list of problems with the build process.

![Backlog of tasks](../media/1-all-tasks-board.png)


She also remembers that they picked three of the problems to fix within the next two weeks. (Of course, everyone else has forgotten about them.)

<!--insert image of 3 work items again?-->

Mara decides to take an initial pass on the biggest issue, **Stabilize the build server**, herself. She won't try to fix everything. Instead she's going to see if she can use Azure Pipelines to replicate the current build process. She's convinced that Azure Pipelines provides enough benefits that the process will be improved just by using it. If she's right, she'll show her version to the team to see if she can make them more enthusiastic.  

## Prerequisites

To complete this module, you need to install development tools and create a few accounts. These are tasks you only need to perform once.

The software and accounts you set up now will prepare you to complete this and future modules as well as apply what you learned to your own projects.

You can set up everything shown here on a Windows, macOS, or Linux system.

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
- [Git](https://git-scm.com/downloads?azure-portal=true)
- A [GitHub account](https://github.com/join?azure-portal=true)
- An [Azure DevOps account](https://dev.azure.com?azure-portal=true)

If you don't already have an Azure DevOps account, we highly recommend you go through the [Design a DevOps practice](https://docs.microsoft.com/learn/paths/design-a-devops-practice?azure-portal=true) learning path before continuing this module. There, you'll:

* Examine your existing processes
* Identify the key benefits of DevOps
* Sign up for your free Azure DevOps account