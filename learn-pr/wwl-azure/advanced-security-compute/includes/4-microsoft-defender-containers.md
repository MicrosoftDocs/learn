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

:::image type="content" source="../media/resource-filter-large-30eded32.png" alt-text="Screenshot showing an example of the resource filter in Microsoft Defender for Cloud.":::


For details on the recommendations that might appear for this feature, check out the **compute section** of the recommendations reference table.

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

You can view security alerts by selecting the Security alerts tile at the top of the Defender for Cloud's overview page, or the link from the sidebar.

:::image type="content" source="../media/overview-page-alerts-links-c4ad0274.png" alt-text="Screenshot showing an example of the overview page alerts links in Microsoft Defender for Cloud.":::


The security alerts page opens.

:::image type="content" source="../media/view-containers-alerts-7648c638.png" alt-text="Screenshot showing the security alerts page.":::


Security alerts for runtime workload in the clusters can be recognized by the K8S.NODE\_ prefix of the alert type.

Defender for Containers also includes host-level threat detection with over 60 Kubernetes-aware analytics, AI, and anomaly detections based on your runtime workload.<br>

Defender for Cloud monitors the attack surface of multicloud Kubernetes deployments based on the MITRE ATT&CK® matrix for Containers, a framework developed by the Center for Threat-Informed Defense in close partnership with Microsoft.

## Agentless discovery for Kubernetes

Defender for containers uses cloud security graph to collect in an agentless manner information about your Kubernetes clusters. This data can be queried via Cloud Security Explorer and used for:

1. Kubernetes inventory: gain visibility into your Kubernetes clusters data plane components such as nodes, pods, and cron jobs.<br>

2. Security insights: predefined security situations relevant to Kubernetes components, such as “exposed to the internet”. For more information, see Security insights.<br>

3. Risk hunting: querying various risk cases, correlating predefined or custom security scenarios across fine-grained Kubernetes properties as well as Defender For Containers security insights.

## Cloud security graph

The cloud security graph is a graph-based context engine that exists within Defender for Cloud. The cloud security graph collects data from your multicloud environment and other data sources. For example, the cloud assets inventory, connections and lateral movement possibilities between resources, exposure to internet, permissions, network connections, vulnerabilities and more. The data collected is then used to build a graph representing your multicloud environment.

Defender for Cloud then uses the generated graph to perform an attack path analysis and find the issues with the highest risk that exist within your environment. You can also query the graph using the cloud security explorer.

:::image type="content" source="../media/security-map-9a2d0bc4.png" alt-text="Diagram showing an example of a security map.":::


## Attack path analysis

Attack path analysis is a graph-based algorithm that scans the cloud security graph. The scans expose exploitable paths that attackers might use to breach your environment to reach your high-impact assets. Attack path analysis exposes attack paths and suggests recommendations as to how best remediate issues that will break the attack path and prevent successful breach.

When you take your environment's contextual information into account, attack path analysis identifies issues that might lead to a breach on your environment, and helps you to remediate the highest risk ones first. For example its exposure to the internet, permissions, lateral movement, and more.<br>

:::image type="content" source="../media/attack-path-47ebcc57.png" alt-text="Diagram showing an example of an attack path.":::


## Cloud security explorer

By running graph-based queries on the cloud security graph with the cloud security explorer, you can proactively identify security risks in your multicloud environments. Your security team can use the query builder to search for and locate risks, while taking your organization's specific contextual and conventional information into account.

Cloud security explorer provides you with the ability to perform proactive exploration features. You can search for security risks within your organization by running graph-based path-finding queries on top the contextual security data that is already provided by Defender for Cloud, such as cloud misconfigurations, vulnerabilities, resource context, lateral movement possibilities between resources and more.

:::image type="content" source="../media/cloud-security-explorer-select-resource-extra-large-7b98b951.png" alt-text="Screenshot showing an example of the Cloud Security Explorer in Microsoft Defender for Cloud.":::
