# Manual Azure Monitor Agent deployment

Azure Monitor Agent (AMA) is the recommended modern agent for collecting data from virtual machines. Unlike the legacy Log Analytics agent, AMA uses Data Collection Rules (DCRs) to specify what data to collect and where to send it. This approach provides more flexibility and better performance.

## Prerequisites

Before installing Azure Monitor Agent with Data Collection Rules, ensure you have:

- A Log Analytics workspace where you have at least contributor rights
- Permissions to create DCR objects in the workspace
- The virtual machines you want to monitor (Azure VMs or Azure Arc-enabled machines)

## Create a Data Collection Rule

To manually install Azure Monitor Agent using Data Collection Rules:

1. **Create the Data Collection Rule**:
   - In the Azure portal, go to **Monitor** > **Data Collection Rules**
   - Select **Create** to open the DCR creation pane
   - On the **Basics** tab, provide:
     - **Rule Name**: A descriptive name for the DCR
     - **Subscription**: The subscription to store the DCR
     - **Resource Group**: A resource group to store the DCR
     - **Region**: Must be the same region as your Log Analytics workspace
     - **Platform Type**: Select **Windows**, **Linux**, or **All** based on your target machines

2. **Add target resources**:
   - On the **Resources** tab, select **Add resources**
   - Choose the VMs that use this DCR
   - The Azure Monitor Agent is automatically installed on selected VMs that don't already have it

3. **Configure data sources**:
   - On the **Collect and deliver** tab, select **Add data source**
   - Choose from available data source types:
     - **Windows Events**: For Windows event logs and security events
     - **Performance Counters**: For system performance metrics
     - **Syslog**: For Linux system logs
     - **Text logs**: For custom application logs
     - **IIS logs**: For web server logs
   - Specify the destination Log Analytics workspace

4. **Save the configuration**:
   - Review your settings and select **Create**
   - The DCR is created with the selected VMs

## Data Sources for Security Monitoring

For Microsoft Defender for Cloud integration, configure these common data sources:

### Windows Machines

- **Windows Events**: Collect security events from Windows event logs
- **Performance Counters**: Monitor system performance metrics
- **Security events**: Capture authentication and authorization events

### Linux Machines

- **Syslog**: Collect system and security logs
- **Performance Counters**: Monitor system performance
- **Authentication logs**: Track user access and security events

## Deployment Methods

You can deploy Azure Monitor Agent with DCRs using multiple methods:

### Azure portal

Use the Azure portal interface to create DCRs and associate them with VMs as described above.

### Azure Resource Manager Templates

Deploy agents using ARM templates for consistent, repeatable deployments across multiple machines.

### PowerShell

Use Azure PowerShell cmdlets to programmatically create and manage DCRs:

```powershell
# Create a DCR association
New-AzDataCollectionRuleAssociation -ResourceUri <vm-resource-id> -RuleId <dcr-resource-id>
```

### Azure CLI

Use Azure CLI commands for scripted deployments:

```bash
# Associate a DCR with a VM
az monitor data-collection rule association create --resource <vm-resource-id> --rule-id <dcr-resource-id>
```

## Verify Installation

After creating the DCR and associating it with VMs:

1. **Check agent status**:
   - Verify the Azure Monitor Agent is installed and running on target VMs
   - Check the **Heartbeat** table in your Log Analytics workspace

2. **Verify data collection**:
   - Query the appropriate tables in Log Analytics to confirm data is being collected
   - It can take up to 5 minutes for data to appear after DCR creation

3. **Monitor agent health**:
   - Use Azure Monitor to track agent health and connectivity
   - Review any error messages in the agent logs

## Best Practices

- **Avoid duplicate data**: Don't create multiple DCRs with the same data sources for the same VMs
- **Use descriptive names**: Name your DCRs clearly to identify their purpose
- **Regular maintenance**: Review and update DCRs as your monitoring requirements change
- **Cost optimization**: Only collect data you need to avoid unnecessary charges

The Azure Monitor Agent with Data Collection Rules provides a modern, flexible approach to data collection that integrates seamlessly with Microsoft Defender for Cloud's security monitoring capabilities.
