On a Windows Data Science Virtual Machine (DSVM), the graphical desktop is available via Remote Desktop Protocol (RDP).

With SSH, you can connect to the command line of the DSVM. Both Windows and Ubuntu DSVM images support SSH connection.

## Connect to a Windows server by using RDP

To connect to a Windows DSVM with Remote Desktop:

1. If necessary, download the [Microsoft Remote Desktop client](https://www.microsoft.com/p/microsoft-remote-desktop/9wzdncrfj3ps?portal=true).

1. Go back to the DSVM in the Azure portal.

1. Select **Connect** > **RDP**.

1. Select **Download RDP File**.

1. Open the file in Microsoft Remote Desktop to connect.

    :::image type="content" source="../media/download-rdp-file.png" alt-text="Screenshot of the portal showing the RDP file download page.":::

## Connect to the command line by using SSH

To access the command line of your DSVM, you use:

- An SSH client running in a terminal on your local machine.
- The username and password that you specified during creation.
- The public IP address of the running Data Science Virtual Machine.

### Install an SSH client on Windows, if necessary

If you're running Linux or macOS, an SSH client is part of the OS standard utilities. If you're running Windows, you might not have an SSH client already installed on your machine. Open a PowerShell console with administrative rights and see if you have the client installed:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# You should see output similar to:
 
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

If the `State` value of `OpenSSH.Client` isn't `Installed`, run:

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

### Connect by using an SSH client from the command line

From a terminal or a PowerShell console, run the following code. Replace `UserName` and `1.1.1.1` with your username and IP address.

```bash
ssh UserName@1.1.1.1
```

The first time you connect via SSH, you'll receive a warning. Accept the fingerprint and you'll be presented with a password prompt. Enter the password you specified while creating the DSVM. You should see a greeting screen and a command prompt.
