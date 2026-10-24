Wide World Importers has thousands of machines across multiple offices. Given the scale of the deployment, an immediate concern is how to successfully onboard all the servers.

For a single server, use a portal-generated onboarding script or Azure PowerShell. Windows Admin Center is another option for Windows servers. For multiple servers, generate a noninteractive onboarding script that uses a Microsoft Entra service principal with an explicitly scoped Azure Connected Machine Onboarding role. Distribute and run the script with an appropriate configuration-management tool, such as Group Policy, Configuration Manager, or Ansible.

With many deployment methods, you can deploy Azure Arc-enabled servers at scale using the tooling that best fits the needs and expertise of your organization.

## Deploy to a single server

For a supported Windows or Linux server, use the Azure portal to generate an onboarding script or use Azure PowerShell on the target server. Windows Admin Center provides an additional onboarding workflow for Windows servers. The following table compares these methods:

| Method | Description |
|---|---|
| **Azure portal** | After submitting resource and deployment details in the Azure portal, you're provided with a script to Arc-enable a server. You must download and run this script with elevated privileges on your Windows or Linux servers. This method requires that you authenticate to your Azure subscription interactively for each installation. |
| **Azure PowerShell** | Use `Connect-AzConnectedMachine` from the `Az.ConnectedMachine` module to download and install the Connected Machine agent and register the machine with Azure Arc. Local execution supports Windows and Linux. Follow the PowerShell onboarding prerequisites and procedure, including elevated local access and Azure authentication. Remote onboarding through the cmdlet's `-PSSession` parameter supports Windows targets only. |
| **Windows Admin Center** | You can use Windows Admin Center to deploy the Connected Machine agent and register your on-premises servers without having to do any steps outside of this tool. Select the **Leverage Azure policies and solutions to manage your servers with Azure Arc** service under Azure hybrid services in the Windows Admin Center. |

> [!NOTE]
> Initial onboarding installs the Connected Machine agent and creates the server's Azure Arc resource. After onboarding, use Azure Machine Configuration to audit or apply supported guest settings. Machine Configuration isn't a replacement for installing the Connected Machine agent on an unregistered server.

## Deploy to multiple servers

For at-scale onboarding, use a Microsoft Entra service principal with the **Azure Connected Machine Onboarding** role assigned at the smallest appropriate scope, normally the target resource group. Generate an onboarding script for that identity and distribute it through your existing configuration-management tooling. The following table describes script generation and distribution:

| Method | Description |
|---|---|
| **Service-principal onboarding script** | Generate a script from **Azure Arc** > **Infrastructure** > **Machines** > **Onboard/Create** > **Onboard existing machines**. On **Basics**, select **Authenticate machines automatically** and the service principal authorized for the target scope. Run the script on the target servers with local administrator or root privileges. |
| **Configuration-management distribution** | Use an appropriate tool, such as Group Policy, Configuration Manager, or Ansible, to distribute and run the onboarding script. Pilot the deployment, verify **Connected** status, and then expand to the remaining servers. |

> [!IMPORTANT]
> Azure Update Manager is used after onboarding; it isn't a substitute for installing and connecting the Connected Machine agent. Creating a service principal doesn't automatically grant it access to your Azure resources. Assign the required role explicitly and protect its credentials in your deployment system.

A service principal's effective permissions depend on its role assignments and their scopes, not its identity type. Review additional or inherited permissions before distribution. Don't embed reusable secrets in example source files or distribute them through broadly readable shares.

The service principal authenticates the initial connection. After onboarding, the server uses its system-assigned managed identity for ongoing Azure Arc communication.

You can use a range of existing software configuration products to deploy the Arc-enabled server agent to machines at scale. Use the service-principal onboarding script for noninteractive deployment instead of a script that requires separate interactive authentication for each server. Choose from the following distribution options:

- **Group Policy**: Define a new Group Policy Object (GPO) for running a PowerShell script, link the GPO to the desired organizational unit, and schedule a task to deploy to multiple servers.

- **Microsoft Configuration Manager**: Author, approve, and run a custom PowerShell script on a collection of devices. See Create and run scripts - Configuration Manager.

- You can also use other automation tooling like Chef, Puppet, or Ansible to deploy the script to managed servers.
