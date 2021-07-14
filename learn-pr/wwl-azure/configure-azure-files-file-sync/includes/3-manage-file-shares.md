To access your files, you will need a storage account. After the storage account is created, provide the file share **Name** and the **Quota**. Quota refers to total size of files on the share.

:::image type="content" source="../media/AZ104_Creating_File_Shares-888aded2.png" alt-text="Screenshot Add a file share page from the portal":::


## Mapping File Shares (Windows)

You can connect to your Azure file share with Windows or Windows Server. Just select **Connect** from your file share page.

:::image type="content" source="../media/AZ104_Mapping_FS_Windows-d63f46e0.png" alt-text="Screenshot of This PC page. Map a Network Drive is highlighted.":::


> [!NOTE]
> Ensure port 445 is open. Azure Files uses SMB protocol. SMB communicates over TCP port 445. Also, ensure your firewall is not blocking TCP ports 445 from the client machine.

## Mounting File Shares (Linux)

:::image type="content" source="../media/AZ104_Mapping_FS_Linux-357f363d.png" alt-text="Screenshot of the file share connect page for linux. The sudo command is shown.":::


Azure file shares can be mounted in Linux distributions using the CIFS kernel client. File mounting can be done on-demand with the mount command or on-boot (persistent) by creating an entry in /etc/fstab.

## Secure Transfer Required

The secure transfer option enhances the security of your storage account by only allowing requests to the storage account by secure connection. For example, when calling REST APIs to access your storage accounts, you must connect using HTTPs. Any requests using HTTP will be rejected when *Secure transfer required* is enabled.
