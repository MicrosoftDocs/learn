If you've studied earlier modules in the [Quantum computing foundations](../../../paths/quantum-computing-fundamentals/index.yml?azure-portal=true) learning path, you're already familiar with the fundamentals of quantum computing and how quantum algorithms can solve some of the problems you and your crew have encountered on the spaceship.

In this learning path, one mission of your spaceship crew is an asteroid mining expedition.

In this module, you'll learn about a *classical* computing method called quantum-inspired optimization. Quantum-inspired optimization refers to a class of algorithms that are applied to solve optimization problems on traditional hardware.

To illustrate the quantum-inspired optimization method, let's look at how the crew's logistics division efficiently loads cargo vessels.

![Illustration of a cargo vessel above two containers that must be loaded with minerals as evenly as possible.](../media/mineral-loading.svg)

Your spaceship is transporting a rare mineral you've mined from a recently discovered asteroid. However, two competing galactic federations have laid claim to the asteroid. To avoid a political crisis, the crew is tasked with delivering the mineral supply to the two federations in approximately equal amounts.

To complicate the problem, the mineral supply has been extracted in massive chunks of varying sizes, so it's not easy to divide them equally.

How can you optimize the distribution of the mineral and avert an intergalactic crisis?

## Learning objectives

After completing this module, you'll understand:

* The origins of quantum-inspired optimization.
* Which kinds of problems are best suited to this method.
* Understand how algorithms inspired by physical processes are used to solve difficult problems.
* Solve a combinatorial optimization problem by using the Azure Quantum optimization service.

## Prerequisites

- An Azure account with an active subscription. 
- An Azure Quantum workspace with the **Microsoft QIO** provider enabled. 

If you don't have these tools yet, we recommend that you begin with the [Get started with Azure Quantum](/learn/modules/get-started-azure-quantum/?azure-portal=true) module.

> [!NOTE]
> This module makes use of paid services on Azure Quantum. The first compute hour on Microsoft QIO solvers is free. For reference, this module should roughly consume 2 compute seconds. You can refer to the [Microsoft QIO pricing page](https://azure.microsoft.com/pricing/details/azure-quantum/) for more details.

