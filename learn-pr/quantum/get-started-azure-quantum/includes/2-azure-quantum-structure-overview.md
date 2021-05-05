Azure Quantum is a Microsoft Azure cloud service for running quantum computing programs and solving optimization problems. In this unit, you'll become familiar with the core elements of the Azure Quantum platform. You'll learn how to use quantum services, and how to create and submit projects to the cloud by using the available hardware.

## What's included on Azure Quantum?

**Quantum computing**: If you're interested in developing quantum software, then Azure Quantum offers a suite of tools that help you express your algorithms using the Quantum Development Kit and Q#.

There are tools for simulating your programs so that you can test the behavior and performance of your code. In addition, there are tools such as the resource estimator, which helps you understand the resources that your code would require. In terms of a quantum program, this can mean the types of quantum gates you use, the number of operations performed, or the number of qubits you need.

Using all these tools together helps you understand the features of a quantum computer that you'd need in order to run your program, such as the number of qubits and their lifetimes. From a software engineering perspective, it also helps you iterate and improve your code, so that you can reduce the number of resources required to run it.

For more details on how this is done in practice, check out Dave Wecker's talk on [Achieving Practical Quantum Computing](https://cloudblogs.microsoft.com/quantum/2018/06/01/achieving-practical-quantum-computing/?azure-portal=true).

![Diagram showing Azure Quantum Computing.](../media/2-azure-quantum-computing.png)

**Quantum hardware**: After you have a quantum program that you'd like to run on a quantum computer, you can choose from a range of compute options.

For example, there's trapped ion quantum hardware from IonQ and Honeywell. There's also quantum hardware built from superconducting circuits from QCI.

- **Honeywell quantum solutions**: Trapped-ion system with high-fidelity, fully connected qubits, and the ability to perform mid-circuit measurement.

- **IonQ trapped-ion quantum computer**: Dynamically reconfigurable system for up to 11 fully connected qubits that lets you run a two-qubit gate between any pair.

- **Quantum Circuits, Inc.**: Fast and high-fidelity system with powerful real-time feedback to enable error correction.

**Quantum-inspired solutions**: If you want to solve large, complex optimization problems at scale, then you can explore quantum-inspired solvers from Microsoft and partners such as 1QBit.

Solvers emulate certain processes from quantum physics by using classical hardware that's available today.

![Diagram showing Azure Quantum optimization stack.](../media/2-azure-quantum-inspired-solutions.png)

- **1Qloud**: Connecting intractable industry problems to innovative solutions.

- **Microsoft QIO**: Ground-breaking optimization algorithms inspired by decades of quantum research.

- **Toshiba SBM**: Toshiba Simulated Bifurcation Machine is a GPU-powered ISING machine that solves large-scale combinatorial optimization problems at high speed.

## Azure subscription

The cloud is a powerful place that hosts many moving parts. To use the Microsoft cloud platform, Azure, your crew needs to first have an account to access and manage Azure resources.

A *subscription* represents a grouping of Azure resources. An invoice is generated at the subscription scope. A subscription has its own payment methods that are used to pay its invoice. [Learn how to create an Azure account.](/learn/modules/create-an-azure-account/?azure-portal=true)

## Workspace

Like other Azure services, you need to deploy an Azure Quantum resource into your Azure subscription in order to use it.

This resource is called a *workspace*, and is a collection of assets that are associated with executing a quantum or quantum-inspired workload. Examples of assets are the problem format, data, and compute target.

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

## Billing

When you enable a provider in your workspace, you also select the billing plan for that provider. The billing plan defines how you're billed for jobs against that provider.

Each provider may have different billing plans and methods available. While you may only select a single billing plan for a specific provider in a single workspace, you can deploy to multiple workspaces within your Azure subscription.

In the next unit, you'll create an Azure Quantum workspace.
