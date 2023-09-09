
Connection Monitor provides unified, end-to-end connection monitoring in Azure Network Watcher. The Connection Monitor feature supports hybrid and Azure cloud deployments. Network Watcher provides tools to monitor, diagnose, and view connectivity-related metrics for your Azure deployments.

You can use Connection Monitor in the following scenarios:

- You can check network connectivity between the two VMs in a two-tier application to ensure that the front-end web server virtual machine (VM) is able to communicate with a VM hosting a database server VM.
- You want to calculate cross-region latencies between VMs deployed in different regions, for example, VMs in the Australia Southeast region with VMs deployed in the Central US region.
- You want to compare the latencies for branch office sites for Microsoft 365 URLs.
- You want to compare the latencies of an on-premises site with the latencies of an Azure application in terms of a connection to an Azure storage account endpoint.
- You want to check the connectivity between your on-premises setups and the Azure VMs that host your cloud application.
- You want to check the connectivity from multiple instances of an Azure Virtual Machine Scale Set to your Non-Azure multi-tier application.

## Diagnosing network issues

Connection Monitor helps you diagnose issues in your connection monitor and your network. Issues in your hybrid network are detected by the Log Analytics agents that you installed earlier. Issues in Azure are detected by the Network Watcher extension.

For networks whose sources are on-premises VMs, the following issues can be detected:

- Request timed out.
- Endpoint not resolved by DNS – temporary or persistent. URL invalid.
- No hosts found.
- Source unable to connect to destination. Target not reachable through ICMP.
- Certificate-related issues including:
	- Client certificate required to authenticate agent
	- Certificate revocation list isn't accessible
	- Host name of the endpoint doesn't match the certificate's subject or subject alternate name
	- Root certificate is missing in source's Local Computer Trusted Certification Authorities store
	- SSL certificate is expired, invalid, revoked, or incompatible.

For networks whose sources are Azure VMs, the following issues can be detected:

- Agent issues including:
	- Agent stopped
	- Failed DNS resolution
	- No application or listener listening on the destination port and Socket could not be opened.
- VM state issues including:
	- Starting
	- Stopping
	- Stopped
	- Deallocating
	- Deallocated
	- Rebooting
	- Not allocated
- ARP table entry is missing.
- Traffic was blocked because of local firewall issues or NSG rules.
- Virtual network gateway issues including:
	- Missing routes
	- The tunnel between two gateways is disconnected or missing
	- The second gateway wasn't found by the tunnel
	- No peering info was found
	- The route was missing in Microsoft Edge
	- Traffic stopped because of system routes or user-defined route (UDR)
	- Border Gateway Protocol (BGP) isn't enabled on the gateway connection
	- The dynamic IP address (DIP) probe is down at the load balancer.

## Configuring Connection Monitor

To use Connection Monitor to measure a specific scenario, you need to perform the following general steps:

1. Install monitoring agents.
1. Create a connection monitor.
1. Analyze monitoring data and set alerts.
1. Diagnose issues in your network.

## Install monitoring agents

Connection Monitor relies on lightweight executable files to run connectivity checks. It supports connectivity checks from both Azure environments and on-premises environments. The executable file that you use depends on whether your VM is hosted on Azure or on-premises.

Connection Monitor can use your Azure VMs or virtual machine scale sets as monitoring sources if the Network Watcher Agent virtual machine extension is installed on them. This extension is also known as the Network Watcher extension. This extension allows end-to-end monitoring and other advanced functionality.

Rules for a network security group (NSG) or firewall can block communication between the source and destination. Connection Monitor detects this issue and shows it as a diagnostics message in the topology. To enable connection monitoring, ensure that the NSG and firewall rules allow packets over TCP or ICMP between the source and destination.

To make Connection Monitor recognize your on-premises machines as sources for monitoring, install the Log Analytics agent on the machines. Then, enable the Network Performance Monitor solution. These agents are linked to Log Analytics workspaces, so you need to set up the workspace ID and primary key before the agents can start monitoring.

## Create a connection monitor

In connection monitors that you create in Connection Monitor, you can add both on-premises machines and Azure VMs/ scale sets as sources. These connection monitors can also monitor connectivity to endpoints. The endpoints can be on Azure or any other URL or IP address.

Connection Monitor includes the following entities:

- Connection monitor resource: A region-specific Azure resource. All the following entities are properties of a connection monitor resource.
- Endpoint: A source or destination that participates in connectivity checks. Examples of endpoints include Azure VMs/ scale sets, on-premises agents, URLs, and IP addresses.
- Test configuration: A protocol-specific configuration for a test. Based on the protocol you select, you can define the port, thresholds, test frequency, and other properties.
- Test group: The group that contains source endpoints, destination endpoints, and test configurations. A connection monitor can contain more than one test group.
- Test: The combination of a source endpoint, destination endpoint, and test configuration. A test is the most granular level at which monitoring data is available. The monitoring data includes the percentage of checks that failed and the round-trip time (RTT).

To create a connection monitor, perform the following steps:

1. In the Azure portal, go to Network Watcher.
1. On the left pane, in the **Monitoring** section, select **Connection monitor**.
1. On the **Connection Monitor** dashboard, select **Create**.
1. On the Basics pane, enter the following details:
    - Connection Monitor Name: Enter a name for your connection monitor. Use the standard naming rules for Azure resources.
    - Subscription: Select a subscription for your connection monitor.
    - Region: Select a region for your connection monitor. You can select only the source VMs that are created in this region.
    - Workspace configuration: Choose a custom workspace or the default workspace. Your workspace holds your monitoring data. To choose a custom workspace, clear the default workspace checkbox, and then select the subscription and region for your custom workspace.
5. Select **Next**: 
1. On the **Test groups** page, either select an existing test group or create a new one.  To create a test group, provide the following information:
    - Test group Name: Enter the name of your test group.
    - Sources: Select **Add sources** to specify both Azure VMs and on-premises machines as sources if agents are installed on them. 
        - When you select a virtual network, subnet, a single VM, or a virtual machine scale set, the corresponding resource ID is set as the endpoint. By default, all VMs in the selected virtual network or subnet participate in monitoring. To reduce the scope, either select specific subnets or agents or change the value of the scope property.
        - To choose on-premises agents, select the **Non–Azure endpoints** tab. Select from a list of on-premises hosts with a Log Analytics agent installed. Select **Arc Endpoint** as the Type and select the subscriptions from the Subscription dropdown list. The list of hosts that have the Azure Arc endpoint extension and the Azure Monitor Agent extension enabled are displayed.
        - To choose public endpoints as destinations, select the **External Addresses** tab. The list of endpoints includes Office 365 test URLs and Dynamics 365 test URLs, grouped by name. You also can choose endpoints that were created in other test groups in the same connection monitor.
        - To add an endpoint, at the upper right, select **Add Endpoint**, and then provide an endpoint name and URL, IP, or FQDN.
7. The next step is to configure Alerts. Alerts allow you to be notified if tests are failing. When you create an alert, you need to specify which connection monitor test failure will trigger the alert. Specify an action group to determine what happens when the alert triggers.
1. At the bottom of the pane, select **Next: Review + create**.

## Analyze monitoring data

While monitoring endpoints, Connection Monitor re-evaluates the status of endpoints once every 24 hours. So, in case a VM gets deallocated or is turned-off during a 24-hour cycle, Connection Monitor would report an indeterminate state due to absence of data in the network path till the end of the 24-hour cycle before re-evaluating the status of the VM and reporting the VM status as deallocated.

Depending on the data that the checks return, tests can have the following states:

- Pass: Actual values for the percentage of failed checks and round-trip time (RTT) are within the specified thresholds.
- Fail: Actual values for the percentage of failed checks or RTT exceeded the specified thresholds. If no threshold is specified, a test reaches the Fail state when the percentage of failed checks is 100.
- Warning:
	- If a threshold is specified and Connection Monitor observes a checks-failed percentage that's more than 80 percent of the threshold, the test is marked as Warning.
	- In the absence of specified thresholds, Connection Monitor automatically assigns a threshold. When that threshold is exceeded, the test status changes to Warning. For RTT in TCP or ICMP tests, the threshold is 750 milliseconds (ms). For the checks-failed percentage, the threshold is 10 percent.
- Indeterminate: No data in the Log Analytics workspace. Check the metrics.
- Not Running: Disabled by disabling the test group.

The data that Connection Monitor collects is stored in the Log Analytics workspace. You set up this workspace when you created the connection monitor.

Monitoring data is also available in Azure Monitor Metrics. You can use Log Analytics to keep your monitoring data for as long as you want. Azure Monitor stores metrics for only 30 days by default.