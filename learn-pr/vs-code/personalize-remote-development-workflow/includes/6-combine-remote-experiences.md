In addition to Profiles and Settings Sync, you can further customize your remote development experience by using remote environments together. Combining remote environments is a common practice, and allows you to use the best of each environment.

## Combine Dev Containers with SSH

A common model is to combine a remote machine with a docker container. Using a docker container on a remote machine is useful for standardizing a development environment across a team while still applying the power of remote compute.

To use Dev Containers with the Remote - SSH extension, you'll need to install the Remote - SSH extension on your local machine. You can do this by opening the Extensions view in VS Code and searching for "Remote - SSH."

In addition, the remote machine will need to have Docker installed.

### Connect to the SSH host

Once you have the Remote - SSH extension installed, you can connect to a remote machine using the **Remote - SSH: Connect to Host** command in the Command Palette. You can also use the Remote Explorer view to connect to a remote machine.

:::image type="content" source="../media/6-ssh-connect-to.png" alt-text="Screenshot of VS Code Command Palette showing the SSH Connect To option.":::

This command allows you to specify the IP address of the machine you wish to connect to. You can also specify a username and port number if needed.

:::image type="content" source="../media/6-ssh-targets.png" alt-text="Screenshot of VS Code SSH host list.":::

### Open the project on the SSH in a Dev Container

Once you connect to the remote machine, you can open a project with a dev container configuration by using the **Remote-Containers: Open Folder in Container** command in the Command Palette. There's nothing special about running a dev container on a remote machine. The process is the same as running a dev container locally.

:::image type="content" source="../media/6-dev-container-ssh.png" alt-text="Screenshot of remote indicator in Visual Studo Code showing a dev container running at a remote SSH address":::

There's now a dev container running on a remote machine. In this scenario, you would be remoted into the virtual machine with SSH, and then remoted into the dev container with VS Code. This allows you to apply the power of the remote machine while still having a consistent development environment with dev container configurations.
