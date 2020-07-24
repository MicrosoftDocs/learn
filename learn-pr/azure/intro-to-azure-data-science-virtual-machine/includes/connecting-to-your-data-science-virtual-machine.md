Now that you've created a Data Science Virtual Machine, you need to connect to it. The Data Science Virtual Machine is preconfigured for SSH access on both Ubuntu and Windows Server 2019. With SSH, you can connect to the command line of the Data Science Virtual Machine. You can also use a full graphical desktop, using Remote Desktop for Windows and X2Go client for Linux. 

## Starting and stopping the Data Science Virtual Machine

Since you just created the virtual machine it will already be running. In general, you bookend your sessions with the virtual machine by starting and stopping it from the Azure portal. The portal is also where you can find the public IP address of your virtual machine, which you will need to connect. 

![Screenshot of portal highlighting start stop buttons and IP address](../media/dsvm-started-in-portal.png)

## Securing your virtual machine


tk

## Connect to the command line using SSH

To access the command line of your Data Science Virtual Machine, you'll use:

- An SSH client running in a terminal on your local machine
- The username and password you specified during creation
- The public IP address of the running Data Science Virtual Machine

### Install an SSH client on Windows, if necessary

If you're running Linux or macOS, an ssh client is part of the OS standard utilities. If you're running Windows, you may not have an SSH client already installed on your machine. Open a PowerShell console with Administrative rights and see if you have the client installed:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# You should see output similar to:
 
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

If the `State` of the `OpenSSH.Client` isn't `Installed`, run:

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

## Connect using an ssh client from the command line

From a terminal or PowerShell console, run the following, replacing your username and the IP address for `1.1.1.1`:

```bash
ssh UserName@1.1.1.1
```

The first time you connect via SSH, you'll receive a warning. Accept the fingerprint and you'll be presented with a password prompt. Enter the password you specified while creating the Data Science Virtual Machine. You should see a greeting screen and a command prompt.

## Connect using a graphical user interface

If you wish to use a graphical user interface, you can use:

* Microsoft Remote Desktop for the Windows Server 2019 Data Science Virtual Machine
* An XFCE client such as X2Go Client for the Ubuntu 18.04 Data Science Virtual Machine.

