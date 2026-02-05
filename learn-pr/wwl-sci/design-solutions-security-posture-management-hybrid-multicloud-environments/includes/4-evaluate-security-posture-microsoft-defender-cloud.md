Microsoft Defender for Cloud provides the tools to evaluate your security posture across hybrid and multicloud environments. This unit covers how Defender for Cloud implements MCSB-based assessment and the key metrics and tools you use to measure and improve your posture.

## How Defender for Cloud evaluates security posture

Defender for Cloud continuously assesses your resources against the Microsoft Cloud Security Benchmark (MCSB) and generates security recommendations when configurations don't meet the benchmark requirements. By default, when you enable Defender for Cloud on an Azure subscription, MCSB is automatically enabled as the baseline security standard. This automated evaluation process:

- **Discovers assets** across Azure subscriptions, AWS accounts, and GCP projects
- **Assesses configurations** against MCSB controls and other enabled security standards
- **Generates recommendations** with remediation guidance for each identified gap
- **Calculates a secure score** that quantifies your overall posture

The following table summarizes the evaluation capabilities available in each CSPM tier:

| Capability | Foundational CSPM | Defender CSPM | Coverage |
|--|--|--|--|
| Continuous assessment against MCSB | ✓ | ✓ | Azure, AWS, GCP |
| Security recommendations | ✓ | ✓ | Azure, AWS, GCP, on-premises |
| Secure score | ✓ | ✓ | Azure, AWS, GCP, on-premises |
| Attack path analysis | - | ✓ | Azure, AWS, GCP |
| Cloud security explorer | - | ✓ | Azure, AWS, GCP |
| Regulatory compliance assessments | - | ✓ | Azure, AWS, GCP |
| Security governance | - | ✓ | Azure, AWS, GCP |
| Agentless VM vulnerability scanning | - | ✓ | Azure, AWS, GCP |
| Risk prioritization | - | ✓ | Azure, AWS, GCP |

## Measuring posture with secure score

Secure score is Defender for Cloud's primary metric for evaluating security posture. Defender for Cloud offers two secure score models depending on where you access the score:

| Model | Portal | Calculation approach |
|-------|--------|---------------------|
| Cloud Secure Score (risk-based) | Microsoft Defender portal | Incorporates asset risk factors, asset criticality, and recommendation risk levels |
| Classic Secure Score | Azure portal | Based on security controls and the ratio of remediated recommendations |

The Cloud Secure Score ranges from 0 to 100, with 100 indicating an optimal security posture. This model provides more accurate prioritization by factoring in contextual risk.

:::image type="content" source="../media/cloud-secure-score.png" alt-text="Screenshot of the Cloud Secure Score and the Defender CSPM plan." lightbox="../media/cloud-secure-score.png":::

### How Cloud Secure Score works

The Cloud Secure Score is a risk-based calculation that aggregates open recommendations while factoring in:

- **Recommendation risk level**: Critical, high, medium, and low severity findings are weighted accordingly
- **Asset risk factors**: Contextual factors such as internet exposure and data sensitivity
- **Asset criticality**: The importance of each asset to your organization

This risk-based approach helps you prioritize remediation efforts on the issues that pose the greatest threat to your environment. As you remediate recommendations, especially those with higher risk levels, your secure score increases.

### How Classic Secure Score works

The classic model groups recommendations into security controls, where each control represents a security risk area. Your control score is calculated based on the ratio of remediated recommendations to total recommendations within that control, multiplied by the control's maximum points. The overall score is the sum of all control scores.

> [!NOTE]
> The two models have different calculations and produce different score values. When reporting on security posture, be consistent about which model you use.

### Using secure score for evaluation

Secure score appears in multiple locations within Defender for Cloud:

- **Overview dashboard**: Shows your current score at a glance
- **Secure score page**: Breaks down the score by subscription and management group
- **Recommendations page**: Displays how each recommendation impacts your score
- **Workbooks**: Provides the "Secure Score Over Time" report for tracking trends

When evaluating your security posture, use secure score to:

- **Establish a baseline**: Document your initial score when first enabling Defender for Cloud
- **Track improvement**: Monitor score changes over time to demonstrate posture improvement
- **Prioritize remediation**: Focus on recommendations with higher risk levels for maximum score impact
- **Compare across environments**: Compare scores between subscriptions or cloud environments

## Advanced evaluation with Defender CSPM

Defender CSPM provides additional tools for deeper security posture evaluation.

### Attack path analysis

Attack path analysis uses the cloud security graph to identify exploitable paths that attackers could use to reach high-impact assets. The analysis considers:

- Internet exposure
- Permissions and access rights
- Lateral movement possibilities
- Vulnerabilities on resources along the path

Attack paths are prioritized by risk, helping you focus remediation on the issues that pose the greatest threat to your critical assets.

:::image type="content" source="../media/security-map.png" alt-text="Screenshot of a conceptualized graph that shows the complexity of security graphing." lightbox="../media/security-map.png":::

### Cloud security explorer

Cloud security explorer lets you run graph-based queries to proactively identify security risks. You can build custom queries that combine multiple risk factors, such as:

- Find all internet-exposed VMs with critical vulnerabilities
- Identify storage accounts with public access containing sensitive data
- Discover identities with excessive permissions to critical resources

This capability enables you to evaluate posture against your organization's specific risk concerns beyond the standard MCSB controls.

## Evaluation across multiple clouds

Defender for Cloud's multicloud connectors enable consistent posture evaluation across Azure, AWS, and GCP. When you connect cloud accounts:

- Resources are discovered and assessed against MCSB
- Recommendations appear in the unified Defender for Cloud dashboard
- Secure score incorporates findings from all connected environments
- Attack paths can span multiple cloud providers

This unified evaluation approach lets you compare posture across cloud platforms and identify where to focus security improvements.
