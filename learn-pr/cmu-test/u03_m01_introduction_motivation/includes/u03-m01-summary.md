<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m01_introduction_motivation\x-oli-workbook_page\_u03_m01_summary.xml -->

##  Introduction and Motivation Summary

- Virtualization is at the core of cloud computing. It allows the construction and provision of virtual hardware images (called virtual machines) from underlying physical machines.
- Virtualization enables the cloud computing model by making it possible to offer a range of cloud services, including IaaS, PaaS, and SaaS.
- Virtualization enhances the cloud _elasticity_ by allowing providers/users to expand or contract services either manually or automatically.
- Virtualization provides _resource sandboxing_ by making it difficult for one cloud user to observe or alter another's data and/or activity.
- Virtualization provides _fault containment_ by preventing a software failure at one virtual machine (VM) to propagate to another VM, even if both exist at the same physical machine (PM).
- Virtualization provides _server consolidation_ by allowing multiple VMs to run on a single PM, thereby improving system utilization and reducing costs. 
- Although virtualization allows running multiple VMs side by side, it provides _full isolation_ (i.e., security, resource, and failure isolations).
- Virtualized systems are complex. The key to managing complexity in virtualized systems is by dividing system components into _levels of abstractions_ separated by _well-defined interfaces_.
- In general, system abstractions hide details and ease software development and manageability (e.g., files abstract disks, whereby programmers can simply create, read, and write files without worrying about locations and sizes of cylinders, sectors, and tracks or bandwidth allocations at disk controllers).
- Abstractions can be applied at the hardware and software levels.
- An interface of a system component is defined as set of function calls that allows leveraging the component's functionalities.
- The three most common system interfaces are the _Application Programming Interface_ (API), the _Instruction Set Architecture_ (ISA) interface, and the _Application Binary Interface_ (ABI).
- ISA and ABI are of a special interest in virtualization, wherein they serve in defining VM types. 
- A core task in virtualization is to share (or _multiplex_) the underlying system components (e.g., CPUs, memory) among various VMs.
- In general, resource sharing can be achieved _in time_ (also called _timesharing_) and/or _in space_. 
- Sharing in time allows VMs to take turns in using a resource component (e.g., sharing a physical CPU among the virtual CPUs of a VM), while sharing in space enables each VM to have an exclusive access to a specific portion of a component (e.g., sharing a physical memory among VMs).
- Timesharing and space sharing in multiprocessor systems are typically more involved than their counterparts in uniprocessor systems.
- Timesharing improves system utilization but requires sophisticated scheduling and management mechanisms.
- Space sharing is usually a sub-optimal solution for system utilization but a near-optimal solution for system complexity. 