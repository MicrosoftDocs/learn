Now that you've created two ThreadX projects, have you thought about how you can protect your system from unexpected hazards? If so, this is the module you should investigate.

## Learning objectives

In this module, you'll:

- Explore the features and uses of counting semaphores and the TX_WAIT_ABORT service.
- Understand the purpose of a monitor thread.
- Use a monitor thread to detect excessive wait times by other threads and break the suspension of those threads.
- Use an application timer to compute and display the total number of cycles each thread completed, the average time for each cycle, and selected values provided by the `thread_performance_info_get` service.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

After you complete this module, you'll be well on your way to develop more sophisticated Azure RTOS ThreadX projects.

## Prerequisites

- [Set up your environment](/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub, and Visual Studio
- Previous modules in this [learning path](/learn/paths/azure-rtos-threadx/?azure-portal=true)