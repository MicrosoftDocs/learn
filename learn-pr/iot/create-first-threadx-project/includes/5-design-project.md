## Introduction

To get started, let's walk through the building blocks for this project before we do the exercise in the next unit. You don't need to copy the code in this unit, the exercise provides everything you need.

## Building block 1

There are more details in this first building block than in the illustrative example. We wish to display screen output, so we  must include `stdio.h` because we need standard input and output. We also need to specify stack sizes for the two threads and the total size of the memory byte pool. There are four object control blocks for the two threads, the mutex, and the memory byte pool. Finally, we need to define the two thread entry function prototypes.

The first building block contains: includes, defines, declarations, and prototypes.

:::code language="c" source="../code/project-hello-world.c" range="1-24" highlight="10,11,13,14,17,18,19,20,23,24":::

The highlighted code is explained as follows:

- `tx_api.h` is required and `stdio.h` is needed for output display.
- The stack size for both threads and the byte pool size.
- Object control blocks for the threads, mutex, and byte pool.
- Prototypes for the thread entry functions.

## Building block 2

The main entry point is the same as in the [illustrative example](/training/modules/create-first-threadx-project/2-example-threadx-project#building-block-2-example) and is contained in the following code:

:::code language="c" source="../code/project-hello-world.c" range="25-35":::

As noted earlier, the `tx_kernel_enter()` statement is required to start ThreadX. Statements may precede the `tx_kernel_enter()` statement but any statement following the `tx_kernel_enter()` statement is unreachable.

## Building block 3

Building block 3 is more complex than the one in the [illustrative example](/training/modules/create-first-threadx-project/2-example-threadx-project#building-block-3-example) and we display it here in two parts. This building block contains the `application define` function, which ThreadX requires. This function is the initialization of the project, and it contains the creation of the memory byte pool, the thread stacks, the threads, and the mutex.

Building block 3, part 1, contains the creation of the memory byte pool and the thread stacks:

:::code language="c" source="../code/project-hello-world.c" range="37-56" highlight="11-12, 14-16, 18-20":::

In the highlighted code we define two stack pointers, a memory byte pool, and a stack for the Urgent thread.

Building block 3, part 2, contains the creation of the two threads and the mutex:

:::code language="c" source="../code/project-hello-world.c" range="58-76" highlight="1-5, 11-15, 17-18":::

In the highlighted code, we create the Urgent thread, the stack for the Routine thread, the Routine thread, and the mutex.

## Building block 4

Building block 4 is also more complex than the one in the illustrative example, and is also displayed in two parts.

<a name="building-block-4-part-1"></a>

Building block 4, part 1, contains the function definition for the Urgent thread:

:::code language="c" source="../code/project-hello-world.c" range="78-104" highlight="13-14, 16-21":::

Activity 1, highlighted, shows the preparation. Activity 2, also highlighted, shows the message handling.

<a name="building-block-4-part-2"></a>

Building block 4, part 2, contains the function definition for Routine thread:

:::code language="c" source="../code/project-hello-world.c" range="105-127" highlight="11-14, 16-17":::

Activity 3, highlighted, shows the preparation. Activity 4, also highlighted, shows the message handling (incomplete).

Activity 1 is the Urgent message preparation that requires two timer ticks. We represent this preparation time with the sleep function.

Activity 2 is the message processing and is a critical section because the Urgent thread and the Routine thread can’t both be processing messages simultaneously. In order to begin message processing, the Urgent thread must first acquire ownership of the mutex called Processor. If the Routine thread already owns the mutex, then the Urgent thread waits until the Routine thread gives up ownership of the mutex. When the Urgent thread acquires ownership of the mutex, it processes the message, which requires four timer ticks. The exercise uses the `tx_thread_sleep` function to represent this processing. When processing is finished, the Urgent thread gives up ownership of the mutex. The Urgent thread then gets the current time and displays a message that it has completed a cycle and includes the current time.

Activity 3 is the Routine message preparation that requires two timer ticks.

Activity 4 is the Routine message handling and is a critical section. This activity is incomplete and your task is to complete it. Use Activity 2 as a guide.
