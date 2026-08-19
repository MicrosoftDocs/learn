Update assessments identify missing operating system updates without installing them. Azure Update Manager supports periodic and on-demand assessments for Azure virtual machines (VMs) and Azure Arc-enabled servers.

## Use periodic assessment

Periodic assessment checks for available updates every 24 hours. Enable it on each machine or at scale through Azure Policy so that Update Manager can display current compliance information.

An assessment uses the update mechanism on the machine:

- Windows uses the Windows Update client and its configured update source.
- Linux uses the package manager and configured repositories.

Azure VMs must be running during assessment. Update Manager doesn't scan stopped or deallocated Azure VMs for missing updates.

## Run an on-demand assessment

Run an on-demand assessment when you need current update information:

1. In the Azure portal, open **Azure Update Manager**.
2. Under **Manage**, select **Machines**.
3. Select one or more machines, and then select **Check for updates**.
4. After the assessment finishes, review the update status and available update classifications.

You can also open a VM or Azure Arc-enabled server, select **Updates**, and then select **Check for updates**.

## Review assessment results

Assessment results show the last assessment time, machine status, pending update counts, and update classifications. Select a machine to review individual updates. You can then install them immediately or include them in a recurring schedule.

Use **History** to review assessment runs and their status. Each run includes an activity identifier, time details, and assessment results. Update Manager stores these results in Azure Resource Graph, where you can query them for custom reports.

## Learn more

- [Assessment options in Update Manager](/azure/update-manager/assessment-options)
- [Check and install on-demand updates](/azure/update-manager/quickstart-on-demand)
