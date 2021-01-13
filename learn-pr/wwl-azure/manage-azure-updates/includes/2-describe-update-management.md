

Updates to Windows are, of course, a recurring series of events. Updates can come quickly and frequently when newly discovered security flaws or attack vectors are addressed. Updates also arrive periodically based on events such as changes in device drivers or planned roll-outs of new system features.

Contoso IT support staff realize that there is no set time that an urgent security update might become available, and it's imperative in many cases to deploy such an update as soon as possible. This approach applies whether the system is a physical host, an on-premises VM, or an Azure VM. They must be vigilant when reviewing Windows Updates to their Azure VMs.

## Azure Automation and Update Management

Azure Automation helps you manage OS updates for Azure VMs running the Windows operating system. The Update Management feature is free, and the only cost is the cost of log storage in Azure Log Analytics.

The following table describes how Update Management features can help with updates for your Azure VMs.

|Feature|How it can help|
|------------------------------------------------------------ |------------------------------------------------------------ |
|Review the status of updates on your VMs|The service includes a cloud-based console where you can review the status of updates across your Azure organization and for a specific VM.|
|Configure dynamic groups of VMs to target|It also allows you to define a query based on a computer group. A *computer group* is a group of computers that are defined based on another query or imported from another source such as WSUS or Microsoft Endpoint Configuration Manager.|
|Search the Azure Monitor logs|Update Management collects records from the Azure Monitor Logs.|

To implement Azure Update Management in your hybrid environment, you must complete the following high-level steps:

1. Create an Azure Automation account.
2. Enable Update Management.
3. Onboard your on-premises servers.
4. Select the machines to manage.
5. Schedule updates

> [!NOTE]
> These steps are the same for on-premises physical servers and VMs, and Azure VMs running Windows Server.

## Interaction with Windows Update

Azure Automation Update Management relies on the Windows Update client to download and install Windows updates. There are specific settings that are used by the Windows Update client when connecting to WSUS or Windows Update. You can manage many of these settings by:

- Using Local Group Policy Editor
- Using Group Policy
- Using Windows PowerShell
- Editing the Registry directly

Update Management respects many of the settings specified to control the Windows Update client.

> [!TIP]
> If you use settings to enable non-Windows updates, Update Management also manages those updates.

### Configure WSUS for managing updates

WSUS improves the security of the systems at Contoso by applying security updates to Microsoft products and third-party products in a timely manner. It provides the infrastructure to download, test, and approve security updates. Applying security updates quickly helps prevent security incidents that are a result of known vulnerabilities. While implementing WSUS, you must keep in mind the hardware and software requirements for WSUS, the settings to configure, and the updates to approve or remove according to Contoso’s needs.

Update Management in Azure supports WSUS settings. You can specify sources for scanning and downloading updates using instructions in **Specify intranet Microsoft Update service location**. By default, the Windows Update client is configured to download updates from Windows Update. When you specify a WSUS server as a source for your machines, if the updates aren't approved in WSUS, update deployment fails.

![A screenshot of the Group Policy Editor in Windows. The administrator has navigated to the Windows Update folder and configured the Configure Automatic Updates, Specify intranet Microsoft Update service location, and Do not connect to any Windows Update Internet locations values.](../media/m3-windows-update.png)

> [!TIP]
> To restrict machines to the internal update service, set **Do not connect to any Windows Update Internet locations**.
