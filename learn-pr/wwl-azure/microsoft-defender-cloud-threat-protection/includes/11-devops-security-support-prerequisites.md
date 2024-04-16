## Cloud and region support<br>

DevOps security is available in the Azure commercial cloud, in these regions:

 -  Asia (East Asia)<br>
 -  Australia (Australia East)
 -  Canada (Canada Central)
 -  Europe (West Europe, North Europe, Sweden Central)
 -  UK (UK South)
 -  US (East US, Central US)

## DevOps platform support

DevOps security currently supports the following DevOps platforms:

 -  Azure DevOps Services<br>
 -  GitHub Enterprise Cloud
 -  GitLab SaaS

## Required permissions

DevOps security requires the following permissions:

| **Feature**                                                     | **Permissions**                                                                                                                                                                     |
| --------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Connect DevOps environments to Defender for Cloud               | Azure: Subscription Contributor or Security AdminAzure DevOps: Project Collection Administrator on target OrganizationGitHub: Organization OwnerGitLab: Group Owner on target Group |
| Review security insights and findings                           | Security Reader                                                                                                                                                                     |
| Configure pull request annotations                              | Subscription Contributor or Owner                                                                                                                                                   |
| Install the Microsoft Security DevOps extension in Azure DevOps | Azure DevOps Project Collection Administrator                                                                                                                                       |
| Install the Microsoft Security DevOps action in GitHub          | GitHub Write                                                                                                                                                                        |

Security Reader role can be applied on the Resource Group or connector scope to avoid setting highly privileged permissions on a Subscription level for read access of DevOps security insights and findings.

## Feature availability

The following tables summarize the availability and prerequisites for each feature within the supported DevOps platforms:

Starting March 7, 2024, Defender CSPM must be enabled on at least one subscription or multicloud connector in the tenant to benefit from premium DevOps security capabilities which include code-to-cloud contextualization powering security explorer and attack paths and pull request annotations for Infrastructure-as-Code security findings.

## Azure DevOps

| **Feature**                                                              | **Foundational CSPM**                                                                       | **Defender CSPM**                                                                           | **Prerequisites**                                                                                                         |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Connect Azure DevOps repositories                                        | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | See here                                                                                                                  |
| Security recommendations to fix code vulnerabilities                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security for Azure DevOps for CodeQL findings, Microsoft Security DevOps extension                        |
| Security recommendations to discover exposed secrets                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security for Azure DevOps                                                                                 |
| Security recommendations to fix open source vulnerabilities              | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security for Azure DevOps                                                                                 |
| Security recommendations to fix infrastructure as code misconfigurations | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Microsoft Security DevOps extension                                                                                       |
| Security recommendations to fix DevOps environment misconfigurations     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | N/A                                                                                                                       |
| Pull request annotations                                                 |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | See here                                                                                                                  |
| Code to cloud mapping for Containers                                     |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Microsoft Security DevOps extension                                                                                       |
| Code to cloud mapping for Infrastructure as Code templates               |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Microsoft Security DevOps extension                                                                                       |
| Attack path analysis                                                     |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Enable Defender CSPM on an Azure Subscription, AWS Connector, or GCP Connector in the same tenant as the DevOps Connector |
| Cloud security explorer                                                  |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Enable Defender CSPM on an Azure Subscription, AWS Connector, or GCP connector in the same tenant as the DevOps Connector |

## GitHub

| **Feature**                                                              | **Foundational CSPM**                                                                       | **Defender CSPM**                                                                           | **Prerequisites**                                                                                                         |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Connect GitHub repositories                                              | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | See here                                                                                                                  |
| Security recommendations to fix code vulnerabilities                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security, Microsoft Security DevOps action                                                                |
| Security recommendations to discover exposed secrets                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security                                                                                                  |
| Security recommendations to fix open source vulnerabilities              | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security                                                                                                  |
| Security recommendations to fix infrastructure as code misconfigurations | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitHub Advanced Security, Microsoft Security DevOps action                                                                |
| Security recommendations to fix DevOps environment misconfigurations     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | N/A                                                                                                                       |
| Code to cloud mapping for Containers                                     |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Microsoft Security DevOps action                                                                                          |
| Code to cloud mapping for Infrastructure as Code templates               |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Microsoft Security DevOps action                                                                                          |
| Attack path analysis                                                     |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Enable Defender CSPM on an Azure Subscription, AWS Connector, or GCP connector in the same tenant as the DevOps Connector |
| Cloud security explorer                                                  |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Enable Defender CSPM on an Azure Subscription, AWS Connector, or GCP connector in the same tenant as the DevOps Connector |

## GitLab

| **Feature**                                                              | **Foundational CSPM**                                                                       | **Defender CSPM**                                                                           | **Prerequisites**                                                                                                         |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Connect GitLab projects                                                  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | See here                                                                                                                  |
| Security recommendations to fix code vulnerabilities                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitLab Ultimate                                                                                                           |
| Security recommendations to discover exposed secrets                     | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitLab Ultimate                                                                                                           |
| Security recommendations to fix open source vulnerabilities              | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitLab Ultimate                                                                                                           |
| Security recommendations to fix infrastructure as code misconfigurations | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | GitLab Ultimate                                                                                                           |
| Cloud security explorer                                                  |                                                                                             | :::image type="content" source="../media/yes-icon-783bde2a.png" alt-text="Icon of Yes.":::  | Enable Defender CSPM on an Azure Subscription, AWS Connector, or GCP connector in the same tenant as the DevOps Connector |
