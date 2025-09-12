Microsoft Defender for Cloud collects data from your Azure virtual machines (VMs), virtual machine scale sets, IaaS containers, and non-Azure (including on-premises) machines to monitor for security vulnerabilities and threats.

Data collection is required to provide visibility into missing updates, misconfigured OS security settings, endpoint protection status, and health and threat protection. Data collection is only needed for compute resources (VMs, virtual machine scale sets, IaaS containers, and non-Azure computers). You can benefit from Defender for Cloud even if you don’t provision agents. However, you have limited security, and the capabilities listed above aren't supported.

Data is collected using:

- **Azure Monitor Agent (AMA)** - The recommended modern agent that collects security-related configurations and event logs from machines and copies the data to your workspace for analysis.

- **Microsoft Defender for Endpoint** - Provides advanced threat protection capabilities and endpoint detection and response.

- **Log Analytics agent** - This agent is officially retired (August of 2024), and is no longer supported. [Migrate to the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-migration) for new deployments.

- Security extensions, such as the Azure Policy Add-on for Kubernetes, which can also provide data to Security Center regarding specialized resource types.

> [!NOTE]
> Auto provisioning is now done on the **Settings & monitoring** page.

:::image type="content" source="../media/auto-provisioning-options.png" alt-text="Screenshot of Auto provisioning settings." lightbox="../media/auto-provisioning-options.png":::

## Why use auto provisioning?

Any of the agents and extensions described on this page can be installed manually. However, auto provisioning reduces management overhead by installing all required agents and extensions on existing - and new - machines to ensure faster security coverage for all supported resources.

## How does auto provisioning work?

Defender for Clouds's auto provisioning settings has a toggle for each type of supported extension. When you enable auto provisioning of an extension, you assign the appropriate *Deploy if not exists* policy to ensure that the extension is provisioned on all existing and future resources of that type.

## Enabling auto provisioning for the Defender for Endpoint sensor

Defender for Endpoint integration is enabled by default when you enable a Defender for Servers plan. If you turn off the Defender for Endpoint integration on a subscription, you can turn it on again manually when necessary using these instructions.

1. In Defender for Cloud, select **Environment settings** and select the subscription containing the machines on which you want to deploy the Defender for Endpoint integration.

1. In **Settings and monitoring** > **Endpoint protection**, toggle the **Status** column settings to **On**.

1. Select **Continue** and **Save** to save your settings.

1. The Defender for Endpoint sensor is deployed to all Windows and Linux machines in the selected subscription.

    Onboarding might take up to an hour. Defender for Cloud detects any previous Defender for Endpoint installations and reconfigures them to integrate with Defender for Cloud.

> [!NOTE]
> For Azure VMs created from generalized OS images, Microsoft Defender for Endpoint (MDE) won't be automatically provisioned via this setting; however, you can manually enable the MDE agent and extension using Azure CLI, REST API, or Azure Policy.

## Direct onboarding with Microsoft Defender for Endpoint

For non-Azure servers (on-premises and multicloud environments), you can use direct onboarding to connect your machines to Microsoft Defender for Cloud through the Defender for Endpoint agent. This approach provides a seamless integration without requiring Azure Arc or extra software deployment.

### How direct onboarding works

Direct onboarding creates a unified protection experience by:

- Automatically showing your non-Azure servers onboarded to Defender for Endpoint in Defender for Cloud under a designated Azure subscription
- Providing licensing, billing, alerts, and security insights through the Azure subscription
- Integrating vulnerability data and software inventory with Defender for Cloud

> [!IMPORTANT]
> Direct onboarding doesn't provide server management capabilities like Azure Policy, Extensions, or Guest configuration. You must use other tools such as Defender for Endpoint security settings management, Configuration Manager, Group Policy, or PowerShell to manage security settings.

### Enable direct onboarding

To enable direct onboarding:

1. In Defender for Cloud, go to **Environment Settings** > **Direct onboarding**.

1. Switch the **Direct onboarding** toggle to **On**.

1. Select the subscription you want to use for servers onboarded directly with Defender for Endpoint.

1. Select **Save**.

After enabling direct onboarding for the first time, it might take up to 24 hours to see your non-Azure servers in your designated subscription.

### Deploy Defender for Endpoint on your servers

Once direct onboarding is enabled, deploy the Defender for Endpoint agent on your on-premises Windows and Linux servers using the standard Defender for Endpoint onboarding process. The deployment method is the same whether you use direct onboarding or not.

### Limitations

- **Plan support**: Direct onboarding provides access to all Defender for Servers Plan 1 features. For Plan 2 features, certain capabilities still require Azure Arc on non-Azure machines.
- **Multicloud support**: You can directly onboard AWS and GCP VMs, but if you plan to use multicloud connectors simultaneously, Azure Arc is still recommended.
- **Agent versions**: Ensure your Defender for Endpoint agent meets minimum version requirements to avoid limitations with simultaneous onboarding methods.

### Information for Microsoft Sentinel users

Users of Microsoft Sentinel: note that security events collection within the context of a single workspace can be configured from either Microsoft Defender for Cloud or Microsoft Sentinel, but not both. If you're planning to add Microsoft Sentinel to a workspace that is already getting alerts from Microsoft Defender for Cloud, and it's set to collect Security Events, you have two options:

- Leave the Security Events collection in Defender for Cloud as is. You're able to query and analyze these events in Microsoft Sentinel and Defender for Cloud. However, you won't be able to monitor the connector's connectivity status or change its configuration in Microsoft Sentinel. If monitoring or customizing the connector is important to you, consider the second option.

- Disable Security Events collection in Defender for Cloud (by setting Windows security events to None in the configuration of your Log Analytics agent). Then add the Security Events connector in Microsoft Sentinel. As with the first option, you're able to query and analyze events in both Microsoft Sentinel and Defender for Cloud, and you're able to monitor the connector's connectivity status or change its configuration in - and only in - Microsoft Sentinel.

### What event types are stored for "Common" and "Minimal"?

These sets were designed to address typical scenarios. Make sure to evaluate which one fits your needs before implementing it.

To determine the events for the Common and Minimal options, we worked with customers and industry standards to learn about the unfiltered frequency of each event and their usage. We used the following guidelines in this process:

- Minimal - Make sure that this set covers only events that might indicate a successful breach and important events that have a low volume. For example, this set contains user successful and failed logins (event IDs 4624, 4625), but it doesn’t contain sign outs, which is important for auditing, but not meaningful for detection and has relatively high volume. Most of the data volume of this set is the login events and process creation event (event ID 4688).

- Common - Provide a full user audit trail in this set. For example, this set contains both user logins and user sign-outs (event ID 4634). We include auditing actions like security group changes, key domain controller Kerberos operations, and other events that are recommended by industry organizations.

Events with low volume were included in the Common set as the main motivation to choose it over all the events is to reduce the volume and not filter out specific events.
