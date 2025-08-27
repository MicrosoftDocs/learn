## Use a private registry

Containers are built from images that are stored in one or more repositories. These repositories can belong to a public registry, like [Docker Hub](https://hub.docker.com/), or to a private registry. An example of a private registry is the [Docker Trusted Registry](https://docs.docker.com/datacenter/dtr/), which can be installed on-premises or in a virtual private cloud. You can also use cloud-based private container registry services, including [Azure Container Registry](/azure/container-registry/container-registry-intro).

A publicly available container image doesn't guarantee security. Container images consist of multiple software layers, and each software layer might have vulnerabilities. To help reduce the threat of attacks, you should store and retrieve images from a private registry, such as Azure Container Registry or Docker Trusted Registry. In addition to providing a managed private registry, Azure Container Registry supports [service principal-based authentication](/azure/container-registry/container-registry-authentication) through Microsoft Entra ID for basic authentication flows. This authentication includes role-based access for read-only (pull), write (push), and other permissions.

## Monitor and scan container images

Take advantage of solutions to scan container images in a private registry and identify potential vulnerabilities. It’s important to understand the depth of threat detection that the different solutions provide.

For example, Azure Container Registry optionally [integrates with Microsoft Defender for Cloud](/azure/security-center/defender-for-container-registries-introduction) to automatically scan all Linux images pushed to a registry. Microsoft Defender for Cloud's integrated Qualys scanner detects image vulnerabilities, classifies them, and provides remediation guidance.

Security monitoring and image scanning solutions such as [Twistlock](https://azuremarketplace.microsoft.com/marketplace/apps/twistlock.twistlock?tab=Overview) and [Aqua Security](https://azuremarketplace.microsoft.com/marketplace/apps/aqua-security.aqua-security-private-offer-primary) are also available through the Azure Marketplace.

## Protect credentials

Containers can spread across several clusters and Azure regions. So, you must secure credentials required for logins or API access, such as passwords or tokens. Ensure that only privileged users can access those containers in transit and at rest. Inventory all credential secrets, and then require developers to use emerging secrets-management tools that are designed for container platforms. Make sure that your solution includes encrypted databases, Transport Layer Security (TLS) encryption for secrets data in transit, and least-privilege [Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/overview). [Azure Key Vault](/azure/key-vault/general/security-features) is a cloud service that safeguards encryption keys and secrets (such as certificates, connection strings, and passwords) for containerized applications. Because this data is sensitive and business critical, secure access to your key vaults so that only authorized applications and users can access them.

## Considerations for the container ecosystem

The following security measures, implemented well and managed effectively, can help you secure and protect your container ecosystem. These measures apply throughout the container lifecycle, from development through production deployment, and to a range of container orchestrators, hosts, and platforms.

## Use vulnerability management as part of your container development lifecycle

By using effective vulnerability management throughout the container development lifecycle, you improve the odds that you identify and resolve security concerns before they become a more serious problem.

## Scan for vulnerabilities

New vulnerabilities are discovered all the time, so scanning for and identifying vulnerabilities is a continuous process. Incorporate vulnerability scanning throughout the container lifecycle:

 -  As a final check in your development pipeline, you should perform a vulnerability scan on containers before pushing the images to a public or private registry.
 -  You should continue to scan container images in the registry. Look to identify any flaws that were somehow missed during development and to address any newly discovered vulnerabilities that might exist in the code used in the container images.

## Map image vulnerabilities to running containers

You need to have a means of mapping vulnerabilities identified in container images to running containers, so security issues can be mitigated or resolved.

## Ensure that only approved images are used in your environment

There’s enough change and volatility in a container ecosystem without allowing unknown containers as well. Allow only approved container images. Have tools and processes in place to monitor for and prevent the use of unapproved container images.

An effective way of reducing the attack surface and preventing developers from making critical security mistakes is to control the flow of container images into your development environment. For example, you might sanction a single Linux distribution as a base image, preferably one that is lean (Alpine or CoreOS rather than Ubuntu), to minimize the surface for potential attacks.<br>

Image signing or fingerprinting can provide a chain of custody that enables you to verify the integrity of the containers. For example, Azure Container Registry supports Docker's content trust model, which allows image publishers to sign images that are pushed to a registry, and image consumers to pull only signed images.<br>

## Permit only approved registries

An extension of ensuring that your environment uses only approved images is to permit only the use of approved container registries. Requiring the use of approved container registries reduces your exposure to risk by limiting the potential for the introduction of unknown vulnerabilities or security issues.

## Ensure the integrity of images throughout the lifecycle

Part of managing security throughout the container lifecycle is to ensure the integrity of the container images in the registry and as they're altered or deployed into production.

 -  Images with vulnerabilities, even minor, shouldn't be allowed to run in a production environment. Ideally, all images deployed in production should be saved in a private registry accessible to a select few. Keep the number of production images small to ensure that they can be managed effectively.<br>
 -  Because it’s hard to pinpoint the origin of software from a publicly available container image, build images from the source to ensure knowledge of the origin of the layer. When a vulnerability surfaces in a self-built container image, customers can find a quicker path to a resolution. With a public image, customers would need to find the root of a public image to fix it or get another secure image from the publisher.<br>
 -  A thoroughly scanned image deployed in production isn't guaranteed to be up-to-date for the lifetime of the application. Security vulnerabilities might be reported for layers of the image that weren't previously known or were introduced after the production deployment.<br>
 -  Periodically audit images deployed in production to identify images that are out of date or haven't been updated in a while. You might use blue-green deployment methodologies and rolling upgrade mechanisms to update container images without downtime. You can scan images by using tools described in the preceding section.<br>
 -  Use a continuous integration (CI) pipeline with integrated security scanning to build secure images and push them to your private registry. The vulnerability scanning built into the CI solution ensures that images that pass all the tests are pushed to the private registry from which production workloads are deployed.<br>
 -  A CI pipeline failure ensures that vulnerable images aren't pushed to the private registry that’s used for production workload deployments. It also automates image security scanning if there’s a significant number of images. Otherwise, manually auditing images for security vulnerabilities can be painstakingly lengthy and error prone.<br>

## Enforce least privileges in runtime

The concept of least privileges is a basic security best practice that also applies to containers. When a vulnerability is exploited, it generally gives the attacker access and privileges equal to those of the compromised application or process. Ensuring that containers operate with the lowest privileges and access required to get the job done reduces your exposure to risk.

## Reduce the container attack surface by removing unneeded privileges

You can also minimize the potential attack surface by removing any unused or unnecessary processes or privileges from the container runtime. Privileged containers run as root. If a malicious user or workload escapes in a privileged container, the container runs as root on that system.

## Preapprove files and executables that the container is allowed to access or run

Reducing the number of variables or unknowns helps you maintain a stable, reliable environment. Limiting containers so they can access or run only preapproved or safe listed files and executables is a proven method of limiting exposure to risk.

It’s a lot easier to manage a safe list when implemented from the beginning. A safe list provides a measure of control and manageability as you learn what files and executables are required for the application to function correctly.<br>

A safe list not only reduces the attack surface but can also provide a baseline for anomalies and prevent the use cases of the "noisy neighbor" and container breakout scenarios.<br>

## Enforce network segmentation on running containers

To help protect containers in one subnet from security risks in another subnet, maintain network segmentation (or nano-segmentation) or segregation between running containers. Maintaining network segmentation might also be necessary to use containers in industries that are required to meet compliance mandates.

For example, the partner tool [Aqua](https://azuremarketplace.microsoft.com/marketplace/apps/aqua-security.aqua-security-private-offer-primary) provides an automated approach for nano-segmentation. Aqua monitors container network activities in runtime. It identifies all inbound and outbound network connections to/from other containers, services, IP addresses, and the public internet. Nano-segmentation is automatically created based on monitored traffic.

## Monitor container activity and user access

As with any IT environment, you should consistently monitor activity and user access to your container ecosystem to quickly identify any suspicious or malicious activity. Azure provides container monitoring solutions including:

 -  [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) monitors the performance of your workloads deployed to Kubernetes environments hosted on Azure Kubernetes Service (AKS). Azure Monitor for containers gives you performance visibility by collecting memory and processor metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API.

The **Azure Container Monitoring Solution** is deprecated (8/31/2024). The best replace tool is using **Azure Monitor Container Insights** built into Azure Monitor. You get a full set of features to keep track of your containers:

- Agent - Runs on the Azure Monitor Agent
- Metrics - Support Azure Monitor metrics
- Alerting - Support both Log and Metric based alerts
- Where to use it - Available in both Azure Monitor and in the AKS/Arc resource pane
- Update - Automatic updates via Azure Arc extension

## Monitor container resource activity

Monitor your resource activity, like files, network, and other resources that your containers access. Monitoring resource activity and consumption is useful both for performance monitoring and as a security measure.

[Azure Monitor](/azure/azure-monitor/overview) enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. For example, the activity log tells you when new resources are created or modified.

Metrics are available that provide performance statistics for different resources and even the operating system inside a virtual machine. You can view this data with one of the explorers in the Azure portal and create alerts based on these metrics. Azure Monitor provides the fastest metrics pipeline (5 minutes down to 1 minute), so you should use it for time-critical alerts and notifications.

## Log all container administrative user access for auditing

Maintain an accurate audit trail of administrative access to your container ecosystem, including your Kubernetes cluster, container registry, and container images. These logs might be necessary for auditing purposes and will be useful as forensic evidence after any security incident. Azure solutions include:

 -  [Integration of Azure Kubernetes Service with Microsoft Defender for Cloud](/azure/security-center/defender-for-kubernetes-introduction) to monitor the security configuration of the cluster environment and generate security recommendations
 -  [Azure Monitor Container Insights](/azure/azure-monitor/containers/container-insights-analyze)
 -  Resource logs for [Azure Container Instances](/azure/container-instances/container-instances-log-analytics) and [Azure Container Registry](/azure/container-registry/monitor-service)
