# Azure Quantum
Watch this video to see the process of creating a set of quantum resources and using these to run a program.

> [!VIDEO https://www.microsoft.com/...]

In the video, you'll have seen the flexibility that Azure Quantum offers to solve different problems. 

**Quantum inspired solutions**: If you want the ability to solve large, complex optimization problems at scale, then you can explore quantum-inspired solvers from Microsoft and partners such as 1QBit.
These techniques emulate certain processes from quantum physics using classical hardware today.
In this module you'll get an understanding of what optimization problems are, and what techniques you can use through Azure Quantum to solve them.

**Quantum software**: If you are interested in developing quantum software, then Azure Quantum offers a suite of tools for helping you express your algorithms using the Quantum Development Kit and Q#.
There are tools for simulating your programs, so that you can test the behaviour and performance of your code. 
In addition, there are tools such as resource estimation, which will help you understand the resources that your code would require.
In terms of a quantum program, this tells you the types of quantum gates you use, and how many.
Using these tools together helps you understand the features of a quantum computer that you'd need in order to run your program, such as the number of qubits. 
From a software engineering perspective, it also helps you iterate and improve your code, so that you can reduce the requirements necessary to run it. 
For more detail on how this is done in practice, check out Dave Wecker's talk on [Achieving Practical Quantum Computing](https://cloudblogs.microsoft.com/quantum/2018/06/01/achieving-practical-quantum-computing/).

**Quantum hardware**: If you have developed quantum software that you would like to run on quantum hardware, then through Azure Quantum you can access a range of different hardware types. 
For example, there's IonQ's quantum computer built from trapped ions. There's also superconducting devices from Honeywell and QCI.

![Azure quantum offering](../media/azure-quantum-2.png)

## Azure Quantum Workspaces
Like other Azure services, you'll need to deploy an Azure Quantum resource into your Azure subscription in order to use the service. 
This resource is called a workspace, and is a collection of assets associated with executing a quantum or quantum-inspired workload, such as the problem format, data, and compute target.

Let us take a tour of some of the terminology associated with creating a quantum workspace.

**Target**: The type of target you use depends on the type of program you want to run. 
For quantum programs, your target will either be quantum hardware, or a quantum simulator.
For quantum-inspired problems, your target will typically be the solver, or optimizer, you wish to run. 

**Provider**: Once you have decided the type of target you wish to use, you can enable different providers in your workspace who offer that target.
For example, if you wanted to run a quantum program, you could choose to enable IonQ, Honeywell, and QCI in your workspace and run your Q# program on each of their respective hardware types.
Every workspace comes with the Microsoft provider always enabled, and you can select which third party providers you'd like to add in addition.

**Jobs**: Whenever you execute a quantum program or solve a QIO problem in Azure Quantum, you are creating and running a job. 
A job consists of an ID that is unique within your workspace, the provider that you want to execute your job, the target that you want to execute your job on, a name - chosen by you - to help you organize your jobs, and for some targets there may also be some input parameters. 
Once created, you'll also find various metadata available about the state of your job and its execution history.

**Billing**: When you enable a provider in your workspace you also select the billing plan for that provider, which defines how you're billed for jobs against that provider. 
Each provider may have different billing plans and methods available.
While you may only select a single billing plan for a specific provider in a single workspace, you may deploy multiple workspaces in your Azure subscription.

![Azure quantum offering](../media/azure-quantum-diagram.png)