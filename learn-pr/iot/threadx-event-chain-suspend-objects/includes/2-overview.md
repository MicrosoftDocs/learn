## Introduction

Event-chaining is a technique that enables the linking (or chaining) of several objects based on the occurrence of independent events. This technique is useful in activating a thread that is suspended on two or more resources. Implementing this technique is a three-step process as follows:

1. Register one or more notification callback functions (one-time only).
1. The registered notification callback function is automatically invoked when an indicated event occurs. Each such function typically contains a `tx_semaphore_put` service call, which communicates to a waiting thread that a particular event has occurred. However, many other service calls could be used.
1. A thread suspends on the semaphore mentioned above. Getting this semaphore signifies that the event in question has occurred, and then the thread continues through the system.

We'll first investigate the basics of event-chaining and study a project that uses this concept. The name of this project is ProjectEventChaining.

The following image illustrates an event-chaining application:

:::image type="content" alt-text="Diagram that illustrates an event-chaining application." source="../media/event-chaining-application-example.svg" loc-scope="Azure":::

A thread needs to get access to one of three different resources. The thread will wait until any one of the three resources becomes available. Ordinarily, this task would be a difficult problem to solve, but with event-chaining, it's relatively easy, as we'll see in this module.
