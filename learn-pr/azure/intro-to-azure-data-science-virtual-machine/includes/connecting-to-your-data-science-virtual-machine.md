Now that you've created a Data Science Virtual Machine, you need to connect to it. The DSVM is preconfigured for ssh access on both Ubuntu and Windows Server 2019. With ssh, you can connect to the command-line of the DSVM. You can also use a full graphical desktop, using Remote Desktop for Windows and X2Go client for Linux. But first, you'll need to authenticate with your DSVM via ssh key pair. 

## Install the ssh private key 

When you created the DSVM in the previous step, you downloaded a **.pem** file containing a private key associated with the account `AzureUser` on the DSVM. Authenticating this way depends on the operating system you're running locally. 

::: zone pivot="windows"

You may or may not have an ssh client already installed on your machine. Open a PowerShell console with Administrative rights and see if you have the client installed:

```powershell
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# You should see output similar to:
 
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

If the `State` of the `OpenSSH.Client` is not `Installed`, run

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

Create a directory in which you will store ssh keys, move the **AzureUserPrivateKey.pem** file to it, and protect the file from prying eyes. In the PowerShell console, switch to the folder to which you downloaded the **.pem** file and run:

```powershell
$ssh_folder="C:\Program Files\ssh"
$key_file="AzureUserPrivateKey.pem"
md -Force $ssh_folder
mv $key_file $ssh_folder
cd $ssh_folder
icacls $key_file /reset
icacls $key_file /grant:r /"$($env:USERNAME):(R) /inheritance:r"
```

This first creates the folder **C:\Program Files\ssh**. The `-Force` option eliminates the warning if the folder exists (and does not overwrite the contents). Then, it moves the **.pem** file to the directory and switches to the directory. The **icacls** utility modifies the discretionary access control list for the file. The first command resets access, the second command removes all inherited Access Control Entries and then allows read-only access to only the current user. 

::: zone-end

::: zone pivot="macos,linux"

Move the **AzureUserPrivateKey.pem** file to the **~/.ssh/** directory and protect it from prying eyes. Open a terminal, navigate to the directory to which you downloaded the **.pem** file, and run:

```bash
mkdir -p ~/.ssh
mv AzureUserPrivateKey.pem ~/.ssh
chmod ~/.ssh/AzureUserPrivateKey.pem 400
```

The first line creates, if necessary, the **.ssh/** directory below your home directory. The second line copies the file to that directory, and the third line sets permissions so that only the user has read-only access.

::: zone-end

To access the DSVM, you'll use:

- The path to the **AzureUserPrivateKey.pem** file you just secured
- The username associated with that key (i.e., `AzureUser`)
- The public IP address of the running DSVM

In the Azure Portal, find the IP address of your DSVM. Click the icon next to the IP to copy it to your clipboard

![Screenshot of the Azure Portal, highlighting the IP address of the virtual machine](tk)

From a terminal or PowerShell console, run the following, substituting the full path to the **.pem** file and the IP address for `1.1.1.1`:

```bash
ssh -i /path/to/AzureUserPrivateKey.pem AzureUser@1.1.1.1
```

The first time you connect via ssh, you will receive a confirmation message with a fingerprint based on the public key that is paired to the private key you're using. Accept the fingerprint and you should be logged on to your DSVM!

This is the moment where, if this were a movie, you'd say "I'm in."