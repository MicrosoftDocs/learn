Microsoft Entra roles govern the identity plane—but when a threat actor compromises an Owner on a production subscription, you're dealing with a different class of incident. The blast radius spans every resource nested beneath that subscription, and the remediation path differs substantially from a Microsoft Entra role compromise. Both planes need just-in-time protection. In this unit, you configure PIM for the resource plane.

## Understand the Azure resource scope in Privileged Identity Management (PIM)

Azure RBAC operates across a nested scope hierarchy: management group, subscription, resource group, and individual resource. Assignments at a broader scope inherit downward. An Owner assignment at the subscription level grants ownership over every resource group and resource within it. PIM surfaces this same hierarchy, letting you make a user eligible at the subscription, resource group, or individual resource level. Scope selection matters: assigning eligibility at a narrower scope limits the potential damage from a compromised activation, so you should align scope to least privilege just as you do with permanent assignments.

Navigate to **ID Governance** > **Privileged Identity Management** > **Azure resources**. Here, you're managing RBAC assignments on Azure control-plane objects rather than directory identities, and keeping this distinction in mind prevents you from inadvertently configuring the wrong target when managing resources. The updated PIM experience uses the latest Azure Resource Manager API and automatically surfaces Azure resources in your tenant—no manual onboarding step is required. The table summarizes the key operational differences between the two planes.

| | Microsoft Entra roles | Azure resource roles |
|---|---|---|
| **PIM navigation** | ID Governance → PIM → Microsoft Entra roles | ID Governance → PIM → Azure resources |
| **Scope** | Tenant (directory-wide) | Subscription / resource group / resource |
| **Discovery required** | No | No—PIM manages Azure resources automatically |
| **Example roles** | Global Administrator, Security Administrator | Owner, Contributor, Key Vault Administrator |

:::image type="content" source="../media/azure-resource-scope-hierarchy.png" alt-text="Diagram of Azure resource scope hierarchy: management group, subscription, resource group, and individual resource.":::

## Identify which resources need the tightest access controls

Not every Azure resource carries the same risk from a compromised Owner or Contributor. The right activation controls depend on four factors: data sensitivity, blast radius, regulatory exposure, and the reversibility of any damage. A misconfigured dev/test resource group is annoying and recoverable. A compromised Owner on a production Key Vault is neither. Mapping resources to a risk tier before configuring assignments means your strictest controls land where they create the most value—and you avoid applying approval-gated, one-hour activations to low-risk sandbox environments where that friction undermines day-to-day productivity.

| Risk tier | Resource examples | Risk reason | Recommended activation controls |
|---|---|---|---|
| Critical | Production subscription, Key Vault, Azure AI services | Compromise grants broad lateral movement; Key Vault secrets unlock downstream systems; AI model weights and training data represent exfiltratable IP | multifactor authentication (MFA) required, justification required, approval required, 1–2 hour max |
| High | Production resource group, Azure SQL, Azure Kubernetes Service | Narrower scope but high data sensitivity or service continuity risk | MFA required, justification required, approval optional, 4–8 hour max |
| Standard | Dev/test resource groups, sandbox subscriptions | Low data sensitivity; mistakes are reversible | MFA required, justification required, no approval, up to 8 hours |

Key Vault sits in the Critical tier because a compromised Owner on a Key Vault exposes every secret it holds—including credentials that authenticate downstream services. That cascading risk means a single Key Vault compromise can propagate silently across multiple dependent systems before your incident response team identifies the initial breach. Azure AI services carry similar weight: model weights and training data represent significant proprietary investment, and exfiltration of that data might not surface in logs immediately.

## Assign eligible access to an Azure resource role

Apply the tier analysis by creating eligible assignments at the scope that matches the resource's risk level.

> [!NOTE]
> If you navigate to **Azure resources** and your subscriptions or resource groups don't appear, select **Discover resources** before troubleshooting permissions or other issues. Some tenants or older PIM configurations can require this one-time step to surface resources in the list.

1. In PIM, select **Azure resources**.
2. Navigate to the target resource—for example, a Key Vault—using the Subscriptions or Resource groups dropdown, and under **Manage**, select **Roles**, then select **Add assignments**.
3. Select the Azure resource role—for example, **Key Vault Administrator**.
4. Set **Assignment type** to **Eligible**.
5. Select the member and configure the assignment duration.
6. Select **Assign** to complete the assignment.

To activate an eligible Azure resource role, navigate to **My roles** in PIM, select the **Azure resources** tab to see your eligible assignments, and select **Activate**—the activation steps follow the same flow as Microsoft Entra roles.

One important nuance: you configure role settings for Azure resource roles independently per role per resource scope. The same Contributor role can have different activation controls at the subscription level versus the resource-group level. This flexibility lets you apply stricter requirements—shorter duration, mandatory approval—on production scopes while keeping lower-friction settings for development scopes. Without this per-scope configuration, you'd be forced to choose between over-enabling production access or over-restricting development workflows. Navigate to **PIM** > **Azure resources**, select the target resource, then select **Settings**, select the role, and select **Edit** to configure them.

Individual eligible assignments now protect both the identity plane and the resource plane. As your organization scales—with multiple engineers needing temporary access to the same production resources—managing assignments one by one creates overhead and increases the chance that you overlook an active assignment. PIM for groups addresses this by making group membership itself eligible, which you explore in the next unit.
