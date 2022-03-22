## Introduction

Let's look at the code building blocks we'll use in the project.

## Building block 1

### Declarations, definitions, and prototypes

We'll use this code to create declarations, definitions, and prototypes:

:::code language="c" source="../code/project-priority-inversion.c" range="1-52":::

> [!NOTE]
> You won't make any changes in this code when you work with the project file in Visual Studio.
>

## Building block 2

### Main entry point

We'll use this code for the main entry point.

:::code language="c" source="../code/project-priority-inversion.c" range="54-62":::

> [!NOTE]
> This building block is identical to the projects in earlier modules. You won't make any changes in this code when you work with the project file in Visual Studio.
>

<a name="building-block-3"></a>

## Building block 3

### Application definitions

We'll use this code to create application definitions:

:::code language="c" source="../code/project-priority-inversion.c" range="64-123" highlight="42-47, 49-51":::

> [!NOTE]
> In the next unit, you'll make these changes to the highlighted lines of code:
>
> - You'll employ priority inheritance to avoid the priority inversion problem. When the mutex was created, priority inheritance wasn't enabled. To enable priority inheritance, you'll change the mutex option from TX_NO_INHERIT to TX_INHERIT. After experimenting with this change and recording your results, you can change the option back to TX_NO_INHERIT.
> - When routine thread was created, the preemption threshold was set to 20. In the next unit, you'll experiment with changing the preemption threshold to 10. Then, you'll complete your experiments and record your results

## Building block 4

You won't make any changes in the following code when you work with the project file in Visual Studio.

### Urgent thread entry function

We'll use this code to create the urgent thread entry function:

:::code language="c" source="../code/project-priority-inversion.c" range="125-144":::

### Important thread entry function

We'll use this code to create the important thread entry function:

:::code language="c" source="../code/project-priority-inversion.c" range="146-163":::

### Routine thread entry function

We'll use this code to create the routine thread entry function:

:::code language="c" source="../code/project-priority-inversion.c" range="165-188":::

### print_stats application timer function

We'll use this code to create the print_stats application timer function:

:::code language="c" source="../code/project-priority-inversion.c" range="198-228":::
