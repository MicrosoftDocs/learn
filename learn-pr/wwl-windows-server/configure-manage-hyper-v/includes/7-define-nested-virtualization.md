Nested virtualization is a Hyper-V feature that you can use to install and run Hyper-V inside a guest VM. It's a virtualized environment running inside a virtualized environment. Nested virtualization enables a guest VM to be a Hyper-V host, which can then host other guest VMs. Nested virtualization can be extremely useful for implementing virtual test and development environments that would otherwise require physical hardware to run. The Contoso Hyper-V administrator is investigating test environments and implementing a private cloud. Both could use nested virtualization.

The following diagram depicts Hyper-V in a non-nested scenario. The Hyper-V hypervisor takes full control of the hardware virtualization capabilities and doesn't expose them to the guest OS. Also, in this non-nested scenario, the VM does not directly interact with the host hardware.

:::image type="content" source="../media/m22-nested-virtualization-1.svg" alt-text="A non-nested virtualization architecture diagram in which the Windows operating system and Hyper-V Guest operating system have to access the hardware on the host via a Hyper-V hypervisor layer." border="false":::

In contrast, the following diagram depicts Hyper-V with nested virtualization enabled. With nested virtualization enabled, a guest VM can install its own hypervisor and run its own guest VM. VM access to the host hardware must go through the second hypervisor and then through the first hypervisor.

:::image type="content" source="../media/m22-nested-virtualization-2.svg" alt-text="A nested virtualization architecture diagram in which there is an additional hypervisor present, which sits above the initial hypervisor, creating two hypervisor layers. Any VMs created above this additional hypervisor access host hardware through the two hypervisors in succession." border="false":::

## Configure networks with nested virtualization

To enable nested virtualization, you need to meet the following prerequisites:

- Both the Hyper-V host and the guest VM must be Windows Server 2016 and newer.
- The physical host computer must have enough static RAM.
- Hyper-V VMs must have a configuration version of 8.0 or greater.
- The physical host computer must have an Intel processor with Virtual Machine Extensions (VT-x) and Extended Page Tables (EPT) capabilities.

## Enable nested virtualization

To enable nested virtualization by using Windows PowerShell, while the VM is in the **off** state, run the following command from the physical Hyper-V host machine:

```powershell
Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
```

After you have enabled nested virtualization, you can install Hyper-V on the guest VM in the same way that you would for a Hyper-V host.

## Networking with nested virtualization

There are two options for networking with nested VMs:

- MAC address spoofing
- NAT

### MAC address spoofing

The first option uses MAC address spoofing, which enables network packets to be routed through two vSwitches. MAC address spoofing must be enabled on the physical Hyper-V host.

To enable MAC address spoofing by using Windows PowerShell, run the following command from the physical Hyper-V host machine:

```powershell
Set-VMNetworkAdapter -VMName <VMName> | Set-VMNetworkAdapter -MacAddressSpoofing On
```

### NAT

The second option uses NAT. This approach is best suited for cases where MAC address spoofing isn't possible, such as in a public cloud environment.

To use NAT, create a virtual NAT switch in the host VM. Assign an IP address to the network adapter and ensure that each nested VM has an IP address and gateway assigned to it.

> [!NOTE] 
> There's more configuration required with the NAT option than the MAC address spoofing option.

### Features that become disabled when you enable nested virtualization

After you enable nested virtualization, the following features will become disabled or will fail:

- Virtualization-based Security (VBS). VBS can't expose virtualization extensions to guests. You must first disable VBS before enabling nested virtualization.
- Device Guard. Device Guard can't expose virtualization extensions to guests. You must first disable Device Guard on the host before enabling nested virtualization.
- Dynamic Memory. Dynamic Memory isn't supported while nested virtualization is enabled, so runtime memory resize will fail.
