In this exercise, you mount NFS volumes on Linux and Windows clients, and mount SMB volumes on Windows clients.

### Task 1 - Mount NFS volumes on Linux clients

In this task, you use Azure portal to mount an NFS volume on a Linux client.

1. Select **Volumes** under storage services.
2. Select an NFS volume that you want to mount. If you don’t have an NFS volume, create one.
3. To mount the NFS volume using a Linux client, select **Mount instructions** from the selected volume.
    :::image type="content" source="../media/exercise-mount-menu.png" alt-text="Screenshot of Azure portal showing Mount instructions option selected for NFS volume." border="true" lightbox="../media/exercise-mount-menu.png":::
4. Follow the steps shown on the **Setting up your Azure instance** page.
    :::image type="content" source="../media/exercise-network-file-system-steps.png" alt-text="Screenshot showing NFS mount setup and command steps in Azure portal." border="true" lightbox="../media/exercise-network-file-system-steps.png":::

### Task 2 - Mount NFS volumes on Windows clients

In this task, you mount an NFS volume on Windows clients.

1. [Mount the volume on a Unix or Linux VM first](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-mount-unmount-volumes-for-virtual-machines#mount-nfs-volumes-on-linux-clients)
2. Run `chmod 777` or `chmod 775` command against the volume.
3. Mount the volume through the Windows NFS client using the mount option `mtype=hard` to reduce connection issues. See [Windows command line utility for mounting NFS volumes](https://learn.microsoft.com/windows-server/administration/windows-commands/mount) for more detail. For example: `Mount -o rsize=256 -o wsize=256 -o mtype=hard \\10.x.x.x\testvol X:*`
4. You can also access NFS volumes from Windows clients using SMB by setting the protocol access for the volume to **dual-protocol**. This setting allows access to the volume via SMB and NFS (NFSv3 or NFSv4.1) and results in better performance than using the NFS client on Windows with an NFS volume.

### Task 3 - Mount SMB volumes for Windows virtual machines

In this task, you use Azure portal to mount an SMB volume on a Windows client.

1. Select **Volumes** under storage services.
2. Select an SMB volume to mount. If you don’t have an SMB volume, create one.
3. To mount the SMB volume using a Windows client, select **Mount instructions** from the selected volume.
4. Follow the mapping steps shown in the Azure portal.
    :::image type="content" source="../media/mount-instructions-server-message-block.png" alt-text="Screenshot showing SMB network drive mapping steps in Azure portal mount instructions." border="true" lightbox="../media/mount-instructions-server-message-block.png":::
