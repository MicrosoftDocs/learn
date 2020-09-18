A key element, which is also one of the more complex parts of virtualization, is CPU virtualization. Virtualizing a CPU entails two major steps:

1. Multiplex a physical CPU (pCPU) among virtual CPUs (vCPUs) associated with virtual machines (VMs). This is called vCPU scheduling.
2. Virtualize the ISA of a pCPU to make vCPUs with different ISAs run on the pCPU.

In this module, we present some conditions for virtualizing ISAs. Second, we describe ISA virtualization. Third, we make a distinction between two types of ISA virtualization: full virtualization and paravirtualization. Fourth, we discuss emulation, a major technique for virtualizing CPUs. Fifth, we compare two kinds of VMs: simultaneous multiprocessing (SMP) and uniprocessor (UP) VMs. Finally, we close with a discussion on vCPU scheduling. As examples, we present two popular Xen vCPU schedulers.

## Learning objectives

In this module, you will:

- Distinguish between different modes of operations in various systems such as traditional operating systems and virtualized systems.
- Identify the three main classes of system instructions.
- Indicate the condition to enable efficient hypervisors.
- Explain how a hypervisor can handle system traps.
- Identify the difference between efficient hypervisors and hypervisors.
- Describe why and when code patching is needed.
- Recognize the dissimilarity between full virtualization and paravirtualization.
- Explain the advantages and disadvantages of full virtualization and paravirtualization.
- Identify the difference between emulation and direct native execution.
- Recognize the two types of emulation: interpretation and binary translation.
- Explain some major interpretation and binary translation techniques.
- Compare and contrast decode-and-dispatch, direct-threaded, and indirect-threaded interpreters.
- Identify the difference in virtual CPU allocation between symmetric multiprocessing and uniprocessor virtual machines.
- Describe the two major virtual CPU schedulers in Xen: Simple Earliest Deadline First and Credit Scheduler.

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.
- Understand how cloud resources are provisioned and metered.
- Be familiar with the concept of virtualization.
- Know what the different types of virtualization are.
