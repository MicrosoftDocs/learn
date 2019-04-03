<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m06_case_study\x-oli-workbook_page\_u03_m06_0_taxonomy.xml -->
##  The PV/HVM Spectrum

In the early days of virtualization, hypervisors had to virtualize all of the resources that they provided to a VM, including: page tables (memory), disk, network and other devices, as well as device buses, timers and interrupts. A guest would typically start in 16-bit mode, run a BIOS that loaded the guest kernel and boot into a 32-bit VM. All the privileged instructions executed by the guest kernel had to be emulated, as well as the page tables. Thus, the guest was fooled into thinking that it was running on actual hardware, hence it was fully virtualized.

Virtualizing privileged instructions in this manner was extremely slow, using either full software emulation or even binary translation. Xen's original approach was to allow the guest to know that it was virtualized and implement a special interface just for virtualization. This approach was known as paravirtualization, and it allowed them to replace any instructions that were difficult to virtualize with "hypercalls" into the hypervisor. Hence, guests could boot directly into the kernel and would run with fully paravirtualized disk and network interfaces, only using hypercalls in place of privileged instructions. Such VMs are said to be running in PV mode.

At the same time as the Xen project, Intel and AMD were building in hardware extensions to simplify full virtualization, without requiring software emulation or binary translation. Such VMs are said to be running in HVM mode. Of course, HVM only made the processor easy to virtualize, but still had inefficient interfaces to network and disk.

HVM and PV represented two poles in approaches to virtualization. Both have evolved over time to move closer to each other, borrowing ideas to improve performance. Fully-virtualized HVM systems started by adopting paravirtualized interfaces for disk and network, since fully emulating these third party components is unnecessarily complicated. Xen 3.0 used this mode, known as HVM with PV drivers.

The next bottleneck in HVM systems was the use of emulated interrupt controllers. Instead, guests could choose to use paravirtualized interfaces for interrupts and timers, which were supported for HVM guests. To support this, the Linux kernel was patched to switch from emulated interrupt controllers and timers to the paravirtualized alternatives, when the guest detected that it was running in HVM mode on Xen. This technique, used in Xen 4.0.1 was known as PVHVM, since it ran in HVM mode but used PV interfaces extensively.

Xen made many of its original design choices before the availability of HVM extensions. The latest update on this spectrum uses a fully paravirtualized guest, and only uses HVM extensions to virtualize the page tables, system calls and other privileged operations. This mode is known as PVH (mainly PV, with a bit of HVM), and is expected to combine PV's fast interface and low overhead while maximizing the use of the hardware. 

The spectrum of virtualization modes can be visualized from Figure 3.33.
![Figure 3.33: The HVM-PV spectrum: S indicates a software virtualized resource, H indicates hardware virtualization and P stands for paravirtualizedGreen indicates good performance, yellow is tolerable and red is extremely poor.](../media/PV_HVM_Spectrum.png)

_Figure 3.33: The HVM-PV spectrum: S indicates a software virtualized resource, H indicates hardware virtualization and P stands for paravirtualizedGreen indicates good performance, yellow is tolerable and red is extremely poor._


Now that we have seen how the role of the hypervisor has evolved, let us also look at some different virtualization suites and how they provide a platform for managing virtual infrastructures. These virtualization suites use the hypervisor as one amongst a set of components used to automate processes within private datacenters and clouds.
##  Virtualization Suites

We briefly survey some of the current and common virtualization software suites and distinguish between virtualization suites and hypervisors. Many vendors often use _hypervisor_ and _virtualization suite_<!-- these terms -->interchangeably. As discussed throughout this chapter, a hypervisor is primarily responsible for running multiple virtual machines (VMs) on a single physical host. A virtualization suite comprises various software components and individual hypervisors that enable the management of many physical hosts and VMs. A management component typically issues commands to the hypervisor to create, destroy, manage, and migrate VMs across multiple physical hosts.

The table below shows our taxonomy of four virtualization suites, [vSphere 5.1](http://www.vmware.com), [Hyper-V](http://www.microsoft.com/en-us/server-cloud/hyper-v-server/default.aspx) , [XenServer 6](http://support.citrix.com/product/xens/v6.0/), and [RHEV 3](http://www.redhat.com/promo/rhev3/). Please note that XenServer is a commercial product from Citrix based on the Xen hypervisor, and the version numbers of Xen are not related to those of XenServer. We compare the suites in terms of multiple features, including the involved hypervisor, the virtualization type, the allowable maximum number of vCPUs per VM, the allowable maximum memory size per VM, and whether memory overcommitment, page sharing, and live migration are supported. In addition, we indicate whether the involved hypervisors contain device drivers, and we list some of the popular cloud vendors that utilize such hypervisors.

To elaborate on some of the features, live migration allows running VMs to be seamlessly shifted from one physical machine to another. It enables many management features, such as maintenance, power-efficient dynamic server consolidation, and workload balancing, among others. Page Sharing refers to sharing identical memory pages across VMs. This renders effective when VMs use similar OS instances. Finally, some hypervisors eliminate device drivers entirely at guest OSs and provide direct communications between guest OSs and host OSs collocated with hypervisors (similar to what we discussed in the Section "Xen's Approach to I/O Virtualization").
|Feature|vSphere 5.1|Hyper-V 2012|XenServer 6|RHEV 6|
|--|--|--|--|--|
|Hypervisor Name|ESXi|Hyper-V|Xen|KVM|
|CPU virtualization support|Full virtualization|Paravirtualization|Paravirtualization|Full virtualization|
|Maximum vCPUs per VM|160|320|64|160|
|Maximum Memory per VM|1TB|1TB|128GB|2TB|
|Memory Overcommitment Support|Yes|Yes|Yes|Yes|
|Page Sharing Support|Yes|No|No|No|
|Live Migration Support|Yes|Yes|Yes|Yes|
|Contains Device Drivers|Yes|No|No|Yes|
|Common Cloud Vendors|[vCloud Hybrid Service](http://www.vmware.com/products/vcloud-hybrid-service)|[Microsoft Azure](http://www.windowsazure.com/en-us/)|[Amazon EC2](http://aws.amazon.com/ec2) and [Rackspace](http://www.rackspace.com/)|[IBM SmartCloud](http://www.ibm.com/cloud-computing/us/en/)|


### References

1. _XenProject (2014). Virtualization Spectrum Source: http://wiki.xenproject.org/wiki/Virtualization_Spectrum_