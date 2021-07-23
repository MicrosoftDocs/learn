To manage an Azure Windows VM, you can use the same set of tools that you used to deploy it. However, you will also want to interact with an operating system (OS) running within the VM. The methods you can use to accomplish this are OS-specific and include the following options:

:::image type="content" source="../media/remote-desktop-connections-65d5e820.png" alt-text="Screenshot of the RDP connection page.":::


**Remote Desktop Protocol (RDP)** allows you to establish a graphical user interface (GUI) session to an Azure VM that runs any supported version of Windows. The Azure portal automatically enables the **Connect button** on the Azure Windows VM blade if the VM is running and accessible via a public or private IP address, and if it accepts inbound traffic on TCP port 3389. After you click this button, the portal will automatically provision an RDP file, which you can either open or download. Opening the file initiates an RDP connection to the corresponding VM. You will get a warning that the RDP file is from an unknown publisher. Certificate warnings are expected. When connecting be sure to use credentials for the virtual machine. The Azure PowerShell **Get-AzRemoteDesktopFile** cmdlet provides the same functionality.

**Windows Remote Management (WinRM)** allows you to establish a command-line session to an Azure VM that runs any supported version of Windows. You can also use WinRM to run noninteractive Windows PowerShell scripts. WinRM facilitates additional session security by using certificates. You can upload a certificate that you intend to use to Azure Key Vault prior to establishing a session. The process of setting up WinRM connectivity includes the following, high-level steps:

1.  Creating a key vault.
2.  Creating a self-signed certificate.
3.  Uploading the certificate to the key vault.
4.  Identifying the URL of the certificate uploaded to the key vault.
5.  Referencing the URL in the Azure VM configuration.

> [!NOTE]
> By default, WinRM uses TCP port 5986. You can change the port. Ensure whatever port you are using is not blocked by network security group rules.
