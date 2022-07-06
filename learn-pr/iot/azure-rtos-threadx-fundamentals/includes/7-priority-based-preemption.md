## Introduction

The term preemptive priority-based scheduling refers to a scheduling approach. In this approach, a higher priority thread can interrupt and suspend a currently executing thread that has a lower priority. For example, the scheduling might occur like this:

:::image type="content" source="../media/priority-based-preemption-sm.svg" alt-text="Image showing priority-based preemption.":::

This diagram shows that Thread 1 has control of the processor. However, Thread 2 has a higher priority and becomes ready for execution. ThreadX then interrupts Thread 1 and gives Thread 2 control of the processor. When Thread 2 completes its work, ThreadX returns control to Thread 1 at the point where it was interrupted.

You don't need to worry about the details of the scheduling process. Thus, you're able to develop the threads in isolation from one another because the scheduler determines when to execute (or interrupt) each thread.
