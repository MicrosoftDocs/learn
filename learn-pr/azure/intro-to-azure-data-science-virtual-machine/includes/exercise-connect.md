The Data Science Virtual Machine (DSVM) is already running because you just created it. Ideally, you noted the public IP address of the Virtual Machine (VM) in the last exercise. If you didn't, you can use the Azure portal to find it.

## Connect to your Ubuntu DSVM by using X2Go

The Linux Virtual Machine (VM) is already provisioned with X2Go Server, and it can accept client connections. To connect to the Linux VM graphical desktop, complete this procedure on your client:

1. Download and install the [X2Go Client](https://wiki.x2go.org/doku.php/doc:installation:x2goclient?portal=true) for your client platform.

1. Run the X2Go Client. If the **New Session** window doesn't automatically appear, go to **Session** > **New Session**.

1. In the configuration window, enter these parameters:
   - **Session tab**:
     - **Host**: Enter the IP address of your VM, which you noted earlier
     - **Login**: Enter the username on the Linux VM
     - **SSH port**: Leave it at **22**, the default value
     - **Session type**: Change the value to **XFCE**. At this time, the Linux VM supports only the XFCE desktop
   - **Media tab**: You can turn off sound support and client printing if you don't need to use them.
   - **Shared folders**: You can mount client machine directories to the virtual machine. On this tab, add the client machine directories that you want to share with the VM

   :::image type="content" source="../media/x2go-ubuntu.png" alt-text="Screenshot of the X2Go configuration window.":::

1. Select **OK**
1. To bring up the sign-in screen for your VM, select the box in the right pane of the X2Go window
1. Enter the password for your VM
1. Select **Ok**
1. To finish the connection process, you might have to give X2Go permission to bypass your firewall

You should now see the graphical interface for your Ubuntu DSVM.

X2Go Client defaults to an 800 x 600 resolution when it opens. If you drag the corner of the window, you can resize the remote desktop.