HANA Large Instances do not come with built-in monitoring tools. Instead, Microsoft offers resources to help you troubleshoot and monitor according to your organization’s requirements, and the Microsoft support team can assist you in troubleshooting technical issues. Monitor HANA Large Instances resources such as CPU, memory, network bandwidth, and storage space using SAP HANA Studio, SAP HANA Cockpit, SAP Solution Manager, and native Linux tools.

SAP HANA on Azure (Large Instances) is no different from any other IaaS deployment, you need to monitor what the OS and the application are doing and how the applications consume the following resources:

 -  CPU
 -  Memory
 -  Network bandwidth
 -  Disk space

As with Azure VMs, you need to determine whether the resource classes named above are sufficient or they get depleted. Here are more details regarding these classes:

 -  **CPU resource consumption**: The ratio of CPU resources that SAP defined for HANA workloads is enforced to make sure that there are enough CPU resources available to work through the data residing in memory. Nevertheless, there might be cases where HANA consumes an excessive amount of CPU resources while executing queries due to misconfiguration issues, such as, for example, missing indexes. This means you should monitor CPU resource consumption of the HANA large instance unit and CPU resources consumed by the specific HANA services.
 -  **Memory consumption**: Is important to monitor memory consumption both from within HANA, and outside of HANA on the unit. Within HANA, monitor how the data is consuming HANA allocated memory in order to stay within the required sizing guidelines of SAP. You also want to monitor memory consumption on the Large Instance level to make sure that additional installed non-HANA software does not consume too much memory, and therefore competes with HANA for memory.
 -  **Network bandwidth**: The Azure VNet gateway limits bandwidth of data moving into the Azure VNet, so it is helpful to monitor the data received by all the Azure VMs within a VNet to determine how close you are to the limits of the Azure gateway SKU you selected. On the HANA Large Instance unit, it also makes sense to monitor incoming and outgoing network traffic.
 -  **Disk space**: Disk space consumption usually increases over time. Most common causes include data volume increases, execution of transaction log backups, storing trace files, and performing storage snapshots. Therefore, it is important to monitor disk space usage and manage the disk space associated with the HANA Large Instance unit.

For the Type II SKUs of the HANA Large Instances, the server comes with the preloaded system diagnostic tools. You can utilize these diagnostic tools to perform the system health check. Run the following command to generate the health check log file at /var/log/health\_check.

```bash
/opt/sgi/health_check/microsoft_tdi.sh

```

When you work with the Microsoft Support team to troubleshoot an issue, you may also be asked to provide the log files by using these diagnostic tools. You can zip the file using the following command.

```bash
tar -czvf health_check_logs.tar.gz /var/log/health_check

```

## Azure Monitor and Log Analytics

You have the option of forwarding logs from HANA Large Instances to Log Analytics via Log Analytics Gateway. In this scenario, HLI uses a locally installed Microsoft Monitoring Agent to forward logs to the Log Analytics Gateway residing in the Azure VM virtual network, which, in turn, forwards data to Log Analytics. The Log Analytics Gateway must have Internet access. For details, refer to [Log Analytics Gateway for Azure Monitor Setup](/services-hub/health/log-analytics-gateway).
