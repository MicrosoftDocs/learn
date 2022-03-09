Azure Quantum is a Microsoft Azure cloud service for running quantum computing programs and solving optimization problems. In this unit, you'll become familiar with the core elements of the Azure Quantum platform. You'll learn how to use quantum services, and how to create and submit projects to the cloud by using the available hardware.

## What's included on Azure Quantum?

Azure Quantum offers you two main paths of quantum solutions:

- **Quantum Computing**: Learn, experiment and prototype with a variety of quantum hardware providers to help you get ready for the future of scaled quantum machines. Unlike other solutions, you are not siloed to a single hardware technology, and you benefit from a full stack approach protecting your long-term investments. 
- **Optimization**: Develop solutions that help you reduce the cost of operation in a broad range of fields such as finance, energy cost, fleet management, scheduling, and more. 

With Azure Quantum and the Quantum Development Kit toolset, you will be able to program your quantum algorithms and optimization solutions, then apply those quantum solutions within the existing Azure platform to achieve real-world impacts even before the development of a general-purpose quantum computer. 

For more details on how this is done in practice, check out Dave Wecker's talk on [Achieving Practical Quantum Computing](https://cloudblogs.microsoft.com/quantum/2018/06/01/achieving-practical-quantum-computing/?azure-portal=true).

### Quantum computing providers

Once you have a quantum program that you'd like to run on a quantum computer, you can choose from a range of compute options.

- [Quantinuum](https://www.quantinuum.com): Trapped-ion system with high-fidelity, fully connected qubits, and the ability to perform mid-circuit measurements.
- [IONQ](https://ionq.com/): Dynamically reconfigurable trapped-ion quantum computer for up to 11 fully connected qubits, that lets you run a two-qubit gate between any pair.
- [Quantum Circuits, Inc](https://quantumcircuits.com/): Fast and high-fidelity system with powerful real-time feedback to enable error correction.

### Optimization providers

For optimization solutions, these are the available providers you can choose from:

- [1QBit](https://1qbit.com/): Iterative heuristic algorithms that use search techniques to solve QUBO problems.
- [Microsoft QIO](https://docs.microsoft.com/azure/quantum/provider-microsoft-qio): A set of multiple targets that rephrase the optimization problem inspired by decades of quantum research.
- [Toshiba SBM](https://www.toshiba-sol.co.jp/en/pro/sbm/index.htm): Toshiba Simulated Bifurcation Machine is a GPU-powered ISING machine that solves large-scale combinatorial optimization problems at high speed.

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

> [!NOTE]
> First-time users automatically get free Azure Quantum Credits for use with each participating quantum hardware provider (500 USD each) when creating your workspace. If you need more credits, you can apply to the [Azure Quantum Credits program](https://aka.ms/aq/credits).

When you enable a provider in your workspace, you also select the billing plan for that provider. The billing plan defines how you're billed for jobs against that provider.

Each provider may have different billing plans and methods available. While you may only select a single billing plan for a specific provider in a single workspace, you can deploy to multiple workspaces within your Azure subscription.

In the next unit, you'll create an Azure Quantum workspace.
