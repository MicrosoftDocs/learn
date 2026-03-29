This guided project consists of the following exercises:

 - Open Cloud Shell and explore the environment
 - **Create and list resources with CLI commands**
 - Tag, query, and clean up resources

In this exercise, you create a resource group and two storage accounts entirely from the command line, then use listing commands to verify what you built. This demonstrates how the CLI lets you accomplish in a few commands what takes many portal clicks.

This exercise includes the following tasks:

 - Create a resource group
 - Create a storage account
 - Create a second storage account
 - List and filter resources

**Outcome:** A resource group and two storage accounts created entirely from the command line, with resource listing confirming the results.

## Task 1: Create a resource group

Create a resource group using a single CLI command. In the portal this takes multiple clicks across several screens — from the CLI, it takes one line.

1.  In Cloud Shell, run the following command (replace **eastus** with your chosen region):

    ```bash
    az group create --name rg-gp-cli-demo --location eastus
    ```

2.  Review the JSON output. Confirm the **provisioningState** shows **Succeeded**.
3.  Run the following command to verify the resource group exists:

    ```bash
    az group show --name rg-gp-cli-demo --output table
    ```

4.  Note the **Location** and **Name** columns in the table output.

> [!NOTE]
> **Validation step:** Confirm the **rg-gp-cli-demo** resource group is created and verified.

## Task 2: Create a storage account

Create a storage account inside the resource group. The CLI requires the same parameters you would fill in through the portal, but expressed as command-line flags.

1.  Run the following command (replace **stgpclidemo** with a unique name — lowercase letters and numbers only, 3-24 characters):

    ```bash
    az storage account create \
      --name stgpclidemo01 \
      --resource-group rg-gp-cli-demo \
      --location eastus \
      --sku Standard_LRS
    ```

2.  Wait for the command to complete (this takes a few seconds).
3.  Review the JSON output and confirm the **provisioningState** shows **Succeeded**.

> [!NOTE]
> **Validation step:** Confirm the first storage account is created with **provisioningState: Succeeded**.

## Task 3: Create a second storage account

Create another storage account to demonstrate managing multiple resources. Having two resources makes the listing and tagging exercises more meaningful.

1.  Run the following command (use a different unique name):

    ```bash
    az storage account create \
      --name stgpclidemo02 \
      --resource-group rg-gp-cli-demo \
      --location eastus \
      --sku Standard_LRS
    ```

2.  Wait for the command to complete and confirm the **provisioningState** shows **Succeeded**.

> [!NOTE]
> **Validation step:** Confirm the second storage account is created with **provisioningState: Succeeded**.

## Task 4: List and filter resources

Use CLI commands to list the resources you created and format the output. This demonstrates how the CLI makes it easy to quickly inventory what exists in a resource group.

1.  Run the following command to list all resources in the resource group:

    ```bash
    az resource list --resource-group rg-gp-cli-demo --output table
    ```

2.  Confirm both storage accounts appear in the table.
3.  Run the following command to list only storage accounts:

    ```bash
    az resource list \
      --resource-group rg-gp-cli-demo \
      --resource-type Microsoft.Storage/storageAccounts \
      --output table
    ```

4.  Confirm the output is filtered to show only the two storage accounts.

> [!NOTE]
> **Validation step:** Confirm the **--resource-type** filter isolated storage accounts from other resource types.

5.  Run the following command to show details of a specific storage account (use your first storage account name):

    ```bash
    az storage account show \
      --name stgpclidemo01 \
      --resource-group rg-gp-cli-demo \
      --output table
    ```

6.  Note the columns showing the account name, location, kind, and SKU.

> [!NOTE]
> **Validation step:** Confirm the CLI returned detailed information for a specific storage account.

> [!TIP]
> The **--output** flag controls the format. Try **table**, **json**, **jsonc** (colorized JSON), **tsv**, and **yaml** to see the differences.

> [!NOTE]
