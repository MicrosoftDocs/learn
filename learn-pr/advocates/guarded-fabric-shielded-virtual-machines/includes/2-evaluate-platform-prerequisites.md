Attestation relies upon the following roles and features:

- **Host Guardian Hyper-V Support**: Install this feature on Hyper-V hosts to support shielded VMs. The Hyper-V hosts request attestation and protected VM key material from HGS.
- **Host Guardian Service**: Install this role on separate HGS servers. The Attestation service evaluates Hyper-V host trust, and the Key Protection Service controls the secure release of VM key material.

> [!NOTE]
> The **Host Guardian Hyper-V Support** feature, `HostGuardian`, is only available in the Datacenter edition of Windows Server 2025. The **Host Guardian Service** role, `HostGuardianServiceRole`, is available in both the Standard and Datacenter editions. 

The similarly named components serve different machines and aren't interchangeable.

A TPM-trusted guarded Hyper-V host requires TPM 2.0, usable endorsement-key certificate trust, Unified Extensible Firmware Interface (UEFI) 2.3.1 or later, UEFI boot, and Secure Boot. It also needs second-level address translation (SLAT) and an input-output memory management unit (IOMMU) for the required virtualization and direct-memory-access protections.

Firmware and drivers must support the required VBS and hypervisor-enforced code integrity configuration. A server that advertises the hardware features but can't run the required security configuration isn't ready. Don't apply all guarded Hyper-V host hardware requirements indiscriminately to HGS servers. Their roles differ.

Server Core supports the Hyper-V and HGS roles. Manage Server Core locally through PowerShell or remotely from a trusted Windows Server management system. A Desktop Experience management server can run the appropriate graphical shielding-data/template tools when needed. Don't assume those wizard interfaces are available locally on Server Core.

To check suitability to function in a shielded fabric, run the following commands in elevated Windows PowerShell on each prospective Hyper-V host.

```powershell
Get-ComputerInfo |
    Select-Object WindowsProductName, WindowsVersion, OsBuildNumber

Get-WindowsFeature -Name Hyper-V, HostGuardian
Get-Tpm
Confirm-SecureBootUEFI

Get-CimInstance -Namespace 'root\Microsoft\Windows\DeviceGuard' `
    -ClassName Win32_DeviceGuard
```

Interpret the edition and installed features first. Inspect TPM readiness and Secure Boot separately. For `Win32_DeviceGuard`, distinguish security services configured from services actually running. Decode the returned values using the target-build documentation. A configured VBS policy isn't proof of a running protected environment.

> [!NOTE]
> A TPM replacement changes the Hyper-V host's identity. Firmware and security-policy changes can change measured evidence even when the server's inventory name stays the same.

## Understand the guest boundary

The working example used in this module is a Windows Server 2025 generation 2 VM, with the Microsoft Windows Secure Boot template, a GUID partition table (GPT) on a basic OS disk, an appropriate EFI system partition, and an NTFS Windows volume. NTFS is the requirement for the Windows volume, not an instruction to format the EFI system partition as NTFS.

A **basic disk** is a Windows guest disk-partitioning choice. It's different from whether the VHDX file is fixed-size or dynamically expanding. Confusing those terms can lead to rejecting a valid virtual-disk format or accepting an unsuitable guest disk layout.

> [!NOTE]
> Linux shielding uses different supported image, encryption, Secure Boot, and specialization arrangements. Don't apply the Windows BitLocker preparation steps to Linux. Establish support for a specific distribution and workflow separately. This module doesn't provide a parallel Linux deployment path. 
