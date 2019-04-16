The _Space Game_ team is being pulled in many different directions. Andy, the lead dev, is running from one meeting to another and never has any time. Amita, the QA person, is helping a tester on another team. Tim, who's in ops, is upgrading his servers and she hasn't seen him for days. Mara's dream of a true DevOps team is stalled (again). 

But she isn't giving up. She remembers that she and Andy made a list of problems with the build process.

![Backlog of tasks](../media/1-all-tasks-board.png)

She also remembers that they picked three of the problems to fix within the next two weeks. (Of course, everyone else has forgotten about them.)

<!--insert image of 3 work items again?-->

Mara decides to take an initial pass on the biggest issue, **Stabilize the build server**, herself. She won't try to fix everything. Instead she's going to see if she can use Azure Pipelines to replicate the current build process. She's convinced that Azure Pipelines provides enough benefits that the process will be improved just by using it. If she's right, she'll show her version to the team to see if she can make them more enthusiastic.  

## Prerequisites

If you don't already have an [Azure DevOps](https://dev.azure.com?azure-portal=true) account, we highly recommend you go through the [Evolve your DevOps practices](https://docs.microsoft.com/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path before continuing this module. 

You'll also need the following set up for software development on your Windows, macOS, or Linux system.

* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account

This setup prepares you for this and future modules. You can also use them to apply your new skills to your own projects.

<!-- TODOs for next iteration:
- All tasks - set displayName
- DotNetCoreCLI@2 - set nobuild: true instead of --no-build
- Add in DotNetCoreInstaller@0
- unit-tests: `dotnet add package coverlet.msbuild`
- Show Summary tab after first build
- Investigate how to disable Merge button in GitHub until build finishes (and succeeds)
- I think we need a boilerplate Note box that says something to the effect:
  - We're using a .NET Core application written in C# for learning purposes.
  - You don't need to be an expert in .NET or C# to complete this module.
  - You can apply the patterns you see to your own projects using your favorite programming languages and frameworks.
-->

<!-- For the next module (adding the note here), we should lock down the Merge button until the build succeeds.
References:
- https://docs.microsoft.com/en-us/azure/devops/repos/git/branch-policies?view=azure-devops
- start creating ref/ branches for the final work the user does
-->