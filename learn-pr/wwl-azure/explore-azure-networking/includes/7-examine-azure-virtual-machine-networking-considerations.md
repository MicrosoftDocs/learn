

Expected network performance (Mbps) and the maximum number of network interfaces supported by each VM SKU are documented in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

Throughput is unaffected by the following factors:

- **Number of network interfaces**: The bandwidth limit is cumulative of all outbound traffic from the virtual machine.
- **Accelerated networking**: Though the feature can be helpful in achieving the published limit, it doesn't change the limit.
- **Traffic destination**: All destinations count toward the outbound limit.
- **Protocol**: All outbound traffic over all protocols counts towards the limit.

## Best networking practices

The following best networking practices are based on existing customer deployments:

- The virtual networks the SAP application is deployed into don't have access to the internet.
- The database VMs run in the same virtual network as the application layer.
- The VMs within the virtual network have a static allocation of the private IP address. This is important when deploying SAP HANA because some configuration attributes for HANA reference IP addresses.
- To separate and isolate traffic to the DBMS VM, assign different NICs to the VM. Every NIC gets a different IP address, and every NIC is assigned to a different virtual network subnet. For example, one NIC can connect to the management subnet, and one NIC to facilitate connectivity from the on-premises network or other Azure virtual networks.
- Traffic restrictions to and from Azure VMs hosting SAP workloads aren't controlled by using operating system firewalls, but rather by using network security groups (NSGs).
- Divide virtual network address space into subnets. Each subnet can be associated with an NSG that defines the access policies for the subnet. Place application servers on a separate subnet so you can secure them more easily by managing the subnet security policies, not the individual servers. Associate NSGs with subnets, rather than individual network adapters to minimize management overhead. When an NSG is associated with a subnet, it applies to all the Azure VMs connected to that subnet. For the listing of ports required by SAP workloads, refer to [TCP/IP Ports of All SAP Products](https://help.sap.com/docs/Security/575a9f0e56f34c6e8138439eefc32b16/616a3c0b1cc748238de9c0341b15c63c.html).

Keep in mind that configuring network virtual appliances in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver, Hybris, or S/4HANA-based SAP system isn't supported. This restriction is for functionality and performance reasons. The communication path between the SAP application layer and the DBMS layer must be a direct one. The restriction doesn't include application security group (ASG) and NSG rules if those ASG and NSG rules allow a direct communication path.

## Other scenarios where network virtual appliances aren't supported

- Communication paths between Azure VMs that represent Linux Pacemaker cluster nodes and SBD devices.
- Communication paths between Azure VMs and Windows Server Scale-Out File Server (SOFS).

Azure VMs can benefit from accelerated networking and Proximity Placement Groups. Use them when you deploy Azure VMs for an SAP workload, especially for the SAP application layer and the SAP DBMS layer.

## Additional points to note about accelerated networking

- A supported VM size without accelerated networking enabled can only have the feature enabled when it's stopped and deallocated.
- SQL Server running with datafiles stored directly on blob storage are likely to greatly benefit from accelerated networking.
- It's possible to have one or more accelerated NICs and a traditional non-accelerated network card on the same VM.
- SAP application server to database server latency can be tested with ABAP report /SSA/CAT -&gt; ABAPMeter.
- Inefficient “chatty” ABAP code or intensive operations such as large Payroll jobs or IS-Utilities Billing jobs have shown significant improvement after enabling accelerated networking.
- To take advantage of accelerated networking in load balancing scenarios, make sure to use Standard Azure load balancer (rather than Basic).
