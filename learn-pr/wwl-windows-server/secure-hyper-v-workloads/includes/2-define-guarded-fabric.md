As the Contoso Windows Server administrator, you can help protect the Contoso Hyper-V infrastructure from being either intentionally or accidentally compromised by using a guarded fabric.

## Overview of guarded fabric

*Fabric* is a term applied to a collection of compute, network, and storage resources. An example of a fabric is the collection of Hyper-V resources that host VMs.

A *guarded fabric* in Hyper-V is a security solution that protects VMs against unwarranted inspection, theft, and tampering from either malware or malicious system administrators.

A guarded fabric consists of the following core components:

- Shielded VM. Within a guarded fabric, you specify the trusted disk templates and images that new VMs can use. The VMs that use your trusted templates and images in a guarded fabric are called *shielded VMs*.
- Guarded host. You specify which servers in a guarded fabric are safe for hosting shielded VMs. Within the guarded fabric, these safe Hyper-V hosts are called *guarded hosts*.
- Host Guardian Service (HGS). The *HGS* ensures that only a safe and authorized guarded host can run a shielded VM. The HGS also provides a safe and authorized guarded host with security keys to power on a shielded VM.

:::image type="content" source="../media/m24-guarded-fabric.png" alt-text="Diagram of a guarded host with a hosted shielded virtual machine. The guarded host is attesting that it is approved to run as a Hyper-V host and then requests keys from the HGS server, all of which take place in a guarded fabric." border="false":::

## Overview of the security features in a guarded fabric

Guarded fabric components work together to protect hosts from compromised VMs, and to protect VMs from compromised hosts. The following table lists ways that guarded fabric can help you protect your infrastructure.

|Guarded fabric security capability|Details|
|---|---|
|Disk encryption for shielded VM|The operating system (OS) disk in a shielded VM uses BitLocker encryption. Shielded VMs also support encryption for data disks.|
|Deploy new shielded VMs from trusted template disks and images|You specify which template disks and images to trust for deploying new shielded VMs. A signature is generated for each of your trusted template disks and images. When you deploy a new shielded VM, a signature is computed for that image and compared with a pre-created trusted signature. The shielded VM is deployed only if the signatures match.|
|Release keys only to healthy and authorized hosts|Once a guarded host is deemed safe and authorized, the HGS releases a secure key to unlock and start a shielded VM.|
|Protect secrets in a shielded VM|VM secrets are stored in an encrypted file called a *shielding data file*, which is protected by certificate keys and uploaded to the fabric. Examples of VM secrets are the trusted disk signatures, Remote Desktop Protocol (RDP) certificates, and the password for the VM's local Administrator account. When you create a shielded VM, you select which shielding data file to use. This approach ensures that VM secrets are only shared among the trusted components within a guarded fabric.|
|Control where a shielded VM can be started|The shielding data file contains a list of the guarded fabrics and guarded hosts that are permitted to run a specific shielded VM.|

A guarded fabric can run the following VM types, which have different levels of security:

- Shielded VMs, which offer the greatest security
- Standard VMs that are secured with encryption, which are not as secure as shielded VMs
- Standard VMs that have no protection, which offer the least amount of security

## Tools used to automate and manage a guarded fabric

To manage and automate processes within a guarded fabric, use the following Hyper-V tools:

- System Center Virtual Machine Manager (VMM), which you can use as unified management solution for virtualization hosts, virtual networking, and storage to help maintain a virtualized environment effectively.
- Windows Azure Pack, which provides a graphical web portal interface to manage a guarded fabric and shielded VMs.
- Windows PowerShell, which you can use to create the components of a shielded VM and to provision a shielded VM to a guarded host.
