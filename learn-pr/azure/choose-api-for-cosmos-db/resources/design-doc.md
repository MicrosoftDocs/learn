# Module Design

## Title

Create an app to run parallel compute jobs in Azure Batch

## Role(s)

- Developer

## Level

- Intermediate

## Product(s)

- Azure
- Azure Batch
- .NET

## Prerequisites

- Familiarity with Azure and Azure Batch and the Azure portal
- Experience developing .NET apps in Visual Studio 

## Summary

Azure Batch is an Azure service that enables you to run large-scale parallel and high-performance computing (HPC) applications efficiently in the cloud. There's no need to manage or configure infrastructure. Just schedule the job, allocate the resources you need and let Batch take care of the rest. In this module, we will create a .NET app that sets up and runs an Azure Batch job. 

## Learning objectives

1. Build and run an Azure Batch job from a .NET app
1. Interact programmatically with Batch and Storage resources
1. Add an application package to a Batch account
1. Manage a Batch  programmatically

## Chunk your content into subtasks

| Subtask                                                                      | What part of the introduction scenario does this subtask satisfy?          | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|------------------------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Setup Batch and Storage accounts in the Azure portal                         | Creates Batch and Storage accounts in your subscription  to run Batch jobs | Exercise                                          | 1                                                | Yes                                                                                                                            |
| Access your Batch account using the .NET client library                      | Creates a .NET console app and accesses Batch account programmatically     | Exercise                                                 | 1,2,4                                            | Yes                                                                                                                            |
| Create and run a Batch job using the .NET client library                     | Creates a simple Batch job programmatically                                | Exercise                                                 | 3                                                | Yes                                                                                                                            |
| Process files in parallel using an application deployed to each compute node | Creates a more sophisticated solution that uses an application package     | Exercise                                                 | 3                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    You're a software developer for company that manages a network of pet shelters across the country. Every day more and more animals are offered up for adoption. Finding new homes is difficult, so you decide to re-vamp your web-site to include a daily feed of each animal. Staff at the pet shelters take a short video of each pet and post them to a central storage location. To make the cute videos easier to download and share virally, you want to convert the 100's of videos each day into animated GIF files. Conversion of mp4 to animated GIF is compute-intensive and you only need bursts of compute resources each day to get the task done. You decide to invest in an Azure Batch workload running ffmpeg to get the job done. By taking advantage of Azure Batch parallelism, you can convert the videos to animated GIFs in a short amount of time, just in time for the daily update of cuteness on your website. 

1. **Learn - Manage Azure Batch workloads from a .NET app**

    - This is a learn unit. 
    - Briefly introduce core concepts of Azure Batch
    - Describe at a high level why you would want to create an app to manage Batch workloads
    - Describe what the client library offers etc.  
    - Describe the broad steps you would carry out to create and run an Azure Batch job from a .NET app
      - Configure a Batch account and an associated Storage account
      - Create a .NET console app and reference the Azure Batch libraries

1. **Exercise - Setup Batch and Storage accounts in the Azure portal**
    - Straightforward Azure portal exercise that walks through the process of creating a Batch account and a Storage account.
    - Procedure is defined in this [tutorial](https://docs.microsoft.com/azure/batch/batch-account-create-portal) 
    - If the module is run against a sandbox subscription (need to verify if this is possible/allowed), can probably have a *Check your work** validation that makes sure one Batch account and Storage account is in the resource group. 

1. **Learn - Access your Batch account using the .NET client library**
    - Explains the client library, it's capabilities and how to get access to it (nuget install)
    - Dive a little deeper into the management API, describe the usage pattern. 

1. **Exercise - Access your Batch account using the .NET client library**
    - Create a .NET Core console app
    - Install  `Microsoft.Azure.Management.Batch`
    - Call the BatchManagementClient to return some info about your batch account, such as account name

1. **Learn - Create and run a Batch job using the .NET client library**

    - Map Azure Batch concepts to the client API and  outline in pseudocode what to do.
    - Talk about how files and resources are uploaded for a job

1. **Exercise - Create and run a Batch job using the .NET client library**
    - Build on the app from the last unit
    - Add code to run a simple job, similar to the docs tutorial that illustrates pools, tasks, uploading input files etc. 

1. **Exercise - Manage and deploy applications on compute nodes**
    - Describe application packages, their benefits
    - Talk about process of deploying packages and then referencing them in an app

1. **Exercise - Process files in parallel using an application deployed to each compute node**
     - Here we are changing the Batch job to be more realistic - process actual files in parallel on compute nodes.
     - Need to show how an application (ffmpeg) is installed and deployed to compute nodes
     - Update code from our project to upload videos, call the ffmpeg app to convert the video to animated GIF

1. **Summary**

    - Benefits of Azure Batch
    - Usefulness of the .NET client libraries for Azure Batch
    - Power of deploying applications to compute nodes to process files
    - Resources for further reading

## Notes

- The key concept we are teaching in this module is that powerful client libraries exist to enable you to programmatically setup and run Azure Batch jobs
- Follow the Learn-Exercise pattern of paired units as much as possible in this module. Teach something and then let the user practice in an exercise.
- Unit names are just suggestions. Feel free to adjust. Do not include the word **Learn** in learn unit titles. Do include the work **Exercise -** in exercise units.
- Design the module for Visual Studio Code running  locally is an easier install and I would go that route. A C# console app is fine for this application, and the Azure documentation(see resources below) show some examples. Do NOT copy the structure of the tutorials - build up the code in a series of steps and by all means give the learner the final product as a GitHub repo. We want to teach the order in which things were added to the app. 
- Assume some familiarity with Azure Batch, but introduce key concepts lightly in unit 2. The learner needs to understand the moving parts of creating and running Batch jobs using the client library
- Start with creating a "hello world" example of creating and running a Batch job from a console app. 
- Evolve the same codebase in the module to do some time consuming processing on a set of compute nodes. Show how we deploy application packages and then reference and use them in a batch job. 
- In  Azure docs, the tutorial talks about using ffmpeg to convert video from one format to another. A unique twist on that theme would be to use the same application (ffmpeg) but this time convert video to animated GIF, as per the scenario I documented in the introduction.
- Produce between 5 and 8 very short (each < 5 seconds) videos that e=we intend to convert to animated GIFs. Given the core scenario involves pets, each video could be as simple a short video of a cute cat or dog. **Please work with the video team on this aspect** - we want videos that are suitable and add value. Perhaps the video team can consider licensing these videos, or we consider getting some team members to make these clips for us.
- Make sure to call out the fact that you can programmatically tear down a Batch job.
- References
  - [Azure Batch Libraries for .NET](https://docs.microsoft.com/dotnet/api/overview/azure/batch?view=azure-dotnet)
  - [Deploy application packages](https://docs.microsoft.com/azure/batch/batch-application-packages)
  - [Batch API Basics](https://docs.microsoft.com/azure/batch/batch-api-basics)
  - [Quickstart: Run your first Azure Batch job with the .NET API](https://docs.microsoft.com/azure/batch/quick-run-dotnet)
  - [Tutorial: Run a parallel workload with Azure Batch using the .NET API](https://docs.microsoft.com/azure/batch/tutorial-parallel-dotnet)
  - [ffmpeg documentation](https://www.ffmpeg.org/documentation.html)
