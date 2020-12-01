Throughout the [quantum computing fundamentals learning path](https://docs.microsoft.com/en-us/learn/paths/quantum-computing-fundamentals/), you've been carrying out various tasks alongside the crew of the spaceship. In this module, you will be faced with an emergency scenario that requires you to work with the maintenance crew to repair critical systems onboard. To achieve this as quickly as possible while still following safety procedure, you will need to optimize the order in which you tackle repair tasks. Luckily, the Azure Quantum Optimization service can help!

This is an example of the **job shop scheduling** problem. Job shop scheduling is a common and important problem in many industries. For example, in the automobile industry manufacturing a car involves many different types of operations. These operations are performed by a number of specialized machines - optimizing the production line to minimize manufacturing time can make for significant cost savings.

The job shop scheduling problem is defined as follows: we have a set of jobs $J_1, J_2, J_3,\dots, J_n$ which have various processing times and need to be processed using a set of machines $m_1, m_2, \dots, m_n$. The goal is to complete all jobs in the shortest time possible.
Each job consists of a set of operations, and the operations must be performed in the correct order to complete that job.

In this module, we'll introduce the necessary concepts and tools for describing this problem in terms of a penalty model, and then solve an example problem using the Azure Quantum optimization service.

### Learning objectives

After completing this module, you'll be able to:

- Identify and build problem constraints for the job shop scheduling problem
- Convert problem constraints to a penalty model
- Learn how to represent the penalty model using Azure Quantum
- Solve optimization problems using Azure Quantum

### Prerequisites

- The latest version of the [Azure Quantum Optimization SDK](TODO)
- [Visual Studio Code](https://code.visualstudio.com/download?azure-portal=true)
