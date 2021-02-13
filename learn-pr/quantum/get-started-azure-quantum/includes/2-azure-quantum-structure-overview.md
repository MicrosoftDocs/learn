Azure Quantum is a Microsoft Azure cloud service for running quantum computing programs and solving optimization problems. In this unit, you'll become familiar with the core elements of the Azure Quantum platform. You'll learn how to use quantum services, and how to create and submit projects to the cloud by using the available hardware.

## Azure subscription

The cloud is a powerful place that hosts many moving parts. To use the Microsoft cloud platform, Azure, your crew needs to first have an account to access and manage Azure resources. 

A *subscription* represents a grouping of Azure resources. An invoice is generated at the subscription scope. A subscription has its own payment methods that are used to pay its invoice. [Learn how to create an Azure account.](/learn/modules/create-an-azure-account/?azure-portal=true)

## Workspace

To use quantum services on Azure, you create a *workspace*. A workspace is an Azure resource that stores all the quantum programs and optimization problems (called *jobs*) that you submit to the Azure Quantum service.

The workspace also contains a list of *providers* and *targets* that you've selected. Every provider publishes a set of targets. Each target allows you to either run a quantum program or solve an optimization problem. Simulators, quantum computers, and optimization solvers are examples of targets.

## Storage account

To store your jobs and results, you need an Azure storage account. It's one of the properties that you configure when you set up an Azure Quantum workspace.

## Jobs

When you run a quantum computing program or solve an optimization problem in Azure Quantum, you create and run a job.

The steps to create and run a job depend on the job type and the provider and target that you configure for the workspace. All jobs have the following properties in common:

|Property|Description|
|-----|----|
|**ID**|A unique identifier for the job. It must be unique within the workspace.|
|**Provider**|*Who* you want to run your job. Examples include a Microsoft quantum solution provider or a partner provider.|
|**Target**|*What* you want to run your job on. An example is the exact quantum hardware or quantum simulator that the provider offers.|
|**Name**|A user-defined name to help organize your jobs.|
|**Parameters**|Optional input parameters for targets. For a definition of available parameters, see the documentation for the selected target.|

After you create a job, you'll find that metadata is available about its state and run history.

In the next unit, you'll create an Azure Quantum workspace.
