This guided project consists of the following exercises:

 - Open Cloud Shell and explore the environment
 - Create and list resources with CLI commands
 - **Tag, query, and clean up resources**

In this exercise, you apply tags from the CLI, use JMESPath queries to filter and shape command output, compare your CLI work to the portal view, and then clean up by deleting the resource group. This completes the full resource lifecycle from the command line.

This exercise includes the following tasks:

 - Tag the resource group
 - Tag individual resources
 - Query resources with JMESPath filters
 - Compare CLI output to the portal
 - Delete the resource group from the CLI

**Outcome:** Resources tagged from the CLI, queried with filters, and the resource group deleted from the command line.

## Task 1: Tag the resource group

Apply tags to the resource group using a single command. Tags assigned from the CLI follow the same key-value format you use in the portal but are faster to apply across multiple resources.

1.  Run the following command to add tags to the resource group:

    ```bash
    az group update \
      --name rg-gp-cli-demo \
      --tags environment=test department=it-ops
    ```

2.  Confirm the JSON output includes the **tags** section with both key-value pairs.
3.  Run the following command to verify the tags:

    ```bash
    az group show --name rg-gp-cli-demo --query tags
    ```

4.  Confirm the output shows **environment: test** and **department: it-ops**.

> [!NOTE]
> **Validation step:** Confirm tags are applied to the resource group from the CLI.

## Task 2: Tag individual resources

Apply tags to each storage account. In a real environment, consistent tagging across resources enables cost tracking and automated governance.

1.  Run the following command to tag the first storage account (use your actual storage account name):

    ```bash
    az resource tag \
      --tags environment=test department=development \
      --ids $(az storage account show --name stgpclidemo01 --resource-group rg-gp-cli-demo --query id --output tsv)
    ```

2.  Run the following command to tag the second storage account with different values:

    ```bash
    az resource tag \
      --tags environment=test department=operations \
      --ids $(az storage account show --name stgpclidemo02 --resource-group rg-gp-cli-demo --query id --output tsv)
    ```

3.  Confirm both commands return JSON output with the expected tags.

> [!NOTE]
> **Validation step:** Confirm both storage accounts are tagged with different **department** values.

## Task 3: Query resources with JMESPath filters

Use the **--query** parameter to extract specific fields from CLI output. JMESPath is a built-in query language that lets you filter and reshape JSON results without piping to external tools.

1.  Run the following command to list resource names and their tags:

    ```bash
    az resource list \
      --resource-group rg-gp-cli-demo \
      --query "[].{Name:name, Department:tags.department, Environment:tags.environment}" \
      --output table
    ```

2.  Confirm the table shows each resource with its **Department** and **Environment** tag values.

> [!NOTE]
> **Validation step:** Confirm the JMESPath query extracted and formatted tag values from CLI output.

3.  Run the following command to list only resources tagged with **department=development**:

    ```bash
    az resource list \
      --resource-group rg-gp-cli-demo \
      --query "[?tags.department=='development'].{Name:name, Type:type}" \
      --output table
    ```

4.  Confirm only the first storage account appears in the filtered output.

> [!NOTE]
> **Validation step:** Confirm the JMESPath filter shows only resources where **department** equals **development**.

5.  Run the following command to count the resources in the resource group:

    ```bash
    az resource list \
      --resource-group rg-gp-cli-demo \
      --query "length([])"
    ```

6.  Confirm the output shows **2**.

> [!NOTE]
> **Validation step:** Confirm the resource count matches the expected number of resources.

## Task 4: Compare CLI output to the portal

Open the portal alongside Cloud Shell to confirm the CLI and portal show the same data. This reinforces that both tools manage the same underlying resources.

1.  In the Azure portal (above the Cloud Shell pane), search for **Resource groups** in the portal search bar and select **Resource groups**.
2.  Select **rg-gp-cli-demo** from the list.
3.  Confirm the portal shows the same two storage accounts.
4.  In the left menu, select **Tags**.
5.  Confirm the **environment** and **department** tags match what you set from the CLI.
6.  Return to the **rg-gp-cli-demo** resource group overview.
7.  Select one of the storage accounts.
8.  In the left menu, select **Tags**.
9.  Confirm the resource-level tags match what you set from the CLI.

> [!NOTE]
> **Validation step:** Confirm the portal and CLI display identical resource tags and metadata.

## Task 5: Delete the resource group from the CLI

Clean up all resources with a single command. Deleting a resource group removes everything inside it, which is why organizing resources into groups is a best practice.

1.  Run the following command to delete the resource group and all resources inside it:

    ```bash
    az group delete --name rg-gp-cli-demo --yes --no-wait
    ```

2.  The **--yes** flag skips the confirmation prompt. The **--no-wait** flag returns control immediately while deletion continues in the background.
3.  Run the following command to check the deletion status:

    ```bash
    az group show --name rg-gp-cli-demo --output table
    ```

4.  If the group still exists, the output shows it. If it's been deleted, you receive a "not found" error, which confirms successful removal.
5.  Wait a minute and run the command again to confirm the resource group is fully deleted.

> [!NOTE]
> **Validation step:** Confirm the resource group deletion is complete ("not found" error confirms removal).

