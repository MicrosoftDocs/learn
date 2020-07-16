Now that you've created a Data Science Virtual Machine, you need to connect to it. The DSVM is preconfigured for SSH access on both Ubuntu and Windows Server 2019. With SSH, you can connect to the command line of the DSVM. You can also use a full graphical desktop, using Remote Desktop for Windows and X2Go client for Linux. 

## If necessary, start the DSVM

A newly-created DSVM will already be running, but generally you'll need to start the virtual machine from the Azure Portal.

1. Navigate to your resource group in the Azure Portal
1. From your resource list, choose your DSVM, which is of type "Virtual machine"
1. From the DSVM's resource page, choose "Start" if necessary
1. Wait until the DSVM's Status is "Running"
1. Record the IP address 

## Connect to the command line using SSH

To access the command line of your DSVM, you'll use:

- An SSH client running in a terminal on your local machine
- The username and password you specified during creation
- The public IP address of the running DSVM

### Install an SSH client on Windows, if necessary

If you are running Linux or MacOS, an ssh client is part of the OS standard utilities. If you are running Windows, you may not have an SSH client already installed on your machine. Open a PowerShell console with Administrative rights and see if you have the client installed:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# You should see output similar to:
 
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

If the `State` of the `OpenSSH.Client` is not `Installed`, run:

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

## Connect using an ssh client from the command line

From a terminal or PowerShell console, run the following, substituting your username and the IP address for `1.1.1.1`:

```bash
ssh UserName@1.1.1.1
```

The first time you connect via SSH, you will receive a warning. Accept the fingerprint and you will be presented with a password prompt. Enter the password you specified while creating the DSVM. You should see a greeting screen and a command prompt.

This is the moment where, if this were a movie, you'd say "I'm in."

## Connect using a graphical user interface

If you wish to use a graphical user interface, you can use Microsoft Remote Desktop for the Windows Server 2019 DSVM and an XFCE client such as X2Go Client for the Ubuntu 18.04 DSVM.

## Connect to your Ubuntu DSVM using X2Go

The Linux VM is already provisioned with X2Go Server and ready to accept client connections. To connect to the Linux VM graphical desktop, complete the following procedure on your client:

1. Download and install the X2Go client for your client platform from [X2Go](https://wiki.x2go.org/doku.php/doc:installation:x2goclient).

1. Run the X2Go client. If the "New Session" window does not pop up automatically, go to Session -> New Session.

1. On the resulting configuration window, enter the following configuration parameters:
   - **Session tab**:
     - **Host**: Enter the IP address of your VM, which you made note of earlier.
     - **Login**: Enter the username on the Linux VM.
     - **SSH Port**: Leave it at 22, the default value.
     - **Session Type**: Change the value to **XFCE**. Currently, the Linux VM supports only the XFCE desktop.
   - **Media tab**: You can turn off sound support and client printing if you don't need to use them.
   - **Shared folders**: If you want directories from your client machines mounted on the Linux VM, add the client machine directories that you want to share with the VM on this tab.

   ![X2go configuration](../media/x2go-ubuntu.png)

1. Select **OK**.
1. Click on the box in the right pane of the X2Go window in order to bring up the log-in screen for your VM.
1. Enter the password for your VM.
1. Select **OK**.
1. You may have to give X2Go permission to bypass your firewall in order to finish connecting.
1. You should now see the graphical interface for your Ubuntu DSVM.

