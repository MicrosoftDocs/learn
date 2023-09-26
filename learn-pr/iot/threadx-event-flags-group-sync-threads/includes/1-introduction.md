## Synchronizing threads

You've created four ThreadX projects, and you've used a mutex in one project and a counting semaphore in another project. Each of these ThreadX resources permits suspension of one thread, and when that suspension is lifted, exactly one thread can proceed. Have you ever wondered how you could have multiple threads suspend on one object, and when that suspension is lifted, all the suspended threads would proceed? If so, then this module is the one you should investigate.

## Learning objectives

In this module, you will:

- Understand how to synchronize threads using an event flags group.
- Use the set service to clear or initialize an event flags group.
- Use the get service to retrieve events from an event flags group.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

After you complete this module, you'll be well on your way to developing more sophisticated ThreadX projects.

## Prerequisites

- [Set up your environment](/training/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub, and Visual Studio
- Previous modules in the [Azure RTOS ThreadX learning path](/training/paths/azure-rtos-threadx/?azure-portal=true)
