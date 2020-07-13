- In the earliest days, either a process fit a memory or it could not be run.
- Virtual memory changed the status quo by allowing a process that cannot fit in physical memory to run as if it essentially fits the memory.
- An indirect inference of virtual memory is that multiple processes that cannot collectively fit a certain physical memory can now run together on this same physical memory.
- The basic idea of virtual memory is that each process is provided with its own _virtual address space_.
- The virtual address space of each process is translated to the _physical address space_ that is used to actually access the physical memory.
- The translation of virtual addresses to physical addresses is maintained in a per-process software data structure called the _page table_.
- In traditional systems (i.e., nonvirtualized environments), the _virtual-to-physical_ translation is called _one-level page mapping_.
- In virtualized environments (i.e., when a hypervisor is involved), the virtual-to-physical translation is extended at least one more level and called _two-level page mapping_.
- The two-level page mapping entails two consecutive translations, _virtual-to-real_ and then _real-to-physical_ translations. In this case, the real address space refers to the memory space of a VM, while the virtual and physical address spaces relate to the traditional memory spaces of processes and the physical memory.
- As a result, memory virtualization in virtualized environments typically is perceived as an extension to the classic virtual memory concept supported in most general-purpose OSs.
- When the combined total size of real memories grows beyond the actual size of the underlying physical memory, _memory overcommitment_ is attained.
- Memory overcommitment improves memory utilization via allowing VMs with aggregate real memories larger than the physical memory to run simultaneously.
- Memory overcommitment, however, necessitates reclaiming inactive real memory pages at VMs and relocating them to the hypervisor when experiencing a physical memory shortage. This is called _reclamation technique_.
- One of the popular reclamation techniques is the _ballooning process_ incorporated in VMware ESXi.

<!-- Moved comment:

- In traditional systems (i.e., nonvirtualized environments), the _virtual-to-physical_ translation is called _one-level page mapping_.

Comment: SCG: or, can be multi-level.

- In virtualized environments (i.e., when a hypervisor is involved), the virtual-to-physical translation is extended at least one more level and called _two-level page mapping_.

-->
