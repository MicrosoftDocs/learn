Here you learn ways to monitor the capacity utilization of an Azure NetApp Files volume.

### Using Windows (SMB) clients

You can use Windows clients to check the used and available capacity of a volume through the network mapped drive properties. You can use one of the following two methods:

- Go to File Explorer, right-click the mapped drive, and select **Properties** to display capacity.

    :::image type="content" source="../media/windows-drive-properties.png" alt-text="Screenshot of mapped network drive properties in Windows File Explorer showing capacity details." lightbox="../media/windows-drive-properties.png" border="true":::

- Or use the `dir` command at the command prompt.

    :::image type="content" source="../media/windows-dir-output.png" alt-text="Screenshot of Windows Command Prompt showing dir output and free space on mapped drive." lightbox="../media/windows-dir-output.png" border="true":::

The available space is accurate using File Explorer or the `dir` command. However, the consumed or used space is an estimate when snapshots are generated on the volume.

### Using Linux (NFS) clients

Linux clients can check the used and available capacity of a volume by using the [df command](https://linux.die.net/man/1/df).

The `-h` option shows size, including used and available space in human readable  format (using M, G and T unit sizes).

The following example shows volume capacity reporting in Linux:

:::image type="content" source="../media/linux-capacity-output.png" alt-text="Screenshot of Linux terminal output for df -h showing volume size, used space, and available space." lightbox="../media/linux-capacity-output.png" border="true":::

The available space is accurate using the `df` command. However, the consumed or used space is an estimate when snapshots are generated on the volume.
