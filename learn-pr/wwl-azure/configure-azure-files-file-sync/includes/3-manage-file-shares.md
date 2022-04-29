To access your files, you will need a storage account. After the storage account is created, you can create the file share. 

:::image type="content" source="../media/create-file-shares-bf2e2f1d.png" alt-text="Screenshot Add a file share page from the portal":::


## Mapping file shares (Windows)

You can connect to your Azure file share with Windows or Windows Server. Just select **Connect** from your virtual machine page.

:::image type="content" source="../media/map-file-shares-windows-a1aa8f59.png" alt-text="Screenshot of This PC page. Map a Network Drive is highlighted.":::


> [!NOTE]
> Ensure port 445 is open. Azure Files uses SMB protocol. SMB communicates over TCP port 445. Also, ensure your firewall is not blocking TCP ports 445 from the client machine.

## Mounting file shares (Linux)

You can also connect to your Azure file share with Linux machines. Just select **Connect** from the virtual machine page. Azure file shares can be mounted in Linux distributions using the CIFS kernel client. File mounting can be done on-demand with the mount command or on-boot (persistent) by creating an entry in /etc/fstab.

## Secure transfer required

The secure transfer option enhances the security of your storage account by only allowing requests to the storage account by secure connection. For example, when calling REST APIs to access your storage accounts, you must connect using HTTPs. Any requests using HTTP will be rejected when *Secure transfer required* is enabled.
