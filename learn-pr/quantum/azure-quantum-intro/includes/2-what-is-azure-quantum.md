In this unit, you will first watch a video introduction about Azure Quantum service and the types of problems Azure Quantum can help with. You will learn about the third party hardware you can access through Azure Quantum. 

In this unit, you will get an overview on Azure Quantum service and the types of problems Azure Quantum can help with. 

> [!VIDEO https://www.microsoft.com/...]

![Microsoft Azure and Azure Quantum](../media/2-azure-quantum.png)

##Quantum Workspace

Azure Quantum is a service provided by Azure. Like other Azure services, you need to deploy an Azure Quantum resource into your Azure subscription in order to use the service. This resource is called an Azure Quantum Workspace.

Once you create a Workspace, you'll be able to select which third party providers you would like to be able to use in that Workspace. Every Workspace also comes with the Microsoft provider always enabled.

When you enable a provider in your Workspace you also select the billing plan for that provider, which defines how you're billed for jobs against that provider. Each provider may have different billing plans and methods available. While you may only select a single billing plan for a specific provider in a single Workspace, you may deploy multiple Workspaces in your Azure subscription.

# Providers and Targets
In Azure Quantum, the ability to execute a job is given by **Providers**. A single Provider may expose one or more **Targets** for execution. A Target is what is ultimately executing your job. The list of available targets is shown below based off of the type of job being executed:

**Types of Targets for Quantum Programs**
- Quantum Hardware (e.g. 6 qubit device, 10 qubit device, ...)
- Quantum Simulator (e.g. full-state simulator, Toffoli simulator, ...)

**Types of Targets for Quantum-Inspired Problems**
- Quantum-Inspired Solution (e.g. simulated quantum annealing optimizer, optimizer with parallel tempering, ...)

## Available Providers and Targets
To see a list of available providers, see [Providers](/Reference/Providers).

