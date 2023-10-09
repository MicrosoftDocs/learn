## Introduction

In this module, we discussed several important terms and concepts related to ThreadX. The following are brief definitions of some key points.

### Determinism

An essential feature of an RTOS is determinism. We may assume that for each possible state and each set of inputs, a unique set of outputs and next state of the system can be predicted. This kind of determinism isn't unique to an RTOS; it's the basis for virtually all types of computing systems.

A system is deterministic if the time required to process any task is finite and predictable. We're less concerned with average response time than we are with the worst-case response time. In the latter case, we must have a guarantee on the upper time limit, which is an example of determinism.

### Scheduling

ThreadX uses a priority-based preemptive scheduling approach. ThreadX controls which thread is allowed to run based on its priority and the length of time it has been waiting. If necessary, ThreadX preempts a lower-priority running thread so that a higher-priority thread can run. A significant advantage of this approach is that ThreadX quickly responds to important events because it doesn't have to wait for any polling.

### Priorities

ThreadX priorities range from 0 to 1023, with a default range of 0-31, where the value 0 represents the highest priority, and the value 31 represents the lowest priority. Every thread must have a priority, but that priority can be changed during run-time.

### Threads

Threads are semi-independent program segments that contain most of the application programming logic. Each thread must have a Thread Control Block (TCB) that contains system information critical to the internal processing of that thread. Threads have three distinct states: executing, ready, and suspended.

### Stacks

A thread shares the same memory space with other resources, but each thread must have its own stack. When a thread is preempted, information about the thread's current state (its context) must be saved to its stack. When that thread is resumed, its current state must be recovered from its stack.

### Priority-based preemption

The term *preemptive priority-based scheduling* refers to a scheduling approach in which a higher priority thread can interrupt and suspend a currently executing thread that has a lower priority. This concept is essential in order to provide rapid response to important events.

### Context switches

A *context* is the current execution state of a thread. It consists of such items as the registers, program counter (PC), and stack pointer (SP). These items are stored in the thread stack when that stack has been preempted. The term context switch refers to the saving of one thread’s context and restoring a different thread’s context so that it can be executed.
