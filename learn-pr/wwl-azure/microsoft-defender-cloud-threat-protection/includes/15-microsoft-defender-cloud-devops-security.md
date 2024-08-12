Microsoft Defender for Cloud enables comprehensive visibility, posture management, and threat protection across multicloud environments including Azure, AWS, GCP, and on-premises resources.

DevOps security within Defender for Cloud uses a central console to empower security teams with the ability to protect applications and resources from code to cloud across multi-pipeline environments, including Azure DevOps, GitHub, and GitLab. DevOps security recommendations can then be correlated with other contextual cloud security insights to prioritize remediation in code. Key DevOps security capabilities include:

 -  Unified visibility into DevOps security posture: Security administrators now have full visibility into DevOps inventory and the security posture of preproduction application code across multi-pipeline and multicloud environments, which includes findings from code, secrets, and open-source dependency vulnerability scans. They can also assess the security configurations of their DevOps environment.
 -  Strengthen cloud resource configurations throughout the development lifecycle: You can enable security of Infrastructure as Code (IaC) templates and container images to minimize cloud misconfigurations reaching production environments, allowing security administrators to focus on any critical evolving threats.
 -  Prioritize remediation of critical issues in code: Apply comprehensive code-to-cloud contextual insights within Defender for Cloud. Security admins can help developers prioritize critical code fixes with pull request annotations and assign developer ownership by triggering custom workflows feeding directly into the tools developers know and love.

These features help unify, strengthen, and manage multi-pipeline DevOps resources.

## Manage your DevOps environments in Defender for Cloud

DevOps security in Defender for Cloud allows you to manage your connected environments and provide your security teams with a high-level overview of issues discovered in those environments through the DevOps security console.

:::image type="content" source="../media/development-operations-ada2b921.png" alt-text="Screenshot showing how to manage your DevOps environments in Defender for Cloud.":::


Here, you can add Azure DevOps, GitHub, and GitLab environments, customize the DevOps workbook to show your desired metrics, and configure pull request annotations.

:::image type="content" source="../media/posture-management-03c5a866.png" alt-text="Screenshot showing the posture management recommendations in the security overview page.":::


## Understanding your DevOps security

:::image type="content" source="../media/security-overview-b7ab20c2.png" alt-text="Screenshot showing how to review development operations security findings.":::


## Review your findings

The DevOps inventory table allows you to review onboarded DevOps resources and the security information related to them.

:::image type="content" source="../media/bottom-of-page-29c226e4.png" alt-text="Screenshot showing how to review onboarded DevOps resources and the related security information.":::
 On this part of the screen you see:

 -  Name - Lists onboarded DevOps resources from Azure DevOps, GitHub, and/or GitLab. View the resource health page by selecting it.
 -  DevOps environment - Describes the DevOps environment for the resource (that is, Azure DevOps, GitHub, GitLab). Use this column to sort by environment if multiple environments are onboarded.
 -  Advanced security status - Shows whether advanced security features are enabled for the DevOps resource.
     -  `On` \- Advanced security is enabled.
     -  `Off` \- Advanced security isn't enabled.
     -  `Partially enabled` \- Certain Advanced security features aren't enabled (for example, code scanning is off).
     -  `N/A` \- Defender for Cloud doesn't have information about enablement.

> [!NOTE]
> Currently, this information is available only for Azure DevOps and GitHub repositories.

 -  Pull request annotation status - Shows whether PR annotations are enabled for the repository.
     -  `On` \- PR annotations are enabled.<br>
     -  `Off` \- PR annotations aren't enabled.<br>
     -  `N/A` \- Defender for Cloud doesn't have information about enablement.<br>

> [!NOTE]
> Currently, this information is available only for Azure DevOps repositories.

 -  Findings - Shows the total number of codes, secrets, dependency, and infrastructure-as-code findings identified in the DevOps resource.

This table can be viewed as a flat view at the DevOps resource level (repositories for Azure DevOps and GitHub, projects for GitLab) or in a grouping view showing organizations/projects/groups hierarchy. Also, the table can be filtered by subscription, resource type, finding type, or severity.
