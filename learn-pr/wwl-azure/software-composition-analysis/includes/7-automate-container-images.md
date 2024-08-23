The terms *container scanning* and *container image scanning* are often used interchangeably, although they refer to slightly different aspects of software composition analysis in containerized environments. Container scanning generally refers to the process of detecting vulnerabilities, misconfigurations, or security issues in containerized applications. It targets the runtime environment, dependencies, libraries, and configuration settings within containers. Container image scanning focuses on the container images. It involves inspecting the layers, packages, libraries, and configurations within the container image to identify such issues as security vulnerabilities and outdated dependencies. Image scanning typically targets container images residing in container registries.

There are numerous container scanning tools and techniques that support Azure DevOps and GitHub platforms. In general, you can leverage platform-agnostic services such as Microsoft Defender for Cloud or incorporate scanning tools directly into Azure Pipelines or GitHub Actions.

## Microsoft Defender for Cloud

Microsoft Defender for Cloud is a cloud-native application protection platform that implements security measures and practices designed to protect cloud-based workloads from a wide range of cyber threats. It includes support for image and container scanning by leveraging the capabilities of Microsoft Defender for Containers and Microsoft Defender Vulnerability Management.

### Microsoft Defender for Containers

Microsoft Defender for Containers is a cloud-native solution which goal is to enhance the security of containerized environments, including Kubernetes clusters, container registries, and container images, across multicloud and on-premises environments. Its functionality can be grouped into four main categories:

 -  **Security posture management** performs continuous monitoring of Kubernetes workloads to discover cloud resources, inventory them, detect their misconfigurations, provide remediation guidance, assess the corresponding risks, and assist with risk hunting by using the Defender for Cloud security explorer.
 -  **Run-time threat protection** delivers threat detection for Kubernetes clusters, closely aligned with the MITRE ATT&CK framework and featuring integration with a broad range of security information and event management (SIEM) and extended detection and response (XDR) products.
 -  **Deployment and monitoring** facilitates implementing Kubernetes clusters and tracking their status.
 -  **Vulnerability assessment** provides agentless vulnerability assessment for multicloud resources, including remediation guidance and automated scanning.

Vulnerability assessment relies on Microsoft Defender Vulnerability Management.

### Microsoft Defender Vulnerability Management

Microsoft Defender Vulnerability Management offers a trigger-based image scanning functionality targeting images in Azure Container Registry (ACR) registries. It automatically generates reports documenting vulnerabilities and the corresponding remediations for each image. It also provides scanning of containers deployed into Azure Kubernetes Service (AKS) clusters based on images pulled from any Defender for Cloud supported registry, including, besides ACR, those native to Amazon Web Services (AWS) and Google Cloud Platform (GCP), such as Elastic Container Registry (ECR), Google Container Registry (GCR), and Google Artifact Registry (GAR).

All images stored in ACR that meet the criteria for scan triggers are automatically scanned for vulnerabilities without any additional configuration. These criteria can be grouped into two main categories:

 -  Triggered by push, import, and pull operations. In case of push or import, a scan is typically completed within a few minutes, but it might take up to an hour. Following individual pulls, images are scanned within 24 hours.
 -  Running continuously for images that have been previously scanned for vulnerabilities in order to update their vulnerability reports to account for newly published vulnerabilities. These scans are performed once per day for images pushed in the last 90 days, images pulled in the last 30 days, and images running on the Kubernetes clusters that are monitored by Defender for Cloud.

Recommendations with vulnerability reports are provided for all images in ACR as well as images that are currently running in Azure Kubernetes Service (AKS) clusters. After you take the recommended steps to remediate the security issue and replace the image in the registry, Microsoft Defender for Cloud automatically rescans the image to confirm that the vulnerabilities no longer exist.

## Incorporating scanning tools directly into Azure Pipelines or GitHub Actions.

You can incorporate container and image scanning directly into your CI/CD pipelines to automatically identify vulnerabilities and ensure compliance. The process begins by selecting a suitable scanning tool compatible with the respective platform, such as Aqua available as a DevOps security extension or Trivy GitHub Action. You can then integrate the chosen scanning tool into the build process to analyze container images for vulnerabilities and compliance issues. Container scanning should be applied during the CD stage to assess the outcome of the deployment.

As part of the CI/CD integration, consider preventing the image deployment in case its scan reports non-compliance. When implementing workflows in GitHub, take advantage of its Dependabot capabilities to detect and create pull requests to update dependencies in container images, including Dockerfiles, package manifests, and other configuration files. Automate remediation actions, such as patching vulnerabilities or rebuilding an image, based on the scan results. Implement continuous monitoring and reviews of scan results, leveraging platform-specific dashboards, reports, and notifications.
