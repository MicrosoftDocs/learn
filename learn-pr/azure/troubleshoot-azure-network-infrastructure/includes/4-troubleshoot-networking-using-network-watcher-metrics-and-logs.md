4. **Troubleshoot networking using Network Watcher metrics and logs**

In this module, you will focus on flow logs, diagnostic logs and traffic analytics. You will learn how these tools can help to troubleshoot the Azure network. You will also look at the use case scenarios for some of the tools towards the end of the module. These scenarios are a great way of teaching your colleagues how they can use Azure Network Watcher to troubleshoot.


   1.  Usage and quotas - Each Microsoft Azure resource can be used up to its quota. Each subscription has separate quotas and usage is tracked per subscription. Only one instance of Network Watcher is required per subscription per region. This gives you a view of usage and quotas, so you can see if you are at risk of hitting a quota. To view the usage and quota, navigate to **All Services > Networking > Network Watcher**, then scroll to the bottom of the list and select usage and quota. You can view more granular data based on usage and the location where the resources are being used. You can view data for metrics such as...
        - Network interfaces
        - Network security groups
        - Virtual network
        - Public IP address

  1. Logs - Network diagnostic logs provide granular data to better understand connectivity and performance issue.
      - Flow logs - Flow logs allow you to view information about ingress and egress IP traffic on Network Security Groups(NSG). NSG flow logs do not support Storage accounts on classic Azure portal. These flow logs show outbound and inbound flows on a per-rule basis and the NIC the flow applies to. NSG Flow log shows whether traffic was allowed or denied based on the  5-tuple information about the flow 
          - Source IP
          - Source port
          - Destination IP
          - Destination port
          - Protocol

        If you have a large infrastructure in Azure, you may have to view 100+ logs. The data is stored in a JSON file. It can be difficult to gain insights into flow logging data by manually searching the log files. You can leverage Power BI to help visual NSG flow logs. You can view the logs by
         - Top talkers (IP add)
         - Flows by direction
         - Flows by decision
         - Flows by destination port

        There are many more ways to customize PowerBI to match your needs. You can also use open source tools to analyse your logs. To learn more about integrating NSG logs  visit [*visualize NSG flow logs.*](https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-visualize-nsg-flow-logs-power-bis")

      - Diagnostic logs - This is a central place to enable and disable network resource diagnostic logs for Azure networking resources, such as NSGs, public IPs, load balancers, application gateways, and more. This tool only supports Azure network resources that generate diagnostic logs. You often store and view diagnostic logs using Log Analytics.

     - Traffic Analytics – This provides visibility into user and application activity across your cloud networks. The tool gives insights into network activity across subscriptions, security threats (such as open ports), VMs communicating with known bad networks, and traffic flow patterns. Traffic Analytics analyses NSG flow logs across Azure regions and subscriptions and equips you with actionable information to optimize network performance. This tool requires log analytics, which powers it.

  1. Now we are going to look at some use case scenarios for troubleshooting using Azure Network Watcher metrics and logs. The scenarios will be in the format below.

      - A. What the problem is (Title)
      - B. How to troubleshoot that issue using Network Watcher metrics and logs (Paragraph)
      - C. An example solution (Paragraph)

- **Customer reports of slow performance**
  - To resolve the slow performance issues, we need to determine the root cause of the problem.
     - Is it too much traffic throttling our server?
     - Is the VM size appropriate for the job? 
     - Are the scalability threshold set appropriately?
     - Is there any malicious activity going on the server? 
     - Is the VM storage configuration correct?

     To start with we will make sure the VM size is appropriate for the job. Next, we need to enable Azure diagnostics on the VM to get more granular data based on specific metrics (CPU usage, Memory usage etc). To enable VM diagnostics via the portal, go to the VM, click Settings, and then click Diagnostics. We also need to enable storage account diagnostics through the portal. Go the VM select *All Settings* and turn diagnostics on. In order to identify if we have any resource bottlenecks, we will need to review the data. If we find that the machine has been running fine, but it has been reported that the performance has recently degraded. We should review a time range of data that encompasses performance metric data before the reported change, during and after the issue. These graphs can also be useful for cross-referencing difference resource behaviours in the same time period. We will check for...
    - CPU Bottleneck
    - Memory Bottleneck
    - Disk Bottleneck


   - CPU Bottleneck - When looking at performance issues, we need to be aware of the trends and understand if they affect our server. We will use the monitoring graphs from the portal to spot trends. There are different type of trends that you may see on the monitoring graph. 
     - Spiking – This could be related to a scheduled task\known event, if you know what this task is, does it run at the required performance level? If the performance is ok, you may not need to increase resource.
     - Spike up and Constant – Could be a new workload, is it a workload you know, if not you will need to enable monitoring in the VM to find out what process(es) cause this. Once the process is recognized, is the increased consumption caused by inefficient code, or is this normal consumption? If normal consumption, does the process operate at the required performance level?
     - Constant – Has your VM always been like this, or since the diagnostics have been enabled? If so you should identify the process(es) causing this and consider adding more of that resource.
     - Steadily Increasing – Do you see a constant increase in consumption? If so, this could be inefficient code or a process taking on more user work load. 

     If you do observe high CPU utilization, in the case of where your application/process is not running at the correct performance level and you are seeing 95% + CPU utilization constant, you can either:
     - For immediate relief - Increase the size of the VM to a size with more cores
     - Understand the issue – locate application \ process and troubleshoot accordingly.
   
      If you have increased the VM and the CPU is still running 95%, is this offering better performance, higher application throughput to an acceptable level? If not, you will need to troubleshoot that individual application\process.

   - Memory Bottleneck - The memory usage shows you how much memory is being consumed with the VM. You should understand the trend and if it maps to the time you see issues. You should not have less than 100MB of available memory.
     - Spike up /Constant Consumption - Just because you have high memory utilization may not mean it is the cause of bad performance, some applications, such as relational database engines allocate a lot of memory and seeing this may not mean anything. However, if there are multiple memory hungry applications you may be seeing the bad performance because of memory contention causing trimming and paging/swapping to disk. This will be a likely noticeable cause of application performance impact.
     - Steadily Increasing Consumption – This could be an application *warming up*. This is common among database engines starting up. However, this could also be a sign of a memory leak in an application. You should identify the application and understand if it is expected behaviour.
     - Page or Swap File Usage – You should check if you are using the Windows Paging file (located on D:\) or Linux Swap file (located on /dev/sdb) are being heavily used, if you have nothing on these volumes except these files, check for high Read / Writes on those disks. This is then indicative of low memory conditions have or are currently occurring.

     To resolve this high memory utilization, we can either
     - For immediate relief or Page or Swap File Usage - Increase the size of the VM to size with more memory, then monitor.
     - Understand the issue – locate application \ process and troubleshoot for identifying high consuming memory applications. If you know the application, see if the memory allocation can be capped.
    
     If you find that after upgrading to a larger VM and you still have a constant steady increase until 100%. We need to identify the application\process and troubleshoot it.

   - Disk Bottleneck - In order to check the storage subsystem for the VM. We will need to check the diagnostics at the Azure VM level by using the counters in VM Diagnostics and the storage account diagnostics. We will need to go into the storage account for the VM in the portal. For identifying issues with storage, we need to look at performance metrics from the storage account diagnostics and the VM diagnostics. We will look for key trends when the issues occur within the time range of the issue. 
      - To Check for Azure Storage Timeout , we will need to use the metrics ClientTimeOutError, ServerTimeOutError, AverageE2ELatency, AverageServerLatency and TotalRequests. If we see values in the *TimeOutError* metrics an IO operation took too long and timed out, working through the next steps will help identify potential causes. If we see *AverageServerLatency* increase at the same time at the *TimeOutErrors*, then it could be a platform issue, we will then need to raise a case.
      - To check for Azure Storage Throttling - we will need to use the storage account metrics *ThrottlingError*. If we are seeing values for throttling, this means we are being throttled at the storage account level, i.e. your hitting the IOPS limit of the account. You can determine if you are hitting the IOPs threshold by checking the metric TotalRequests.

      To Remediate High Disk Utilization/Latency issues 
       - Optimize VM IO to scale past VHD Limits
       - Increase Throughput and Reduce Latency - If you find that you have a latency sensitive application and require high throughput, then you should migrate your VHDs to Azure Premium storage.

- **Virtual machine firewall rules blocking traffic**
   - To troubleshoot this issue, we will use Network Watcher IP Flow Verify and NSG flow logging to determine whether there is a Network Security Group (NSG) or User-Defined Route (UDR) that is interfering with traffic flow. Run IP Flow Verify, specify the Local VM (IP add and port) you are connecting from and the remote VM  (IP add and port) you are connecting to. Once you hit check, Azure runs a logical test on rules in place. It turns out access is allowed. Next, we will use NSG flow logs to determine if NSG or UDR in the way.  In the portal, navigate to NSGs and under the flow logs settings, select on. Now try to connect to the VM machine again. Connection fails again. We download the flow logs file (JSON). We use Network Watcher traffic analytics to visualize the data. Again it turns out access is allowed, there is not NSG rule in the way. So logically we are allowed to go from local (VM) to remote (VM), we tested this and there are no issues. However when we try to connect the connection fails. 
  - So far we establish that on the network there are no rules that block our traffic. So there must be something locally on the machine.  On the remote VM(destination) disable the firewall, and then test connectivity. It turns out we can connect to the remote VM with the firewall disabled. Verify the firewall settings, and then re-enable the firewall.  

- **Frontend and backend subnet unable to communicate**
   - We know by default all subnets can communicate in Azure. So, there must be configuration change that is blocking communication. Before checking the flow logs, we run an IP flow verify from VM in frontend to VM in the backend. This tool will run a logical test on the rules on the network.
   - It turns out there is NSG on the backend subnet that is blocking all communication. Its incorrectly configured NSG. For security purposes, we need to block some communication with the frontend. The frontend is exposed to the public. By blocking communication to the backend, we limit the amount of exposure in the event of malware or security attack. However, the NSG is incorrectly configured as it is blocking everything. We can enable protocol/port specific communication. We need to enable communication for specific protocols HTTP/HTTPS, SQL.


**Knowledge check**

A. How can you automate remote network monitoring with packet capture?
- Use Azure Traffic Manager 
- Use Azure Load Balancer
-  Use IP flow verify
- Trigger packet capture by setting alerts

B. Which feature helps to see network level topology overview, various interconnections, and associations between network resources in an Azure Resource Group?
- Topology
- Connection troubleshoots
- Role Based Access Control
-  Network Security Group View