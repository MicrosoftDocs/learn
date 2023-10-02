IT pros often automate management tasks for their multi-device environments by running sequences of long-running tasks or workflows.

These tasks can affect multiple managed computers or devices at the same time.

PowerShell Workflow lets IT pros and developers apply the benefits of Windows Workflow Foundation with the automation capabilities and ease of using Windows PowerShell.

> [!TIP]
> Refer to [A Developer's Introduction to Windows Workflow Foundation (WF) in .NET 4](/previous-versions/dotnet/articles/ee342461%28v=msdn.10%29) for more information.

Windows PowerShell Workflow functionality was introduced in Windows Server 2012 and Windows 8 and is part of Windows PowerShell 3.0 and later.

Windows PowerShell Workflow helps automate distribution, orchestration, and completion of multi-device tasks, freeing users and administrators to focus on higher-level tasks.

## Activities

An **activity** is a specific task that you want a workflow to do. Just as a script is composed of one or more commands, a workflow is composed of activities carried out in sequence.

You can also use a script as a single command in another script and use a workflow as an activity within another workflow.

## Workflow characteristics

A workflow can:

 -  Be long-running.
 -  Be repeated over and over.
 -  Run tasks in parallel.
 -  Be interrupted—can be stopped and restarted, suspended, and resumed.
 -  Continue after an unexpected interruption, such as a network outage or computer/server restart.

## Workflow benefits

A workflow offers many benefits, including:

 -  Windows PowerShell scripting syntax. Is built on PowerShell.
 -  Multidevice management. Simultaneously apply workflow tasks to hundreds of managed nodes.
 -  Single task runs multiple scripts and commands. Combine related scripts and commands into a single task. Then run the single task on multiple computes. The activity status and progress within the workflow are visible at any time.
 -  Automated failure recovery.
     -  Workflows survive both planned and unplanned interruptions, such as computer restarts.
     -  You can suspend a workflow operation, then restart or resume the workflow from the point it was suspended.
     -  You can author checkpoints as part of your workflow so that you can resume the workflow from the last persisted task (or checkpoint) instead of restarting the workflow from the beginning.
 -  Connection and activity retries. You can retry connections to managed nodes if network-connection failures occur. Workflow authors can also specify activities that must run again if the activity cannot be completed on one or more managed nodes (for example, if a target computer was offline while the activity was running).
 -  Connect and disconnect from workflows. Users can connect and disconnect from the computer running the workflow, but the workflow will remain running. For example, suppose you're running the workflow and managing the workflow on two different computers. In that case, you can sign out of or restart the computer from which you're managing the workflow and continue to monitor workflow operations from another computer without interrupting the workflow.
 -  Task scheduling. You can schedule a task to start when specific conditions are met, as with any other Windows PowerShell cmdlet or script.
