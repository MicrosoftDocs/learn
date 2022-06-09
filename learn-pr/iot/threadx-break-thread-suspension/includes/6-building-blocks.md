## Building block 1

Let's look at the code building blocks that we'll use in the project.

### Declarations, definitions, and prototypes

We'll use this code to create declarations, definitions, and prototypes:

:::code language="c" source="../code/project-break-suspension.c" range="1-43" highlight="16, 17, 26, 32, 37":::

> [!NOTE]
> The highlighted code shows where:
>
> - The Monitor thread, the counting semaphore, and the thread run count variables are defined.
> - A run count is initialized to detect idle time.
> - A variable to store the count of wait aborts for Routine thread is added.
> - A variable to store the count of wait aborts for Urgent thread is added.
>

## Building block 2

### Main entry point

We'll use this code for the main entry point.

:::code language="c" source="../code/project-break-suspension.c" range="54-62":::

> [!NOTE]
> This building block is identical in the projects in earlier modules, and no changes are needed.
>

## Building block 3

### Application definitions

We'll use this code to create application definitions:

:::code language="c" source="../code/project-break-suspension.c" range="53-94" highlight="7, 29, 33":::

> [!NOTE]
> This code shows how these items are created:
>
> - Pointer for the Monitor thread stack.
> - Monitor stack; we give it the highest priority of the three threads.
> - Urgent thread
> - Routine thread
> - Monitor thread
> - Counting semaphore
> - Application timer
>

## Building block 4

### Urgent thread entry function

We'll use this code to create the Urgent thread entry function. One feature that is new to this function is the use of the counting semaphore that controls when the Urgent function establishes its sleep time and begins its processing.

:::code language="c" source="../code/project-break-suspension.c" range="98-127" highlight="16, 20":::

> [!NOTE]
> The highlighted lines of code:
>
> - Use the C library function `rand()` to compute sleep time for the Urgent thread.
> - Determine whether the suspension of Urgent thread was aborted. When this process finishes, the Urgent function places an instance back on the counting semaphore.
>

### Routine thread entry function

We'll use the following code to create the Routine thread entry function. A major difference between this function and the Urgent thread entry function is that the amount of sleep time is considerably greater for the Routine thread. However, we use the same approach to obtain the sleep times for the Routine thread entry function. Another major difference is that there are no modifications for you to make in the Urgent thread entry function. Still, you need to write code to detect excessive wait time for the Routine thread entry function (use the Urgent thread entry function as a guide).

:::code language="c" source="../code/project-break-suspension.c" range="136-167" highlight="16, 20":::

> [!NOTE]
> The highlighted lines of code:
>
> - Use the C library function `rand()` to compute sleep time for the Routine thread.
> - Detect excessive wait time.
>

### Monitor thread entry function

We'll use the following code to create the Monitor thread entry function. This function checks both the Urgent thread and the Routine thread every 50 timer ticks to determine whether the run counts of the two threads have changed since the previous time they were checked. If a run count hasn't changed, the Monitor thread considers this as excessive wait time, and the thread suspension is aborted. You're given the code for the Urgent thread, and your task is the write the code for the Routine thread to detect whether there's excessive wait time.

:::code language="c" source="../code/project-break-suspension.c" range="171-196" highlight="13, 17, 20, 23":::

> [!NOTE]
> The highlighted lines of code:
>
> - Add a Monitor check on Urgent and Routine threads every 50 timer ticks.
> - Get the Urgent run count.
> - Determine whether to abort Urgent suspension.
> - Create the Routine thread.
>

### print_stats application timer function

We'll use the following code to create the print_stats application timer function. The print_stats timer entry function is invoked every 500 timer ticks by the stats_timer application timer, which is defined in Figure 10. There are no modifications that you have to make in this function, but you should review this function so that you can understand how the tx_thread_performance_info_get service works.

No changes are needed for this code.

:::code language="c" source="../code/project-break-suspension.c" range="190-228":::
