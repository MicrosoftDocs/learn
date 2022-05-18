## Overview

You've created six Azure RTOS ThreadX (from now on, ThreadX) projects, you've used a mutex in one project, a counting semaphore in another project, an event flags group in another project, and a message queue in yet another project. Each of these ThreadX resources permits suspension of one thread, or suspension of multiple threads. Have you ever wondered if one thread could have the potential to suspend on multiple resources? If so, this module is one you should investigate.

## Learning objectives

In this module, you will:

- Understand the ThreadX-unique concept of event-chaining.
- Understand how to have one thread suspend on multiple objects.
- Understand the concept of notification callback functions.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

After you complete this module, you'll be well on your way to develop more sophisticated Azure RTOS ThreadX projects.

## Prerequisites

- [Set up your environment](https://docs.microsoft.com/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub and Visual Studio
- Previous modules in this [learning path](https://docs.microsoft.com/learn/paths/azure-rtos-threadx/?azure-portal=true)
