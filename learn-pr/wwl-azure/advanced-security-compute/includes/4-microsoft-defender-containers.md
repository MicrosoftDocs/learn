Microsoft Defender for Containers is the cloud-native solution to improve, monitor, and maintain the security of your clusters, containers, and their applications.

Defender for Containers assists you with four core aspects of container security:<br>

 -  **Environment hardening** \- Defender for Containers protects your Kubernetes clusters whether they're running on Azure Kubernetes Service, Kubernetes on-premises/IaaS, or Amazon EKS. Defender for Containers continuously assesses clusters to provide visibility into misconfigurations and guidelines to help mitigate identified threats.<br>
 -  **Vulnerability assessment** \- Vulnerability assessment and management tools for images stored in Azure Container Registry and Elastic Container Registry.<br>
 -  **Run-time threat protection for nodes and clusters** \- Threat protection for clusters and nodes generates security alerts for suspicious activities.<br>
 -  **Agentless discovery for Kubernetes** \- Provides tools that give you visibility into your data plane components, generating security insights based on your Kubernetes and environment configuration and lets you hunt for risks.<br>

## Hardening

Continuous monitoring of your Kubernetes clusters - wherever they're hosted

Defender for Cloud continuously assesses the configurations of your clusters and compares them with the initiatives applied to your subscriptions. When it finds misconfigurations, Defender for Cloud generates security recommendations that are available on Defender for Cloud's Recommendations page. The recommendations let you investigate and remediate issues.

You can use the resource filter to review the outstanding recommendations for your container-related resources, whether in asset inventory or the recommendations page:

## Kubernetes data plane hardening

To protect the workloads of your Kubernetes containers with tailored recommendations, you can install the Azure Policy for Kubernetes. Learn more about monitoring components for Defender for Cloud.

With the add-on on your AKS cluster, every request to the Kubernetes API server will be monitored against the predefined set of best practices before being persisted to the cluster. You can then configure it to enforce the best practices and mandate them for future workloads.<br>

For example, you can mandate that privileged containers shouldn't be created, and any future requests to do so will be blocked.<br>

## Vulnerability assessment

Defender for Containers scans the container images in Azure Container Registry (ACR) and Amazon AWS Elastic Container Registry (ECR) to provide vulnerability reports for your container images, providing details for each vulnerability detected, remediation guidance, real-world exploit insights, and more.

There are two solutions for vulnerability assessment in Azure, one powered by Microsoft Defender Vulnerability Management and one powered by Qualys.<br>

## Run-time protection for Kubernetes nodes and clusters

Defender for Containers provides real-time threat protection for supported containerized environments and generates alerts for suspicious activities. You can use this information to quickly remediate security issues and improve the security of your containers.

Threat protection at the cluster level is provided by the Defender agent and analysis of the Kubernetes audit logs. This means that security alerts are only triggered for actions and deployments that occur after you've enabled Defender for Containers on your subscription.<br>

Examples of security events that Microsoft Defenders for Containers monitors include:<br>

 -  Exposed Kubernetes dashboards<br>
 -  Creation of high privileged roles
 -  Creation of sensitive mounts
