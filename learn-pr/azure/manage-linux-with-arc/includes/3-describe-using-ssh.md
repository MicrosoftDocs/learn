> [!CAUTION]
> This content references CentOS, a Linux distribution that is nearing End Of Life (EOL) status. Please consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to their Linux systems. Through SSH, Azure Arc provides Contoso with a secure, encrypted connection for managing both their Windows and Linux machines.

SSH for Azure Arc provides SSH-based connections to Linux machines on Azure Arc without requiring a public IP address or additional open ports. This functionality can be used interactively, automated, or with existing SSH-based tooling, allowing existing management tools to have a greater impact. SSH access allows you to reach your Linux machines through a simple Azure CLI command or through Microsoft PowerShell. You can leverage your existing local SSH keys to connect to your Linux machines.

Additionally, you can use SSH with Microsoft Entra credentials. With SSH you can access any of your machines, in any network, with one command, without exposing a public IP address or opening additional inbound firewall ports.

> [!NOTE]
> Microsoft Entra authorization is limited to Linux machines.

## Supported Linux environments

- CentOS: CentOS 7, CentOS 8
- RedHat Enterprise Linux (RHEL): RHEL 7.4 to RHEL 7.9, RHEL 8.3+
- SUSE Linux Enterprise Server (SLES): SLES 12, SLES 15.1+
- Ubuntu Server: Ubuntu Server 16.04 to Ubuntu Server 22.04
- Common Base Linux Mariner (CBL-Mariner): CBL-Mariner 1, CBL-Mariner 2
- Debian: Debian 9, Debian 10, Debian 11
- openSUSE: openSUSE Leap 42.3, openSUSE Leap 15.1+

## Enabling SSH functionality

In order to connect to a Linux resource using SSH through Azure Arc, the resource will need to be fully Arc-enabled. That means that it already has the Azure Arc Connected machine agent (azmagent) installed and functioning properly, so that the resource appears as an Arc resource in the Azure portal. 

To use SSH with a Linux machine connected via Azure Arc, the following high-level steps are required:

1. Verify that you satisfy all the prerequisites. You'll need:
    
    - Azure CLI installed on your remote work station
    - To be logged in to your Azure environment
    
1. Enable connections on the Connected Machine agent installed on the Linux machine.
    
    Run the following command to view your current connections:
    
    `azcmagent config list`
    
    If you have existing ports, you'll need to include them in the following command:
    
    `azcmagent config set incomingconnections.ports 22<,other open ports,...>`
    
    If you're using a non-default port for your SSH connection, replace port 22 with your desired port in the previous command.

1. Install the SSH extension on your remote workstation:
    
    `az extension add --name ssh`
    
1. Run the following command to make the connection between the workstation to the linux machine through Azure Arc:
    
    `az ssh arc --resource-group \<resource-group\> \<host-name\> --local-user \<local-user-name\>`

    To connect using Microsoft Entra ID instead of connecting as a local user, remove the `--local-user` parameter from the command above. You need to already be logged in through Microsoft Entra ID for this method to work.

Once you've established your SSH connection, you can now manage the Linux resource securely.
