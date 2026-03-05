Microsoft Defender for Containers is a cloud-native solution to improve, monitor, and maintain the security of your containerized assets (Kubernetes clusters, Kubernetes nodes, Kubernetes workloads, container registries, container images and more), and their applications, across multicloud and on-premises environments.

Defender for Containers assists you with five core domains of container security:

- **Security posture management** - performs continuous monitoring of cloud APIs, Kubernetes APIs, and Kubernetes workloads to discover cloud resources, provide comprehensive inventory capabilities, detect misconfigurations, and provide guidelines to mitigate them, provide contextual risk assessment, and empowers users to perform enhanced risk hunting capabilities through the Defender for Cloud security explorer.
- **Vulnerability assessment** - provides agentless vulnerability assessment of container registry images, running containers, and supported Kubernetes nodes for Azure, AWS, and GCP with remediation guidelines, zero configuration, daily rescans, coverage for OS and language packages, and exploitability insights. Vulnerability findings are signed with Microsoft certificates for integrity and authenticity.
- **Run-time threat protection** - a rich threat detection suite for Kubernetes clusters, nodes, and workloads, powered by Microsoft leading threat intelligence, provides mapping to MITRE ATT&CK framework for easy understanding of risk and relevant context, and automated response. Security operators can investigate and respond to threats through the Microsoft Defender XDR portal.
- **Container software supply chain protection** - strengthens your software supply chain by embedding security checks from build to deployment. Enforces organizational security policies through gated deployment that blocks risky images and assesses deployments against security rules, helping prevent vulnerabilities from reaching production.
- **Deployment & monitoring** - Monitors your Kubernetes clusters for missing sensors and provides frictionless at-scale deployment for sensor-based capabilities, support for standard Kubernetes monitoring tools, and management of unmonitored resources.

## Security posture management

### Agentless capabilities

- **Agentless discovery for Kubernetes** - provides zero footprint, API-based discovery of your Kubernetes clusters, their configurations, and deployments.
- **Agentless vulnerability assessment** - provides vulnerability assessment for cluster nodes and for all container images, including recommendations for registry and runtime, quick scans of new images, daily refresh of results, exploitability insights, and more. Agentless runtime container scanning is now generally available for AKS and extends coverage to running containers using images from any registry. Vulnerability information is added to the security graph for contextual risk assessment and calculation of attack paths, and hunting capabilities.
- **Comprehensive inventory capabilities** - enables you to explore resources, pods, services, repositories, images, and configurations through security explorer to easily monitor and manage your assets.
- **Enhanced risk-hunting** - enables security admins to actively hunt for posture issues in their containerized assets through queries (built-in and custom) and security insights in the security explorer.
- **Control plane hardening** - continuously assesses the configurations of your clusters and compares them with the initiatives applied to your subscriptions. When it finds misconfigurations, Defender for Cloud generates security recommendations that are available on Defender for Cloud's Recommendations page. The recommendations let you investigate and remediate issues.

You can use the resource filter to review the outstanding recommendations for your container-related resources, whether in asset inventory or the recommendations page:

:::image type="content" source="../media/defender-for-cloud-resource-filter-f77ae012.png" alt-text="Screenshot showing how to use the resource filter to review the outstanding recommendations.":::

## Sensor-based capabilities

**Kubernetes data plane hardening** - To protect the workloads of your Kubernetes containers with best practice recommendations, you can install Azure Policy for Kubernetes.

With Azure Policy for Kubernetes, every request to the Kubernetes API server is monitored against the predefined set of best practices before being persisted to the cluster. You can then configure it to enforce the best practices and mandate them for future workloads.

For example, you can mandate that privileged containers shouldn't be created, and any future requests to do so are blocked.

**Binary drift detection** - Defender for Containers provides a sensor-based capability that alerts you about potential security threats by detecting unauthorized external processes within containers. You can define drift policies to specify conditions under which alerts should be generated, helping distinguish between legitimate activities and potential threats.

## Vulnerability assessment

Defender for Containers scans container images in Azure Container Registry (ACR), Amazon AWS Elastic Container Registry (ECR), Google Artifact Registry (GAR), Google Container Registry (GCR), and supported external registries (including JFrog Artifactory Cloud and Docker Hub) to provide vulnerability reports for your container images. It also performs agentless daily scans of all running containers to provide updated vulnerability assessment, agnostic to the container's image registry.

Vulnerability reports provide details for each vulnerability detected, remediation guidance, real-world exploit insights, CVSS scoring, and exploitability information. Vulnerability assessment is powered by Microsoft Defender Vulnerability Management.

## Run-time protection for Kubernetes nodes and clusters

Defender for Containers provides real-time threat protection for supported containerized environments and generates alerts for suspicious activities. You can use this information to quickly remediate security issues and improve the security of your containers.

Threat protection at the cluster level is provided by the Defender sensor and analysis of the Kubernetes audit logs. Security operators can also investigate and respond to threats to Kubernetes services through the Microsoft Defender XDR portal. This means that security alerts are only triggered for actions and deployments that occur after enabling Defender for Containers on your subscription.

Examples of security events that Microsoft Defender for Containers monitors include:

- Exposed Kubernetes dashboards
- Creation of high privileged roles
- Creation of sensitive mounts

You can view security alerts by selecting the Security alerts tile at the top of the Defender for Cloud's overview page, or the link from the sidebar.

:::image type="content" source="../media/defender-for-cloud-alerts-page-6029c1e5.png" alt-text="Screenshot showing how to view security alerts in Defender for Cloud.":::

The security alerts page opens:

:::image type="content" source="../media/alerts-for-runtime-workload-091200c3.png" alt-text="Screenshot showing security alerts for runtime workload in the clusters.":::

Security alerts for runtime workload in the clusters are recognized by the `K8S.NODE_` prefix of the alert type.

Defender for Containers also includes host-level threat detection with over 60 Kubernetes-aware analytics, AI, and anomaly detections based on your runtime workload. Other capabilities include:

- **Restrict Pod Access response action** - Available in preview in Microsoft Defender XDR, this action blocks sensitive interfaces within Kubernetes pods to contain potential breaches and reduce exposure within cluster environments.
- **Kubernetes gated deployment** - Now generally available, this feature enforces container image security at deployment time using Kubernetes admission control to block or audit deployments of container images that violate organizational security rules.

Defender for Cloud monitors the attack surface of multicloud Kubernetes deployments based on the MITRE ATT&CK matrix for Containers. MITRE ATT&CK is a framework developed by the Center for Threat-Informed Defense in close partnership with Microsoft.
