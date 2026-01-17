
An Azure landing zone is the standardized and recommended approach for all organizations using Azure. It provides a consistent way to set up and manage your Azure environment at scale, ensuring alignment with security, compliance, and operational efficiency requirements.

## What is an Azure landing zone?

Azure landing zones provide a well-architected foundation aligned with core design principles across eight design areas. They consist of two primary components:

- **Platform landing zone**: Provides shared services (identity, connectivity, management) that multiple application workloads use
- **Application landing zones**: Host individual workloads or applications in pre-provisioned subscriptions

The landing zone architecture is scalable and modular, allowing you to apply consistent configurations and controls across all subscriptions while adapting to evolving requirements.

## Landing zone design areas

Azure landing zones are organized around eight design areas that cybersecurity architects must understand:

| Design Area | Security Relevance |
| --- | --- |
| **Azure billing and Microsoft Entra tenant** | Foundational identity and tenant configuration |
| **Identity and access management** | Authentication, authorization, and access controls |
| **Management group and subscription organization** | Resource hierarchy and policy inheritance |
| **Network topology and connectivity** | Network segmentation, connectivity, and traffic controls |
| **Security** | Security operations, threat protection, and monitoring |
| **Management** | Operational visibility and management capabilities |
| **Governance** | Policy enforcement, compliance, and standards |
| **Platform automation and DevOps** | Infrastructure as code and deployment practices |

## Relationship to the Cloud Adoption Framework

Azure landing zones are a key output of the **Ready methodology** in the Cloud Adoption Framework. While the CAF provides the strategic guidance and methodologies for your cloud journey, landing zones translate that guidance into a concrete, deployable environment.

Think of it this way: the Cloud Adoption Framework tells you *what* to do and *why*, while Azure landing zones give you the *how*—a technical implementation that embeds CAF principles directly into your Azure infrastructure.

The connection spans multiple CAF methodologies:

| CAF Methodology | Landing Zone Relationship |
| --- | --- |
| **Ready** | Landing zones are the primary deliverable, preparing your environment for workload deployment |
| **Govern** | Landing zone governance design area implements CAF governance disciplines through Azure Policy |
| **Secure** | Landing zone security design area operationalizes CAF Secure methodology guidance, including Zero Trust principles |
| **Manage** | Landing zone management design area establishes the operational foundation defined in CAF |

This integration means that when you deploy an Azure landing zone, you're automatically implementing the security posture modernization, Zero Trust alignment, and governance controls that the Cloud Adoption Framework recommends. The landing zone becomes the technical realization of your CAF-driven cloud strategy.

## Security design area

The security design area focuses on implementing comprehensive security controls across your landing zone. Key considerations include:

### Security operations center integration

Design your landing zone to integrate with centralized security operations:

- Configure Microsoft Defender for Cloud for security posture management
- Enable Microsoft Sentinel for SIEM and SOAR capabilities
- Establish security monitoring and alerting baselines

### Threat protection

Implement threat protection mechanisms at multiple layers:

- Enable Microsoft Defender plans for applicable resource types
- Configure vulnerability assessment and management
- Implement endpoint detection and response capabilities

### Security baselines

Apply security baselines consistently across the environment:

- Use Azure Security Benchmark recommendations
- Implement compliance policies through Azure Policy
- Establish security configuration standards for all resource types

## Identity and access management design area

Identity is a primary security perimeter in cloud environments. Design considerations include:

### Microsoft Entra ID integration

- Plan tenant structure and configuration
- Implement Conditional Access policies aligned with Zero Trust
- Configure Privileged Identity Management for administrative access

### Access control strategy

Apply the principle of least privilege throughout your landing zone:

- Use Azure role-based access control (RBAC) with custom roles where needed
- Implement Just-In-Time (JIT) access for privileged operations
- Design entitlement management for external and guest access

### Identity protection

- Enable Microsoft Entra ID Protection for risk-based policies
- Configure multi-factor authentication requirements
- Implement passwordless authentication where possible

## Network topology and connectivity design area

Network design significantly impacts security posture. Consider these elements:

### Network segmentation

Design network topology to support security boundaries:

- Implement hub-spoke or Virtual WAN architectures
- Create network security groups and application security groups
- Design subnet segmentation based on workload requirements

### Traffic control

Control traffic flows to minimize attack surfaces:

- Deploy Azure Firewall or network virtual appliances for traffic inspection
- Configure web application firewalls for public-facing applications
- Implement private endpoints for Azure PaaS services

### Connectivity security

Secure connections between environments:

- Use Azure Private Link for service access
- Configure ExpressRoute or VPN for hybrid connectivity
- Implement network encryption where required

## Governance design area

Governance ensures consistent security enforcement:

### Azure Policy implementation

Use Azure Policy to enforce security standards:

- Apply built-in policy initiatives like Azure Security Benchmark
- Create custom policies for organization-specific requirements
- Configure remediation tasks for non-compliant resources

### Compliance management

Maintain compliance across the environment:

- Map regulatory requirements to Azure controls
- Implement compliance dashboards and reporting
- Establish compliance baselines for different workload types

### Resource organization

Organize resources to support security management:

- Design management group hierarchy for policy inheritance
- Implement consistent tagging for security classification
- Use naming conventions that support security operations

## Platform landing zone security considerations

The platform landing zone hosts shared services that require special security attention:

### Identity subscription

- Hosts domain controllers or Microsoft Entra Domain Services
- Requires highest level of security controls
- Implements strict access controls and monitoring

### Connectivity subscription

- Contains network infrastructure (firewalls, gateways)
- Requires network security monitoring
- Implements traffic inspection and filtering

### Management subscription

- Hosts monitoring and management tools
- Contains security operations resources
- Requires controlled access for operations teams

## Application landing zone management approaches

Different management approaches have security implications:

| Approach | Description | Security Responsibility |
| --- | --- | --- |
| **Central team** | Central IT fully manages the landing zone | Central team owns all security controls |
| **Application team** | Application team manages their landing zone | Shared responsibility with platform governance |
| **Shared** | Central IT manages platform, app teams manage applications | Clear delineation of security responsibilities |

## AI in Azure landing zones

For AI workloads, you don't need a separate AI landing zone. The existing Azure landing zone architecture supports AI deployments:

- Deploy AI services into application landing zones
- Apply the same governance, security, and management controls
- Use the landing zone design areas to secure AI components
- Leverage Microsoft Defender for Cloud AI workload protections

This approach ensures AI workloads benefit from the same well-architected foundation as other enterprise applications.
