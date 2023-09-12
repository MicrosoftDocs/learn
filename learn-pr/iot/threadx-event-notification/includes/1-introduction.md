## Mutexes and counting semaphores

On the surface, you may think that a mutex and a counting semaphore are similar. In fact, some developers use a *binary semaphore* in place of a mutex. A binary semaphore is a counting semaphore that is initialized to zero, and the number of instances in the semaphore must never exceed one. The main reason some developers choose to use a binary semaphore is when resources are scarce. If resources aren't scarce, you should always use a mutex to ensure mutual exclusion properties such as protecting critical sections in an application.

First, we compare the properties of mutexes and counting semaphores, and then we explore the classic producer-consumer problem using only counting semaphores. The name of the project for this module is *ProjectProducerConsumer*.

## Learning objectives

In this module, you'll:

- Use a counting semaphore in an event notification application.
- Use two threads in a producer-consumer scenario.
- Understand the difference between mutual exclusion and event notification.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

## Prerequisites

- [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub, and Visual Studio
- Previous modules in the [Azure RTOS ThreadX learning path](/training/paths/azure-rtos-threadx/?azure-portal=true)
