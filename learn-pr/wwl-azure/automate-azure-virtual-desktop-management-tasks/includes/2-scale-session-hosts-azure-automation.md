You can reduce your total Azure Virtual Desktop deployment cost by scaling your virtual machines (VMs). This means shutting down and deallocating session host VMs during off-peak usage hours, then turning them back on and reallocating them during peak hours.

**Early morning, employees arriving at work.**:::image type="content" source="../media/automation-5-59am-c0d99de3.png" alt-text="Diagram of Early morning with employees arriving at work.":::


**The threshold is met, increased VM allocation to meet demand.**:::image type="content" source="../media/automation-threshold-met-a0f107a5.png" alt-text="Diagram of threshold is met and increased VM allocation to meet demand.":::


**Ideal optimization for VM allocation.**

:::image type="content" source="../media/automation-8am-e752248a.png" alt-text="Diagram of ideal optimization for VM allocation.":::


**The work day winds down.**

:::image type="content" source="../media/automation-5pm-362e1dcd.png" alt-text="Diagram of work day winds down.":::


**Remaining workers begin leaving for home.**

:::image type="content" source="../media/automation-8pm-6680b6d8.png" alt-text="Diagram of remaining workers begin leaving for home.":::


In this unit, you'll learn about the scaling tool built with the Azure Automation account and Azure Logic App that automatically scales session host VMs in your Azure Virtual Desktop environment.

## How the scaling tool works

The scaling tool provides a low-cost automation option for customers who want to optimize their session host VM costs.

You can use the scaling tool to:

 -  Schedule VMs to start and stop based on Peak and Off-Peak business hours.
 -  Scale out VMs based on number of sessions per CPU core.
 -  Scale in VMs during Off-Peak hours, leaving the minimum number of session host VMs running.

The scaling tool uses a combination of an Azure Automation account, a PowerShell runbook, a webhook, and the Azure Logic App to function. When the tool runs, Azure Logic App calls a webhook to start the Azure Automation runbook. The runbook then creates a job.

During peak usage time, the job checks the current number of sessions and the VM capacity of the current running session host for each host pool. It uses this information to calculate if the running session host VMs can support existing sessions based on the `SessionThresholdPerCPU` parameter defined for the *CreateOrUpdateAzLogicApp.ps1* file.

 -  If the session host VMs can't support existing sessions, the job starts additional session host VMs in the host pool.

During the off-peak usage time, the job determines how many session host VMs should be shut down based on the `MinimumNumberOfRDSH` parameter. If you set the `LimitSecondsToForceLogOffUser` parameter to a non-zero positive value, the job will set the session host VMs to drain mode to prevent new sessions from connecting to the hosts.

 -  The job will notify any currently signed in users to save their work, wait the configured amount of time, and then force the users to sign out.
 -  Once all user sessions on the session host VM have been signed out, the job will shut down the VM.
 -  After the VM shuts down, the job will reset its session host drain mode.
