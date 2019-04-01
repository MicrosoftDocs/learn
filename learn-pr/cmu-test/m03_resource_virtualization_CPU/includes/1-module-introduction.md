<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m03_resource_virtualization_CPU\x-oli-workbook_page\_u03_m03_1_intro.xml -->
A key element, which is also one of the more complex parts of virtualization, is CPU virtualization. Virtualizing a CPU entails two major steps:


- Multiplexing a physical CPU (pCPU) among virtual CPUs (vCPUs) associated with virtual machines (VMs); this is called vCPU scheduling.
- Virtualizing the ISA of a pCPU in order to make vCPUs with different ISAs run on this pCPU.
In this module, we present some conditions for virtualizing ISAs. Second, we describe ISA virtualization. Third, we make a distinction between two types of ISA virtualization: full virtualization and paravirtualization. Fourth, we discuss emulation, a major technique for virtualizing CPUs. Fifth, we compare two kinds of VMs: simultaneous multiprocessing (SMP) and uniprocessors (UP) VMs. Finally, we close with a discussion on vCPU scheduling. As examples, we present two popular Xen vCPU schedulers.