## What is a security recommendation?

Defender for Cloud periodically uses policies to analyze the compliance status of your resources to identify potential security misconfigurations and weaknesses. It then provides you with recommendations on how to remediate those issues. Recommendations result from assessing your resources against the relevant policies and identifying resources that aren't meeting your defined requirements.

Defender for Cloud **makes its security recommendations based on your chosen initiatives**. When a policy from your initiative is compared against your resources and finds one or more that isn't compliant, it's presented as a recommendation in Defender for Cloud.

**Example: Microsoft Defender for Cloud - All Recommendations**

:::image type="content" source="../media/microsoft-defender-for-cloud-all-recommendations-dashboard-version-1-7c54073a.jpg" alt-text="Screenshot showing an example of the Microsoft Defender for Cloud All recommendations dashboard.":::


**Recommendations** are actions for you to take to secure and harden your resources. Each recommendation provides you with the following information:<br>

 -  A short description of the issue
 -  The remediation steps to carry out in order to implement the recommendation
 -  The affected resources

In practice, it works like this:

 -  Microsoft Cloud security benchmark is an ***initiative*** that contains requirements.
    
    For example, Azure Storage accounts must restrict network access to reduce their attack surface.
 -  The initiative includes multiple ***policies***, each requiring a specific resource type. These policies enforce the requirements in the initiative.
    
    To continue the example, the storage requirement is enforced with the policy "**Storage accounts should restrict network access using virtual network rules**."
 -  Microsoft Defender for Cloud continually assesses your connected subscriptions. If it finds a resource that doesn't satisfy a policy, it displays a ***recommendation*** to fix that situation and harden the security of resources that aren't meeting your security requirements.
    
    For example, if an Azure Storage account on your protected subscriptions isn't protected with virtual network rules, you see the recommendation to harden those resources.

So, (1) **an initiative includes** (2) **policies that generate** (3) **environment-specific recommendations**.

## Security recommendation details

Security recommendations contain details that help you understand its significance and how to handle it.

:::image type="content" source="../media/recommendation-details-page-d6bf1702.png" alt-text="Screenshot of recommendations for virtual machine vulnerability findings.":::


The recommendation details shown are:

 -  For supported recommendations, the top toolbar shows any or all of the following buttons:
    
    
     -  Enforce and Deny
     -  View the policy definition to go directly to the Azure Policy entry for the underlying policy.
     -  **Open query** \- You can view the detailed information about the affected resources using Azure Resource Graph Explorer.
 -  **Severity indicator**
 -  **Freshness interval**
 -  **Count of exempted resources** if exemptions exist for a recommendation; this shows the number of resources that have been exempted with a link to view the specific resources.
 -  **Mapping to MITRE ATT&CK tactics and techniques** if a recommendation has defined tactics and techniques, select the icon for links to the relevant pages on MITRE's site. This applies only to Azure-scored recommendations.
    
    :::image type="content" source="../media/tactics-window-38591f40.png" alt-text="Screenshot of recommendations for management ports that should be closed on virtual machines.":::
    
 -  **Description** \- A short description of the security issue.
 -  When relevant, the details page also includes a table of related recommendations:
    
    The relationship types are:
    
    
     -  **Prerequisite** \- A recommendation that must be completed before the selected recommendation
     -  **Alternative** \- A different recommendation that provides another way of achieving the goals of the selected recommendation
     -  **Dependent** \- A recommendation for which the selected recommendation is a prerequisite
    
    For each related recommendation, the number of unhealthy resources is shown in the "**Affected resources**" column.
    
    If a related recommendation is grayed out, its dependency isn't yet completed or available.
 -  **Remediation steps** \- A description of the manual steps required to remediate the security issue on the affected resources. For recommendations with the Fix option, you can **select View remediation logic** before applying the suggested fix to your resources.
 -  **Affected resources** \- Your resources are grouped into tabs:
     -  **Healthy resources** – Relevant resources that either aren't impacted or on which you have already remediated the issue.
     -  **Unhealthy resources** – Resources that are still impacted by the identified issue.
     -  **Not applicable resources** – Resources for which the recommendation can't give a definitive answer. The not applicable tab also includes reasons for each resource.
 -  Action buttons to remediate the recommendation or trigger a logic app.

:::image type="content" source="../media/recommendations-not-applicable-reasons-19d5a9ad.png" alt-text="Screenshot showing an example of how to view not applicable resources that are listed in under the affected resources column.":::


## **Viewing the relationship between a recommendation and a policy**

As mentioned above, Defender for Cloud's built-in recommendations are based on the Microsoft cloud security benchmark. Almost every recommendation has an underlying policy that is derived from a requirement in the benchmark.

When you're reviewing the details of a recommendation, it's often helpful to be able to see the underlying policy. For every recommendation supported by a policy, use the View policy definition link from the recommendation details page to go directly to the Azure Policy entry for the relevant policy:

:::image type="content" source="../media/view-policy-definition-79d58740.png" alt-text="Screenshot showing an example of how to view policy definitions for unhealthy virtual resources.":::


Use this link to view the policy definition and review the evaluation logic.

If you're reviewing the list of recommendations on our Security recommendations reference guide, you'll also see links to the policy definition pages:

:::image type="content" source="../media/view-policy-definition-from-documentation-fd84f2cd.png" alt-text="Screenshot of recommendations for management ports that should be closed on your virtual machines and an example link to the policy definition pages.":::
