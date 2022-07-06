## Introduction

Following is an overview of the ThreadX resources needed for the Hello World project.

For this project, we have two sets of activities that we'll model with threads, so we'll need two threads that we'll call Urgent and Routine.

We need to guarantee that only one thread can be in its critical section at any time, so we'll use a mutex called Processor.

Every thread must have its own stack, so we'll need one memory byte pool called `my_memory_pool` that will provide memory for the thread stacks.

Finally, we'll give Urgent thread a higher priority than Routine thread because we consider handling Urgent messages to be more important than handling Routine messages.

## Summary of resources needed

- Two threads, Urgent and Routine
- One mutex, Processor - to ensure that only one thread will be in its critical section at any point in time
- One memory byte pool - to provide stacks for the threads
- System timer - to show when activities are completed
- Urgent threads have a higher priority than Routine threads
