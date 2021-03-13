Because you just created the virtual machine, it will already be running. You should have noted the public IP address of the virtual machine in the last exercise. If you didn't, use the Azure portal to find it.

## Connect to your Ubuntu Data Science Virtual Machine by using X2Go

The Linux VM is already provisioned with X2Go Server, and is ready to accept client connections. To connect to the Linux VM graphical desktop, complete the following procedure on your client:

1. Download and install the X2Go Client for your client platform from [X2Go](https://wiki.x2go.org/doku.php/doc:installation:x2goclient?portal=true).

1. Run X2Go Client. If the **New Session** window doesn't appear automatically, go to **Session** > **New Session**.

1. In the configuration window, enter the following parameters:
   - **Session tab**:
     - **Host**: Enter the IP address of your VM, which you noted earlier.
     - **Login**: Enter the username on the Linux VM.
     - **SSH port**: Leave it at **22**, the default value.
     - **Session type**: Change the value to **XFCE**. Currently, the Linux VM supports only the XFCE desktop.
   - **Media tab**: You can turn off sound support and client printing if you don't need to use them.
   - **Shared folders**: You can mount client machine directories to the virtual machine. Add the client machine directories that you want to share with the VM on this tab. 

   ![Screenshot of the X2Go configuration window.](../media/x2go-ubuntu.png)

1. Select **OK**.
1. Select the box in the right pane of the X2Go window to bring up the sign-in screen for your VM.
1. Enter the password for your VM.
1. Select **Ok**.
1. You might have to give X2Go permission to bypass your firewall to finish connecting.

You should now see the graphical interface for your Ubuntu DSVM.

X2Go Client defaults to opening at 800 x 600 resolution. If you drag the corner of the window, you can also resize the remote desktop.