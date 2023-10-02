## Introduction

Let's review the four building blocks that form a solution to our problem before we do the exercise in the next unit. You don't need to copy the code in this unit, everything you need is already in the exercise.

<a name="building-block-1"></a>

## Building block 1

Building Block 1 contains various declarations, definitions, and prototypes:

:::code language="c" source="../code/project-producer-consumer.c" range="1-29" highlight="18,24,27":::

> [!NOTE]
>
> - Add another Consumer thread, counter, and prototype. Refer to the highlighted code for an example.

## Building block 2

Building Block 2 contains the main entry point:

:::code language="c" source="../code/project-producer-consumer.c" range="31-36":::

## Building block 3

Building Block 3, part 1 contains initialization and various application definitions:

:::code language="c" source="../code/project-producer-consumer.c" range="38-55":::

<a name="building-block-3-part-2"></a>

Building Block 3, part 2 contains more application definitions:

:::code language="c" source="../code/project-producer-consumer.c" range="57-72" highlight="4-7, 11":::

> [!NOTE]
>
> - Add a second Consumer thread. Its entry function should be similar to the one in this code example.
> - We initialized the counting semaphore to zero, which signifies that `StorageFacility` is initially empty.

## Building block 4

Building Block 4, part 1 contains the Producer thread entry function:

:::code language="c" source="../code/project-producer-consumer.c" range="74-91":::

> [!NOTE]
>
> - No changes are needed for the Producer thread entry function.

Building Block 4, part 2 contains the Consumer thread entry function:

:::code language="c" source="../code/project-producer-consumer.c" range="95-108":::

> [!NOTE]
>
> - Use this function as a guide to creating the second consumer.

Building Block 4, part 3 contains the `print_stats` application timer entry function:

:::code language="c" source="../code/project-producer-consumer.c" range="110-125" highlight="11-15":::

> [!NOTE]
>
> - Add a `printf` to display information about the second consumer that you added.
