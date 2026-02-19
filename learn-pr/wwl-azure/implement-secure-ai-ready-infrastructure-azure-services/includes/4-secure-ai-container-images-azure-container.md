
## The container security challenge

Your AI applications don't run in isolation—they're packaged as container images that bundle your application code with runtime dependencies, libraries, and base operating systems. Each layer in these images introduces potential vulnerabilities. That Python inference API you built for fraud detection might depend on a TensorFlow version with known security flaws, or the Ubuntu base image could contain unpatched OpenSSL vulnerabilities. Traditional approaches require security teams to manually scan images before deployment, creating bottlenecks that delay releases and fail to catch vulnerabilities introduced in dependencies you don't directly control.

Azure Container Registry (ACR) solves this problem through automated vulnerability scanning that examines every layer of your container images. When your CI/CD pipeline pushes a new fraud detection model container to ACR, Microsoft Defender for Containers immediately scans the image for Common Vulnerabilities and Exposures (CVEs). Within minutes, you receive a security report showing which base image layers contain vulnerabilities, their severity ratings (critical, high, medium, low), and specific remediation steps. For example, Defender might identify CVE-2023-1234 in your TensorFlow dependency and recommend upgrading to version 2.15.1, which patches the vulnerability.

## Automated vulnerability scanning in action

Consider what happens when a critical vulnerability is discovered in a widely used library. On a Tuesday morning, security researchers announce a remote code execution flaw in the OpenSSL library that affects millions of applications. Your fraud detection model container built three months ago, includes this vulnerable OpenSSL version in its base image. With traditional scanning approaches, you wouldn't discover this vulnerability until your next scheduled security review—potentially weeks away. During that window, attackers could exploit the flaw to compromise your AI infrastructure.

With Microsoft Defender for Containers enabled on your ACR instance, the vulnerability scan updates automatically when new CVEs are published. By Tuesday afternoon, Defender rescans all images in your registry against the updated vulnerability database. Your fraud detection container now shows a new critical vulnerability, and Defender provides the exact base image version that contains the patch. Your security team receives an alert through Azure Monitor, and your operations team rebuilds the container with an updated base image. Within 24 hours of the vulnerability announcement, you've identified affected containers, applied patches, and redeployed secure versions—reducing your exposure window from weeks to a single day.

This becomes especially important when managing AI model containers at scale. Your organization maintains 50 different model containers across development, staging, and production environments. Manually tracking vulnerabilities across all images and their dependencies would require dedicated security staff. Defender automates this entire process, continuously scanning all registry images and providing a centralized dashboard that shows your security posture. Organizations implementing automated container scanning report 85% reduction in vulnerability remediation time and identify critical issues 95% faster compared to manual security reviews.

:::image type="content" source="../media/continuous-scan-registry-images-centralized.png" alt-text="Diagram showing how Defender automates an entire process by continuously scanning all registry images.":::

## Access control: Repository-scoped permissions

Now that you understand vulnerability management, let's examine how ACR controls who can push and pull your AI container images. Traditional container registry configurations grant users registry-wide permissions—if someone can pull images, they can pull all images in the registry. This creates security risks when multiple teams share a registry. Your fraud detection team shouldn't access customer service model containers, and junior developers shouldn't deploy production images.

Azure Container Registry provides two layers of access control that address these requirements. Azure RBAC roles (AcrPush, AcrPull, AcrDelete) grant registry-wide permissions suitable for administrators and CI/CD service principals that manage multiple repositories. Building on this concept, repository-scoped tokens deliver granular access control by allowing you to create tokens with permissions limited to specific repositories. For example, you create a token named "fraud-detection-ci" with push permission only to the "fraud-detection" repository. Your CI/CD pipeline uses this token to publish new model containers but can't modify other teams' repositories or pull production images from protected repositories.

At the same time, managed identities eliminate tokens entirely when integrating ACR with Azure services. Your Azure Machine Learning workspace uses its managed identity to pull model containers for inference deployments. You assign the AcrPull role to the workspace's managed identity at the repository scope, granting pull access only to approved model repositories. This approach provides audit trails through Microsoft Entra ID access logs and eliminates token management overhead—no credentials to rotate, secure, or accidentally expose in configuration files.

## Content trust: Verifying image integrity

With access controls preventing unauthorized modifications, your next concern is ensuring that deployed containers haven't been tampered with between build time and deployment. An attacker who compromises your CI/CD pipeline could inject malicious code into container images before pushing to ACR. Without integrity verification, this compromised image could deploy to production, executing attacker-controlled code within your AI infrastructure.

Content trust solves this problem through digital signatures that verify both the publisher's identity and the image's integrity. When content trust is enabled on your ACR instance, you can't push unsigned images. Your CI/CD pipeline must digitally sign each image using Docker Content Trust (Notary) before pushing to the registry. This signature includes a cryptographic hash of the image content and the signing identity's certificate. When Azure Machine Learning pulls the image for deployment, it verifies the signature against ACR's trust store, confirming that the image originated from your authorized CI/CD pipeline and hasn't been modified.

Consider a scenario where an attacker gains temporary access to your ACR instance and attempts to push a modified fraud detection container. Without content trust, the malicious image would be indistinguishable from legitimate containers—same repository, same tag, but containing backdoor code. With content trust enabled, the attacker can't push the image because they don't possess your signing key. Even if they somehow obtained push permissions, the image would lack a valid signature, and deployment systems would reject it during pull operations. This provides defense-in-depth that protects against both external attacks and insider threats.

## Network isolation and geo-replication

Remember that private endpoints eliminated public internet access for AI services. The same principle applies to container registries—you don't want your production container images accessible via public registry endpoints where attackers could attempt brute-force attacks or exploit registry vulnerabilities. When you deploy a private endpoint for your ACR instance, all pull and push operations flow through your virtual network. Your Azure Machine Learning workspace, Azure Kubernetes Service clusters, and Foundry Projects access the registry using private IP addresses within your virtual network, completely removing the registry from public internet routing.

Building on this network security foundation, geo-replication addresses disaster recovery and global deployment scenarios. Your AI infrastructure spans three Azure regions: East US for North American customers, West Europe for European operations, and Southeast Asia for APAC markets. Without geo-replication, all regions pull container images from your primary ACR instance in East US, introducing cross-region latency and creating a single point of failure. If the East US region experiences an outage, deployments in all regions fail.

:::image type="content" source="../media/geo-replication-addresses-disaster-recovery.png" alt-text="Diagram showing how the East US region experiences an outage and deployments in all regions fail.":::

ACR geo-replication solves both problems by maintaining synchronized registry replicas in multiple Azure regions. When you push a new fraud detection model container to your East US registry, ACR automatically replicates it to your West Europe and Southeast Asia instances within minutes. Deployments in each region pull images from their local replica, reducing pull times by 70% and eliminating cross-region dependencies. At the same time, this replication provides disaster recovery—if your primary region fails, applications continue pulling images from healthy replicas in other regions. Your operations team configures replication once, and ACR handles synchronization automatically, maintaining identical image catalogs across all regions.

## Integration with AI deployment platforms

Now that you understand the individual security features, let's see how ACR integrates with the AI platforms your applications actually run on. Azure Machine Learning workspaces pull model containers from ACR for batch scoring jobs and real-time inference endpoints. When you deploy a model, Machine Learning uses its managed identity to authenticate to ACR, pulls the specified container image through your private endpoint, and launches the inference service. Because ACR provides the container, vulnerability scanning, and access logging, your security team has complete visibility into which models are deployed and whether they contain known vulnerabilities.

Azure Kubernetes Service (AKS) extends this integration to more complex AI workloads. Your fraud detection system runs as microservices in an AKS cluster, with each service packaged as a container stored in Azure Container Registry. AKS worker nodes use managed identities to pull images from Azure Container Registry through private endpoints. When you update a fraud detection model, you push a new container to ACR, Defender scans it for vulnerabilities, and Kubernetes automatically pulls the updated image during the next deployment. This workflow combines Azure Container Registry's security controls with AKS's orchestration capabilities, ensuring every deployed container has passed security validation before serving production traffic.

With this understanding of container security—from vulnerability scanning through access control to network isolation—you've now covered the complete security architecture for AI infrastructure. You're ready to implement these controls in a hands-on exercise that validates your production-ready configuration.

:::image type="content" source="../media/azure-container-registry-security-workflow.png" alt-text="Diagram showing the Azure Container Registry security workflow.":::


*Azure Container Registry security workflow from image creation through scanning, access control, and deployment to AI platforms*


## More resources

- [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction) - Comprehensive guide to vulnerability scanning and image security
- [Configure content trust in Azure Container Registry](/azure/container-registry/container-registry-content-trust) - Implementation steps for image signing and verification
- [Azure Container Registry geo-replication](/azure/container-registry/container-registry-geo-replication) - Configuration guidance for multi-region registry replication


