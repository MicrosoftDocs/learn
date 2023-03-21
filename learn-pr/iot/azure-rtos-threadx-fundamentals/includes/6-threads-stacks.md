## Introduction

A thread is a semi-independent program segment. Threads typically share global memory.

## Thread management

ThreadX maintains several internal data structures to manage threads in their various states of execution. These data structures represent the suspended thread state and the ready thread state, or more simply, the suspended state and the ready state. As implied by the nomenclature, threads in the suspended state have been suspended—temporarily stopped executing—for some reason, such as needing a resource that isn't available. Threads can be in the ready state and aren't currently executing because they have a lower priority than the thread currently being processed.

### Suspended state

When a thread is placed in the suspended state, it is because of a blocking condition or circumstance, such as being forced to wait for an unavailable resource. Such a thread remains in that state until the event or circumstance has been resolved. When a thread is removed from the suspended state, one of two possible actions occurs: it's placed in the ready state, or it's terminated.

### Ready state

When a thread becomes ready for execution, it's placed in the ready state. When ThreadX schedules a thread for execution, it selects the ready thread that has the highest priority. If all the ready threads have equal priority, ThreadX selects the thread that has been waiting the longest time.

If a thread isn't ready for execution, it's placed in the suspended state. Following are several examples of thread suspension.

- a thread is waiting for a resource.
- a thread is in `sleep` mode.
- a thread was created with a `TX_DONT_START` option.
- a thread was explicitly suspended.

A thread remains in a suspended state until that situation has cleared.

## Thread stack

A thread shares the same memory space, but each thread must have its own stack. Threads are the essential building blocks because they contain most of the application programming logic. There's no explicit limit on how many threads can be created, and each thread can have a different stack size. When threads are executed, they're processed independently of each other. In cases where there's only one processor, we say that threads are executed in pseudo-parallel.

:::image type="content" source="../media/thread-stack-example-sm.svg" alt-text="Image that illustrates a thread stack.":::

### Thread attributes

When a thread is created, several attributes need to be specified.

| &nbsp; | &nbsp; |
| :-- | :-- |
| **Thread Control Block (TCB)** | Every thread must have a TCB, which contains system information critical to the internal processing of that thread. However, most applications have no need to access the contents of the TCB. |
| **Name** | Every thread is assigned a name, which is used primarily for identification purposes. |
| **Thread entry function** | This function is where the actual C code for a thread is located. |
| **Thread entry input** | This value is passed to the thread entry function when it first executes. The developer exclusively determines the use of the thread entry input value. |
| **Stack** | Every thread must have a stack, so a pointer to the actual stack location is specified, including the stack size. |
| **Priority** | The thread priority must be specified, but it can be changed during run-time. |
| **Preemption-threshold** | This value is optional; a value equal to the priority disables the preemption-threshold feature. |
| **Time-slice** | An optional time-slice may be assigned, which specifies the number of timer-ticks that this thread is allowed to execute before other ready threads with the same priority are permitted to run. Use of the **preemption-threshold** attribute, disables the time-slice option. A time-slice value of zero (`0`) disables time-slicing for this thread. |
| **Start option** | A start option must be specified. The start-option indicates whether the thread starts immediately or whether it's placed in a suspended state where it must wait for another thread to activate it. |
