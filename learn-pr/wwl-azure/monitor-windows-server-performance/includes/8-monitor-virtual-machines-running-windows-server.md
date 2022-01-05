Server virtualization has been part of the Windows Server operating system since the release of Windows Server 2008 and the introduction of the Hyper-V role. Many organizations have migrated some or all their server workloads to virtual machines (VMs) that are running virtualization servers. From a monitoring perspective, it's important to remember that servers running as guest VMs consume resources in the same way as physical host–server computers.

## Why monitor VMs?

With Hyper-V server virtualization, you can create separate VMs and run them concurrently by using the resources of the operating system that's running on a single physical server. The operating systems running within each VM are guests, while the computer that's running Hyper-V is the host.

Guest VMs function as physical computers. Guest VMs that are hosted on the same hypervisor remain independent from one another.

> [!TIP]
> If the host server has enough resources, you can simultaneously run multiple VMs that are using different operating systems on a host server.

When you create a VM, you configure characteristics that define the available resources for that guest. These resources include memory, processors, disk configuration, and network adapter configuration. These VMs operate within the boundaries of the resources that you allocate to them, and they can suffer from the same performance bottlenecks as host servers. Therefore, it's important to monitor VMs in the same way you monitor host servers.

> [!IMPORTANT]
> In addition to monitoring guest VMs, always remember that you must monitor the host that runs them.

## How can you monitor VMs?

Microsoft provides a tool, Hyper-V Resource Metering, that enables you to monitor resource consumption on VMs. Hyper-V Resource Metering allows you to track the resource utilization of VMs hosted on Windows Server computers that have the Hyper-V role installed.

With Hyper-V Resource Metering, you can measure the following parameters on individual Hyper-V VMs:

- Average graphics processing unit (GPU) use

- Average physical memory use, including:

  - Minimum memory use

  - Maximum memory use

- Maximum disk-space allocation

- Incoming network traffic for a network adapter

- Outgoing network traffic for a network adapter

By measuring how much of these resources each VM uses, an organization can bill departments or customers based on their hosted VM use rather than charging a flat fee per VM. An organization with only internal customers can also use these measurements to observe patterns of use and to plan future expansions.

You perform resource-metering tasks by using Windows PowerShell cmdlets with the Hyper-V module for Windows PowerShell. There's no graphical user interface (GUI) tool to perform this task. You can use the following cmdlets to perform resource metering tasks:

- **Enable-VMResourceMetering**. This cmdlet starts collecting data on a per-VM basis.

- **Disable-VMResourceMetering**. This cmdlet disables resource metering on a per-VM basis.

- **Reset-VMResourceMetering**. This cmdlet resets VM resource-metering counters.

- **Measure-VM**. This cmdlet displays resource-metering statistics for a specific VM.

> [!TIP]
> To install the Hyper-V module for PowerShell, run the ` Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Management-PowerShell` command.

Typical output from the `measure-VM` cmdlet is displayed in the following screenshot.

![The screenshot displays a Command window where the output that results from running the measure-VM PowerShell cmdlet is displayed. This command is part of Hyper-V Resource Metering functionality and in the screenshot typical values for tracking resource utilization of VMs are displayed, such as CPU, RAM, disk, and network throughput.](../media/measure-virtual-machine.png)

