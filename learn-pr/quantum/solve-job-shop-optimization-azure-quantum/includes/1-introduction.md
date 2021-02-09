Throughout the [Quantum Computing Foundations](/learn/paths/quantum-computing-fundamentals?azure-portal=true) learning path, you've been carrying out various tasks alongside the crew of the spaceship. In this module, you will be faced with an emergency scenario that requires you to work with the maintenance crew to repair critical systems onboard. To achieve this as quickly as possible while still following safety procedure, you will use the Azure Quantum optimization service to optimize the order in which you tackle repair tasks.

This scenario is an example of the **job shop scheduling** problem. Job shop scheduling is a common and important problem in many industries. For example, in the automobile industry manufacturing a car involves many different types of operations. These operations are performed by a number of specialized machines - optimizing the production line to minimize manufacturing time can make for significant cost savings.

The job shop scheduling problem is defined as follows: we have a set of jobs ($J_0, J_1, J_2, \dots, J_{a-1} \text{,}$ where $a$ is the total number of jobs), which have various processing times and need to be processed using a set of machines ($m_0, m_1, m_2, \dots, m_{b-1} \text{,}$ where $b$ is the total number of machines). The goal is to complete all jobs in the shortest time possible. This is called minimizing the **makespan**.
Each job consists of a set of operations, and the operations must be performed in the correct order to complete that job.

In this module, we'll introduce the necessary concepts and tools for describing this problem in terms of a penalty model, and then solve an example problem using the Azure Quantum Optimization service.

## Learning objectives

After completing this module, you'll be able to:

- Identify and build problem constraints for the job shop scheduling problem
- Convert problem constraints to a penalty model
- Learn how to represent the penalty model using Azure Quantum
- Solve optimization problems using Azure Quantum

## Prerequisites

- The latest version of the [Python SDK for Azure Quantum](/azure/quantum/optimization-install-sdk?azure-portal=true)
- [Jupyter Notebook](https://jupyter.org/install.html?azure-portal=true)
- An Azure Quantum workspace

If you don't have these tools yet, we recommend that you follow the [Get started with Azure Quantum](/learn/modules/get-started-azure-quantum/?azure-portal=true) module first.
