This guided project consists of the following exercises:

 - **Open Cloud Shell and explore the environment**
 - Create and list resources with CLI commands
 - Tag, query, and clean up resources

In this exercise, you launch Cloud Shell, verify your subscription, explore the built-in help system, and list available regions. By the end, you're comfortable navigating the CLI and ready to start creating resources from the command line.

This exercise includes the following tasks:

 - Launch Cloud Shell
 - Verify your account and subscription
 - Explore the CLI help system
 - List available regions

**Outcome:** Cloud Shell is running in Bash mode and you can verify your subscription and navigate the shell environment.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Launch Cloud Shell

Open Cloud Shell from the Azure portal. Cloud Shell is a browser-based terminal that comes preinstalled with the Azure CLI, so you can manage Azure resources without installing anything on your computer.

> [!WARNING]
> This project creates Azure resources that may incur charges. If this is your first time using Cloud Shell, Azure also creates a small storage account to persist your files. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create resources.
2.  Select the **Cloud Shell** icon in the top menu bar (it looks like a terminal prompt **>_**).
3.  If prompted to choose a shell type, select **Bash**.
4.  If prompted to create storage, select **Create storage** and wait for Cloud Shell to initialize.
5.  Confirm that the Cloud Shell terminal opens at the bottom of the portal with a **Bash** prompt.

> [!NOTE]
> **Validation step:** Confirm Cloud Shell is running in Bash mode with a command prompt visible.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go—you'll review them all in the validation unit at the end of this module.

## Task 2: Verify your account and subscription

Confirm that Cloud Shell is connected to the correct subscription. Every CLI command you run will target this subscription by default.

1.  Run the following command to display your account details:

    ```bash
    az account show --output table
    ```

2.  Review the output and confirm the **SubscriptionId** and **Name** match the subscription you want to use.
3.  If you have multiple subscriptions and need to switch, run:

    ```bash
    az account list --output table
    ```

4.  Note the subscription name and ID for the one you want to use.

> [!NOTE]
> **Validation step:** Confirm the **SubscriptionId** and **Name** match the subscription you want to use.

## Task 3: Explore the CLI help system

Learn how to find commands and get help without leaving the terminal. The built-in help system is one of the most useful features for beginners learning the CLI.

1.  Run the following command to see the top-level CLI command groups:

    ```bash
    az --help
    ```

2.  Scroll through the output and note the major groups such as **group**, **storage**, **monitor**, and **resource**.
3.  Run the following command to see the subcommands available for managing resource groups:

    ```bash
    az group --help
    ```

4.  Note the available commands: **create**, **delete**, **list**, **show**, and others.
5.  Run the following command to see the full parameter list for creating a resource group:

    ```bash
    az group create --help
    ```

6.  Note the required parameters: **--name** and **--location**.

> [!NOTE]
> **Validation step:** Confirm you can navigate the CLI help system to discover commands and required parameters.

## Task 4: List available regions

Before creating resources, check which Azure regions are available to your subscription. This is the CLI equivalent of the region dropdown you see in the portal.

1.  Run the following command to list available regions:

    ```bash
    az account list-locations --output table
    ```

2.  Find a region close to you and note its **Name** value (for example, **eastus**, **westeurope**, or **southeastasia**). You use this value in the next exercise.

> [!NOTE]
> **Validation step:** Confirm you identified and recorded a target region for resource creation.

> [!TIP]
> You can resize the Cloud Shell pane by dragging its top edge. A larger pane makes it easier to read command output.

> [!NOTE]
