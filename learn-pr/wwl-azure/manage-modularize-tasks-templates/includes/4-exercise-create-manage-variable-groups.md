This exercise demonstrates variable group creation, configuration, and integration within Azure DevOps release pipelines for centralized configuration management.

## Steps

Release pipelines utilize variable groups for predefined configuration sets that eliminate redundant variable definitions across pipeline stages and multiple pipeline definitions.

Variable groups provide centralized configuration management, similar to task group functionality, reducing maintenance overhead and ensuring consistent configuration across complex deployment scenarios.

The following steps demonstrate variable group creation, configuration, and pipeline integration:

1. On the main menu for the **Parts Unlimited** project, click **Pipelines**, then click **Library**. There are currently no variable groups in the project.

   :::image type="content" source="../media/08-01-no-existing-variable-groups-7804ff9d.png" alt-text="Screenshot showing no existing variable groups.":::

2. Click **+ Variable group** to start creating a variable group. Set **Variable group name** to **Website Test Product Details**.

   :::image type="content" source="../media/08-02-new-variable-group-91c7cc04.png" alt-text="Screenshot showing new variable group.":::

3. In the **Variables** section, click **+Add**, enter **Name**, enter **ProductCode**, and in **Value**, enter **REDPOLOXL**.

   :::image type="content" source="../media/08-03-added-product-code-592a385d.png" alt-text="Screenshot showing added ProductCode.":::

   The lock column enables secret variable configuration, masking sensitive values from display in configuration interfaces while maintaining functional access during pipeline execution.

   Secret variables typically secure sensitive information such as passwords, API keys, and authentication tokens. Azure Key Vault integration provides enterprise-grade secret management for credentials requiring external security control.

   Azure Key Vault integration offers superior security for credential management compared to platform-stored secrets, enabling centralized secret lifecycle management outside project scope.

   This demonstration utilizes non-sensitive product configuration data for website testing scenarios.

4. Add another variable called **Quantity** with a value of **12**.
5. Add another variable called **SalesUnit** with a value of **Each**.

   :::image type="content" source="../media/08-04-three-variables-configured-354c5de1.png" alt-text="Screenshot showing three variables are configured.":::

6. Click **Save** to save the new variable group.

   :::image type="content" source="../media/08-05-save-location-9243d3f0.png" alt-text="Screenshot showing Save location.":::

7. On the main menu, click **Pipelines**, click Releases and click **Edit** to return to editing the release pipeline we have been working on. From the top menu, click **Variables**.

   :::image type="content" source="../media/08-06-variables-location-a8472dad.png" alt-text="Screenshot showing Variables location.":::

8. In the left-hand pane, click **Variable Groups**.

   :::image type="content" source="../media/08-07-variable-groups-selection-013dd0fd.png" alt-text="Screenshot showing Variable groups selection.":::

   Variable groups establish linked relationships with pipelines through reference associations rather than direct integration, enabling reusable configuration across multiple pipeline definitions.

9. Click **Link variable group**, then in the **Link variable group** pane, click the **Website Test Product Details** variable group (notice that it shows you how many variables are contained). In the **Variable group scope**, select the **Development**, **Test Team A**, and **Test Team B** stages.

   :::image type="content" source="../media/08-08-link-variable-group-0e492b12.png" alt-text="Screenshot showing Link variable group.":::

   Test product configuration applies to development and testing environments but remains excluded from production deployments. Universal stage access requires **Release** scope selection for variable group availability across all pipeline stages.

10. Click the **Link** to complete the link.

    :::image type="content" source="../media/08-09-linked-variable-group-8df463e4.png" alt-text="Screenshot showing Linked variable group.":::

Variable group content becomes accessible within scoped stages (excluding production), providing identical functionality to individually defined variables while maintaining centralized configuration management.
