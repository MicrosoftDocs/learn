
To access your files, you need an Azure storage account. After you have a storage account, you can create and configure a file share by using Azure Files in the Azure portal.

:::image type="content" source="../media/create-file-shares-bf2e2f1d.png" alt-text="Screenshot that shows how to configure a new Azure Files share in the Azure portal.":::

### Things to consider when using Azure Files shares

There are two important settings for Azure Files that you need to be aware of when creating and configuring file shares.

- **Open port 445**. Azure Files uses the SMB protocol. SMB communicates over TCP port 445. Be sure port 445 is open. Also, make sure your firewall isn't blocking TCP port 445 from the client machine.

- **Enable secure transfer**. The `Secure transfer required` setting enhances the security of your storage account by limiting requests to your storage account from secure connections only. Consider the scenario where you use REST APIs to access your storage account. If you attempt to connect, and secure transfer required is enabled, you must connect by using HTTPS. If you try to connect to your account by using HTTP, and secure transfer required is enabled, the connection is rejected.

## Map Azure Files share on Windows

You can connect your Azure Files share with Windows or Windows Server in the Azure portal. Specify the **Drive** where you want to map the share, and choose the **Authentication method**. The system supplies you with PowerShell commands to run when you're ready to work with the file share. This video shows how to mount an Azure file share in Windows.  

> [!VIDEO https://www.youtube.com/embed/bmRZi9iGsK0]

## Mount Azure Files share on Linux

You can also connect Azure Files shares with Linux machines. From your virtual machine page, select **Connect**. Azure Files shares can be mounted in Linux distributions by using the CIFS kernel client. File mounting can be done on-demand with the `mount` command or on-boot (persistent) by creating an entry in /etc/fstab.

:::image type="content" source="../media/map-file-shares-linux-1639a49a.png" alt-text="Screenshot that shows how to connect to an Azure Files share with Linux in the Azure portal.":::
