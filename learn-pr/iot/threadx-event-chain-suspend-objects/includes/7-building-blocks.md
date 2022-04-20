## Overview

Let's look at the building blocks we'll use to create our project in the next unit.

## Building block 1

<a name="declarations"></a>

### Declarations, definitions, and prototypes

We'll use this code to add declarations, definitions, and prototypes:

:::code language="c" source="../code/project-event-chaining.c" range="13-48" highlight="7-11, 17-21":::

> [!NOTE]
> The highlighted code:
>
> - Adds another queue and queue timer.
> - Adds the values in the highlighted section for your project.

<a name="variables"></a>

### Variables

We'll use this code to add variables:

:::code language="c" source="../code/project-event-chaining.c" range="50-72" highlight="12-23":::

> [!NOTE]
> The highlighted code adds variables, a counter, a timer entry, and prototypes for the added queue.

## Building block 2

### Main entry point

We'll use this code for the main entry point:

:::code language="c" source="../code/project-event-chaining.c" range="74-83":::

> [!NOTE]
> The code is identical to the code that's used in earlier modules, and no changes are needed.

## Building block 3

<a name="application-definitions"></a>

### Application definitions

We'll use this code to add application definitions:

:::code language="c" source="../code/project-event-chaining.c" range="85-154" highlight="11, 40-44, 69":::

> [!NOTE]
> The highlighted lines of code:
>
> - Add another queue pointer.
> - Create another queue and timer.
> - Register another function.

## Building block 4

<a name="urgent-thread-entry"></a>

### Urgent thread entry function

We'll use this code to add an urgent thread entry function:

:::code language="c" source="../code/project-event-chaining.c" range="160-196" highlight="13-22":::

> [!NOTE]
> We'll modify the if statement to check for three queues.

<a name="routine-thread-entry"></a>

### Routine thread entry function

We'll use this code to add a routine thread entry function:

:::code language="c" source="../code/project-event-chaining.c" range="200-234" highlight="10-18":::

> [!NOTE]
> In this code, you'll modify the if statement to check for three queues.

<a name="print-stats"></a>

### print_stats application timer function

We'll use this code to add a print_stats application timer function:

:::code language="c" source="../code/project-event-chaining.c" range="237-264" highlight="10-14":::

> [!NOTE]
> In this code, you'll modify the third queue.
>

<a name="notification-functions"></a>

### Notification functions

We'll use this code to add a notification function:

:::code language="c" source="../code/project-event-chaining.c" range="288-302" highlight="6":::

> [!NOTE]
> In this code, you'll add another notification function.
