**Azure Automation State Configuration (DSC)** is an **Azure** cloud-based implementation of **PowerShell DSC**, available as part of **Azure Automation**. **Azure Automation State Configuration** allows you to write, manage, and compile **PowerShell DSC** configurations, import **DSC Resources**, and assign configurations to target nodes, all in the cloud.

## Why use Azure Automation State Configuration?

The following outlines some of the reasons why you would consider using **Azure Automation State Configuration:**

### Built-in pull server

**Azure Automation State Configuration** provides a **DSC pull server** similar to the **Windows Feature DSC service** so that target nodes automatically receive configurations, conform to the desired state, and report back on their compliance. The built-in pull server in **Azure Automation** eliminates the need to set up and maintain your own pull server.

### Centralized management

You can manage all your **DSC configurations**, **resources**, and target nodes from the **Azure portal** or **PowerShell**. This centralized management simplifies configuration deployment and monitoring across your entire infrastructure.

### Integration with Log Analytics

Nodes managed with **Azure Automation State Configuration** send detailed reporting status data to the built-in pull server. You can configure **Azure Automation State Configuration** to send this data to your **Log Analytics workspace** for advanced monitoring, alerting, and compliance reporting.

## How Azure Automation State Configuration works

The general process for how **Azure Automation State Configuration** works is as follows:

### Step 1: Create a PowerShell configuration script

Create a **PowerShell** script with the **configuration** element. This script defines the desired state for your target nodes using **DSC** syntax.

### Step 2: Upload and compile the configuration

Upload the script to **Azure Automation** and compile the script into a **MOF file**. The **MOF (Managed Object Format) file** is transferred to the **DSC pull server**, provided as part of the **Azure Automation** service.

### Step 3: Assign configurations to nodes

Define the nodes that will use the configuration, and then apply the configuration. The nodes automatically pull the configuration from the **DSC pull server** and apply it to maintain the desired state.

:::image type="content" source="../media/dsc1-127af77c.png" alt-text="A diagram is made up of three sections Configurations, Node Configurations, and Nodes. On the left, Configurations has a code window with text beneath that says, 1 or more per automation account. An arrow labeled Compiled, put on pull server via compilation jobs points from section 1 to section 2, Node Configurations MOF configuration documents. This section has three Sharepoint.WebService icons. Text below the icons says, 1 or more per Configuration. An arrow labeled Applied via node pulls points from section 2 to section 3, Nodes, which has six Node icons, with the text 1 or more per Node Configuration beneath it.":::

## Understanding MOF files

For more information about **Managed Object Format (MOF) files**, visit [Managed Object Format (MOF) file](/windows/win32/wmisdk/managed-object-format--mof-).
