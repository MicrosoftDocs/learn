<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m04_resource_virtualization_memory\x-oli-workbook_page\_u03_m04_3_two-level_page_mapping.xml -->
##  Two-Level Page Mapping

Contrary to OSs in traditional systems, with system virtualization, the hypervisor allocates a contiguous addressable memory space for each created VM (not process). This memory space, allocated per a VM, is called _real memory_. In return, each guest OS running in a VM allocates a contiguous, addressable memory space for each process in its real memory. This memory space per process is called virtual memory (the same name as in traditional systems). Each guest OS maps the virtual memories of its processes to the real memory of the underlying VM, while the hypervisor maps the real memories of its VMs to the system physical memory. Clearly, in contrast to traditional OSs, this entails two levels of mappings between <!-- SCG: How do you want to differentiate between an OS that uses multi-level page tables and this two-level page mapping. Without some mention of this I think it could be confusing. --> three types of addresses: virtual, real, and physical. In fact, these virtual-to-real and real-to-physical mappings define system memory virtualization. This basic idea of memory virtualization via two-level page mapping is summarized in Video 3.10:

> [!VIDEO https://youtube.com/embed/Gl0Dw7G9V5U]

_Video 3.10: Memory Virtualization._

![Figure 3.25: Memory virtualization in a native system VM.](../media/native_system_VM.png)

_Figure 3.25: Memory virtualization in a native system VM._


Similar to any general-purpose OS, a guest OS would still own its set of page tables. In addition, the hypervisor would own another set of page tables for mapping real-to-physical addresses. The page tables in the hypervisor are called real map tables. Figure 3.25 demonstrates system memory virtualization in a native system VM. It shows page tables maintained by guest VMs and real map tables maintained by the hypervisor. Each entry in a page table maps a virtual page of a program to a real page in the respective VM. Likewise, each entry in a real map table maps a real page in a VM to a physical page in the physical memory. When a guest OS attempts to establish a valid mapping entry in its page table, it traps to the hypervisor. Subsequently, the hypervisor establishes a corresponding mapping in the relevant VM's real map table. 