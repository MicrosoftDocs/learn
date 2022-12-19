Azure Automanage can be enabled on existing or new virtual machines using the Azure portal, Azure Resource Manager (ARM), or Azure Policy.

## Enable Azure Automanage on a VM using the Azure portal

If you don't have an Azure subscription, [create an account](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/) before you begin.

> [!NOTE]
> Free trial accounts do not have access to the virtual machines used in this tutorial. Please upgrade to a Pay-As-You-Go subscription.

> [!IMPORTANT]
> You need to have the **Contributor** role on the resource group containing your VMs to enable Automanage. If you are enabling Automanage for the first time on a subscription, you need the following permissions: **Owner** role or **Contributor** along with **User Access Administrator** roles on your subscription.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, search for an select **Automanage**.
1. In the menu, select **Automanage machines**.
1. Select **Enable on existing machine**.
1. On the **Basics** tab, select your profile type: **Azure best practices: Production** or **Azure best practices: Dev/Test**.
    The profile type you select will determine the services and settings applied to your machine(s). To view the details for the different profiles, select **View Azure best practices profiles**:
    IMAGE HERE
1. Select the **Machines** tab, then check the box for the machine(s) you want to enable for Automanage:
1. Select the Review + Create tab to review the machine(s) you've chose, then select the **Create** button.









<!-->
Contoso uses SSH for their Windows machines to provide secure management, remote access to resources, and updates. They want to apply that same level of security to their Linux systems. Through SSH, Azure Arc provides Contoso with a secure, encrypted connection for managing both their Windows and Linux machines.

SSH for Azure Arc provides SSH-based connections to Linux machines on Azure Arc without requiring a public IP address or additional open ports. This functionality can be used interactively, automated, or with existing SSH-based tooling, allowing existing management tools to have a greater impact. SSH access allows you to reach your Linux machines through a simple Azure CLI command or through Microsoft PowerShell. You can leverage your existing local SSH keys to connect to your Linux machines.

Additionally, you can use SSH with Azure Active Directory credentials. With SSH you can access any of your machines, in any network, with one command, without exposing a public IP address or opening additional inbound firewall ports.

> [!NOTE]
> Azure Active Directory authorization is limited to Linux machines.

## Supported Linux environments

- CentOS: CentOS 7, CentOS 8
- RedHat Enterprise Linux (RHEL): RHEL 7.4 to RHEL 7.10, RHEL 8.3+
- SUSE Linux Enterprise Server (SLES): SLES 12, SLES 15.1+
- Ubuntu Server: Ubuntu Server 16.04 to Ubuntu Server 20.04

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

    To connect using Azure Active Directory instead of connecting as a local user, remove the `--local-user` parameter from the command above. You need to already be logged in through Azure Active Directory for this method to work.

Once you've established your SSH connection, you can now manage the Linux resource securely.