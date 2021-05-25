### Task 1: Create a Power BI workspace

1. In a new browser tab, navigate to <https://powerbi.microsoft.com/>.

2. Sign in with the same account used to sign in to Azure by selecting the **Sign in** link on the upper-right corner.

3. If this is your first time signing into this account, complete the setup wizard with the default options.

4. Select **Workspaces**, then select **Create a workspace**.

    ![The create a workspace button is highlighted.](../media/power-bi-create-workspace.png "Create a workspace")

5. If you are prompted to upgrade to Power BI Pro, select **Try free**.

    ![The Try free button is highlighted.](../media/power-bi-try-pro.png "Upgrade to Power BI Pro")

    Select **Got it** to confirm the pro subscription.

    ![The Got it button is highlighted.](../media/power-bi-try-pro-confirm.png "Power BI Pro is yours for 60 days")

6. Set the name to **synapse-training**, then select **Save**.

    ![The form is displayed.](../media/power-bi-create-workspace-form.png "Create a workspace")

### Task 2: Connect to Power BI from Synapse

1. Open Synapse Studio (<https://web.azuresynapse.net/>), and then navigate to the **Manage hub**.

    ![Manage hub.](../media/manage-hub.png "Manage hub")

2. Select **Linked services** on the left-hand menu, then select **+ New**.

    ![The new button is highlighted.](../media/new-linked-service.png "New linked service")

3. Select **Power BI**, then select **Continue**.

    ![The Power BI service type is selected.](../media/new-linked-service-power-bi.png "New linked service")

4. In the dataset properties form, complete the following:

    | Field                  | Value                       |
    |------------------------|-----------------------------|
    | Name **(1)**           | _enter `handson_powerbi`_   |
    | Workspace name **(2)** | _select `synapse-training`_ |

    ![A form is displayed.](../media/new-linked-service-power-bi-form.png "New linked service")

5. Select **Create (3)**.

### Task 3: Explore the Power BI linked service in Synapse Studio

1. In  [**Azure Synapse Studio**](<https://web.azuresynapse.net/>) and navigate to the **Develop** hub using the left menu option.

    ![Develop option in Azure Synapse Workspace.](../media/develop-hub.png "Develop hub")

2. Expand `Power BI`, expand `SynapseDemos` (or `synapse-training`, named after your resource group) and observe that you have access to your Power BI datasets and reports, directly from Synapse Studio.

    ![Explore the linked Power BI workspace in Azure Synapse Studio](../media/power-bi-workspace.png)

    New reports can be created by selecting **+** at the top of the **Develop** tab. Existing reports can be edited by selecting the report name. Any saved changes will be written back to the Power BI workspace.
