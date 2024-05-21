When you capture logs and data in Azure Monitor, Azure stores the collected information in a Log Analytics workspace. Your Log Analytics workspace is the basic management environment for Azure Monitor Logs.

### How to define your Log Analytics scope

> [!Video https://www.youtube.com/embed/34IrPO1Xh2o]

### Things to know about the Log Analytics workspace

To get started with Log Analytics in Azure Monitor, you need to create your workspace. Each workspace has a unique workspace ID and resource ID. After you create your workspace, you configure your data sources and solutions to store their data in your workspace.

:::image type="content" source="../media/create-workspace-f37a5b11.png" alt-text="Screenshot that shows how to create a Log Analytics workspace in the Azure portal.":::


To create your Log Analytics workspace, configure the following parameters:

- **Name**: Provide a name for your new Log Analytics workspace. The name for your workspace must be unique within your resource group. 

- **Subscription**: Specify the Azure Subscription to associate with your workspace.

- **Resource Group**: Specify the resource group to associate with your workspace. You can choose an existing resource group or create a new one. The resource group must contain at least one Azure Virtual Machines instance. 

- **Region**: Select the region where you deploy your virtual machines.

   > [!Note]
   > The region must support Log Analytics. You can review the [regions that support Log Analytics](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/). In the **Search for a product** box, enter "Azure Monitor."

- **Pricing**: The default pricing tier for a new workspace is _pay-as-you-go_. Charges incur only after you start collecting data. 

   Each Log Analytics workspace in Azure Monitor can have a different pricing tier. You can change the pricing tier for a workspace and also track the changes.