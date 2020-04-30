In this unit, you will first watch a video introduction about Azure Quantum service and the types of problems Azure Quantum can help with. 
You will learn about the third party hardware providers you can access through Azure Quantum. 

> [!VIDEO https://www.microsoft.com/...]

Azure Quantum allows you to run Quantum Programs and solve Quantum-Inspired Optimization (QIO) problems in the cloud. 
Azure Quantum takes these jobs and schedules them with the desired provider for execution. 
Using our SDKs and tools you can easily run a job against multiple providers and targets to find the one that will work best for your scenario.

![Azure Quantum Overview](./media/Azure-Quantum-Flow-Diagram.png)

# Quantum Workspace
Azure Quantum is a service provided by Azure. Like other Azure services, you need to deploy an Azure Quantum resource into your Azure subscription in order to use the service. This resource is called an **Azure Quantum Workspace** - or **Workspace** for short. Please see [Creating an Azure Quantum Workspace](/Guides/Creating-an-Azure-Quantum-Workspace) for detailed instructions.

Once you create a Workspace, you'll be able to select which third party providers you would like to be able to use in that Workspace. Every Workspace also comes with the Microsoft provider always enabled. For more information about providers, see [Providers and Targets](#Providers-and-Targets) below. If you haven't enabled a particular provider for execution in your Workspace, you will not be able to run jobs against that provider later. You may change the enabled providers in your Workspace after creating it.
> In the current private preview, only the first party Microsoft provider is available.

When you enable a provider in your Workspace you also select the billing plan for that provider, which defines how you're billed for jobs against that provider. Each provider may have different billing plans and methods available. For more information, see the documentation on the provider you would like to enable.

While you may only select a single billing plan for a specific provider in a single Workspace, you may deploy multiple Workspaces in your Azure subscription.

# Jobs in Azure Quantum
Whenever you execute a Quantum Program or solve a QIO problem in Azure Quantum, you are creating and running a job. The way to create and run a job depends on the type of the job and the target (see below for a list of [providers and targets](#Providers-and-Targets)), however all jobs have the following properties:
- **ID**: A unique identifier for a job. Unique within your Workspace.
- **Provider**: _who_ you want to execute your job - e.g. Microsoft or a 3rd party
- **Target**: _what_ you want to execute your job on - e.g. the exact quantum hardware or solver offered by the provider
- **Name**: a name, chosen by you, to help you organize your jobs
- **Parameters**: some targets take input parameters. See your chosen target for a definition of available parameters.

Once created, you'll also find various metadata available about the state of your job and its execution history.

## Job Lifecycle
Jobs are typically created using one of our SDKs (e.g. the [Python SDK](/Guides/Using-the-Python-SDK)) or the QDK. Once you've written your Quantum Program or expressed your QIO problem, you may pick a target and run the job.

Once a job has been submitted you must poll for the status of the job. Jobs have the following possible states:
- `waiting` - the job is waiting to be executed. Some jobs will perform pre-processing in the waiting state. `waiting` is always the first state, however a job may move to `executing` before you observe it in `waiting`.
- `executing` - the job is currently being executed by the target.
- `succeeded` - _[Final]_ the job has succeeded and output is available.
- `failed` - _[Final]_ the job has failed and error information is available.
- `cancelled` - _[Final]_ the user requested the job execution be cancelled - see [Job Cancellation](#Job-Cancellation).

The diagram below shows the possible state transitions.

::: mermaid
graph LR
    waiting --> executing
    waiting --> failed
    waiting -.-> cancelled
    executing --> succeeded
    executing --> failed
    executing -.-> cancelled
:::

The `succeeded`, `failed`, and `cancelled` states are considered **final states** - once in one of these states, no more updates will occur. It also means that the corresponding job output data will not change.

After a job completes successfully, it will have a link to your Azure Storage account where you can find the output data. How you access this data depends on the SDK or tool you used to submit the job.

## Job Cancellation
When a job is not in a final state, you may _request_ for the job to be cancelled. Not all providers support job cancellation in all states. All providers will cancel your job if it is in the `waiting` state, however if your job is `executing` the provider may not support cancellation.

If you cancel a job after it has started executing you may still be billed a partial or full amount for that job. Please see the billing documentation for your selected provider.

# Providers and Targets
In Azure Quantum, the ability to execute a job is given by **Providers**. A single Provider may expose one or more **Targets** for execution. A Target is what is ultimately executing your job. The list of available targets is shown below based off of the type of job being executed:

**Types of Targets for Quantum Programs**
- Quantum Hardware (e.g. 6 qubit device, 10 qubit device, ...)
- Quantum Simulator (e.g. full-state simulator, Toffoli simulator, ...)

**Types of Targets for Quantum-Inspired Problems**
- Quantum-Inspired Solution (e.g. simulated quantum annealing optimizer, optimizer with parallel tempering, ...)

## Available Providers and Targets
To see a list of available providers, see [Providers](/Reference/Providers).

# Getting Started
When you're ready to get started, please see our guide for [Creating an Azure Quantum Workspace](/Guides/Creating-an-Azure-Quantum-Workspace).
