Fabrikam Residences wants consistent monitoring, security, and configuration across its hybrid servers without configuring every machine individually. Azure Policy initiatives group related policy definitions so that Fabrikam can assign and monitor a governance baseline at a resource-group, subscription, or management-group scope.

## Choose services for a governance baseline

Start with the outcomes you need, then select policies and service configurations that support Azure Arc-enabled servers. An initiative can combine auditing and deployment policies, but each policy retains its own effect, parameters, and prerequisites.

| Management outcome | Service and configuration |
| --- | --- |
| Operating system compliance | Use Azure Machine Configuration policies to audit settings or apply supported configurations. Choose audit, apply and monitor, or apply and autocorrect behavior where the configuration supports it. |
| Monitoring and performance | Use Azure Monitor Agent (AMA), data collection rules (DCRs), and a Log Analytics workspace. Azure Policy can deploy AMA and associate DCRs. For VM insights, use its supported AMA-based onboarding configuration. |
| Change tracking and inventory | Use Azure Change Tracking and Inventory with AMA, the Change Tracking extension, and a Change Tracking DCR associated with each machine. |
| Operating system updates | Use Azure Update Manager for assessments and patch installation. Azure Policy can enable periodic assessment, while maintenance configurations define update schedules. |
| Endpoint protection | Use a Microsoft Defender for Servers plan in Microsoft Defender for Cloud with Microsoft Defender for Endpoint integration. Check operating system support, existing endpoint protection, and the required antivirus mode. |
| Operational automation | Use an Azure Automation account and extension-based Hybrid Runbook Workers to run approved operational tasks on Arc-enabled servers. |

For monitoring deployment, see Install and manage AMA with Azure Policy and Enable VM insights in More Info in the Summary unit. For endpoint protection, see Enable Defender for Endpoint integration in the same section. These services have their own prerequisites and billing; assigning a policy initiative doesn't replace service enrollment or licensing.

## Onboard servers by using a policy initiative

Use Change Tracking and Inventory as an example of repeatable service onboarding. Fabrikam first enables it for a small group of connected Arc-enabled servers, verifies the results, and then expands the scope.

Before you start, check these prerequisites:

- Check the Change Tracking and Inventory support matrix in More Info in the Summary unit, and allow the network access required by Azure Arc and the monitoring services.
- Have a Log Analytics workspace and a Change Tracking DCR that sends data to that workspace. Use the Change Tracking schema, not a general-purpose events or performance-counter DCR. Associate only one Change Tracking DCR with each machine. See Create a Change Tracking DCR in More Info in the Summary unit.
- Ensure that you can create policy assignments at the chosen scope and grant the assignment's managed identity the roles required by its deployment policies. You also need access to configure the monitoring resources and view collected data. Have an authorized administrator grant any missing permissions.

Follow these steps to assign the initiative:

1. In the Azure portal, open **Policy** and select **Definitions**. The Azure portal address is in More Info in the Summary unit.
1. Filter **Definition type** to **Initiative**. Search for and select **Enable ChangeTracking and Inventory for Arc-enabled virtual machines**. Use the Arc-specific initiative, not the initiative for Azure VMs.
1. Select **Assign initiative**. On **Basics**, choose the subscription and pilot resource group as the **Scope**, and provide an assignment name.
1. On **Parameters**, provide the **Data Collection Rule Resource Id** for your Change Tracking DCR. Keep the effect set to **DeployIfNotExists**, and ensure that **Applicable Locations** includes the Azure resource locations of the target machines.
1. On **Remediation**, configure a system-assigned managed identity for the policy assignment and select its location. Select **Review + create**, then **Create**.
1. After the assignment is created, verify that its identity has the roles required by the deployment policies. Grant any missing permissions, including access to required resources outside the assignment scope, before starting remediation.
1. Use **Policy** > **Remediation** to create remediation tasks for the initiative's deployment policies that have existing noncompliant resources. A compliance evaluation alone doesn't deploy the required resources to existing machines.
1. Review the remediation results and **Policy** > **Compliance**. On the machines, verify that AMA and the Change Tracking extension are provisioned and the Change Tracking DCR is associated. Then confirm that records arrive in the workspace and are visible in **Change Tracking and Inventory**.

The policy assignment's managed identity performs Azure resource deployments. It's separate from the Arc-enabled server's system-assigned managed identity, which AMA uses to authenticate. Don't copy Azure VM user-assigned identity requirements onto Arc-enabled servers.

See Enable Change Tracking and Inventory at scale and Azure Policy remediation in More Info in the Summary unit for the complete service and access-control guidance.

## Monitor compliance and respond to drift

Review deployment failures, service health, and compliance after onboarding. Use remediation tasks for applicable `deployIfNotExists` or `modify` policies when existing resources need correction. Policy evaluation doesn't automatically remediate every resource that later becomes noncompliant.

For settings inside the operating system, automatic correction requires a Machine Configuration package and assignment that support apply and autocorrect. The audit-only security baseline from the previous unit continues to report findings without correcting them. This separation lets Fabrikam automate approved changes while keeping audit-only checks under its change-management process.
