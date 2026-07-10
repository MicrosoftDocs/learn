Here you learn how to mount an NFS volume for Linux or Windows virtual machines (VMs).

### Requirements

- You must have at least one export policy to access an NFS volume.
- Since NFS is a network-attached service, required ports must be opened across firewalls to ensure proper functionality.

### Mount NFS volumes on Linux clients

To mount an NFS volume using a Linux client, in Azure portal go to **Mount instructions** from the selected volume.

:::image type="content" source="../media/mount-instructions-network-file-system.png" alt-text="Screenshot of Azure portal showing Azure NetApp Files mount instructions for NFS volumes." border="true" lightbox="../media/mount-instructions-network-file-system.png":::

- Ensure that you use the `vers` option in the mount command to specify the NFS protocol version that corresponds to the volume you want to mount.
- For example, if the volume uses NFSv4.1:

    `sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=4.1,tcp,sec=sys $MOUNTTARGETIPADDRESS:/$VOLUMENAME $MOUNTPOINT`

- If you want the volume mounted automatically when an Azure VM is started or rebooted, add an entry to the `/etc/fstab` file on the host.
- For example:

    `$ANFIP:/$FILEPATH /$MOUNTPOINT nfs bg,rw,hard,noatime,nolock,rsize=65536,wsize=65536,vers=3,tcp,_netdev 0 0`

- `$ANFIP` is the IP address of the Azure NetApp Files volume found in the volume properties menu.
- `$FILEPATH` is the export path of the Azure NetApp Files volume.
- `$MOUNTPOINT` is the directory on the Linux host used to mount the NFS export.
- If you want to mount an NFS Kerberos volume, refer to [Configure NFSv4.1 Kerberos encryption](https://learn.microsoft.com/azure/azure-netapp-files/configure-kerberos-encryption) for more details.
- You can also access SMB volumes from Linux clients via NFS by setting the protocol access for the volume to **dual-protocol**. This allows for accessing the volume via NFS (NFSv3 or NFSv4.1) and SMB.
- Review the [Linux NFS mount options best practices](https://learn.microsoft.com/azure/azure-netapp-files/performance-linux-mount-options)

### Mount NFS volumes on Windows clients

Mounting NFSv4.1 volumes on Windows clients isn't supported.

You can mount NFSv3 volumes on Windows clients by using NFS:

1. [Mount the volume on a Linux VM first](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-mount-unmount-volumes-for-virtual-machines#mount-nfs-volumes-on-linux-clients)
2. Run `chmod 777` or `chmod 775` command against the volume.
3. Mount the volume via the NFS client on Windows using the mount option `mtype=hard` to reduce connection issues.
    - You can also access NFS volumes from Windows clients via SMB by setting the protocol access for the volume to **dual-protocol**. This setting allows access to the volume via SMB and NFS (NFSv3 or NFSv4.1) and results in better performance than using the NFS client on Windows with an NFS volume.
    - Mounting a dual-protocol volume from Windows clients uses the same procedure as regular SMB volumes.
