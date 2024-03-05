Now that you've set up your SSH server, let's learn how to connect to the remote machine from your local machine. Developers at your agency want to continue using Visual Studio Code as their editor. Developing on a remote machine using Visual Studio Code is possible through the Remote - SSH extension.

## The Remote - SSH extension
 
The [VS Code Remote - SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) lets you use any remote machine with an SSH server as your development environment. The extension opens a connection between your local machine and the remote. The extension installs a server, called the [VS Code Server](https://code.visualstudio.com/docs/remote/vscode-server), on the remote environment, which allows local VS Code to smoothly interact with remote source code and runtimes.

Once connected to a remote machine, you can interact with files and folders anywhere on the remote file system and take advantage of the full feature set of Visual Studio Code, like IntelliSense (completions), code navigation, and debugging. The extension runs commands and other extensions directly on the remote machine, so no source code needs to be on your local machine to gain these benefits. 

:::image type="content" source="../media/4-remote-ssh-architecture.png" alt-text="Diagram showing how the Remote - SSH extension connects the local VS Code editor to the remote machine's development environment.":::
 
VS Code runs extensions in one of two places: locally on the UI / client side, or remotely on the SSH host. While extensions that affect the VS Code UI, like themes, are installed locally, most extensions reside on the remote machine. This setup ensures you have a smooth experience and allows you to install any needed extensions for a given workspace on a remote machine from your local machine. This way, you can pick up exactly where you left off, from a different machine complete with your extensions.

Only use Remote-SSH to connect to secure remote machines that you trust and that are owned by a party whom you trust. A compromised remote could use the VS Code Remote connection to execute code on your local machine.

In the next section, you'll install the Remote – SSH extension and use it to connect to the SSH server that you created.
