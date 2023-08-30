## Overview

First let's walk through the building blocks for this project before we do the exercise in the next unit. You don't need to copy the code in this unit, the exercise provides everything you need.

## Building block 1

Building block 1, part 1, contains declarations, definitions and prototypes:

:::code language="c" source="../code/project-message-queues.c" range="1-22":::

<a name="building-block-1-part-2"></a>

Building block 1, part 2, is shown in the following code:

:::code language="c" source="../code/project-message-queues.c" range="23-37":::

> [!TIP]
> You need to add counters, another thread, and another prototype

## Building block 2

Building block 2 represents main entry point:

:::code language="c" source="../code/project-message-queues.c" range="43-48":::

> [!NOTE]
> The preceeding code is identical to the other projects in this learning path and no changes are needed

## Building block 3

<a name="building-block-3-part-1"></a>

Building block 3, part 1, represents application definitions:

:::code language="c" source="../code/project-message-queues.c" range="54-80" highlight="5-6":::

> [!TIP]
> You need to create new pointers as highlighted in the preceeding code.

<a name="building-block-3-part-2"></a>

Building block 3, part 2, is shown in the following code:

:::code language="c" source="../code/project-message-queues.c" range="82-105" highlight="5,15":::

> [!TIP]
> You need to create another thread and another queue as highlighted in the preceeding code.

<a name="building-block-4-dispatcher-thread-entry"></a>

## Building block 4

Building block 4 contains the functions. The `dispatcher thread entry` function is shown in the following code:

:::code language="c" source="../code/project-message-queues.c" range="110-130" highlight="9-19":::

> [!TIP]
> You need to send messages to another queue, use a sleep time of 5.

The `urgent thread entry` function is shown in the following code:

:::code language="c" source="../code/project-message-queues.c" range="133-146":::

<a name="building-block-4-routine-thread-entry"></a>

Building block 4 also contains the `routine thread entry` function, shown in the following code:

:::code language="c" source="../code/project-message-queues.c" range="149-162" highlight="9-12":::

> [!TIP]
> Use this entry function as a model to create a new entry function with a sleep time of 21.

<a name="building-block-4-print-stats"></a>

Building block 4 also contains the `print_stats` application timer function, as shown in this code:

:::code language="c" source="../code/project-message-queues.c" range="165-183":::

> [!TIP]
> You need to make modifications to include the new thread and queue that you created.
