Microsoft Defender for Cloud uses secure score as the primary metric for evaluating and tracking your security posture. Understanding how secure score works helps you prioritize remediation, set targets, and demonstrate posture improvement to stakeholders.

## Microsoft secure scores in context

Microsoft provides several secure scores across its security portfolio, each measuring posture for a different domain. Before diving into the Defender for Cloud scores used for cloud posture management, it helps to understand where they fit in the broader landscape:

| Score | Domain | Portal | Primary sources |
|-------|--------|--------|-----------------|
| Microsoft Secure Score | Identity, devices, apps, data | Microsoft Defender portal (security.microsoft.com) | Microsoft Entra, Defender for Endpoint, Defender for Cloud Apps, Microsoft 365 services |
| Cloud Secure Score | Cloud posture (multicloud) | Microsoft Defender portal → Exposure Management → Initiatives | Microsoft Defender for Cloud (Azure, AWS, GCP) |
| Classic Secure Score | Cloud posture (control-based) | Azure portal → Defender for Cloud | Microsoft Defender for Cloud (MCSB controls) |
| Exposure Secure Score | Device and endpoint posture | Microsoft Defender portal → Exposure Management | Microsoft Defender for Endpoint |

For this module's focus on **security posture management in hybrid and multicloud environments**, the relevant scores are the **Cloud Secure Score** and the **Classic Secure Score**—both from Microsoft Defender for Cloud. The broader Microsoft Secure Score covers identity, device, and application posture, which falls outside the scope of cloud infrastructure posture management. However, all these scores are visible in the Microsoft Defender portal's Exposure Management experience, giving security architects a consolidated view across domains.

## Understanding Defender for Cloud secure score models

Defender for Cloud provides two secure score models, each available in different portals:

| Model | Portal | How it calculates |
|-------|--------|-------------------|
| Cloud Secure Score | Microsoft Defender portal | Risk-based, factoring in asset criticality, risk level, and exposure |
| Classic Secure Score | Azure portal | Control-based, using the ratio of remediated recommendations per security control |

Both models measure your security posture as a percentage from 0 to 100, but they use different calculations and produce different values. When reporting to stakeholders, consistently use one model to avoid confusion.

:::image type="content" source="../media/cloud-secure-score.png" alt-text="Screenshot of the Cloud Secure Score showing the risk-based score and Defender CSPM plan status." lightbox="../media/cloud-secure-score.png":::

## How Cloud Secure Score works

Cloud Secure Score uses a risk-based calculation that provides more actionable prioritization. The score aggregates open recommendations while weighting them by:

- **Recommendation risk level**: Critical, high, medium, and low severity findings carry different weights. Critical recommendations have the most impact on your score.
- **Asset risk factors**: Contextual factors such as internet exposure, data sensitivity, and lateral movement potential influence how each finding affects the score.
- **Asset criticality**: The business importance of each asset determines how much weight its recommendations carry.

This approach means fixing a critical vulnerability on an internet-facing server processing sensitive data improves your score more than fixing a low-severity configuration issue on an isolated test machine. You access the Cloud Secure Score through the Defender portal under **Exposure Management > Initiatives > Cloud Security**.

## How Classic Secure Score works

The classic model in the Azure portal organizes recommendations into security controls, where each control represents a group of related security recommendations addressing a specific risk area.

:::image type="content" source="../media/score-on-recommendations-page.png" alt-text="Screenshot of the Defender for Cloud recommendations page showing the secure score, recommendation status, and resource health." lightbox="../media/score-on-recommendations-page.png":::

Each control has a maximum score value. Your score for a control is calculated based on the ratio of healthy resources to total resources for the recommendations in that control, multiplied by the control's maximum points. The overall secure score is the sum of all control scores.

Key security controls include:

- **Remediate vulnerabilities**: Address vulnerability findings on machines and applications
- **Enable encryption at rest**: Ensure data is encrypted in storage
- **Manage access and permissions**: Restrict excessive access rights
- **Encrypt data in transit**: Enforce transport encryption
- **Enable endpoint protection**: Deploy anti-malware and EDR solutions
- **Restrict unauthorized network access**: Secure network configurations
- **Apply adaptive application control**: Control which applications run on machines

> [!NOTE]
> Fixing all recommendations within a single control gives you the maximum score increase for that control. Partially remediating recommendations within a control still improves your score proportionally. Recommendations flagged as Preview don't affect secure score calculations.

## Accessing secure score across views

Secure score appears in multiple locations, each serving a different evaluation purpose:

- **Overview dashboard**: The Defender for Cloud overview shows your current score alongside other key security metrics including active recommendations, security alerts, and resource health.

- **Secure score dedicated page**: Breaks down the score by subscription. Use this view to compare posture across subscriptions and identify which environments need the most attention.

- **Management group view**: Toggle the management group view on the secure score page to see scores organized by your Azure management group hierarchy. This helps evaluate posture across organizational units and identify management groups with the weakest security posture.

# [Overview dashboard](#tab/overview)
:::image type="content" source="../media/score-on-main-dashboard.png" alt-text="Screenshot of the Defender for Cloud overview page highlighting the secure score section." lightbox="../media/score-on-main-dashboard.png":::

# [Secure score dedicated page](#tab/secure-score-dedicated-page)
:::image type="content" source="../media/score-on-dedicated-dashboard.png" alt-text="Screenshot of the Defender for Cloud secure score page showing the overall score and per-subscription breakdown." lightbox="../media/score-on-dedicated-dashboard.png":::

# [Management group view](#tab/management-group-view)
:::image type="content" source="../media/secure-score-management-groups.png" alt-text="Screenshot of the secure score page with management group grouping enabled, showing scores for management groups and subscriptions." lightbox="../media/secure-score-management-groups.png":::

---

**Recommendations page**: Shows how each recommendation and control impacts your score, with potential score increases listed alongside each control.

:::image type="content" source="../media/defender-for-cloud-recommendations.png" alt-text="Screenshot of the Microsoft Defender for Cloud recommendations page." lightbox="../media/defender-for-cloud-recommendations.png":::

## Tracking secure score over time

Defender for Cloud provides the **Secure Score Over Time** workbook that charts your score trends. This workbook displays weekly score progression for each security control, top recommendations with recent increases in unhealthy resources, and historical trends for identifying positive or negative trajectories.

:::image type="content" source="../media/secure-score-over-time-snip.png" alt-text="Screenshot of the Secure Score Over Time workbook showing control score trends and top recommendations with unhealthy resource counts." lightbox="../media/secure-score-over-time-snip.png":::

Use this workbook to:

- **Establish baselines**: Document your starting score when first enabling Defender for Cloud
- **Identify regressions**: Spot score drops from new deployments or configuration changes
- **Demonstrate progress**: Show score improvement over time to demonstrate security investment effectiveness
- **Correlate events**: Match score changes with deployment activities or security incidents

For long-term analysis, export secure score data to Log Analytics using continuous export. This enables custom KQL queries, Power BI dashboards, and integration with your broader reporting infrastructure. You can also use the REST API to retrieve scores programmatically for custom reporting.

## Using secure score for posture evaluation

As a security architect, use secure score strategically to evaluate and drive posture improvement:

**Set target scores**: Establish target scores for each subscription or management group. Targets create accountability and provide measurable goals for remediation teams.

**Prioritize by impact**: Focus remediation on recommendations with the highest potential score increase. In the classic model, controls with the highest point values offer the biggest gains. In the Cloud Secure Score, critical recommendations on high-value assets provide the greatest benefit.

**Compare across environments**: Use per-subscription scores to compare posture across production, development, and test environments. Different environments may have different target scores reflecting their risk tolerance.

**Report by scope**: Present scores at the management group level for executive reporting and at the subscription level for operational teams. This layered reporting aligns security posture data with organizational accountability.

## Secure score across multicloud

When you connect AWS accounts and GCP projects to Defender for Cloud, resources from these environments contribute to your secure score calculation. Recommendations for AWS and GCP resources appear alongside Azure recommendations, and their remediation improves your overall score. This multicloud integration provides a single score that reflects posture across your entire cloud estate.

With secure score providing the measurement framework, the next step is designing the integrated posture management solution that defines how Defender for Cloud connects across your hybrid and multicloud environments.
