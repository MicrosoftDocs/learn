Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to managing their Linux systems. Through SSH, Azure Arc provides Contoso with a secure encrypted connection for managing their Linux machines.

SSH for Arc provides SSH-based connections to Arc-enabled Linux machines without requiring a public IP address or additional open ports. This functionality can be used interactively, automated, or with existing SSH based tooling, allowing existing management tools to have a greater impact. SSH access allows you to reach your Linux machines through a simple Azure CLI command. You can leverage your existing local SSH keys to connect to your Linux machines. Additionally, you can use SSH with Azure AD credentials. With SSH you can access any of your machines, in any network, with one command, without exposing a public IP address or opening additional inbound firewall ports.

## Prerequisites

To use SSH for your Arc-enabled Linux machines, you'll need the following:

- Access as an [Azure user](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-linux)

## Supported Linux enviroments

- CentOS: CentOS 7, CentOS 8
- RedHat Enterprise Linux (RHEL): RHEL 7.4 to RHEL 7.10, RHEL 8.3+
- SUSE Linux Enterprise Server (SLES): SLES 12, SLES 15.1+
- Ubuntu Server: Ubuntu Server 16.04 to Ubuntu Server 20.04


