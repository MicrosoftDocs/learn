Here are some of the important concepts covered in this module:

- Virtualization is a key enabling technology for cloud computing. It allows the provisioning of virtual hardware images (virtual machines, or VMs) from underlying physical machines.
- There are two types of VMs: process VMs and system VMs. VMs created in the cloud are system VMs.
- A system VM provides a complete system environment. An operating system can run in a system VM.
- An underlying physical machine is called a host, and an operating system running in a system VM is called a guest operating system.
- Virtualization enhances cloud elasticity by allowing providers and users to expand or contract services manually or automatically.
- Virtualization provides resource sandboxing by making it difficult for one cloud user to observe or alter another\'s data and activity.
- Virtualization provides fault containment by preventing a software failure in one virtual machine (VM) from propagating to another VM, even if both are hosted on the same physical machine.
- Virtualization supports server consolidation by allowing multiple VMs to run on a single physical machine, thereby improving system utilization and reducing costs.
- Although virtualization allows running multiple VMs side by side on the same host, it provides full isolation (security, resource, and failure isolation) between VMs.
- A VM can run only at a single host at a certain point in time, yet can be migrated to a different host at a different point in time.
- A system VM can offer resources different in quantity and in type than the physical machine that hosts it. For example, a host can contain one Intel IA-32 physical CPU, while a VM can include eight PowerPC virtual CPUs that all map to the single physical CPU.
- In multi-tenant networks, there is a strong need for virtualization, as overlay networks are constructed to allow tenants to flexibly share network resources.
- Networks can be virtualized, too, and virtual networks (VNets) are just as vital to cloud computing as virtual machines.
- Virtual networks can be provisioned, migrated, reconfigured, and snapshotted just like virtual machines.
- Containers are an emerging technology that provide many of the benefits of virtualization without some of the drawbacks.
- Containers abstract operating systems while virtual machines abstract entire machines, including the hardware.
