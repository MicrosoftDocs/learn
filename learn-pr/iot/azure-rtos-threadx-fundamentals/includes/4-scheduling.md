## Introduction

Early operating systems used a *Big Loop* approach to scheduling. Sometimes, this method is referred to as the control loop with polling approach. Modern real-time operating systems such as ThreadX, use a *priority-based preemptive* scheduling approach. Let's look at both scheduling approaches.

## Big Loop scheduling

In the Big Loop approach, the kernel executes an infinite loop, which polls the threads in a predetermined pattern. If a thread needs service, then it's processed.

:::image type="content" source="../media/big-loop-scheduling-sm.svg" alt-text="Diagram of threads processing in a loop, from Thread 1 to Thread n." border="false":::

Although the Big Loop approach is relatively easy to implement, it has several severe limitations. For example, it wastes much time because the processor polls threads that don't need servicing. In this approach, a thread that needs attention must wait its turn until the processor finishes polling other threads. Furthermore, this approach makes no distinction between the relative importance of the threads, so it's difficult to give threads with critical requirements fast access to the processor.

## Priority-based preemptive scheduling

In the priority-based preemptive approach, the RTOS controls which thread is allowed to run based on its priority, and the length of time it has been waiting. If necessary, the RTOS preempts a lower-priority running thread so that a higher-priority thread can run. As the following image shows, the RTOS schedules the ready thread with the highest priority that has been waiting for the processor the longest. Whenever preemption occurs, a context switch also occurs (this feature is discussed in the next unit).

:::image type="content" source="../media/rtos-scheduling-sm.svg" alt-text="Diagram of threads processing from Thread 1 to Thread n, but each thread has its own priority." border="false":::

A significant advantage of this approach is that the RTOS quickly responds to important events because it doesn't have to wait for any polling. In addition to fast response time, the RTOS also provides many thread services.
