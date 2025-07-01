Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to their Linux systems. Through SSH, Azure Arc provides Contoso with a secure, encrypted connection for managing both their Windows and Linux machines.

SSH for Azure Arc provides SSH-based connections to Linux machines on Azure Arc without requiring a public IP address or other open ports. This functionality can be used interactively, automated, or with existing SSH-based tooling, allowing existing management tools to have a greater impact. With SSH you can access any of your machines, in any network, with one Azure CLI or Microsoft PowerShell command. You can use your existing local SSH keys to connect to your machines. With Linux machines, you can also use SSH with Microsoft Entra credentials.

## Enable SSH functionality

To use SSH with a Linux machine connected via Azure Arc, the following high-level steps are required:

1. Verify that you satisfy all the prerequisites. You need:

    - Azure CLI or Azure PowerShell installed on your remote workstation. The examples below use Azure CLI.
    - To be logged in to your Azure environment
    - `openssh-server` installed on the Linux machine via a package manager

1. Enable connections on the Connected Machine agent installed on the Linux machine.

    View your current connections:

    `azcmagent config list`

    Ensure connection is enabled to a specific port:

    `azcmagent config set incomingconnections.ports 22`

    Replace port 22 in this command if you use a different port, or add additional ports if needed.

1. Install the SSH extension on your remote workstation:

    `az extension add --name ssh`

1. Make the connection between the workstation to the Linux machine through Azure Arc:

    `az ssh arc --resource-group YOUR_RESOURCE_GROUP YOUR_HOSTNAME --local-user YOUR_LOCAL_USER_NAME`

    To connect using Microsoft Entra ID instead of connecting as a local user, remove the `--local-user` parameter from the preceding command. You need to already be logged in through Microsoft Entra ID for this method to work, and additional packages must be installed on the Linux machine.

Once you establish your SSH connection, you can manage the Linux resource securely.
