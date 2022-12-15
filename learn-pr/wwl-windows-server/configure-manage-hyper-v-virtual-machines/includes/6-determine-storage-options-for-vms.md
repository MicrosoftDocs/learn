The Contoso Hyper-V administrator will need to understand and determine the various storage options available for VMs in Hyper-V, such as Fibre Channel storage on storage area networks (SANs) and storing VMs on SMB 3.0 file shares.

## Storage options in Hyper-V

Just as a physical computer has a hard disk for storage, VMs also require storage. Hyper-V provides many different VM storage options. If you know which option is appropriate for a given situation, you can ensure that a VM performs well and doesn't consume unnecessary space or place an unnecessary performance burden on the Hyper-V host server. You need to understand the various options for storing virtual hard disks (VHDs) so that you can select a storage option that meets your requirements for performance and high availability.

A key factor when provisioning VMs is to ensure correct placement and storage of the VHDs. Servers that otherwise are well provisioned with RAM and processor capacity can still experience poor performance if the storage system is overwhelmed or inadequate. You can store VHDs on local disks, a SAN, or Server Message Block (SMB) version 3.0 file shares.

### Plan for VHD storage

Consider the following factors when you plan the storage location of VHD files:

- High-performance connection to storage. You can locate VHD files on local or remote storage. When you locate them on remote storage, you need to ensure that there's adequate bandwidth and minimal latency between the host and the remote storage. Slow network connections to storage or connections where there's latency result in poor VM performance.
- Redundant storage. The volume on which the VHD files are stored should be fault tolerant whether the VHD is stored on a local disk or on a remote NAS or SAN device. Although hard disk failures are common,  the VM and the Hyper-V host should remain in operation after a disk failure. Replacing failed disks shouldn't affect the operation of the Hyper-V host or VMs.
- High-performance storage. The storage device on which you store VHD files should have excellent I/O characteristics. Many enterprises use hybrid solid state drives (SSDs) in RAID 1+0 arrays to achieve maximum performance and redundancy.

  > [!CAUTION]  
  > Multiple VMs that are running simultaneously on the same storage can place a tremendous I/O burden on a disk subsystem. If you don't choose high-performance storage in this scenario, VM performance will suffer.
- Adequate growth space. If you have configured VHDs to grow automatically, ensure that there's adequate space into which the files can grow.

    > [!TIP]
    > You should carefully monitor growth so that you aren't surprised when a VHD fills the volume that you allocated to host it.

## Fibre Channel support for SANs

Hyper-V virtual Fibre Channel adapter is a virtual hardware component that you can add to a VM to enable access to Fibre Channel storage on storage area networks (SANs). To deploy a virtual Fibre Channel:

- You must configure the Hyper-V host with a Fibre Channel host bus adapter (HBA) or a Fibre Channel over Ethernet (FCoE) network adapter.
- The Fibre Channel HBA must have a driver that supports virtual Fibre Channel.

Virtual Fibre Channel adapters support port virtualization by exposing HBA ports in the guest OS. Doing so enables a VM to access a SAN by using a standard World Wide Name that's associated with the VM.

> [!NOTE]
> You can deploy up to four virtual Fibre Channel adapters on each VM.

## Storing VMs on SMB 3.0 file shares

Hyper-V supports storing VM data, such as VM configuration files, checkpoints, and VHD files, on SMB 3.0 file shares. The file share must support SMB 3.0.

> [!NOTE]
> The recommended bandwidth for network connectivity to an SMB file share is 1 gigabit per second (Gbps) or more.

SMB 3.0 file shares provide an alternative to storing VM files on iSCSI or Fibre Channel SAN devices. When creating a VM in Hyper-V, you can specify a network share as the VM and the VHD location. You can also attach disks to VMs that are stored on SMB 3.0 file shares. You can use .vhd, .vhdx, and .vhds files with SMB 3.0 file shares.

> [!CAUTION]
> When you use SMB 3.0 file shares, you should separate network traffic to the file shares that contain the VM files. Client network traffic shouldn't be on the same virtual LAN (VLAN) as SMB traffic.

To provide high availability for file shares storing VM files, you can use Scale-Out File Server (SOFS). SOFS provides redundant servers for accessing a file share. This also provides faster performance than when you're accessing files through a single share, because all servers in the SOFS are active at the same time. To manage Quality of Service (QoS) policies for Hyper-V and SOFS, on Windows Server 2016 and later versions, you can use Storage QoS. This allows deployment of QoS policies for SMB 3.0 storage.
