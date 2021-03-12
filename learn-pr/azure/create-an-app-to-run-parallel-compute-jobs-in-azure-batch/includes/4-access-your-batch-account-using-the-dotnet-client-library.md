In the previous unit, you created Azure Batch and Azure Storage accounts. Then you uploaded **FFmpeg** as an application so that Batch jobs can use it for their tasks. Let's review our scenario once more. 

You'd like to automate the process of converting MP4 video files into animated GIFs. To do this, you create an app that can upload video files for conversion, start the conversion in parallel across all the uploaded files, monitor the progress, and finally download the results.

In this unit, we'll look at Azure Batch client libraries we can use to access the Batch and Storage accounts we created in the preceding exercise.

## Azure client libraries

There are two NuGet packages you'll need to import into your app. The first is the Azure Batch client library, `Microsoft.Azure.Batch`. You'll use this library to create and delete Azure Batch Pools, create and delete workload jobs, create and delete tasks, and monitor running tasks.

The next library we'll use in the solution is the Azure Storage client library, `Microsoft.Azure.Storage.Blob`, which allows you to connect to, and manage, files in an Azure Storage account. You'll use this library to manage the files in the Blob storage container. The app will scan the folder for all the uploaded videos, and gives access to the job to write out the tasks converted videos.

The Azure Batch Management library, `Microsoft.Azure.Management.Batch`, is a third library that isn't needed for your app because you manually created the Batch and Storage accounts.

We'll add the NuGet packages we need with the `dotnet add package` command.

## Typical usage pattern

Using the above libraries a typical approach to setting up a batch process is:

1. Create Batch Service account (**Batch Management API**)
1. Create a Storage account (**Storage API**)
1. Create a Blob client to manage file processing (**Storage API**)
1. Upload files to process (**Storage API**)
1. Create a pool of compute nodes (**Batch API**)
1. Create a job to run on those nodes (**Batch API**)
1. Add a task to the job to run (**Batch API**)
1. Monitor the progress of the task (**Batch API**)
1. Download processed files when finished (**Storage API**)
1. Delete the input storage container, delete the pool, delete the job (**Batch API** & **Storage API**)

## Azure Batch Pools

A powerful feature of Azure Batch is how it manages to compute resources. By defining pools of resources, Azure Batch has the flexibility to be set to a specific number of nodes. This is a good option if the size of the processing is well-defined and there's a requirement to have a known fixed cost. The other option is to allow the pool to scale up or down automatically based on a formula you define. This can take into account fluctuations in demand, and allow an application to scale to meet that demand. This also has the added benefit of keeping the costs as low as possible.

When creating Azure Batch pools, you specify the attributes:

- The target number of nodes (default limit 100)
- The node's operating system and version (a range of Windows and Linux images are available)
- Type of node, dedicated or low-priority (dedicated nodes are more expensive but wont be preempted, low-priotity nodes are cheaper as they take advantage of surplus capacity in a region, but could have their tasks suspended if the resources are required elsewhere)
- The nodes performance as the size of CPU, memory, and storage
- Auto-scaling policy (scaling is controlled by a formula you specify, for example, based on the percentage of CPU in use)
- Task scheduling policy (control the maximum number of tasks a node can run in parallel, and choose how tasks are distributed between nodes)
- Startup tasks to be performed when nodes boot (used to set up the node to be able to run the tasks, like installing required applications)
- Network configuration (subnet and VNet options)
- Application packages (allow applications to be easily deployed to every node in a pool) 
