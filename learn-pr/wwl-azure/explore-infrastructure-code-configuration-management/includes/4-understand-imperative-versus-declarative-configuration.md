There are a few different approaches that you can adopt to implement Infrastructure as Code and Configuration as Code.

Two of the main methods of approach are:

 -  **Declarative** (functional). The declarative approach states *what* the final state should be. When run, the script or definition will initialize or configure the machine to have the finished state declared without defining *how* that final state should be achieved.

:::image type="content" source="../media/declarative-703bb981.png" alt-text="An arrow points from a script icon to an icon of two cogs representing coding procedures.":::


 -  **Imperative** (procedural). In the imperative approach, the script states the *how* for the final state of the machine by executing the steps to get to the finished state. It defines what the final state needs to be but also includes how to achieve that final state. It also can consist of coding concepts such as *for*, *if-then*, *loops*, and matrices.

:::image type="content" source="../media/imperative-a9e6a2ad.png" alt-text="An arrow points from a script icon to an icon of two cogs representing coding procedures, followed by another arrow pointing to an image representing an application in its final state.":::


## Best practices

The **declarative** approach abstracts away the methodology of how a state is achieved. As such, it can be easier to read and understand what is being done.

It also makes it easier to write and define. Declarative approaches also separate the final desired state and the coding required to achieve that state.

So, it doesn't force you to use a particular approach, allowing for optimization.

A **declarative** approach would generally be the preferred option where ease of use is the primary goal. Azure Resource Manager template files are an example of a declarative automation approach.

An **imperative** approach may have some advantages in complex scenarios where changes in the environment occur relatively frequently, which need to be accounted for in your code.

There's no absolute on which is the best approach to take, and individual tools may be used in either *declarative* or *imperative* forms. The best approach for you to take will depend on your needs.
