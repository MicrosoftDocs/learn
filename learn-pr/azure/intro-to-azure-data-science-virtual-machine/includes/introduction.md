The Data Science Virtual Machine (DSVM) is a customized virtual machine (VM) image built specifically for data science. The DSVM runs on the Azure cloud platform. It has many popular data science tools preinstalled and preconfigured to jumpstart building intelligent applications for advanced analytics.

If you work with data, you know that data wrangling is time-consuming. Data transformations require different tools for different tasks. Working with data challenge the CPU/GPU require large amounts of storage and RAM, and become difficult to replicate. Sharing data and tools can become difficult, and can involve fragile data transmissions or the sharing of drives through the "sneakernet."

You want to:

- Work in the operating system that you prefer.
- Work with the tools that you know.
- Work on a powerful machine.
- Easily share your work with your colleagues.

You can buy or build your own machine, and configure it just as you choose. Buying a machine might be the right choice for you if you're willing to bear the upfront costs, and know that you could frequently stress the machine. Even so, safe remote access to the machine for yourself or your colleagues might become a challenge. At the least, it becomes an ongoing administrative task.

With a DSVM, you only pay when the machine is running. If you're worried about forgetting to shut down the machine, you can schedule a daily shutdown at the time of your choosing. You can connect to the machine's command-line interface, or use its graphical desktop.

:::image type="content" source="../media/jupyter-running-pytorch-in-dsvm.png" alt-text="Screenshot of the desktop of the Data Science Virtual Machine running a Jupyter notebook.":::

The DSVM has dozens of applications and programming tools and libraries, preinstalled and preconfigured. These tools take advantage of the GPUs if you choose to run the DSVM on hardware with GPU compute resources. For Python, R, Julia, Node, and .NET developers, the DSVM offers the base languages already installed. It also offers popular packages, development environments, and Jupyter kernels.

For this exercise, imagine that you're a bank analyst, and you want to do some statistical analysis to predict investment trends. You don't yet know where this analysis might lead, but you hope you can extract a signal, and develop a model that has potentially great importance.

At this early stage in the process, you don't know exactly which tools and approaches might become important. However, the data volume is so large that it's difficult to locally work with the data while you share work with your colleagues.

## Learning objectives

In this module, you'll:

- Match operating systems and hardware resources available for the DSVM
- Specify and create a DSVM running Ubuntu Server 20.04 LTS
- Connect to the command line of the DSVM with SSH
- Connect to the graphical desktop of the DSVM with X2Go Client
- Demonstrate the use of a Python conda environment running inside the DSVM
- List custom Python environments, activate one, and run a Jupyter notebook server

## Prerequisites

- Basic understanding of virtual machines
