## Introduction

Here's an overview of the ThreadX resources needed for the Hello World project.

For this project, we have two sets of activities that are modeled with threads. The two threads are called *Urgent* and *Routine*.

We need to guarantee that only one thread can be in its critical section at any time, so we use a mutex called *Processor*.

Every thread must have its own stack, so we need one memory byte pool called `my_memory_pool` to provide memory for the thread stacks.

Finally, we give the Urgent thread a higher priority than the Routine thread because we consider handling Urgent messages to be more important than handling Routine messages.

## Summary of resources needed

- Two threads, Urgent and Routine.
- One mutex, Processor. To ensure that only one thread is in its critical section at any point in time.
- One memory byte pool, `my_memory_pool`. To provide stacks for the threads.
- System timer. To show when activities are completed.
- Urgent threads have a higher priority than Routine threads.
