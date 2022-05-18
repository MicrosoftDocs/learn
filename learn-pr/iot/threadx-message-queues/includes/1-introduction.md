## Overview

Message queues are the primary means of inter-thread communication in ThreadX. One or more messages can reside in a message queue, which generally observes a FIFO discipline. Messages are usually sent to the rear of a queue, but messages are always received from the front of the queue. Thread suspension can occur either when a queue is full and a thread tries to send a message to that queue, or when a queue is empty and a thread tries to read a message from that queue.

We'll first investigate how to create message queues, how to send messages to a queue, and how to receive messages from a queue. The name of this project is ProjectMessageQueue.

## Learning objectives

In this module, you'll:

- Understand how to send messages from one thread to another thread by using a message queue.
- Understand how to receive messages from a queue.
- Understand how to send a message to the front of a queue, rather than to the rear of the queue.
- Design and debug the ThreadX solution using a hands-on approach with GitHub Codespace or Visual Studio.

## Prerequisites

- [Set up your environment](https://docs.microsoft.com/learn/modules/introduction-azure-rtos/2-set-up-environment?azure-portal=true)
- Working knowledge of C or C++, GitHub, and Visual Studio
- Previous modules in this [learning path](https://docs.microsoft.com/learn/paths/azure-rtos-threadx/?azure-portal=true)
