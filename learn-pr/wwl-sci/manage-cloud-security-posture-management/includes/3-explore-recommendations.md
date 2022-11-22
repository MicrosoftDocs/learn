Defender for Cloud's recommendations is based on the Azure Security Benchmark. Azure Security Benchmark is the Microsoft-authored, Azure-specific set of guidelines for security and compliance best practices based on common compliance frameworks. This widely respected benchmark builds on the controls from the Center for Internet Security (CIS) and the National Institute of Standards and Technology (NIST) with a focus on cloud-centric security.  Other recommendations are generated from regulator compliance initiatives.


## View your recommendations
Defender for Cloud analyzes the security state of your resources to identify potential vulnerabilities.

To view your Secure score recommendations:

- Sign in to the Azure portal.

- Navigate to Microsoft Defender for Cloud > Recommendations.

:::image type="content" source="../media/recommendations-view.png" alt-text="Screenshot of Defender for Cloud Secure Score Recommendations." lightbox="../media/recommendations-view.png":::


Here you'll see the recommendations applicable to your environment(s). Recommendations are grouped into security controls.

- Select Secure score recommendations.

    Secure score recommendations affect the secure score and are mapped to the various security controls. The All recommendations tab, allows you to see all of the recommendations including recommendations that are part of different regulatory compliance standards.

- (Optional) Select a relevant environment(s).

- Select the  > to expand the control, and view a list of recommendations.

- Select a specific recommendation to view the recommendation details page.

    For supported recommendations, the top toolbar shows any or all of the following buttons:

    - **Enforce and Deny** (see Prevent misconfigurations with Enforce/Deny recommendations).
    - **View policy definition** to go directly to the Azure Policy entry for the underlying policy.
    - **Open query** - All recommendations have options to view the detailed information about the affected resources using Azure Resource Graph Explorer.

- **Severity indicator.**

- **Freshness interval** (where relevant).

- **Count of exempted resources** if exemptions exist for a recommendation, the count shows the number of resources that have been exempted with a link to view the specific resources.

- **Mapping to MITRE ATT&CK ® tactics and techniques** if a recommendation has defined tactics and techniques, select the icon for links to the relevant pages on MITRE's site. This applies only to Azure scored recommendations.

- **Description** - A short description of the security issue.

- When relevant, the details page also includes a table of **related recommendations**:

The relationship types are:

- **Prerequisite** - A recommendation that must be completed before the selected recommendation
- **Alternative** - A different recommendation, which provides another way of achieving the goals of the selected recommendation
- **Dependent** - A recommendation for which the selected recommendation is a prerequisite
For each related recommendation, the number of unhealthy resources is shown in the "Affected resources" column.

 
- **Remediation steps** - A description of the manual steps required to remediate the security issue on the affected resources. For recommendations with the Fix option**, you can select View remediation logic before applying the suggested fix to your resources.

- **Affected resources** - Your resources are grouped into tabs:

    - **Healthy resources** – Relevant resources, which either aren't impacted or on which you've already remediated the issue.

    - **Unhealthy resources** – Resources that are still impacted by the identified issue.

    - **Not applicable resources** – Resources for which the recommendation can't give a definitive answer. The not applicable tab also includes reasons for each resource.

- Action buttons to remediate the recommendation or trigger a logic app.

## Remediation steps
Recommendations give you suggestions on how to better secure your resources. You implement a recommendation by following the remediation steps provided in the recommendation.

After reviewing all the recommendations, decide which one to remediate first. We recommend that you prioritize the security controls with the highest potential to increase your secure score.

1. From the list, select a recommendation.

1. Follow the instructions in the Remediation steps section. Each recommendation has its own set of instructions. 

1. Once completed, a notification appears informing you whether the issue is resolved.

### Fix button
To simplify remediation and improve your environment's security (and increase your secure score), many recommendations include a Fix option.

To implement a Fix:

1. From the list of recommendations that have the Fix action icon, select a recommendation.

1. From the Unhealthy resources tab, select the resources that you want to implement the recommendation on, and select Remediate.

1. In the confirmation box, read the remediation details and implications.

1. Insert the relevant parameters if necessary, and approve the remediation.
 
1. Once completed, a notification appears informing you if the remediation succeeded.