Now that you have a remote host configured, you need to connect to it from VS Code. To connect to the remote machine, you need the Remote – SSH extension.

In this exercise, you'll install the [VS Code Remote – SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) and connect to the SSH host.

## Install a supported SSH client

Your local machine must have a supported SSH client to enable SSH connections to the remote machine.

- Install a [supported SSH client](https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-client) for your local operating system.

## Install the Remote – SSH extension

The VS Code Remote – SSH extension must be installed to connect to your SSH server from within VS Code.

1. Open VS Code.
2. Select the "Extensions" icon in the Activity Bar to open the Extensions view.

    :::image type="content" source="../media/5-extensions-view.png" alt-text="Screenshot highlighting the Extensions view in the VS Code activity bar.":::

1. Type "remote ssh."
1. Locate the Remote – SSH extension and select the Install button.

    :::image type="content" source="../media/5-remote-ssh-extension.png" alt-text="Screenshot highlighting how to search for an install the VS Code Remote - SSH extension.":::

1. The Remote - SSH extension will install, and you'll have access to the commands that it adds to Visual Studio Code.

## Set up new SSH host

Now, you can use the Remote - SSH commands in VS Code to set up your SSH host configuration.

1. In the Command Palette, run the command "Remote-SSH: Connect to Host…"

    :::image type="content" source="../media/5-connect-to-host.png" alt-text="Screenshot showing the Connect to Host command in the Command Palette.":::

1. Select "Add New SSH Host…". You'll be prompted to enter connection information for your VM. You need to specify to use the .pem file that contains the VM's private key. The command takes the following format:

    ```bash
    ssh user@hostname -i filepath
    ```

    - The `user` is the username you set when adding the SSH public key to your VM. If you kept the defaults, this value should be azureuser.
    - The `hostname` is the public IP address of the VM that you copied in the last step of the previous exercise. 
    - The `filepath` is the file path of the `.pem` file that was downloaded in the previous exercise.
    
    :::image type="content" source="../media/5-ssh-connection-command.png" alt-text="Screenshot showing the SSH connection command for connecting to the host.":::

1. Hit <kbd>Enter</kbd> to update the default SSH configuration file. This action adds a host to the configuration file.

## Connect to VM

Now that the host is configured, you can connect to the remote machine.

1. Run the "Remote-SSH: Connect to Host…" command again. You can now see your newly added host listed by its IP address. Select the host.
1. Once you select the host, VS Code will now open a new window. You'll see a notification that the "VS Code Server" is initializing on the SSH Host.

    :::image type="content" source="../media/5-initializing-vs-code-server.png" alt-text="Screenshot showing the Initializing VS Code Server notification when connecting to the SSH host.":::

1. You may be prompted to select the platform of the host. Select "Linux."
1. If prompted to trust the connection, select yes.
1. Once complete, you know that you're connected by viewing the remote indicator in the bottom left of the Status Bar in the editor.

    :::image type="content" source="../media/5-remote-indicator.png" alt-text="Screenshot showing the remote indicator in VS Code.":::

    - You can also click the remote indicator as a quick entry into top commands.
    
        :::image type="content" source="../media/5-remote-indicator-commands.png" alt-text="Screenshot showing the top commands that you can access by clicking the remote indicator.":::

1. Once you're connected to your SSH host, you can interact with files and open folders on the remote machine. If you open the integrated terminal, you'll see you're working inside a bash shell, even though your local machine may not be Linux-based!

    :::image type="content" source="../media/5-bash-shell.png" alt-text="Screenshot showing the bash shell on the remote machine.":::
 
You successfully connected to the VM! Other than providing the host and connection information, VS Code takes care of the rest of the connection process, so you don't need to memorize any commands or worry about other configuration.

In the next section, you'll learn how to run and debug code while connected using SSH in VS Code.
