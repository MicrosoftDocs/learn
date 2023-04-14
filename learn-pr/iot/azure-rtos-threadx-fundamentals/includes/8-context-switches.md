## Introduction

A context is the current execution state of a thread. Typically, it consists of such items as the registers, program counter (PC), and stack pointer (SP).

:::image type="content" source="../media/thread-context-example-sm.svg" alt-text="Image showing a thread context example.":::

The term *context switch* refers to the saving of one thread's context and restoring a different thread's context so that it can be executed. This action normally occurs as a result of preemption, interrupt handling, time-slicing, cooperative round-robin scheduling, or suspension of a thread because it needs an unavailable resource.

When a thread's context is restored, the thread resumes execution at the point where it was stopped. The kernel performs the context switch operation, and the actual code required to perform context switches is necessarily processor-specific.
