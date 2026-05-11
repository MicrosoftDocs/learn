# Onboard servers to Defender for Servers

Enabling Defender for Servers transforms unmonitored virtual machines and Arc-connected servers into actively protected assets with vulnerability scanning, endpoint detection and response, and advanced threat protection. Before you enable protection, you select the plan tier that matches your organization's security requirements and budget.

| Capability | Plan 1 | Plan 2 |
|------------|--------|--------|
| Microsoft Defender for Endpoint integration | Included | Included |
| Agent-based vulnerability assessment | Included | Included |
| Security alerts and threat detection | Included | Included |
| Agentless scanning | Unavailable | Included |
| Just-in-time VM access | Unavailable | Included |
| File Integrity Monitoring | Unavailable | Included |
| OS configuration assessment (Machine Configuration) | Unavailable | Included |
| Premium Defender Vulnerability Management features | Unavailable | Included |
| OS updates assessment | Unavailable | Included |
| Network map | Unavailable | Included |

## Choose between Plan 1 and Plan 2

Plan 1 provides essential protection when Microsoft Defender for Endpoint integration and agent-based vulnerability assessment meets your needs. Organizations with cost constraints or simple server workloads often start with Plan 1. The plan delivers core endpoint detection and response (EDR) capabilities and continuous vulnerability scanning through the MDE sensor installed on each machine.

Plan 2 adds agentless scanning, which analyzes server disk contents without requiring agent deployment or consuming machine resources. With agentless scanning, you gain software inventory, vulnerability assessment, secrets scanning, and malware detection capabilities that run offline every 24 hours. Plan 2 also unlocks just-in-time VM access for securing management ports, File Integrity Monitoring for detecting unauthorized changes, and OS configuration assessment through Machine Configuration.

For Contoso Manufacturing, Plan 2 is the right choice. The factory environment includes Arc-connected on-premises servers where minimizing agent overhead matters, and the regulatory requirements for manufacturing demand the advanced capabilities that only Plan 2 provides—agentless scanning for comprehensive coverage and File Integrity Monitoring for detecting tampering with OT system files.

## Enable Defender for Servers at subscription scope

You enable Defender for Servers at the subscription level through the Defender for Cloud environment settings. Navigate to **Defender for Cloud** > **Environment Settings**, select your subscription, then locate the **Servers** plan in the Defender plans list. Toggle the plan to **On** and choose either **Plan 1** or **Plan 2** from the plan selector. Select **Save** to apply the configuration.

When you enable Defender for Servers, a 30-day trial period begins immediately. The trial provides full access to all plan features at no cost, giving you time to validate the deployment and assess the value before charges start. You can't stop, pause, or extend the trial once it starts—after 30 days, standard billing applies automatically.

## Override protection scope at resource group or resource level

You can override the subscription-level plan setting at the resource group or individual resource level when different environments require different protection tiers. For example, you might apply Plan 1 to development and test resource groups while maintaining Plan 2 for production workloads. This approach optimizes costs while ensuring critical assets receive premium protection.

At the resource level, you can exclude specific virtual machines from Defender for Servers protection entirely. Use this capability cautiously—excluded VMs lose all Defender for Servers protections including vulnerability scanning, threat detection, and endpoint protection. Valid use cases include temporary test VMs or machines with conflicting external security software that can't coexist with Defender for Endpoint.

## Onboard Arc-connected servers automatically

Arc-connected servers in your subscription automatically receive protection when you enable Defender for Servers at the subscription level. Defender for Cloud detects Arc-enrolled machines and deploy the Microsoft Defender for Endpoint extension to them without requiring manual intervention. This automatic deployment ensures consistent protection across your hybrid server estate.

Verify that Arc servers appear in your protected inventory by navigating to **Defender for Cloud** > **Asset Inventory** and filtering for **Non-Azure machines**. Each Arc-connected server shows its Defender for Servers plan assignment and the status of security agents. If a server doesn't appear, confirm that the Azure Arc Connected Machine agent is installed and that the server resource is in a subscription with Defender for Servers enabled.

## Deploy at scale using Azure Policy

For organizations with multiple subscriptions or management groups, manual enablement becomes impractical. Use the built-in Azure Policy **Configure Azure Defender for Servers to be enabled (with 'P1' subplan) for all resources (resource level)** to automatically enable Defender for Servers Plan 1 on all VMs and Arc-connected machines at the resource level. Assign this policy at a management group to cover all factory subscriptions in the Contoso environment.

The policy assignment creates a managed identity that continuously evaluates resources and enables Defender for Servers on any new or existing VMs that lack protection. Policy-based deployment ensures that newly provisioned factory servers immediately receive protection without manual configuration steps.

## Verify post-enablement behavior

After enablement, Defender for Cloud automatically deploys the Microsoft Defender for Endpoint extension to supported Windows and Linux VMs. The extension provides the EDR sensor that performs continuous monitoring, behavioral analysis, and threat detection on each protected machine. Vulnerability assessment activates immediately, with the MDE sensor beginning to report software inventory and vulnerability findings within minutes.

For Plan 2 subscriptions, agentless scanning activates automatically and begins its 24-hour scanning cycle. The first agentless scan completes within 24 hours of enablement, after which scans repeat on a daily schedule. You see results from both agent-based and agentless vulnerability assessment in the Defender portal vulnerability management dashboard.

For Contoso Manufacturing, the security team enables Plan 2 at the subscription level covering all factory environments. Within hours, the Asset Inventory shows protected status for both Azure VMs running factory software and Arc-connected on-premises servers controlling production equipment. The deployment establishes comprehensive visibility into vulnerabilities and threats across the entire server estate.

Now that Defender for Servers is active on your environment, you configure vulnerability scanning to identify security weaknesses in your server software stack.
