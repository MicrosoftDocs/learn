## Introduction

To get a better understanding of the behavior of thread activities in the Hello World project, we'll collect timing data for each cycle of activities performed by the threads. We'll compute and display the total number of cycles each thread completed and the average time for each cycle.

To accomplish this purpose, we'll modify the code for the Hello World project by adding several ThreadX time and timer facilities. We'll call this modified project ProjectAnalyze.

## Learning objectives

In this module, you'll:

- Explore the features and uses of Application Timers and the Thread Info Get services.
- Review the purpose of the internal system clock.
- Obtain a better understanding of the behavior of the Hello World project and modify some of its code.
- Use the internal system clock function to collect timing data for each cycle of the activities performed by the two threads
- Use an Application Timer to compute and display the total number of cycles each thread completed, the average time for each cycle, and selected values provided by the `thread_performance_info_get` service.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

## Prerequisites

- [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub, and Visual Studio
- Previous modules in this [learning path](/training/paths/azure-rtos-threadx/?azure-portal=true)
