As the Windows Server administrator you need to understand shielded VMs components and configuration requirements, so you can make a proper assessment of the appropriateness of their use in Contoso's infrastructure.

## Overview of shielded VMs

Shielded VMs can run only on healthy and approved guarded hosts that are authorized by the HGS. There are two core elements to creating shielded VMs, these are:

1. Create a shielded VM signed template disk.
1. Create a shielded data file.

### 1. Create a shielded VM signed template disk

A *VM template disk* is used as the basis for all future VMs deployed within the fabric. A shielded VM template disk provides additional security by hiding from the fabric administrators all confidential information, such as passwords and certificates.

#### Prepare the template disk file by installing an OS

To create the template disk, the first step is to prepare an OS disk on which to install the OS. The disk must be a .vhdx file format.

The disk you set up must meet the following requirements:

|Template disk .vhdx file requirements|Description|
|---------|---------|
|Must be a GUID Partition Table (GPT) disk|Needed for generation 2 VMs to support UEFI.|
|Disk type must be Basic|BitLocker doesn't support dynamic disks.|
|Disk must have at least two partitions|One partition must include the drive that you'll install Windows on. BitLocker encrypts this drive. The other partition is the active partition, which contains the bootloader and remains unencrypted so that the computer can start.|
|File system must be NTFS|Required for BitLocker|
|Supported OS|Must be able to support generation 2 VMs and the Microsoft Secure Boot process.|
|OS must be generalized|The template disk must be generalized by running `sysprep.exe`.|

> [!NOTE]
> After you install the OS, be sure to verify and install all the latest Windows updates.

#### Use the Shielded Template Disk Creation Wizard

Before you can use the template disk to create shielded VMs, the generalized disk must be prepared and encrypted with BitLocker. You can perform this task by using the **Shielded Template Disk Creation Wizard**. The wizard generates a hash for the disk and adds it to a volume signature catalog (VSC). The VSC is signed using a certificate you specify and is used during the provisioning process to ensure the disk being deployed in the fabric has not been altered or replaced with a disk that isn't trusted. Finally, BitLocker is installed on the disk's OS to prepare the disk for encryption during VM provisioning.

### 2. Create a shielded data file

To use the signed template disks in the VMM library, you must prepare one or more shielding data files. A shielding data file, also called a provisioning data file or platform development kit (PDK) file, is an encrypted file that contains encrypted secrets that are needed to deploy a shielded VM. A shielding data file can only be read by a guarded host in trusted fabric, and specifies which guarded fabric the HGS can trust to host a shielded VM.

A shielding data file can contain secrets such as:

- Administrator account credentials
- An answer file, unattend.xml, used to customize the VM deployment
- A security policy that determines whether VMs created using this shielding data are configured as shielded or encryption supported
- Identity-related certificates
- An RDP certificate to secure remote desktop communication with the VM and other
- A volume signature catalog that contains a list of trusted, signed template-disk signatures from which a new VM can be created
- A KP that defines which guarded fabrics a shielded VM is authorized to run on
- Domain-join credentials

## Understand the shielded VM process

You must complete the following steps to deploy a shielded VM:

1. Deploy an HGS server.
1. Set up a guarded host.
1. Prepare a signed template disk (.vhdx file).
1. Create a shielding data file.
1. Import the shielding data file into the VMM library.
1. Create a new shielded VM from the signed template disk.
1. Add the shielding data file to the new shielded VM.

## Attack types examples and how shielded VMs protect against attacks

The following table provides examples of common attack types and how shielded VMs can protect the Contoso fabric against them.

|Attack type|Protection provided by shielded VMs|
|--|--|
|*Unauthorized access to the .vhdx files for all VMs on a single host*|A host's administrator typically has access to the .vhdx files for all the VMs on a host. However, by implementing full disk encryption on the .vhdx files, the files in a shielded VM are protected against malicious administrators.|
|*Compromised VM templates*|The HGS attests to the health and identity of shielded VMs to ensure that the hosts aren't modified without your knowledge. Shielded VMs can only be started on the guarded hosts in an approved fabric. This ensures that your .vhdx files for your shielded VMs can't be started (or modified) by an actor outside of your trusted environment.|
|*Compromised VM secrets*|The PDK file provides assurances that the VM will be created according to the intend specification. For example, if the HGS administrator configures the shielding data file to contain an answer file, the fabric administrator can't access or make changes to the answer file. Similarly, the fabric administrator can't substitute a different .vhdx file when creating the shielded VM, because the shielding data file contains the signatures of the trusted disks that shielded VMs can be created from. A fabric administrator can use the shielding data file to help create a shielded VM, but cannot access the file information directly.|

## Linux support in Windows Server 2019

Hyper-V includes support for provisioning Linux shielded VMs. You can provision a Linux shielded VM in a guarded fabric with System Center VMM as follows:

1. Deploy an HGS server and set up a guarded host
1. Prepare a template disk.
1. Sign the template disk.
1. Copy the template disk and the signed image to the VMM library.
1. Create a Linux shielded VM template in VMM.
1. Generate a shielding data file (PDK file).
1. Use the VMM console to create a Linux shielded VM from VM disk template and the PDK.

## Troubleshoot shielded VMs

The following tools are available to troubleshoot shielded VMs:

- Virtual Machine Connection (VMConnect) with enhanced session mode
- PowerShell Direct in Windows Server 2019

### VMConnect

*VMConnect* is a tool you can use to connect to a VM and interact with the VM's guest OS. Its functionality is similar to RDP with enhanced session mode. Some tasks that you can perform by using VMConnect include the following:

- Start and shut down a VM
- Connect to a DVD image (an .iso file) or a USB flash drive
- Create a checkpoint
- Modify the settings of a VM
- Diagnose network issues

  > [!NOTE] 
  > An administrator requires VM guest credentials to use VMConnect to access a VM.

You can disable VMConnect in a VM by running the following:

```powershell
reg add "HKLM\Software\Microsoft\Virtual Machine\Guest" /v DisableEnhancedSessionConsoleConnection /t REG_DWORD /d 1
```

### PowerShell Direct

You can use *PowerShell Direct* to run Windows PowerShell cmdlets in a Windows 10 or Windows Server 2016 VM from a Hyper-V host. Some tasks that you can perform by using *PowerShell Direct* include the following:

- Start an interactive Windows PowerShell session by using the `Enter-PSSession` cmdlet.
- Run a single Windows PowerShell command or script by using the `Invoke-Command` cmdlet.
- Open a persistent Windows PowerShell session by using the `New-PSSession`, `Copy-Item`, and `Remove-PSSession` cmdlets.

You can disable PowerShell Direct in a VM, by running the following:

```powershell
Stop-Service vmicvmsession
Set-Service vmicvmsession -StartupType Disabled
```

> [!NOTE]
> To re-enable VMConnect and PowerShell Direct for a shielded VM, move the VMs to a Hyper-V host that runs Windows Server version 1803 or newer. If a shielded VM is moved to a host that runs an earlier version of Windows Server, VMConnect and PowerShell Direct will be disabled again.
