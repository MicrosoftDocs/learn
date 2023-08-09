## Introduction

Let's look at the code building blocks that we use in this project.

## Building block 1

<a name="declarations"></a>

### Declarations, definitions, and prototypes

We use this code to create declarations, definitions, and prototypes:

:::code language="c" source="../code/project-event-flags.c" range="1-39" highlight="13, 19, 32-36":::

> [!NOTE]
> The highlighted lines of code:
>
> - Add a synchronization value.
> - Create an event flags group. (You'll need one more thread for this project.)
> - Add another counter, variables for thread performance, and one more prototype.
>

## Building block 2

### Main entry point

We use this code for the main entry point.

:::code language="c" source="../code/project-event-flags.c" range="38-43":::

> [!NOTE]
> This building block is identical to the code that's used in earlier modules, and no changes are needed.
>
<a name="building-block-3"></a>

## Building block 3

<a name="application-definitions"></a>

### Application definitions

We use this code to create application definitions:

:::code language="c" source="../code/project-event-flags.c" range="45-87" highlight="31-34":::

> [!NOTE]
> The highlighted lines of code create another thread.

## Building block 4

These code blocks create the functions that are required for the project.

### Monitor thread entry function

We use this code to create the monitor thread entry function:

:::code language="c" source="../code/project-event-flags.c" range="89-104":::

<a name="important-thread-entry"></a>

### Urgent thread entry function

We use this code to create the urgent thread entry function:

:::code language="c" source="../code/project-event-flags.c" range="106-124" highlight="14-17":::

> [!NOTE]
> The highlighted lines of code define one more thread entry functions.
>

### Routine thread entry function

We use this code to create the routine thread entry function:

:::code language="c" source="../code/project-event-flags.c" range="126-144":::

<a name="print-stats"></a>

### print_stats application timer function

We use this code to create the print_stats application timer function:

:::code language="c" source="../code/project-event-flags.c" range="146-177" highlight="2-5":::

> [!NOTE]
> The highlighted lines of code modify the function to include data for the thread you created.
>
