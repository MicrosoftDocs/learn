Now that you've created a Data Science Virtual Machine, you need to connect to it. The DSVM is preconfigured for ssh access on both Ubuntu and Windows Server 2019. With ssh, you can connect to the command-line of the DSVM. You can also use a full graphical desktop, using Remote Desktop for Windows and X2Go client for Linux. But first, you'll need to authenticate with your DSVM via ssh key pair. 

## Install the ssh private key 

When you created the DSVM in the previous step, you downloaded a **.PEM** file containing a private key associated with the account `AzureUser` on the DSVM. Authenticating this way depends on the operating system you're running locally. 

::: zone pivot="Windows"

On windows you tk

::: zone-end

::: zone pivot="Mac or Linux"

On a Mac or Linux tk

::: zone-end
