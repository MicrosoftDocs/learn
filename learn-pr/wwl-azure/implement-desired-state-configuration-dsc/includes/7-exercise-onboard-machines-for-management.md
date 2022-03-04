After your configuration is in place, you'll select the Azure VMs or on-premises VMs that you want to onboard.

> [!NOTE]
> For more information on onboarding on-premises VMs, review the [Physical/virtual Windows machines on-premises or in a cloud other than the Azure/AWS](/azure/automation/automation-dsc-onboarding#physicalvirtual-windows-machines-on-premises-or-in-a-cloud-other-than-azureaws) webpage.

You can onboard a VM and enable DSC in several different ways. Here we'll cover onboarding through an Azure Automation account.

## Onboard VMs to configure

When onboarding VMs using this method, you'll need to deploy your VMs to Azure before starting:

1.  In the left pane of the Automation account, select **State configuration (DSC)**.
2.  Select the **Nodes** tab, and then select **+ Add** to open the Virtual Machines pane.
3.  Find the VM you would like to enable. (You can use the search field and filter options to find a specific VM, if necessary.)
4.  Select the VM, and then select **Connect**.

    :::image type="content" source="../media/dsc7-147b0d38.png" alt-text="Screenshot of the virtual machines pane with SimpleVM VM selected, and Connect highlighted.":::


5.  In the resultant Registration pane, configure the following settings, and then select **OK**.
    
    :::image type="content" source="../media/dsc8-cfa1f9bf.png" alt-text="Screenshot of the registration pane with configuration details described in the following text.":::
    
    
    :::row:::
      :::column:::
        **Property**
      :::column-end:::
      :::column:::
        **Description**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Registration key.
      :::column-end:::
      :::column:::
        Primary or secondary, for registering the node with a pull service.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Node configuration name.
      :::column-end:::
      :::column:::
        The name of the node configuration that the VM should be configured to pull for Automation DSC.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Refresh Frequency.
      :::column-end:::
      :::column:::
        The time interval, in minutes, at which the LCM checks a pull service to get updated configurations. This value is ignored if the LCM isn't configured in pull mode. The default value is 30.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Configuration Mode Frequency.
      :::column-end:::
      :::column:::
        How often, in minutes, the current configuration is checked and applied. This property is ignored if the **ConfigurationMode** property is set to **ApplyOnly**. The default value is 15.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Configuration mode.
      :::column-end:::
      :::column:::
        Specifies how the LCM gets configurations. Possible values are **ApplyOnly**, **ApplyAndMonitor**, and **ApplyAndAutoCorrect**.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Allow Module Override.
      :::column-end:::
      :::column:::
        Controls whether new configurations downloaded from the Azure Automation DSC pull server can overwrite the old modules already on the target server.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Reboot Node if Needed.
      :::column-end:::
      :::column:::
        Set this to **$true** to automatically reboot the node after a configuration that requires a reboot is applied. Otherwise, you'll have to reboot the node for any configuration that needs it manually. The default value is **$false**.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Action after Reboot.
      :::column-end:::
      :::column:::
        Specifies what happens after a reboot during the application of a configuration. The possible values are **ContinueConfiguration** and **StopConfiguration**.
      :::column-end:::
    :::row-end:::
    
    
    The service will then connect to the Azure VMs and apply the configuration.

6.  Return to the State configuration (DSC) pane and verify that the status now displays as Compliant after applying the configuration.

    :::image type="content" source="../media/dsc10-6d2fb07b.png" alt-text="Screenshot of the State configuration(DSC) pane with the SimpleWinVM node listed with a Status of compliant.":::


    Each time Azure Automation DSC does a consistency check on a managed node, the node sends a status report back to the pull server. You can review these reports on that node's blade. Access it by double-clicking or pressing the spacebar and then Enter on the node.

    :::image type="content" source="../media/dsc11-e2e3044d.png" alt-text="Screenshot of the node properties pane with multiple configurations reports listing their status and report time.":::


> [!NOTE]
> You can also unregister the node and assign a different configuration to nodes.

For more information about onboarding VMs, see also:

 -  [Enable Azure Automation State Configuration.](/azure/automation/automation-dsc-onboarding)
 -  [Configuring the Local Configuration Manager](/powershell/scripting/dsc/managing-nodes/metaconfig)
