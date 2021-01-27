The primary benefits of Windows Server-based iSCSI solutions are cost-efficiency and simplicity. You can take advantage of these benefits in several ways. At the same time, you need to be cognizant of additional considerations that are critical for delivery of successful implementation.

## Common use cases of Windows Server iSCSI

The common use cases of iSCSI in Windows Server include:

- Network or diskless boot. You can rapidly deploy diskless servers by using either boot-capable network adapters or a software loader. You can also save as much as 90 percent of the storage space that you use for operating-system images by using differencing virtual disks. This is ideal for large deployments of identical operating-system images, such as Hyper-V VM-based Virtual Desktop Infrastructure (VDI) or high-performance computing (HPC) clusters.
- Server application storage. Some applications such as Microsoft Exchange Server require block storage. The iSCSI Target Server can provide these applications with continuously available block storage.
- Heterogeneous storage. iSCSI Target Server supports iSCSI initiators that aren't based on Windows operating systems, so you can share storage on servers that are running Windows operating systems in multiple-platform environments.
- Test environments. Windows Server can function as a low-cost network-accessible block storage device in situations when you want to test applications prior to deploying them on SAN storage.

## Considerations for implementing iSCSI

The primary considerations for implementing iSCSI include:

- Network speed and performance. The network speed should be at least 1 Gbps. Many iSCSI networks offer higher bandwidths, with 10 Gbps, 40 Gbps, or even 100 Gbps infrastructure becoming more common.
- High availability. The network infrastructure should be highly available, with redundant network paths between iSCSI initiator and targets.
- Security. The iSCSI solution should provide an appropriate level of security, reflecting criticality and sensitivity of data it delivers. For this purpose, you can use a dedicated, isolated network and iSCSI authentication.
- Workloads. Review the workload-specific recommendations regarding the use of iSCSI storage.
- Infrastructure staff. IT personnel involved in design and implementation of iSCSI solutions must collectively possess expertise in administering Windows Server, networking, storage administrators, and security.
- Application support teams. Application-specific administrators should participate in the design and implementation to map the infrastructure configuration to the workload requirements.
