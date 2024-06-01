The Contoso Hyper-V administrator needs to plan for the deployment of various workloads that have different requirements and considerations. Because of this, they should consider the following best practices when they provision Windows Server to function as a Hyper-V host:

- Provision the host with adequate hardware.
- Deploy VMs on separate disks or Cluster Shared Volumes (CSVs). It's strongly suggested to do so with hard disk drives (HDDs). However, with solid state drives (SSDs), it's possible to have multiple running VMs on the same SSD.
- Hyper-V should be the only server role installed on the host server.
- Manage Hyper-V remotely.
- Run Hyper-V by using a Server Core configuration.
- Run the Best Practices Analyzer and use resource metering.
- Use generation 2 VMs if the guest OS supports them.

> [!IMPORTANT]
> These are critical decisions that need to be determined prior to deployment. Failure to correctly determine best practices for your deployments can result in poor performing VMs.

## Provision the host with adequate hardware

Perhaps the most important best practice is to ensure that you provision the Hyper-V host with adequate hardware. Make sure that the Hyper-V host has appropriate processing capacity, enough RAM, and fast and redundant storage. Provision the Hyper-V host with multiple network adapters and designate a team to each group of adapters. A Hyper-V host that's provisioned with inadequate hardware resources will reduce the performance of all the VMs that the server hosts.

## Deploy VMs on separate drives

The host server's OS and the VM files should be stored on separate drives, because:

- Using separate drives minimizes contention by ensuring that any disk read/write operations required by the VM files don't conflict with read/write operations required by the host's OS.

- Using separate drives enables the host's OS volume to grow, without consuming all of the disk space that's available to the VM files.

You should use SSDs where possible because SSDs have faster read-write speeds and consume less power than standard HDDs.

> [!TIP]
> You can further improve performance if you deploy to a disk that uses striping, such as a Redundant Array of Independent Disks (RAID) 1+0 array.

Also, when using shared storage, you can provision multiple VMs on the same logical unit number (LUN) if you use CSVs. However, choosing between separate LUNs for each VM or a shared LUN depends on the VM workload and host configuration.

## Hyper-V should be the only server role installed on the host server

You should ensure that Hyper-V is the only server role installed on the host server. Don't install the Hyper-V role with other roles such as the domain controller or the file server role. Each role you deploy on a server requires resources. When you deploy Hyper-V, you want to ensure that each VM has access to as many of the host's resources as possible.

> [!TIP]
> If you have a requirement to locate multiple roles on the same hardware, deploy the roles as VMs instead of installing them onto the physical host.

## Manage Hyper-V remotely

When you sign in to a server locally, your session consumes server resources. Instead of signing in locally to perform administrative tasks, configure your Hyper-V Server for remote management. This approach enables hosted VMs to utilize as many of the Hyper-V host's resources as possible.

A configuration error on a Hyper-V host can cause downtime for all of the guest VMs. To minimize the potential for disruptive downtime, you should restrict access to the Hyper-V Server so that only administrators who are responsible for VM management can make connections.

## Run Hyper-V by using the Server Core configuration

Managing Hyper-V by using the Server Core configuration provides the following benefits:

- The Server Core configuration of Windows Server minimizes hardware-resource utilization for the host OS. As a result, more hardware resources are made available to the hosted VMs.
- The Server Core requires fewer software updates, which in turn requires fewer restarts.

> [!TIP] 
> During a restart, a Hyper-V host is unavailable, so all of the VMs that the server hosts become unavailable, also. To minimize downtime, consider using a clustered environment to fail over any VMs needing to be restarted from the host. When the original host is available again, you can then live migrate the VMs that the server hosts back to the original host.

## Run Best Practices Analyzer and use resource metering

Use Best Practices Analyzer to identify configuration-specific issues that need to be addressed. You can also use resource metering to monitor how hosted VMs are utilizing their allocated server resources and to determine which VMs use a disproportionate amount of a host's resources.

> [!TIP]
> If the performance of a VM has an adverse impact on the performance of another VM that's on the same Hyper-V host server, consider migrating the VMs to different hosts.

## Use generation 2 VMs if supported by the guest OS

Generation 2 VMs have slightly faster start times than generation 1 VMs. Generation 2 VMs use a simplified hardware model and provide features and functionality such as:

- Pre-Boot Execution Environment (PXE) boot from a standard network adapter
- Hot add/removal of virtual network adapters
- Small Computer System Interface (SCSI) controller boot from attached VHD and DVD
- Secure Boot
- Shielded VMs
