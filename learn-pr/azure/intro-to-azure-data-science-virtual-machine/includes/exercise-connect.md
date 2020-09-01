Since you just created the virtual machine, it will already be running. You should have noted the public IP address of the virtual machine in the last exercise. If you did not, use the portal to find it.

## Connect to your Ubuntu Data Science Virtual Machine using X2Go

The Linux VM is already provisioned with X2Go Server and is ready to accept client connections. To connect to the Linux VM graphical desktop, complete the following procedure on your client:

1. Download and install the X2Go client for your client platform from [X2Go](https://wiki.x2go.org/doku.php/doc:installation:x2goclient?portal=true).

1. Run the X2Go client. If the "New Session" window doesn't pop up automatically, go to **Session -> New Session**.

1. On the resulting configuration window, enter the following configuration parameters:
   - **Session tab**:
     - **Host**: Enter the IP address of your VM, which you made note of earlier.
     - **Login**: Enter the username on the Linux VM.
     - **SSH Port**: Leave it at 22, the default value.
     - **Session Type**: Change the value to **XFCE**. Currently, the Linux VM supports only the XFCE desktop.
   - **Media tab**: You can turn off sound support and client printing if you don't need to use them.
   - **Shared folders**: You can mount client machine directories to the virtual machine. Add the client machine directories that you want to share with the VM on this tab. 

   ![X2go configuration](../media/x2go-ubuntu.png)

1. Select **OK**.
1. Click on the box in the right pane of the X2Go window to bring up the sign-in screen for your VM.
1. Enter the password for your VM.
1. Select **OK**.
1. You may have to give X2Go permission to bypass your firewall to finish connecting.
1. You should now see the graphical interface for your Ubuntu Data Science Virtual Machine.

X2Go Client defaults to opening at 800x600 resolution, but if you drag the corner of the window, the remote desktop will resize as well. 