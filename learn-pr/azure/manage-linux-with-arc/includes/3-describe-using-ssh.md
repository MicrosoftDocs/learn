Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to their Linux systems. Through SSH, Azure Arc provides Contoso with a secure, encrypted connection for managing both their Windows and Linux machines.

SSH for Azure Arc provides SSH-based connections to Linux machines on Azure Arc without requiring a public IP address or additional open ports. This functionality can be used interactively, automated, or with existing SSH-based tooling, allowing existing management tools to have a greater impact. SSH access allows you to reach your Linux machines through a simple Azure CLI command or through Microsoft PowerShell. You can leverage your existing local SSH keys to connect to your Linux machines.

Additionally, you can use SSH with Azure Active Directory credentials. With SSH you can access any of your machines, in any network, with one command, without exposing a public IP address or opening additional inbound firewall ports.

> [!NOTE]
> Azure Active Directory authorization is limited to Linux machines.

## Supported Linux enviroments

- CentOS: CentOS 7, CentOS 8
- RedHat Enterprise Linux (RHEL): RHEL 7.4 to RHEL 7.10, RHEL 8.3+
- SUSE Linux Enterprise Server (SLES): SLES 12, SLES 15.1+
- Ubuntu Server: Ubuntu Server 16.04 to Ubuntu Server 20.04


