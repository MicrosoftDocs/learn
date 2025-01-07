Update Manager has been redesigned and doesn't depend on Azure Automation or Azure Monitor Logs, as required by the [Azure Automation Update Management feature](/azure/automation/update-management/overview). Update Manager offers many new features and provides enhanced functionality over the original version available with Azure Automation. Some of those benefits are listed here:

 -  Provides native experience with zero on-boarding.
     -  Native functionality on Azure compute and the Azure Arc for Servers platform for ease of use.
     -  No dependency on Log Analytics and Azure Automation.
     -  Azure Policy support.
     -  Global availability in all Azure compute and Azure Arc regions.
 -  Works with Azure roles and identity.
     -  Access control at the per-resource level instead of access control at the level of the Azure Automation account.
     -  Update Manager now has Azure Resource Manager-based operations. It allows role-based access control and roles based on Azure Resource Manager in Azure.
 -  Offers enhanced flexibility.
     -  Ability to take immediate action either by installing updates immediately or scheduling them for a later date.
     -  Check updates automatically or on demand.
     -  Helps secure machines with new ways of patching, such as [automatic VM guest patching](/azure/virtual-machines/automatic-vm-guest-patching) in Azure, [hotpatching](/azure/automanage/automanage-hotpatch), or custom maintenance schedules.
     -  Sync patch cycles in relation to "patch Tuesday," the unofficial term for Microsoft's scheduled security fix release on every second Tuesday of each month.

The diagram illustrates how Update Manager assesses and applies updates to all Azure machines and Azure Arc-enabled servers for both Windows and Linux.

:::image type="content" source="../media/update-management-center-overview-bc9aa352.png" alt-text="Diagram showing how Update Manager assesses and applies updates to all Azure machines and Azure Arc-enabled servers.":::
