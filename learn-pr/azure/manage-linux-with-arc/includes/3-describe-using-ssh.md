Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to their Linux systems. Through SSH, Azure Arc provides Contoso with a secure, encrypted connection for managing both their Windows and Linux machines.

SSH for Azure Arc provides SSH-based connections to Linux machines on Azure Arc without requiring a public IP address or other open ports. This functionality can be used interactively, automated, or with existing SSH-based tooling, allowing existing management tools to have a greater impact. SSH access allows you to reach your Linux machines through a simple Azure CLI command or through Microsoft PowerShell. You can use your existing local SSH keys to connect to your Linux machines.

Additionally, you can use SSH with Microsoft Entra credentials. With SSH you can access any of your machines, in any network, with one command. All without exposing a public IP address or opening more inbound firewall ports.

> [!NOTE]
> Microsoft Entra authorization is limited to Linux machines.

## Supported Linux environments

For SSH access to Azure Arc-enabled servers, the supported Linux environments include:

- RedHat Enterprise Linux (RHEL) 7, 8, and 9
- SUSE Linux Enterprise Server (SLES) 12 SP3-SP5 and 15
- Ubuntu 18.04, 20.04, and 22.04 LTS12
- Azure Linux (CBL-Mariner) 2.0
- AlmaLinux 9
- Amazon Linux 2 and 2023
- Debian 11 and 12
- Oracle Linux 7, 8, and 9
- Rocky Linux 8 and 9

## Enabling SSH functionality

In order to connect to a Linux resource using SSH through Azure Arc, the resource needs to be fully Arc-enabled. That means that it already has the Azure Arc Connected machine agent installed and functioning properly, so that the resource appears as an Arc resource in the Azure portal.

To use SSH with a Linux machine connected via Azure Arc, the following high-level steps are required:

1. Verify that you satisfy all the prerequisites. You need:

    - Azure CLI installed on your remote work station
    - To be logged in to your Azure environment

1. Enable connections on the Connected Machine agent installed on the Linux machine.

    Run the following command to view your current connections:

    `azcmagent config list`

    If you have existing ports, you need to include them in the following command:

    `azcmagent config set incomingconnections.ports 22<,other open ports,...>`

    If you're using a nondefault port for your SSH connection, replace port 22 with your desired port in the previous command.

1. Install the SSH extension on your remote workstation:

    `az extension add --name ssh`

1. Run the following command to make the connection between the workstation to the linux machine through Azure Arc:

    `az ssh arc --resource-group \<resource-group\> \<host-name\> --local-user \<local-user-name\>`

    To connect using Microsoft Entra ID instead of connecting as a local user, remove the `--local-user` parameter from the preceding command. You need to already be logged in through Microsoft Entra ID for this method to work.

Once you establish your SSH connection, you can manage the Linux resource securely.
