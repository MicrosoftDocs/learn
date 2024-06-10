Windows Defender Credential Guard helps protect you against NTLM Pass-the-Hash attacks or Kerberos Pass-the-Ticket attacks. It protects you by restricting access to NTLM password hashes (Pass-the-Hash), Kerberos TGTs (Pass-the-Ticket), and application credentials stored as domain credentials to special processes and memory that manage and store that authorization and authentication-related data. Therefore, only specific, digitally authorized elements of the host operating system—which verifies those elements—can access the special processes and memory. This blocks unauthorized operations or unauthorized software from gaining access to the protected processes and memory, and subsequently limiting their access to authorization and authentication-related data. Windows Defender Credential Guard also provides hardware security by utilizing hardware security features such as secure boot and virtualization for NTLM, Kerberos, and Credential Manager.

## How Windows Defender Credential Guard works

Windows Defender Credential Guard protects user credentials from compromise by isolating those credentials within a protected, virtualized container, separate from the rest of the operating system. Only privileged system software can access the credentials.

The virtualized container’s operating system runs in parallel with, but independent from the host operating system. This operating system protects these processes from attempts by any external entity to read information that those processes store and use. This means that credentials are more protected, even if malware has penetrated the rest of your system.

### Windows Defender Credential Guard requirements

You can deploy Windows Defender Credential Guard only on devices that meet certain hardware requirements. Windows Defender Credential Guard should be used on any computer where IT staff use privileged credentials, especially workstations dedicated to privileged access.

Windows Defender Credential Guard requires the following:

 -  Windows 10 Enterprise or Windows Server 2016 or later
 -  64-bit CPU CPU virtualization extensions plus extended page tables (Intel VT-x or AMD-V)
 -  Trusted Platform Module (TPM) 1.2 or 2.0
 -  Unified Extensible Firmware Interface (UEFI) firmware version 2.3.1.c or newer
 -  UEFI Secure boot
 -  UEFI secure firmware update

Windows Defender Credential Guard can protect secrets in a Microsoft Hyper-V virtual machine when:

 -  The Hyper-V host has an input/output memory management unit (IOMMU) and runs Windows Server 2016 or later, or runs Windows 10 Enterprise.
 -  The virtual machine must be Generation 2, have virtual TPM enabled, and run an operating system that supports Windows Defender Credential Guard.

Windows Defender Credential Guard does not support:

 -  Unconstrained Kerberos delegation
 -  NTLMv1
 -  MS-CHAPv2
 -  Digest authentication
 -  Credential (CredSSP) delegation
 -  Kerberos DES (Data Encryption Standard) encryption

Windows Defender Credential Guard is not supported on domain controllers. It also does not provide protections for the AD DS (Active Directory) database or Security Accounts Manager (SAM).
