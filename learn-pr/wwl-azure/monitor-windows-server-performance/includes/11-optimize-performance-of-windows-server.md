Having gathered performance data about your installed Windows Server computers, it's possible you might need to make configuration changes to optimize their performance. It's important that when planning this optimization, you consider the impact of any hardware, workload configuration, and server tuning changes that you intend to make. When optimizing, there are three broad areas you can consider. These are:

- Server hardware

- Server roles

- Server subsystem

## Tune server hardware

When considering server hardware tuning, there are two key areas  to consider. These are:

- Hardware performance

- Hardware power

### Hardware performance

The following list summarizes server hardware performance optimization guidance.

- Processor recommendations:

  - Use 64-bit processors

  - Choose processors with higher frequency processor cores

  - Choose processors with more processor cores

  > [!IMPORTANT]
  > Match and scale the memory and I/O subsystem with the CPU performance, and vice versa

- Cache recommendations:

  - Choose large L2 or L3 processor caches

- Memory and paging storage recommendations:

  - Always install enough memory to eliminate paging

  - Isolate paging file on its own physical disk

  - Use SSDs for the paging disk, and ideally, enable a fault tolerant configuration

- Disk recommendations:

  - Choose high speed HDDs

  - Use SSDs for the UEFI System disk (boot disk)

  - Use SSDs (or high speed flash disks) for read mostly disks with high I/O rates or latency sensitive I/O

  > [!TIP]
  > Consider NVMe SSDs for heavy simultaneous I/O. These provide higher performance with greater command queue depths, more efficient interrupt processing, and greater efficiency for 4KB commands.

- Network and storage adapter recommendations:

  - Always use adapters that are Windows Hardware Certification approved

  - Use 64-bit capable adapters

  - Enable Receive Side Scaling (RSS) on NICs

### Hardware power

The following provides a summary of power considerations. To reduce server power consumption, consider:

- Choosing processors with a lower thermal design point (TDP) rating

- Selecting low power memory, but always consider possible performance tradeoff

- Choosing SSDs as HDDs, with their moving parts, use more power

- Opting for 2.5-inch disks over 3.5-inch disks as the former use less power

- Installing variable-speed fans in power supplies

## Tune server roles

Windows Server provides a large number of roles. From a performance perspective, the key roles to consider are:

- Active Directory Domain Services (AD DS)

- File and Storage Services

- Hyper-V

- Remote Desktop Services

- Web Server

- Windows Server Containers

For guidance on tuning these roles, refer to the Summary unit at the end of this module for additional links.

## Tune server subsystem

When tuning the server subsystem, consider the following key areas:

- Cache and memory management

- Networking

- Software Defined Networking (SDN)

The following table provides high-level guidance on tuning these subsystems.

| Subsystem| Guidance|
| :--- | :--- |
| Cache and memory management| Install sufficient memory and optimize paging by using SSDs.|
| Networking| Enable NIC Teaming and implement RSS. Consider enabling network adapter offload.|
| SDN| Ensure that your Network Controllers are sized appropriately. Enable physical NIC Teaming.|

For detailed guidance on tuning these subsystems, refer to the Summary unit at the end of this module for additional links.

