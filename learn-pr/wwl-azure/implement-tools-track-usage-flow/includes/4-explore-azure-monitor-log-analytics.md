
When you run at a cloud scale, you need intelligent logging and monitoring tools that scale to your needs and provide real-time insight into your data.

Azure Monitor is Microsoft's native cloud monitoring solution. Azure Monitor collects monitoring telemetry from different kinds of on-premises and Azure sources.

Azure Monitor provides Management tools, such as those in Azure Security Center and Azure Automation, enabling ingestion of custom log data to Azure.

The service aggregates and stores this telemetry in a log data store optimized for cost and performance.

With Azure Monitor, you can analyze data, set up alerts, and get end-to-end views of your applications. And use machine-learning-driven insights to identify and resolve problems quickly.

:::image type="content" source="../media/azure-monitor-68847a2c.png" alt-text="Screenshot of Azure Monitor and services covering Insights, Visualize, Analyze, Respond and Integrate monitoring.":::


In this tutorial, we'll focus on the Log Analytics part of Azure Monitor. We'll learn how to:

 -  Set up Log Analytics workspace.
 -  Connect virtual machines to a log analytics workspace.
 -  Configure Log Analytics workspace to collect custom performance counters.
 -  Analyze the telemetry-using Kusto Query Language.

## Getting started

1.  You'll need a resource group with one or more virtual machines that you have access to RDP to follow along.
2.  Log into [Azure Shell](https://shell.azure.com/powershell). Execute the command below. It will create a new resource group and log analytics workspace. Take a record of the workspaceid of the log analytics workspace as we'll be using it again.
    
    ```powershell
    $ResourceGroup = "azwe-rg-devtest-logs-001"
    $WorkspaceName = "azwe-devtest-logs-01"
    $Location = "westeurope"
    
    # List of solutions to enable
    $Solutions = "CapacityPerformance", "LogManagement", "ChangeTracking", "ProcessInvestigator"
    
    # Create the resource group if needed
    try {
        Get-AzResourceGroup -Name $ResourceGroup -ErrorAction Stop
    } catch {
        New-AzResourceGroup -Name $ResourceGroup -Location $Location
    }
    
    # Create the workspace
    New-AzOperationalInsightsWorkspace -Location $Location -Name $WorkspaceName -ResourceGroupName $ResourceGroup
    
    # List all solutions and their installation status
    Get-AzOperationalInsightsIntelligencePacks -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName
    
    # Add solutions
    foreach ($solution in $Solutions) {
        Set-AzOperationalInsightsIntelligencePack -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName -IntelligencePackName $solution -Enabled $true
    }
    
    # List enabled solutions
    (Get-AzOperationalInsightsIntelligencePacks -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName).Where({($_.enabled -eq $true)})
    
    # Enable IIS Log Collection using the agent
    Enable-AzOperationalInsightsIISLogCollection -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName
    
    # Windows Event
    New-AzOperationalInsightsWindowsEventDataSource -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName -EventLogName "Application" -CollectErrors -CollectWarnings -Name "Example Application Event Log"
    
    
    ```

3.  Retrieve the Log Analytics workspace secure key.
    
    ```powershell
    Get-AzOperationalInsightsWorkspaceSharedKey `
                        -ResourceGroupName azwe-rg-devtest-logs-001 `
                        -Name azwe-devtest-logs-01
    
    ```

4.  Map existing virtual machines with the Log Analytics workspace. The following query uses the wokspaceid and workspace-secret key of the log analytics workspace to install the Microsoft Enterprise Cloud Monitoring extension onto an existing VM.
    
    ```powershell
    
    $PublicSettings = @{"workspaceId" = "<myWorkspaceId>"}
    $ProtectedSettings = @{"workspaceKey" = "<myWorkspaceKey>"}
    
    Set-AzVMExtension -ExtensionName "Microsoft.EnterpriseCloud.Monitoring" `
        -ResourceGroupName "azwe-rg-devtest-logs-001" `
        -VMName "azsu-d-sql01-01" `
        -Publisher "Microsoft.EnterpriseCloud.Monitoring" `
        -ExtensionType "MicrosoftMonitoringAgent" `
        -TypeHandlerVersion 1.0 `
        -Settings $PublicSettings `
        -ProtectedSettings $ProtectedSettings `
        -Location westeurope
    
    
    ```

5.  Run the script to configure the below-listed performance counters to be collected from the virtual machine.
    
    ```powershell
    #Login-AzureRmAccount
    
    #Instance
    ##################################
    $InstanceNameAll = "*"
    $InstanceNameTotal = '_Total'
    #Objects
    ##################################
    $ObjectCache = "Cache"
    $ObjectLogicalDisk = "LogicalDisk"
    $ObjectMemory = "Memory"
    $ObjectNetworkAdapter = "Network Adapter"
    $ObjectNetworkInterface = "Network Interface"
    $ObjectPagingFile = "Paging File"
    $ObjectProcess = "Process"
    $ObjectProcessorInformation = "Processor Information"
    $ObjectProcessor = "Processor"
    
    $ObjectSQLAgentAlerts = "SQLAgent:Alerts"
    $ObjectSQLAgentJobs = "SQLAgent:Jobs"
    $ObjectSQLAgentStatistics = "SQLAgent:Statistics"
    
    $ObjectSQLServerAccessMethods = "SQLServer:Access Methods"
    $ObjectSQLServerExecStatistics = "SQLServer:Exec Statistics"
    $ObjectSQLServerLocks = "SQLServer:Locks"
    $ObjectSQLServerSQLErrors = "SQLServer:SQL Errors"
    
    $ObjectSystem = "System"
    
    #Counters
    #########################################################
    $CounterCache = "Copy Read Hits %"
    
    $CounterLogicalDisk =
        "% Free Space" `
        ,"Avg. Disk sec/Read" `
        ,"Avg. Disk sec/Transfer" `
        ,"Avg. Disk sec/Write" `
        ,"Current Disk Queue Length" `
        ,"Disk Read Bytes/sec" `
        ,"Disk Reads/sec" `
        ,"Disk Transfers/sec" `
        ,"Disk Writes/sec"
    
    $CounterMemory =
        "% Committed Bytes In Use" `
        ,"Available MBytes" `
        ,"Page Faults/sec" `
        ,"Pages Input/sec" `
        ,"Pages Output/sec" `
        ,"Pool Nonpaged Bytes"
    
    $CounterNetworkAdapter =
        "Bytes Received/sec" `
        ,"Bytes Sent/sec"
    
    $CounterNetworkInterface = "Bytes Total/sec"
    
    $CounterPagingFile =
        "% Usage" `
        ,"% Usage Peak"
    
    $CounterProcess = "% Processor Time"
    
    $CounterProcessorInformation =
        "% Interrupt Time" `
        ,"Interrupts/sec"
    
    $CounterProcessor = "% Processor Time"
    $CounterProcessorTotal = "% Processor Time"
    
    $CounterSQLAgentAlerts = "Activated alerts"
    $CounterSQLAgentJobs = "Failed jobs"
    $CounterSQLAgentStatistics = "SQL Server restarted"
    $CounterSQLServerAccessMethods = "Table Lock Escalations/sec"
    $CounterSQLServerExecStatistics = "Distributed Query"
    $CounterSQLServerLocks = "Number of Deadlocks/sec"
    $CounterSQLServerSQLErrors = "Errors/sec"
    
    $CounterSystem = "Processor Queue Length"
    
    #########################################################
    $global:number = 1 #Name parameter needs to be unique that why we will use number ++ in function
    #########################################################
    
    function AddPerfCounters ($PerfObject, $PerfCounters, $Instance)
    {
        ForEach ($Counter in $PerfCounters)
        {
            New-AzOperationalInsightsWindowsPerformanceCounterDataSource `
                        -ResourceGroupName 'azwe-rg-devtest-logs-001' `
                        -WorkspaceName 'azwe-devtest-logs-01' `
                        -ObjectName $PerfObject `
                        -InstanceName $Instance `
                        -CounterName $Counter `
                        -IntervalSeconds 10 `
                        -Name "Windows Performance Counter $global:number"
            $global:number ++
        }
    }
    
    AddPerfCounters -PerfObject $ObjectLogicalDisk -PerfCounter $CounterLogicalDisk -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectNetworkAdapter -PerfCounter $CounterNetworkAdapter -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectNetworkInterface -PerfCounter $CounterNetworkInterface -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectPagingFile -PerfCounter $CounterPagingFile -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectProcess -PerfCounter $CounterProcess -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectProcessorInformation -PerfCounter $CounterProcessorInformation -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectProcessor -PerfCounter $CounterProcessor -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectProcessor -PerfCounter $CounterProcessorTotal -Instance $InstanceNameTotal
    AddPerfCounters -PerfObject $ObjectSQLAgentAlerts -PerfCounter $CounterSQLAgentAlerts -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLAgentJobs -PerfCounter $CounterSQLAgentJobs -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLAgentStatistics -PerfCounter $CounterSQLAgentStatistics -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLServerAccessMethods -PerfCounter $CounterSQLServerAccessMethods -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLServerExecStatistics -PerfCounter $CounterSQLServerExecStatistics -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLServerLocks -PerfCounter $CounterSQLServerLocks -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSQLServerSQLErrors -PerfCounter $CounterSQLServerSQLErrors -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectSystem -PerfCounter $CounterSystem -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectMemory -PerfCounter $CounterMemory -Instance $InstanceNameAll
    AddPerfCounters -PerfObject $ObjectCache -PerfCounter $CounterCache -Instance $InstanceNameAll
    
    ```

6.  To generate some interesting performance statistics. Download the [HeavyLoad utility](https://www.jam-software.com/heavyload/) (a free load testing utility) and run it on the virtual machine to simulate high CPU, Memory, and IOPS consumption.

## How it works

1.  Log Analytics works by running the Microsoft Monitoring Agent service on the machine. The service locally captures and buffers the events and pushes them securely out to the Log Analytics workspace in Azure.
2.  Log into the virtual machine, navigate to the C:\\Program Files\\Microsoft Monitoring Agent\\MMA, and open the control panel. It will show you the details of the log analytics workspace connected. You also can add multiple log analytics workspaces to publish the log data into various workspaces.

    :::image type="content" source="../media/microsoft-monitoring-agent-properties-c1189ab6.png" alt-text="Screenshot of the Microsoft Monitoring Agent Properties with computer name, property name, and product version information.":::


## Summary

So far, we've created a log analytics workspace in a resource group.

The log analytics workspace has been configured to collect performance counters, event logs, and IIS Logs.

The Microsoft Enterprise cloud monitoring extension has mapped a virtual machine to the log analytics workspace.

HeavyLoad has been used to simulate high CPU, memory, and IOPS on the virtual machine.
