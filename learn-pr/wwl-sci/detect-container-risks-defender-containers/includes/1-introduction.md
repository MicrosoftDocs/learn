Contoso Retail runs a cloud-native e-commerce platform on Azure. Microservices handle inventory, payments, and order tracking—each one packaged as a container image, stored in Azure Container Registry (ACR), and deployed into Azure Kubernetes Service (AKS) clusters that scale with customer traffic. The platform processes thousands of orders daily, and the security posture of each container affects the integrity of every transaction.

After a recent security review, the Cloud Security Engineering team discovered two critical gaps. No vulnerability scanning was configured for ACR images, so container images pulled from external sources reached production without any analysis of known CVEs (Common Vulnerabilities and Exposures). No runtime visibility existed in the AKS clusters, meaning workload behavior—new processes, network anomalies, privilege escalation attempts—produced no alerts. Suspicious activity in an external base image went undetected for weeks, long enough to affect deployed workloads before anyone identified the problem.

Microsoft Defender for Containers addresses both gaps. Defender for Containers provides cloud-native security across the container lifecycle: scanning images in ACR for known vulnerabilities, monitoring runtime behavior in AKS clusters, enforcing security posture recommendations aligned to industry benchmarks, and blocking noncompliant workloads from reaching production.

In this module, you explore the architecture and protection pillars of Defender for Containers, enable and configure the plan in Microsoft Defender for Cloud, evaluate vulnerability findings from ACR image scanning, and interpret runtime alerts and security posture recommendations for AKS clusters. By the end of this module, you detect container risks across the full lifecycle—from registry to runtime—and take action on what Defender for Containers surfaces.

## In this module, you:

- Describe the architecture and protection pillars of Microsoft Defender for Containers
- Enable and configure the Defender for Containers plan in Microsoft Defender for Cloud
- Evaluate container image vulnerability findings from ACR scanning
- Interpret runtime threat alerts and security posture recommendations for AKS clusters
