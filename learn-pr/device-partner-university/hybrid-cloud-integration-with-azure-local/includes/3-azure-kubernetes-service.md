Azure Kubernetes Service (AKS) is integrated with Azure Arc, extending Azure management capabilities to on-premises, multicloud, and edge environments. This integration allows organizations to use AKS beyond the Azure cloud, enabling consistent container management across diverse infrastructure environments.

AKS enabled by Azure Arc provides a range of features, including:

- Centralized Kubernetes cluster management through the Azure portal
- Streamlined fleet management for container workloads in hybrid environments
- Deployment of fully conformant Kubernetes clusters on Azure Local with built-in features such as logging, monitoring, load balancing, and certificate management
- Consistent identity and security across on-premises infrastructure via Azure Arc integration

AKS enabled by Azure Arc supports both Linux and Windows containers, offering:

- A unified infrastructure without requiring additional setup
- Integrated tooling for migrating Windows applications to containerized environments
- GitOps for automated deployment pipelines
- Disconnected AKS management (available in preview) for edge scenarios

>[!IMPORTANT]
> Regularly scan and patch both Windows and Linux containers to maintain security. Access the [Security book for Azure Arc-enabled Kubernetes and AKS enabled by Azure Arc](/azure/azure-arc/kubernetes/conceptual-security-book) to learn more.

Security integrations for AKS enabled by Azure Arc include:

- Microsoft Entra ID
- Microsoft Defender for Cloud
- Microsoft Sentinel
- Runtime protection against vulnerabilities and threats
- A unified identity framework for simplified authentication and access control
- Regular security updates and certificate-based intra-cluster communication

## User scenario

To support new digital health apps, you deploy AKS enabled by Azure Arc, running both Windows and Linux containers. GitOps pipelines automate deployments, and disconnected AKS management ensures clinics in remote areas stay operational even during network outages.

:::image type="content" border="true" source="../media/aks-clusters-diagram.png" alt-text="A diagram showing centralized management of AKS clusters via Azure Arc for a healthcare datacenter and remote clinic.":::
