::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=56ad7be1-37e6-4490-bcd5-8764ca8da986]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

Sovereignty decisions should rely on evidence rather than assumptions or reactive architecture changes. The sovereignty risk and resilience framework in this lesson organizes a conversation about jurisdictional, security, and operational risk.

The goal isn't absolute control in a globally connected environment. It's to understand likelihood and impact, prioritize mitigations, make residual risk explicit, and prepare for disruption. Treat sovereignty as a continuous risk-management discipline.

## Establish the evidence and accountability

Use these questions with IT, security, legal, compliance, and executive stakeholders:

- **Which risks does the organization explicitly accept today, and on what evidence?** Distinguish conscious, approved risk acceptance from assumptions.
- **What must never be a surprise during an audit, incident, or public review?** Identify mandatory requirements and escalation triggers.
- **How does the organization verify data location, access, jurisdiction, and AI usage?** Use configuration evidence, audit records, contracts, and tested controls rather than diagrams alone.
- **Who is accountable for sovereignty risk decisions?** Record decision owners, approvals, evidence, and review dates.
- **What architectural disruption is acceptable, and what would trigger change?** Agree on sequencing, migration constraints, and continuity requirements before an emergency.

These questions help identify governance gaps and technical gaps. A team might have a suitable control but no owner responsible for verifying it or explaining the residual risk.

## Discuss four risk-response profiles

> [!NOTE]
> These profiles aren't product tiers, regulatory certifications, or a universal scoring system.

Use the following four profile labels as working language for this lesson's risk conversation.

| Profile | Decision to discuss |
| --- | --- |
| Bunker | Evaluate stronger isolation and local operating authority for a workload whose requirements justify those measures, including their cost and continuity implications. |
| Mitigate strongly | Apply layered technical, operational, and contractual controls to reduce significant risks while retaining suitable cloud capabilities. |
| Tolerate | Explicitly accept a residual risk within the organization's approved risk appetite, with evidence, an accountable owner, and review conditions. |
| Manage and monitor | Maintain controls, collect evidence, monitor changes, and use agreed triggers to reassess the workload's posture. |

Local or disconnected operation can address some dependencies while introducing others, such as local maintenance and recovery responsibilities.

:::image type="complex" source="../media/sovereignty-risk-resilience-framework.png" alt-text="Diagram showing an impact and probability matrix with Bunker, Mitigate strongly, Tolerate, and Manage and monitor risk-response profiles." lightbox="../media/sovereignty-risk-resilience-framework.png":::
   Impact increases upward and probability increases to the right. Bunker Strategy is upper left, Mitigate Strongly upper right, Tolerate lower left, and Manage and Monitor lower right.
:::image-end:::

> [!IMPORTANT]
> Don't choose a profile solely from an industry label or a general concern about a provider's home jurisdiction. Identify the specific risk, applicable law, likelihood, business impact, existing safeguards, and evidence.

## Apply the framework to a workload

Apply the framework through the following steps:

1. **Define scope and obligations.** Identify the workload, data classifications, operating regions, and applicable requirements. Map them to relevant assessment templates, such as DORA, PCI DSS, NERC CIP, or SWIFT where applicable.
2. **Assess risks and current controls.** Document credible events, likelihood, impact, technical dependencies, and evidence. Separate requirements that prohibit a design from risks the organization can accept.
3. **Compare responses.** Evaluate public, private, and partner cloud options, layered mitigations, portability, recovery plans, and the operational cost of each choice.
4. **Agree on the response and ownership.** Record the selected profile, controls, residual risks, decision owner, and rationale. Test continuity arrangements rather than assuming they work.
5. **Monitor and reassess.** Review the decision when regulations, service capabilities, threat conditions, dependencies, or business needs change.

For example, a payment service might need low recovery times, residency controls, and auditable operator access. The team can compare how each cloud model meets those requirements, identify gaps, test recovery, and have an accountable owner approve the remaining risk. It shouldn't select disconnected infrastructure solely because the workload is regulated.

> [!NOTE]
> The [Microsoft Purview Compliance Manager regulations list](/purview/compliance-manager-regulations-list) helps identify assessment templates. Availability depends on licensing and the current catalog. Templates support evidence collection and improvement actions; they don't automatically select a profile, prove compliance, or replace a risk assessment.

::: zone-end
