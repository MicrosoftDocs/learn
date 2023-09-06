Workflows let you implement complex logic within your code. Two features available with workflows are checkpoints and parallel processing.

## Checkpoints

A **checkpoint** is a snapshot of the current state of the workflow.

Checkpoints include the current value for variables and any output generated up to that point. (For more information on what a checkpoint is, read the [checkpoint](/azure/automation/automation-powershell-workflow) webpage.)

If a workflow ends in an error or is suspended, the next time it runs, it will start from its last checkpoint instead of at the beginning of the workflow.

You can set a checkpoint in a workflow with the **Checkpoint-Workflow** activity.

For example, if an exception occurs after Activity2, the workflow will end in the following sample code.

When the workflow is rerun, it starts with Activity2, followed just after the last checkpoint set.

```PowerShell
    <Activity1>
        Checkpoint-Workflow
            <Activity2>
                <Exception>
            <Activity3>

```

## Parallel processing

A script block has multiple commands that run concurrently (or *in parallel*) instead of sequentially, as for a typical script.

It's referred to as *parallel processing*. (More information about parallel processing is available on the [Parallel processing](/azure/automation/automation-powershell-workflow) webpage.)

In the following example, two *vm0* and *vm1* VMs will be started concurrently, and *vm2* will only start after *vm0* and *vm1* have started.

```PowerShell
    Parallel
    {
        Start-AzureRmVM -Name $vm0 -ResourceGroupName $rg 
        Start-AzureRmVM -Name $vm1 -ResourceGroupName $rg
    }

    Start-AzureRmVM -Name $vm2 -ResourceGroupName $rg 

```

Another parallel processing example would be the following constructs that introduce some extra options:

 -  **ForEach -Parallel**. You can use the **ForEach -Parallel** construct to concurrently process commands for each item in a collection. The items in the collection are processed in parallel while the commands in the script block run sequentially.

In the following example, *Activity1* starts at the same time for all items in the collection.

For each item, *Activity2* starts after *Activity1* completes. *Activity3* starts only after both *Activity1* and *Activity2* have been completed for all items.

 -  *ThrottleLimit* \- We use the *ThrottleLimit* parameter to limit parallelism. Too high of a *ThrottleLimit* can cause problems. The ideal value for the *ThrottleLimit* parameter depends on several environmental factors. Try starting with a low *ThrottleLimit* value, and then increase the value until you find one that works for your specific circumstances:

```powershell
ForEach -Parallel -ThrottleLimit 10 ($<item> in $<collection>)
{
    <Activity1>
    <Activity2>
}
<Activity3>

```

A real-world example of it could be similar to the following code: a message displays for each file after it's copied. Only after all files are copied does the completion message display.

```powershell
    Workflow Copy-Files
    {
        $files = @("C:\LocalPath\File1.txt","C:\LocalPath\File2.txt","C:\LocalPath\File3.txt")
   
        ForEach -Parallel -ThrottleLimit 10 ($File in $Files)
        {
            Copy-Item -Path $File -Destination \\NetworkPath
            Write-Output "$File copied."
        }
   
        Write-Output "All files copied."
    }

```
