There are several options for updating Azure Virtual Desktop desktops. Deploying an updated image every month guarantees compliance and state.

 -  [Microsoft Configuration Manager (MCM)](/mem/configmgr/) updates server and desktop operating systems.
 -  [Windows Updates for Business](/windows/deployment/update/waas-manage-updates-wufb) updates desktop operating systems like Windows 10 multi-session.
 -  [Azure Update Management](/azure/automation/update-management/overview) updates server operating systems.
 -  [Azure Log Analytics](/azure/azure-monitor/platform/log-analytics-agent) checks compliance.
 -  Deploy a new (custom) image to session hosts every month for the latest Windows and applications updates. You can use an image from the Azure Marketplace or a [custom Azure managed image](/azure/virtual-machines/windows/capture-image-resource).
