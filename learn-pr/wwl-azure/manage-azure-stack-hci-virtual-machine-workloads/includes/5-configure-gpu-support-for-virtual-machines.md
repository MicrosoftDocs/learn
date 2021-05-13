Some of Contoso's Linux-based financial modeling applications require powerful compute resources. Currently, those applications rely on third-party hardware that is nearing its end of life. You want to check if the support for GPU in Azure Stack HCI can provide a viable replacement for the legacy hardware.

## What are the benefits of GPU in Azure Stack HCI scenarios?

GPU is a specialized electronic circuitry optimized for specialized workloads that require significantly more processing power than what traditional CPUs can deliver. GPUs supplement CPUs through acceleration and by processing the most compute-intensive tasks. Some of the workloads that benefit from GPU acceleration include:

- App and desktop remoting, including VDI and desktop-as-a-service (DaaS) scenarios
- Remote rendering, encoding, and visualization
- High-performance computing (HPC) and machine learning (ML), common in financial modeling scenarios

GPU supports virtualization, which helps in using GPU for virtualized workloads. In Azure Stack HCI, you can implement such virtualization by using Discrete Device Assignment (DDA). DDA allows you to assign one or more physical GPUs to a VM running Windows or Linux operating system. 

> [!NOTE]
> With DDA, a physical GPU provides acceleration to a single VM only. To maximize DDA benefits in multi-user environments, consider hosting multiple specialized workloads per VM. By implementing Remote Desktop Services (RDS), you can then use the multi-session capabilities of Windows Server to host multiple user sessions on the same VM. Each of these sessions will effectively benefit from GPU acceleration.

## Configure GPU acceleration for Azure Stack HCI VMs

The process of configuring DDA-based GPU acceleration on Azure Stack HCI VMs consists of three main tasks:

1. Configure the VM for DDA.
1. Dismount the GPU from the cluster node.
1. Assign the device to the VM.
1. Install the GPU drivers in the guest operating system.

> [!NOTE]
> Since DDA associates the physical GPU on the Hyper-V hosts to a VM, it does not support failover in Azure Stack HCI scenarios. Effectively, you should provision the VM as stand-alone, rather than as a highly-available cluster role. When using Windows Admin Center to create such a VM, make sure that you connect it to the target cluster node, and not to the cluster. 

### Configure the VM for DDA

DDA requires several VM-level configuration changes, including:

- Setting **Automatic Stop Action** to **Turn off the virtual machine** for the target VM. 
- Assigning values that enable and optimize communication between the physical GPU and the target VM.

You can perform all of these tasks by using Windows PowerShell running on the cluster node that hosts the target VM. Automatic stop action settings are also configurable from Windows Admin Center.

## Dismount the GPU from the cluster node

Since the GPU will be used exclusively by the VM, you have to disable and dismount it from the cluster node. First, you need to identify the PCI location path of the GPU device. You can retrieve its value and disable the device by using Windows Device Manager. To dismount the device, run the **Dismount-VMHostAssignableDevice** PowerShell cmdlet on the cluster node that hosts the target VM and reference the device location path.

## Assign the device to the VM

With the device dismounted on the cluster node, you can now assign it to the target VM. To perform this task, you can also use Windows PowerShell running on the cluster node that hosts the target VM.

## Install the GPU drivers in the guest operating system

After the device is successfully assigned to the target VM, you can bring it online and install GPU hardware-specific drivers within its operating system. To verify the outcome, use Device Manager in Windows or the **lspci** utility in Linux.