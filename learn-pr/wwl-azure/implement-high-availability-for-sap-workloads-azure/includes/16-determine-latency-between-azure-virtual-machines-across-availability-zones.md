To determine the latency between the different zones, you need to:

- Deploy the virtual machine SKU you want to use for your DBMS instance in all three zones. Make sure Azure Accelerated Networking is enabled when you take this measurement.
- When you find the two zones with the least network latency, deploy another three virtual machines of the virtual machine SKU that you want to use as the application layer virtual machine across the three availability zones. Measure the network latency against the two DBMS virtual machines in the two DBMS zones that you selected.
- Use niping as a measuring tool. This tool, from SAP, is described in [SAP Note \#500235](https://me.sap.com/notes/500235) and [SAP Note \#1100926](https://me.sap.com/notes/1100926). Focus on the commands documented for latency measurements. Ping isn't recommended in such scenarios because it doesn't work through the Azure Accelerated Networking code paths.

Based on your measurements and the availability of your virtual machine SKUs in the availability zones, you need to make some decisions:

- Define the ideal zones for the DBMS layer.
- Determine whether you want to distribute your active SAP application layer across one, two, or all three zones, based on differences of network latency in-zone versus across zones.
- Determine whether you want to deploy an active/passive configuration or an active/active configuration, from an application point of view.

In making these decisions, also consider SAP's network latency recommendations, as documented in [SAP Note \#1100926](https://me.sap.com/notes/1100926).

The measurements and decisions you make are valid for the Azure subscription you used when you took the measurements. If you use another Azure subscription, you need to repeat the measurements. The mapping of enumerated zones might be different for another Azure subscription.

It's expected that the measurements described earlier will provide different results in every Azure region that supports availability zones. Even if your network latency requirements are the same, you might need to adopt different deployment strategies in different Azure regions because the network latency between zones can be different. In some Azure regions, the network latency among the three different zones can be vastly different. In other regions, the network latency among the three different zones might be more uniform. The claim that there's always a network latency between 1 millisecond and 2 milliseconds isn't correct. The network latency across availability zones in Azure regions can't be generalized.

One of the limitations of using availability zones for SAP system deployments is that you can’t deploy the SAP application layer by using availability sets within the specific zone. Following these guidelines can help bypass this limitation:

- Create a proximity placement group.
- Deploy your anchor virtual machine, usually the DBMS server, by referencing an availability zone.
- Create an availability set that references the Azure proximity group.
- Deploy the application layer virtual machines by referencing the availability set and the proximity placement group.

> [!IMPORTANT]
> Availability zones introduce "cross zone" charges for network traffic. Additionally, the added latency will show up in overall performance numbers for the system.

> [!IMPORTANT]
> Application layer VMs disks aren't guaranteed to be allocated in the same availability zone as the VMs are directed to using the proximity placement group. The deployment may have VMs allocated in the same network spine and with that the same availability zone as the anchor VM. But the respective disks (base VHD and mounted Azure block storage disks) may not be allocated under the same network spine or even the same availability zone. Instead the disks of those VMs can be allocated in **any** datacenters of the specific region. Though the disks of the anchor VM deployed by defining a zone are deployed in the same zone as the VM.
