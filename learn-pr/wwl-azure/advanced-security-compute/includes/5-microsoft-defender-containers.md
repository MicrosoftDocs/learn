Microsoft Defender for Containers is a cloud-native solution to improve, monitor, and maintain the security of your containerized assets (Kubernetes clusters, Kubernetes nodes, Kubernetes workloads, container registries, container images and more), and their applications, across multicloud and on-premises environments.

Defender for Containers assists you with four core domains of container security:

 -  Security posture management - performs continuous monitoring of cloud APIs, Kubernetes APIs, and Kubernetes workloads to discover cloud resources, provide comprehensive inventory capabilities, detect misconfigurations and provide guidelines to mitigate them, provide contextual risk assessment, and empowers users to perform enhanced risk hunting capabilities through the Defender for Cloud security explorer.<br>
 -  Vulnerability assessment - provides agentless vulnerability assessment for Azure, AWS, and GCP with remediation guidelines, zero configuration, daily rescans, coverage for OS and language packages, and exploitability insights.<br>
 -  Run-time threat protection - a rich threat detection suite for Kubernetes clusters, nodes, and workloads, powered by Microsoft leading threat intelligence, provides mapping to MITRE ATT&CK framework for easy understanding of risk and relevant context, automated response, and Security Information and Event Management/Extended detection and response integration.<br>
 -  Deployment & monitoring- Monitors your Kubernetes clusters for missing agents and provides frictionless at-scale deployment for agent-based capabilities, support for standard Kubernetes monitoring tools, and management of unmonitored resources.<br>

## Security posture management

### Agentless capabilities

 -  Agentless discovery for Kubernetes - provides zero footprint, API-based discovery of your Kubernetes clusters, their configurations and deployments.
 -  Agentless vulnerability assessment - provides vulnerability assessment for all container images, including recommendations for registry and runtime, quick scans of new images, daily refresh of results, exploitability insights, and more. Vulnerability information is added to the security graph for contextual risk assessment and calculation of attack paths, and hunting capabilities.<br>
 -  Comprehensive inventory capabilities - enables you to explore resources, pods, services, repositories, images and configurations through security explorer to easily monitor and manage your assets.<br>
 -  Enhanced risk-hunting - enables security admins to actively hunt for posture issues in their containerized assets through queries (built-in and custom) and security insights in the security explorer<br>
 -  Control plane hardening - continuously assesses the configurations of your clusters and compares them with the initiatives applied to your subscriptions. When it finds misconfigurations, Defender for Cloud generates security recommendations that are available on Defender for Cloud's Recommendations page. The recommendations let you investigate and remediate issues.<br>

You can use the resource filter to review the outstanding recommendations for your container-related resources, whether in asset inventory or the recommendations page:

:::image type="content" source="../media/defender-for-cloud-resource-filter-f77ae012.png" alt-text="Screenshot showing how to use the resource filter to review the outstanding recommendations.":::


## Agent-based capabilities

**Kubernetes data plane hardening** \- To protect the workloads of your Kubernetes containers with best practice recommendations, you can install the Azure Policy for Kubernetes.

With the add-on on your Kubernetes cluster, every request to the Kubernetes API server is monitored against the predefined set of best practices before being persisted to the cluster. You can then configure it to enforce the best practices and mandate them for future workloads.

For example, you can mandate that privileged containers shouldn't be created, and any future requests to do so are blocked.

## Vulnerability assessment<br>

Defender for Containers scans the container images in Azure Container Registry (ACR) and Amazon AWS Elastic Container Registry (ECR) to provide vulnerability reports for your container images, providing details for each vulnerability detected, remediation guidance, real-world exploit insights, and more.

There are two solutions for vulnerability assessment in Azure, one powered by Microsoft Defender Vulnerability Management and one powered by Qualys.

## Run-time protection for Kubernetes nodes and clusters

Defender for Containers provides real-time threat protection for supported containerized environments and generates alerts for suspicious activities. You can use this information to quickly remediate security issues and improve the security of your containers.

Threat protection at the cluster level is provided by the Defender agent and analysis of the Kubernetes audit logs. This means that security alerts are only triggered for actions and deployments that occur after you've enabled Defender for Containers on your subscription.

Examples of security events that Microsoft Defenders for Containers monitors include:

 -  Exposed Kubernetes dashboards<br>
 -  Creation of high privileged roles
 -  Creation of sensitive mounts

You can view security alerts by selecting the Security alerts tile at the top of the Defender for Cloud's overview page, or the link from the sidebar.

:::image type="content" source="../media/defender-for-cloud-alerts-page-6029c1e5.png" alt-text="Screenshot showing how to view security alerts in Defender for Cloud.":::


The security alerts page opens:

:::image type="content" source="../media/alerts-for-runtime-workload-091200c3.png" alt-text="Screenshot showing security alerts for runtime workload in the clusters.":::


Security alerts for runtime workload in the clusters can be recognized by the `K8S.NODE_` prefix of the alert type.

Defender for Containers also includes host-level threat detection with over 60 Kubernetes-aware analytics, AI, and anomaly detections based on your runtime workload.

Defender for Cloud monitors the attack surface of multicloud Kubernetes deployments based on the MITRE ATT&CK matrix for Containers, a framework developed by the Center for Threat-Informed Defense in close partnership with Microsoft.
