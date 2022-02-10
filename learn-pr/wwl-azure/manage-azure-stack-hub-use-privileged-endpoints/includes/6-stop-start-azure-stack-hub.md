Follow the procedures in this unit to shut down and restart Azure Stack Hub services. *Stop* will physically shut down and power off the entire Azure Stack Hub environment. *Start* powers on all infrastructure roles and returns tenant resources to the power state they were in before shutdown.

## Stop Azure Stack Hub

Stop or shut down Azure Stack Hub with the following steps:

1.  Prepare all workloads running on your Azure Stack Hub environment's tenant resources for the upcoming shutdown.
2.  Open a privileged endpoint session (PEP) from a machine with network access to the Azure Stack Hub ERCS virtual machines.
3.  From the PEP, run:

```
Stop-AzureStack

```

4.  Wait for all physical Azure Stack Hub nodes to power off.

## Start Azure Stack Hub

Start Azure Stack Hub with the following steps. Follow these steps regardless of how Azure Stack Hub stopped.

1.  Power on each of the physical nodes in your Azure Stack Hub environment. Verify the power on instructions for the physical nodes by following the instructions from the OEM who supplied the hardware for your Azure Stack Hub.
2.  Wait until the Azure Stack Hub infrastructure services starts. Azure Stack Hub infrastructure services can require two hours to finish the start process. You can verify the start status of Azure Stack Hub with the **Get-ActionStatus** cmdlet.
3.  Ensure that all of your tenant resources have returned to the state they were in before shutdown. Workloads running on tenant resources may need to be reconfigured after startup by the workload manager.
