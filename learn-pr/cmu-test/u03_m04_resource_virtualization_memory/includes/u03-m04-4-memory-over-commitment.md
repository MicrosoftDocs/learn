<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m04_resource_virtualization_memory\x-oli-workbook_page\_u03_m04_4_memory_over-commitment.xml -->

##  Memory Overcommitment

In memory virtualization, the combined total size of real memories can grow beyond the actual size of physical memory. This concept is typically called memory overcommitment. Memory overcommitment ensures that physical memory is highly utilized by active, real memories (assuming multiple VMs running simultaneously). Indeed, without memory overcommitment, the hypervisor can only run VMs with a total size of real memories less than that of the physical memory. For instance, Figure 3.26 shows a hypervisor with 4GB of physical memory and three VMs, each with 2GB of real memory. Without memory overcommitment, the hypervisor can only run one VM because of not having enough physical memory to assign to two VMs at once. Although each VM would require only 2GB of memory, wherein the hypervisor has 4GB of physical memory, this memory cannot be afforded because hypervisors generally require overhead memories (e.g., to maintain various virtualization data structures).

![Figure 3.26: A hypervisor with 4GB of physical memory, enabling three VMs at once with a total of 6GB of real memory.](../media/4GB_physical_memory.png)

_Figure 3.26: A hypervisor with 4GB of physical memory, enabling three VMs at once with a total of 6GB of real memory._


To this end, in practical situations, some VMs might be lightly loaded, while others might be heavily loaded. Lightly loaded VMs can cause some pages to sit idle, while heavily loaded VMs can result in memory page thrashing. To deal with such a situation, the hypervisor can take (or steal) the inactive physical memory pages away from idle VMs and provide them to heavily loaded VMs. As a side effect, hypervisors usually write zeros to the stolen/reclaimed, inactive physical memory pages in order to avert information leaking among VMs. 