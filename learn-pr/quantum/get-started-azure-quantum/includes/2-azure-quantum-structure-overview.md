Azure Quantum is a Microsoft Azure cloud service for running quantum computing programs and solving optimization problems. In this unit, you will become familiar with the core elements of the Azure Quantum platform. You will learn how to use the different quantum services and create and submit projects to the cloud to use the hardware available.

## What is an Azure subscription?

The cloud is a powerful place that hosts many moving parts. To use the Microsoft cloud, Azure, your crew needs to first have an account to access and manage Azure resources. A *subscription* represents a grouping of Azure resources. An invoice is generated at the subscription scope. It has its own payment methods that are used to pay its invoice. [Learn how to create an Azure account.](/learn/modules/create-an-azure-account/?azure-portal=true)

## How do I use quantum services on Azure?

Azure Quantum is a service on Azure. To use it, you create a *Quantum Workspace*, which is an Azure resource that stores all the quantum programs and optimization problems (called *Jobs*) that you submit to the Azure Quantum service.

The workspace also contains a list of *providers* and *targets* that you've selected. Every provider publishes a set of targets, each of which allows you to run either a quantum program or solve an optimization problem. Simulators, quantum computers, and optimization solvers are examples of targets.

In the next section of this module, you'll create an Azure Quantum workspace.

## Storage account

To store your jobs and results, you will need an Azure storage account. It is one of the properties configured when you set up a Quantum Workspace.

## Jobs

When you run a quantum computing program or solve an optimization problem in Azure Quantum, you create and run a *job*.

The steps to create and run a job depend on the job type and the provider and target that you configure for the Workspace. All jobs, however, have the following properties in common:

|Property|Description|
|-----|----|
|**ID**|A unique identifier for the job. It must be unique within the Workspace.|
|**Provider**|*Who* you want to run your job. For example, the Microsoft Quantum Solution provider, or a third-party provider.|
|**Target**|*What* you want to run your job on. For example, the exact quantum hardware or quantum simulator offered by the provider.|
|**Name**|A user-defined name to help organize your jobs.|
|**Parameters**|Optional input parameters for targets. See the documentation for the selected target for a definition of available parameters.|

After you create a job, you'll also find various metadata available about its state and run history.

In the next unit, you'll create an Azure Quantum workspace.
