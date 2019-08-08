If you want to diagnose a problem quickly, you have to understand the information that is available in the Network Watcher logs.

In your engineering company, you want to ensure that your staff can minimize the time it takes to diagnose and resolve any network configuration problem. You want to ensure that they know which information is available in which logs.

In this module, you will focus on flow logs, diagnostic logs, and traffic analytics. You will learn how these tools can help to troubleshoot the Azure network. You will also look at the use case scenarios for some of the tools towards the end of the module. 

## Usage and quotas

Each Microsoft Azure resource can be used up to its quota. Each subscription has separate quotas and usage is tracked per subscription. Only one instance of Network Watcher is required per subscription per region. This instance gives you a view of usage and quotas, so that you can see if you are at risk of hitting a quota. 

To view the usage and quota information, navigate to **All Services > Networking > Network Watcher**, and then select **Usage and quotas**. You can view more granular data based on usage and the location where the resources are being used. You can view data for metrics such as:

- Network interfaces
- Network security groups
- Virtual networks
- Public IP addresses

![Usage and quotas](../media/4-usage-and-quotas.png)

## Logs

Network diagnostic logs provide granular data, which you can use to better understand connectivity and performance issue. There are three log display tools in Network Watcher:

- Flow logs
- Diagnostic logs
- Traffic analytics

Let's look at each of these tools in turn.

### Flow logs

In flow logs you can view information about ingress and egress IP traffic on network security groups (NSGs). These flow logs show outbound and inbound flows on a per-rule basis and the network card that the flow applies to. NSG flow logs shows whether traffic was allowed or denied based on the 5-tuple information about the flow:

- Source IP
- Source port
- Destination IP
- Destination port
- Protocol

This diagram shows the work flow that NSG follows:

![NSG Workflow](../media/4-nsg-rule-flow.png)

If you have a large infrastructure in Azure, you may have to view hundreds of logs. The data in flow logs is stored in a JSON file. It can be difficult to gain insights into flow logging data by manually searching the log files. You can use Power BI to help visualize NSG flow logs. In Power BI, you can view the logs by. for example:

- Top talkers (IP add)
- Flows by direction (inbound and outbound)
- Flows by decision (allowed and denied)
- Flows by destination port

You can also use open-source tools to analyze your logs, such as Elastic Stack, Grafana, and Graylog.

> [!NOTE]
> NSG flow logs do not support storage accounts on the classic Azure portal. 

### Diagnostic logs

In Network Watcher, the Diagnostic Logs tool is a central place to enable and disable logs for Azure networking resources, such as NSGs, public IPs, load balancers, and application gateways. Once you have enabled the logs that interest you, you can use the tools to query and view log entries. 

As for flow logs, you can import diagnostic logs into Power BI and other tools to analyze them.

### Traffic Analytics

Use the Traffic Analytics tool to investigate user and application activity across your cloud networks. 

The tool gives insights into network activity across subscriptions. You can diagnose security threats, such as open ports, VMs communicating with known bad networks, and traffic flow patterns. Traffic Analytics analyzes NSG flow logs across Azure regions and subscriptions. You can use the data to optimize network performance. 

This tool requires log analytics. The Log Analytics workspace must exist in a supported region.

## Use case scenarios

Now let's look at some use case scenarios where Azure Network Watcher metrics and logs can be helpful. 

### Customer reports of slow performance

To resolve slow performance issues, we need to determine the root cause of the problem:

- Is there it too much traffic throttling our server?
- Is the VM size appropriate for the job? 
- Are the scalability thresholds set appropriately?
- Are there any malicious attacks happening? 
- Is the VM storage configuration correct?

First, check that the VM size is appropriate for the job. Next, enable Azure Diagnostics on the VM to get more granular data for specific metrics, such as CPU usage and memory usage. To enable VM diagnostics via the portal, go to the **VM**, click **Diagnostics  Settings**, and then turn on diagnostics. 

In order to identify if we have any resource bottlenecks, we will need to review the data. If we find that the machine has been running fine, but it has been reported that the performance has recently degraded, we should review a time range of data before, during, and after the issue. These graphs can also be useful for cross-referencing difference resource behaviors in the same time period. We will check for:

- CPU bottlenecks
- Memory bottlenecks
- Disk bottlenecks

#### CPU bottlenecks

When looking at performance issues, examine trends and understand if they affect our server. Use the monitoring graphs from the portal to spot trends. There are different types of trends that you may see on the monitoring graph:

- **Isolated spikes**. A spike could be related to a scheduled task or expected event. If you know what this task is, does it run at the required performance level? If the performance is OK, you may not need to increase capacity.
- **Spike up and constant**. This trend could be caused by a new workload. Is it a workload you aware of? If not, enable monitoring in the VM to find out what processes cause the load. Is the increased consumption caused by inefficient code, or is this normal consumption? If it is normal consumption, does the process operate at the required performance level?
- **Constant**. Has your VM always been like this? If so you should identify the processes that consume most resources and consider adding more capacity.
- **Steadily increasing**. Do you see a constant increase in consumption? If so, this trend could indicate inefficient code or a process taking on more user workload.

If you do observe high CPU utilization, you can either:

- Increase the size of the VM to size with more cores
- Investigate the issue further. Locate the application and process and troubleshoot accordingly.
   
If you have increased the VM and the CPU is still running at above 95%, is this offering better performance or higher application throughput to an acceptable level? If not, troubleshoot that individual application.

#### Memory bottleneck

The memory usage shows you how much memory is being consumed with the VM. Use logs to understand the trend and if it maps to the time you see issues. You should not have less than 100 MB of available memory at any time. Watch out for the following trends:

- **Spike up and constant consumption**. Just because you have high memory utilization may not mean it is the cause of bad performance. Some applications, such as relational database engines, are memory intensive by design. However, if there are multiple memory hungry applications, you may see bad performance because memory contention causes trimming and paging to disk. These processes will cause a negative performance impact.
- **Steadily increasing consumption**. This trend could be an application *warming up*. It is common when database engines starting up. However, it could also be a sign of a memory leak in an application. Identify the application and understand if it is expected behavior.
- **Page or swap file usage**. Check if you are using the Windows Paging file heavily, or the Linux swap file, located on /dev/sdb.

To resolve this high memory utilization, consider these solutions:

- For immediate relief or page file usage, increase the size of the VM to add memory, then monitor.
- Investigate the issue further. Locate that application or process and troubleshoot it. If you know the application, see if the memory allocation can be capped.
    
#### Disk bottleneck

In order to check the storage subsystem for the VM, check the diagnostics at the Azure VM level by using the counters in VM Diagnostics and the storage account diagnostics. Investigate the storage account for the VM in the portal. To identify issues with storage, look at performance metrics from the storage account diagnostics and the VM diagnostics. Look for key trends when the issues occur within the time range of the issue.

- To check for Azure Storage timeout, use the metrics **ClientTimeOutError**, **ServerTimeOutError**, **AverageE2ELatency**, **AverageServerLatency**, and **TotalRequests**. If you see values in the **TimeOutError** metrics, an IO operation took too long and timed out. If you see **AverageServerLatency** increase at the same time as the **TimeOutErrors**, then it could be a platform issue: Raise a case with Microsoft technical support.
- To check for Azure storage throttling, use the storage account metric **ThrottlingError**. If you see throttling, you are hitting the IOPS limit of the account. You can check this problem investigating the metric **TotalRequests**.

To remediate high disk utilization and latency issues: 

- Optimize VM IO to scale past Virtual Hard Disk (VHD) limits.
- Increase throughput and reduce latency. If you find that you have a latency sensitive application and require high throughput, then migrate your VHDs to Azure Premium storage.

#### Virtual machine firewall rules blocking traffic

To troubleshoot this issue, use the Network Watcher IP Flow Verify tool and NSG flow logging to determine whether there is an NSG or UDR that is interfering with traffic flow. 

Run IP Flow Verify and specify the Local VM and the remote VM. Once you click **Check**, Azure runs a logical test on rules in place. If the result is that access is allowed, next use NSG flow logs. 

In the portal, navigate to NSGs and under the flow logs settings, select **On**. Now try to connect to the VM again. Use Network Watcher traffic analytics to visualize the data. If the result is that access is allowed, there is no NSG rule in the way. 

If you have reached this point and still not diagnosed the problem, then there must be something wrong locally on the VM.  On the remote VM, disable the firewall, and then test connectivity. If the results it that you can connect to the remote VM with the firewall disabled, verify the firewall settings. Then re-enable the firewall.

#### Frontend and backend subnet unable to communicate

By default all subnets can communicate in Azure. So, if two VMs on two subnets cannot communicate, there must be configuration that is blocking communication. Before checking the flow logs, run the IP Flow Verify tool from the frontend VM to the backend VM. This tool runs a logical test on the rules on the network.

If the result is that there is an NSG on the backend subnet that is blocking all communication, reconfigure that NSG. For security purposes, you must block some communication with the frontend because the frontend is exposed to the public internet. By blocking communication to the backend, we limit the amount of exposure in the event of a malware or security attack. However, if the NSG blocks everything, then it is incorrectly configured. Enable the sepcifc protocols and ports that are required. 