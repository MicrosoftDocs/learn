## Introduction

Before starting with our Hello World project, we'll walk through a simple illustrative ThreadX system. This system has a single thread with a priority of 3. The thread executes, increments a counter, then sleeps for one timer tick. This process continues forever.

A ThreadX project typically consists of four building blocks as follows:

|Building block   | Component |
|---|---|
|1 | `#includes and definitions`|
|2 | `main()` |
|3 | `tx_application_define` |
|4 | `functions: thread entry and others` |

The four building blocks are defined in more detail below.

## Building block 1

`#includes and definitions` is shown in the code block below. The code contains an essential header `(#include tx_api.h)` and two definitions:

```c
#include "tx_api.h"
ULONG my_thread_counter = 0;
TX_THREAD my_thread;
```

The header file contains all system equates, data structures, and service prototypes.

We'll use a counter `my_thread_counter` in this example, so we define and initialize it. We also define a thread `my_thread` that will be created in [building block 3](#building-block-3). This block would typically contain comments concerning the project, but we've skipped them for the sake of brevity.

## Building block 2

`main()` is the shortest of all the blocks and will probably be the same for most of your projects. This code example illustrates `main()`:

```c
main()
{ 
 /* Enter the ThreadX kernel. */
  tx_kernel_enter();
}
```

> [!NOTE]
> The `tx_kernel_enter()` statement is required to start ThreadX. Statements may precede the `tx_kernel_enter()` statement but any statement following the `tx_kernel_enter()` statement is unreachable.

The `tx_kernel_enter()` function initializes ThreadX and starts the task scheduler, and it doesn't return. After the task scheduler has started, the RTOS kernel takes control over the machine and only thread code created by the developer is run.

## Building block 3

`tx_application_define()` is a required function where the initial system resources are created. This code shows a single thread created:

```c
void tx_application_define(void *first_unused_memory)
{
 /* Create my_thread */
 tx_thread_create(&my_thread, "My Thread",
    my_thread_entry, 0x1234,
    first_unused_memory,
    1024, 3, 3, TX_NO_TIME_SLICE, TX_AUTO_START);
 }
```

In this case, only one thread is created and the meanings of the thread create parameters are as follows:

|Parameter   | Meaning   |
|---|---|
|&my_thread | pointer to the thread control block (TCB) structure |
|"My Thread" | pointer to a string with the thread name |
|my_thread_entry | thread’s entry function |
|0x1234 | entry function parameter to be used by the developer |
|first_unused_memory | pointer to the start of the thread’s stack area |
|1024 | thread’s stack size in bytes |
|3 | thread’s priority level |
|3 | thread’s preemption threshold (not used because it's the same value as the priority) |
|TX_NO_TIME_SLICE | thread’s time slice (0 in this case) |
|TX_AUTO_START | means that the thread will be started automatically by the kernel|

## Building block 4

`functions: thread entry and others` contains definitions of all thread functions. The following code shows a single function:

```c
void my_thread_entry(ULONG thread_input)
{
 /* Enter into a forever loop. */
 while(1)
 {
  /* Increment thread counter. */
  my_thread_counter++;
  /* Sleep for 1 tick. */
  tx_thread_sleep(1);
 }
}
```

This block contains the function `my_thread_entry` that is an entry function for the thread named `my_thread`. This function is in a forever loop, which is the case for most real-time embedded functions.

> [!NOTE]
> This is an over simplified function for illustration purposes only, and it contains only two executable statements. One such statement is a counter `my_thread_counter++` and the other statement `tx_thread_sleep(1)` suspends the thread for one timer tick.

Now let's look at the project.
