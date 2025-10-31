Release pipelines deploy software to target environments, extending beyond application deployment to include supporting infrastructure components.

Continuous Delivery requires Infrastructure as Code (IaC) integration and automated infrastructure provisioning within release pipelines.

Infrastructure deployment considerations include understanding target environment types:

- **On-premises servers:** Physical and virtual server infrastructure
- **Infrastructure as a Service (IaaS):** Cloud-based virtual machines and networks
- **Platform as a Service (PaaS) and Functions as a Service (FaaS):** Managed services like Azure SQL Database and Azure Functions
- **Clusters:** Container orchestration and high-scale application hosting
- **Service connections:** Secure authentication mechanisms for resource access

Each target environment type requires specific configuration and deployment approaches.

## On-premises servers

On-premises deployments typically target existing hardware and operating systems where infrastructure provisioning is pre-established. Release pipelines focus primarily on application deployment rather than infrastructure creation.

Virtual machine management (Hyper-V or VMware) may require start/stop operations during deployment processes.

Server management scripts must be maintained in source control and delivered through build artifacts to ensure version control and repeatability.

Release pipeline tasks execute server management scripts for operational control during deployments.

Server configuration management utilizes technologies like PowerShell Desired State Configuration (DSC) to maintain consistent server states. DSC ensures configuration drift detection and automatic remediation to desired state specifications.

PowerShell DSC integration follows standard pipeline task patterns for seamless automation workflows.

## Infrastructure as a service

Cloud-based target environments enable dynamic infrastructure provisioning capabilities. Organizations may implement lift-and-shift migrations that replicate on-premises deployment patterns, or leverage Infrastructure as a Service (IaaS) for on-demand resource creation.

IaaS implementations benefit significantly from Infrastructure as Code (IaC) practices for automated resource provisioning.

Scripts and templates enable automated creation of infrastructure components including servers, databases, networks, and IP addresses.

Template definitions and command-line scripts stored in version control integrate with release pipeline tasks for cloud resource provisioning.

Infrastructure creation occurs within pipeline execution, followed by software deployment steps.

Azure Resource Manager templates provide declarative infrastructure provisioning capabilities for on-demand resource creation.

## Platform as a Service

Platform as a Service (PaaS) abstracts infrastructure management from application deployment workflows. Cloud providers manage underlying infrastructure including servers, hardware, networking, IP addresses, and storage accounts.

Azure Web Apps exemplify PaaS capabilities by providing fully managed web hosting environments. Developers focus exclusively on application code while the platform handles infrastructure concerns.

PaaS deployment requires templates that instruct cloud platforms to create application hosting resources. Functions as a Service (FaaS) and serverless technologies follow similar patterns.

Azure Functions exemplify serverless deployment where application code is deployed while the platform manages all infrastructure concerns. Resource provisioning templates define hosting environments for application deployment.

Azure Resource Manager templates, Azure CLI, and command-line tools provide infrastructure definition capabilities.

Infrastructure definitions must be maintained in script files alongside application code in source control systems.

## Clusters

Container deployment requires orchestration clusters for execution. Clusters consist of multiple machines configured to provide high availability and horizontal scalability capabilities.

Self-managed IaaS clusters require comprehensive lifecycle management including provisioning templates, update deployment, security patching, and maintenance operations.

Managed cluster services operate as Platform as a Service offerings where cloud providers handle infrastructure management while users deploy applications to cluster resources.

Container orchestration platforms like Azure Kubernetes Service (AKS) provide managed Kubernetes environments with automated cluster operations and enterprise-grade security features.

## Service connections

Service connections provide secure authentication mechanisms for pipeline access to external resources and cloud services.

Azure DevOps service connections establish authenticated communication channels with Azure Resource Manager, enabling automated deployment operations without embedded credentials.

Multi-cloud environments require platform-specific service connections for AWS, Google Cloud Platform, and other providers to support cross-platform deployment scenarios.

Authentication methods include service principals, managed identities, and certificate-based authentication depending on security requirements and service capabilities.

## Summary

Infrastructure provisioning and configuration must be integrated into release pipelines and maintained within source control repositories regardless of hosting technology selection.

Infrastructure as Code principles enable automated environment creation and support Continuous Delivery practices through declarative infrastructure definitions and on-demand resource provisioning capabilities.

## Links

- [Desired State Configuration Overview.](/powershell/dsc/overview/dscforengineers)
- [Azure Functions.](https://azure.microsoft.com/services/functions)
- [Azure Resource Manager.](/azure/azure-resource-manager/resource-group-overview)
