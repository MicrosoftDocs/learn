After a private endpoint rollout, the environment is clean—every platform as a service (PaaS) resource uses a private IP address, and no public endpoints are exposed. But as teams deploy new resources, public endpoints return unless you automate enforcement. Here, you learn how to use Azure Policy to continuously audit private endpoint adoption and prevent new PaaS resources from being deployed with public access.

| Phase | Effect | Purpose |
|-------|--------|---------|
| **Audit** | Report noncompliant resources | Gain visibility without blocking deployments |
| **Remediate** | Work with teams to create private endpoints | Clean the environment before enforcement |
| **Deny** | Block resource creation with public endpoints | Prevent drift after remediation |

## Understand the drift problem and prevention strategy

A developer deploys a new Azure SQL Database and uses the default networking settings—public endpoint enabled, firewall rules set to "allow all Azure services." Three weeks later, a penetration test, or Defender for Cloud recommendation flags the resource. The security team remediates it manually, but by then, the resource held sensitive data for weeks with public exposure.

The drift pattern repeats across every new deployment unless you enforce the standard automatically. Azure Policy prevents drift by evaluating new and existing resources continuously against your private endpoint requirements. The policy can **audit** noncompliant resources in the compliance dashboard without blocking deployments, **deny** resource creation or modification that would introduce a public endpoint, or use **DeployIfNotExists** to automatically remediate by deploying the private endpoint on behalf of the user.

The recommended enforcement sequence is audit → remediate → deny. Never start with Deny—it blocks legitimate work and creates friction. Instead, follow a three-phase approach. In Phase 1, you assign all relevant policies with the Audit (or AuditIfNotExists) effect. The compliance dashboard shows which existing resources violate the standard, giving the security team visibility without disrupting operations. In Phase 2, you work through the noncompliant resources with the owning teams—creating private endpoints, configuring DNS, and disabling public access. You validate the remediation before the resource leaves the noncompliant list. In Phase 3, after the estate is clean, you change the policy effect to Deny. Azure Policy blocks new deployments that don't meet the standard at creation time, making drift impossible.

> [!NOTE]
> When you change a policy effect from Audit to Deny, apply the change to a management group scope starting with nonproduction environments. Monitor for blocked deployments and work with teams to update their provisioning templates before applying to production.

## Assign built-in policies to audit private endpoint adoption

Azure provides built-in policy definitions for the most common PaaS services. These audit-only policies detect whether a private endpoint is configured and report noncompliant resources in the compliance dashboard.

| PaaS service | Built-in policy definition (display name) | Effect options |
|---|---|---|
| Azure SQL Database | "Private endpoint connections on Azure SQL Database should be enabled" | Audit, Disabled |
| Azure Storage accounts | "Storage accounts should use private link" | AuditIfNotExists, Disabled |
| Azure Key Vault | "Azure Key Vaults should use private link" | Audit, Deny, Disabled |
| Azure OpenAI / AI Services | "Azure AI Services resources should use Azure Private Link" | Audit, Disabled |

These built-ins detect the presence of a private endpoint connection. To block public endpoints more aggressively, you can use a separate "Deny" policy or create a custom policy definition that evaluates the `publicNetworkAccess` property.

> [!TIP]
> For a comprehensive starting point, assign the **Azure Security Benchmark** or **NIST SP 800-53** initiative. These initiatives include the private endpoint audit policies alongside many other network security controls, giving you a single compliance view.

To configure a policy assignment in the Azure portal, follow these steps:

1. In the Azure portal, go to **Policy** > **Assignments** > **+ Assign policy**.
2. Under **Scope**, select the management group that covers all of Contoso's subscriptions.
3. Under **Policy definition**, search for "Private endpoint connections on Azure SQL Database should be enabled" and select it.
4. Under **Parameters**, the effect defaults to **Audit** - leave it as Audit for Phase 1.
5. Under **Remediation**, no action is needed for an Audit policy. Remediation tasks apply to DeployIfNotExists policies only.
6. Select **Review + create**, then **Create**.
7. Repeat steps 1–6 for the Storage, Key Vault, and Azure AI Services built-in definitions.

After assigning the policies, go to **Policy** → **Compliance** to view the compliance dashboard. The compliance percentage shows how many resources meet the policy standard. Select a noncompliant resource to see the specific reason it failed evaluation—typically "No private endpoint connections found" or "Public network access is enabled." Use this view as your Phase 2 remediation work list.

## Scale enforcement with Resource Graph and Defender for Cloud

For large environments, the compliance dashboard can have thousands of resources. Azure Resource Graph gives you a programmatic query interface to filter and export noncompliant resources at scale.

The following Resource Graph query finds all storage accounts without a private endpoint connection:

```kusto
Resources
| where type == "microsoft.storage/storageaccounts"
| where isnull(properties.privateEndpointConnections) or array_length(properties.privateEndpointConnections) == 0
| project name, resourceGroup, subscriptionId, location
```

The query returns a list of storage accounts with no private endpoint connections—a fast way to generate a remediation work list without waiting for the policy evaluation cycle. Export the results to CSV and distribute them to resource owners by subscription or resource group.

> [!NOTE]
> Resource Graph reflects the current state of Azure Resource Manager—it doesn't enforce policy. Use Resource Graph for discovery and triage, and Policy for ongoing enforcement.

Microsoft Defender for Cloud generates security recommendations when PaaS resources lack private endpoints. The recommendations appear under **Recommendations** → **Networking** tab. The recommendations link to the same built-in policies you assigned—implementing the policy and remediating resources improves the Defender for Cloud secure score in the same category. For Contoso, Defender for Cloud provided the initial alert that flagged the Azure OpenAI endpoint as publicly accessible, which aligns with the policy "Azure AI Services resources should use Azure Private Link." When you remediate the resource by creating a private endpoint, both the policy compliance and the Defender for Cloud recommendation resolve automatically.
