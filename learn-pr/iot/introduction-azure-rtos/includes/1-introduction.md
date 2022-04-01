## Introduction

Welcome to the world of the Real-Time Operating System (RTOS). In this module, you'll be introduced to an RTOS, and you'll understand the structure and purpose of an RTOS. We'll focus on Azure RTOS ThreadX (from now on, ThreadX), which is one of the most widely used RTOSes in the world. In fact, ThreadX is deployed in over 10 billion devices worldwide.

When you complete this series of modules, you'll have acquired a solid foundation of RTOS concepts and techniques. You'll be prepared to apply what you have learned, and you'll be ready to expand your knowledge about the wonderful world of the RTOS.

## Learning objectives

In this module, you will:

- Learn the basic components of an RTOS
- Learn what an RTOS does

## Basic components of an RTOS
An RTOS typically consists of a kernel (note the spelling), a file system, graphics, USB, and networking capabilities.

:::image type="content" alt-text="Example of an RTOS." source="../media/rtos-example.png" border="false" loc-scope="Azure":::

At the heart of the kernel is the scheduler, which schedules threads. The scheduler also manages resources, such as:

- application timers
- message queues
- event flags groups
- counting semaphores
- memory pools

The scheduler uses a preemptive priority-based model. Don't worry, we'll address these fundamental concepts in the next module.

:::image type="content" alt-text="Components of a kernel." source="../media/kernel-components.png" border="false" loc-scope="Azure":::

## What does an RTOS do?

An RTOS simplifies the use of hardware resources and provides a library of services. An RTOS handles many tedious, but important details in a fast and efficient manner. Following are some of the benefits of using an RTOS.

- Better responsiveness and lower overhead
- Simplified resource sharing
- Increased portability and maintenance

While it's true that an RTOS incurs a certain cost, the benefits generally outweigh these costs. One of the biggest reasons for using an RTOS is that it achieves quick response time to important events with low overhead.

## Prerequisites

None
