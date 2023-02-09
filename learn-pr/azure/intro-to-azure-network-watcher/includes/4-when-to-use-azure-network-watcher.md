Azure Network Watcher is useful when you're attempting to troubleshoot networking issues related to Azure IaaS products. For example, you can use the tools included in Azure Network Watcher in the following scenarios: 

- Resolve connectivity issues related to IaaS VMs.
- Troubleshoot VPN connections.
- Determine cross region network latencies.

## Resolve connectivity issues related to IaaS VMs

A Windows Server IaaS VM has recently been deployed to Azure. The developers who deployed the VM are unable to establish a remote PowerShell session to this IaaS VM from another IaaS VM on the same virtual network.  

You can troubleshoot this issue using the IP flow verify tool. This tool lets you specify a local and remote port, the protocol (TCP/UDP), the local IP, and the remote IP to check the connection status. It also lets you specify the direction of the connection (inbound or outbound). IP flow verify runs a logical test on the rules in place on your network.

In this case, you can use IP flow verify to specify the VM's IP address and the TCP port 5986 (used by PowerShell when using HTTPS). Then, specify the remote VM's IP address and port. Choose the TCP protocol, then select **Check**. If an NSG rule is blocking traffic, the IP flow verify rule reports which rule is responsible for the dropped traffic.

## Troubleshoot VPN connections

An IaaS VM has been deployed on an Azure virtual network. Connections to this IaaS VM from on-premises hosts are made through a site-to-site VPN connection.

You can troubleshoot this VPN connection using the Azure VPN troubleshoot tool. This tool runs diagnostics on a virtual network gateway connection, and returns a health diagnosis. You can run this tool from the Azure portal, PowerShell, or the Azure CLI.

When you run the tool, it checks the gateway for common issues and returns the health diagnosis. You can also view the log file to get more information. The diagnosis will show whether the VPN connection is working. If the VPN connection isn't working, VPN troubleshoot will suggest ways to resolve the issue.

## Determine cross-region network latency

You can use Network Watcher tools to determine the best location to place IaaS resources based on network latencies. For example, you can use Network Watcher tools to have IaaS VMs in different regions regularly ping each other to determine cross region network latency. This can allow you to determine whether IaaS VMs need to be all located in a single region, or if you can have them spread across different regions to support specific application architectures.  

You could also use Network Watcher if you have an on-premises hybrid application and an application running in an Azure IaaS VM that connect to the same storage account endpoint and you want to perform a comparison of latencies. If the latency for the on-premises application is too high, this might strengthen a case for migrating that application to Azure. If the latency for the Azure IaaS VM is too high, this might strengthen a case for migrating the VM to another region with lower latency.

## When not to use Network Watcher

Network Watcher tools provide intermediate levels of network diagnostic functionality. These tools don't provide some of the advanced features available in some third-party tools. If your organization needs access to this advanced functionality, you may need to deploy a third-party tool that includes this advanced functionality to accomplish your diagnostic goals.  

It's important to realize that Network Watcher is mostly used for IaaS resources on Azure virtual networks and that you can't use Azure Network Watcher to diagnose connectivity issues related to PaaS services or Web analytics. If you're encountering problems related to these services, you should check the Azure status or service health dashboard.
