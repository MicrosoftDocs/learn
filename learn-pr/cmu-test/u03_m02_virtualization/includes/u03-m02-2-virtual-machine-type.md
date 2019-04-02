<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m02_virtualization\x-oli-workbook_page\_u03_m02_2_virtual_machine_type.xml -->
##  Virtual Machine Types

There are two main implementations of virtual machines (VMs): process VMs and system VMs. The following video (Video 3.4) covers the taxonomy of Virtual Machine Types:
> [!VIDEO https://youtube.com/embed/15DGinFJwFg]


We first cover process VMs and then system VMs.
##  Process Virtual Machines
![Figure 3.14: Process virtual machine (VM).](../media/process_vm.png)

_Figure 3.14: Process virtual machine (VM)._


A process VM is a VM capable of supporting an individual process as long as the process is alive. Figure 3.14 demonstrates process VMs. A process VM terminates when the hosted process ceases. From a process VM perspective, a machine consists of a virtual memory address space, user-level registers, and instructions assigned to a process to execute a user program. According to this definition, a process in a general-purpose OS can also be called a machine. However, a regular process in an OS can only support user program binaries compiled for the ISA of the host machine. That is, executing binaries compiled for an ISA different than that of the host machine is not supported by regular processes. Conversely, a process VM allows that to happen. Process VMs can support ISAs that differ from host ISAs via emulation. As shown in Figure 3.15, emulation is the process of allowing the interfaces and functionalities of one system (the source) to be implemented on a system with different interfaces and functionalities (the target). Emulation is discussed in detail later. The abstraction of the process VM is provided by a piece of virtualizing software called the runtime (see Fig. 3.14). The runtime is placed at the Application Binary Interface (ABI) on top of the host OS and the underlying hardware. It is this runtime that emulates the VM instructions and/or system calls when guest and host ISAs are different.
![Figure 3.15: The emulation process.](../media/emulation_process.png)

_Figure 3.15: The emulation process._


Finally, a process VM may not directly correspond to any physical platform; it is employed mainly to offer cross-platform portability. Such kinds of process VMs are called high-level language VMs (HLL VMs). An HLL VM abstracts away details of the underlying hardware resources and the OS and allows programs to run the same way on any platform. Java VM (JVM) and Microsoft Common Language Infrastructure (CLI) are examples of HLL VMs. In summary, a process VM is similar to a regular process running on an OS. However, a process VM allows, via emulation, the execution of an application compiled for an ISA different than that of the host machine.
##  System Virtual Machines

Contrary to process VMs, a system VM is a VM capable of virtualizing a full set of hardware resources, including processors, memories, and I/O devices, thus providing a complete system environment. A system VM can support an OS along with its associated processes as long as the system environment is alive. Figure 3.16 illustrates system VMs. As defined previously, the hypervisor (or the VM monitor [VMM]) is a piece of software that provides the abstraction for the system VM. It can be placed at the ISA level directly on top of the raw hardware and below system images (e.g., OSs). The hardware resources of the host platform can be shared among multiple guest VMs. The hypervisor manages the allocation of and access to the hardware resources by the guest VMs. In practice, the hypervisor provides an elegant way to logically isolate multiple guest VMs sharing a single physical system. Each guest VM is given the illusion of acquiring all of the underlying hardware resources.
![Figure 3.16: System virtual machine (VM).](../media/system_vm.png)

_Figure 3.16: System virtual machine (VM)._


There are different classes of system VMs. Figure 3.17 exhibits three of these classes as well as traditional systems. In a conventional time-shared system, the OS runs in a privileged mode (system mode), while the applications associated with it run in unprivileged mode (user mode) (more details on system privileges are discussed later). With system virtualization, however, the guest OS(s) might run in unprivileged mode, while the hypervisor operates in a privileged mode. Such a system is called a native system VM. In a native system VM, every privileged instruction issued by a user program in any guest OS has to trap to the hypervisor. In addition, the hypervisor needs to specify and implement every function required for managing hardware resources. On the other hand, if the hypervisor operates in unprivileged mode on top of a host OS, the guest OS(s) will also operate in unprivileged mode. This system is called a user-mode hosted system VM. In this case, privileged instructions from guest OS(s) still need to trap to the hypervisor. In return, the hypervisor needs also to trap to the host OS. Clearly, this requirement increases the overhead by adding one more trap per every privileged instruction. Nonetheless, the hypervisor can utilize the functions already available on the host OS to manage hardware resources. Finally, the hypervisor can operate partly in privileged mode and partly in user mode in a system called a dual-mode hosted system VM. This way, the hypervisor can make use of the host OS's resource-management functions and preclude the one more trap per each privileged instruction imposed in user-mode hosted system VMs.
![Figure 3.17: Different system VM classes.](../media/different_system_vm.png)

_Figure 3.17: Different system VM classes._