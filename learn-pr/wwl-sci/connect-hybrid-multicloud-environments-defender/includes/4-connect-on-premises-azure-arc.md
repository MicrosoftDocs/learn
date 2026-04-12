On-premises servers present a unique challenge in Defender for Cloud's multicloud strategy: unlike AWS or GCP, where native cloud connectors read resource configurations directly from cloud provider APIs, on-premises machines have no API surface that Defender for Cloud can call. The solution is **Azure Arc–enabled servers**—a technology that installs a lightweight Azure Connected Machine agent on each machine, registering it as a native Azure resource with an Azure Resource ID, and making it manageable and monitorable through Azure services.

## How Azure Arc-enabled servers work with Defender for Cloud

Once a machine is Arc-enabled, it appears in Defender for Cloud's Inventory alongside native Azure VMs. The machine gets the same posture assessment, recommendation generation, and CWPP plan coverage as an Azure VM—because from Defender for Cloud's perspective, *it's* an Azure resource.

An Arc-enabled server running Windows Server or Linux:

- Contributes to the subscription's secure score
- Receives CSPM recommendations for OS-level configuration findings
- Becomes eligible for Defender for Servers protection when the plan is enabled on the subscription
- Appears in the Microsoft Defender XDR unified asset inventory alongside Azure VMs, AWS EC2 instances, and GCP Compute Engine VMs

The Azure Connected Machine agent sends heartbeats, configuration data, and security signals to Azure. For production environments with strict network controls, the agent supports proxy configuration and private endpoint communication through Azure Arc private link scope. For required endpoints and TLS inspection guidance, see the NOTE at the end of this unit.

:::image type="content" source="../media/arc-defender-integration.png" alt-text="Diagram showing the Azure Connected Machine agent connecting an on-premises server to Defender for Cloud.":::

## Choose a deployment path

Two deployment paths exist for Arc-enabling on-premises machines, suited to different deployment scales.

### Single-machine deployment

For individual machines or small-scale pilots, use the Azure portal to generate a deployment script:

1. In Defender for Cloud, select **Environment settings** > **Add environment** > **On-premises servers**.
2. Alternatively, go to **Azure Arc** > **Azure Arc resources** > **Machines** > **Add/Create** > **Add a single server**.
3. Follow the prompts to select the subscription, resource group, and operating system type.
4. The portal generates a PowerShell script (Windows) or Shell script (Linux).
5. Run the script on the target machine with local administrator privileges.

The script downloads the Connected Machine agent installer, installs the agent, and registers the machine with Azure. The script is valid for a short time window—typically 24 hours—so run it promptly after generation.

### At-scale deployment

For fleets of on-premises servers, use a **service principal** to automate agent installation across machines without interactive credentials:

1. Create a service principal in Microsoft Entra ID and assign it the **Azure Connected Machine Onboarding** role.
2. Generate a deployment script from the Azure Arc portal that uses service principal authentication.
3. Distribute the script through your existing management tooling: Group Policy, System Center Configuration Manager (SCCM), Ansible, or any similar orchestration tool.
4. The script installs the Connected Machine agent on each machine and registers it using the service principal credentials.

The service principal approach means each machine installs the agent independently, with no manual intervention required per machine. You set the target subscription and resource group once in the script configuration, and all machines register there.

> [!TIP]
> Create dedicated resource groups for Arc-enabled on-premises servers that mirror your physical location structure. For example, use a resource group named `rg-arc-datacenter-eastus` for machines in your East US data center. Dedicated resource groups let you apply Azure Policy and Defender plans at the resource group level with precision.

> [!NOTE]
> **Azure VMware Solution (AVS) machines** follow the same Arc onboarding path. AVS machines don't have an Azure Resource ID by default and aren't automatically discovered by Defender for Cloud. Deploy the Connected Machine agent on each AVS machine using the single-machine or at-scale approach.

## Retire monitoring agent: Arc is now the required path

A critical change affects on-premises server onboarding: the **Microsoft Monitoring Agent (MMA)**, also known as the Log Analytics agent, retired in August 2024. Any Defender for Cloud guidance that references MMA-based onboarding for on-premises servers is outdated. The current and supported path is Azure Arc.

- **Defender for Servers Plan 1**: Direct Microsoft Defender for Endpoint (MDE) onboarding provides some Plan 1 capabilities—including threat detection and vulnerability assessment—without Arc.
- **Defender for Servers Plan 2**: Requires Azure Arc for full feature availability, including just-in-time (JIT) VM access, file integrity monitoring, agentless scanning, and 500-MB daily free log ingestion per server.

For Contoso's compliance audit requirements, Plan 2 features are essential. Arc is required for on-premises servers that need full CWPP coverage.

> [!TIP]
> After deploying the Arc agent, verify connectivity by opening **Inventory** in Defender for Cloud and filtering for Arc-enabled server resources. If a machine shows no Defender for Servers coverage, confirm that Defender for Servers Plan 1 or Plan 2 is active on the target subscription.

> [!NOTE]
> The Connected Machine agent requires outbound HTTPS (port 443) to `management.azure.com`, `login.microsoftonline.com`, `guestconfiguration.azure.com`, and `*.his.arc.azure.com`. In environments with TLS inspection, exclude these endpoints—the agent uses its own certificate store.

