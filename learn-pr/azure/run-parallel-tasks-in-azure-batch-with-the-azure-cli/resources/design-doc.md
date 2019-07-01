# Module Design

## Title

Run parallel tasks in Azure Batch with the Azure CLI

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure
- Azure Batch
- Azure CLI

## Prerequisites

- Familiarity with Azure and the Azure CLI

## Summary

Azure Batch is an Azure service that enables you to run large-scale parallel and high-performance computing (HPC) applications efficiently in the cloud. There's no need to manage or configure infrastructure. Just schedule the job, allocate the resources you need and let Batch take care of the rest.

## Learning objectives

1. Create an Azure Batch job in the Azure CLI
1. Run an Azure Batch job in the Azure CLI
1. Check status and results of Batch job in Azure CLI
1. Monitor a Batch job with Batch Explorer

## Chunk your content into subtasks

| Subtask                        | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|--------------------------------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Design an Azure Batch job to run your parallel task         | Maps parallel task to Batch concepts                                    | Knowledge Check                                                 | 1                                                | Yes                                                                                                                            |
| Create an Azure Batch job to run your parallel task                  | Creates a Batch job using the CLI                                           | Exercise                                                 | 2                                                | Yes                                                                                              |
| Monitor your Azure Batch job in the CLI | Use CLI commands to check job status and download results                                   | Exercise                                                 | 3                                                | Yes                                                                                                                            |
| Monitor and visualize your batch job in Batch Explorer               | Use Batch Explorer to monitor running tasks                            | Exercise                                                 | 4                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

You're a software developer in a non-profit whose mission is to give every human on the planet access to clean water. To reach this goal, every citizen is asked to take a picture of their water purification meter and text it to you. Each day, you have to scan picture from over 500,000 households, and  record each reading against the sender phone number. The data is used to detect water quality trends and to dispatch the mobile water quality team to investigate the worst cases across each region. Time is of the essence, but processing each image with Optical Character recognition is time intensive. With Azure Batch, you can scale out the amount of compute needed to handle this task on a daily basis, saving your non-profit the expense of fixed resources. 
    

1. **What is Azure Batch?**

    - Introduce the world of compute-intensive tasks, parallel workloads.
    - Describe the characteristics of an Azure Batch workload design - pools, nodes, jobs and tasks.
    - Show a workflow of how a job is run on a pool, data inputs, outputs etc. <!-- Graphic -->

1. **Design an Azure Batch job to run your parallel task**

<!-- Please fill out the details of the job you are going to use for this module. The scenario n the intro describes a full-blown, real-world scenario but we need to produce something  that works for the module.  For example, it would be fine in my opinion to use a timer to simulate a long-running process (for say 20 seconds). -->
    - Describe a sample scenario, with two or three tasks
    - Explain how/why the tasks in the scenario can be run in parallel, making it a good candidate for Batch
    - Map it to an Azure Batch implementation
    - Re-iterate some advantages of the Batch approach and service.

1. **Exercise - Create an Azure Batch job in the CLI to run your parallel task**

    - Introduce the `az batch` command set
    - Walk learner through steps to setup the job described in the preceding unit.
    - Run job, do not delete because we'll use it in following units

1. **Exercise  - Monitor your Azure Batch job in the CLI**

    - Describe monitor and file download commands
    - Show these commands in action with job in preceding unit - re-run job if necessary 

1. **Visualize batch jobs with the Batch Explorer**

    - Introduce Batch Explorer
    - Explain how to install it

1. **Exercise - Monitor and visualize your batch job in Batch Explorer**

    - Same job as in unit 4 above, this time run it with more tasks.  
    - Show how to monitor the tasks in **jobs** panel

1. **Summary**

    - Benefits of Azure Batch
    - Why CLI is a good choice for running jobs - perhaps mention other options
    - Batch Explorer as another useful too
    - Resources for further reading

## Notes

- This module is an "intro to Azure Batch using the CLI". Assume no knowledge of Azure Batch, but some knowledge of Azure, the Azure portal, Azure CLI and what it means to run tasks in parallel.
- As of this writing, we still need to verify whether the sandbox will support running Azure Batch jobs. If not, the mitigation plan would be to make this a module that requires a developer to have their own subscription. However, the target option is that everything runs in the sandbox.
- We're trying  to teach the concept of Azure Batch, so a simple pool with two or three compute nodes will suffice. Demonstrating that three tasks that take 20 seconds to complete, complete in a total of 20 seconds and not 60 seconds would show parallelism. 
- A stretch goal is to introduce the Batch Explorer to the learner, so they know that there is a tool available to visualize Batch jobs. 
- This is NOT a Batch Explorer module, do don't try to do too much with it. 
- [https://docs.microsoft.com/azure/batch/batch-technical-overview](https://docs.microsoft.com/azure/batch/batch-technical-overview)
- [https://azure.microsoft.com/services/batch/](https://azure.microsoft.com/services/batch/)

- [https://azure.github.io/BatchExplorer/]( https://azure.github.io/BatchExplorer/)
