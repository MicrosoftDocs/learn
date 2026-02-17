Throughout this module, you've explored individual security capabilities: development standards, lifecycle strategies, posture evaluation, threat modeling, workload identities, API security, and web application firewalls. As a cybersecurity architect, your final task is to map these technologies to specific application security requirements, ensuring that each requirement has an appropriate solution and that your overall architecture doesn't leave gaps.

This unit provides a structured approach for mapping security technologies to application requirements and identifying the right combination of Azure services for different application scenarios.

## Security requirements framework

Application security requirements generally fall into these categories. For each category, Azure provides technologies that address the requirement at different layers:

### Identity and access control

| Requirement | Azure technologies |
|---|---|
| Authenticate users to web applications and APIs | Microsoft Entra ID, Microsoft Entra External ID, OAuth 2.0/OpenID Connect (OIDC) |
| Authenticate services and workloads to Azure resources | Managed identities, workload identity federation |
| Enforce least-privilege access for applications | Azure role-based access control (RBAC), Microsoft Entra app roles, API scopes |
| Detect compromised workload identities | Microsoft Entra ID Protection, Conditional Access for workload IDs |
| Review and reduce standing permissions | Privileged Identity Management (PIM) access reviews for service principals |

### Network and perimeter protection

| Requirement | Azure technologies |
|---|---|
| Protect web applications from Open Worldwide Application Security Project (OWASP) Top 10 attacks | Azure Web Application Firewall (WAF) on Application Gateway or Front Door |
| Protect globally distributed apps at the edge | Azure Front Door with WAF |
| Isolate APIs from public internet | API Management with virtual network integration (internal mode), private endpoints |
| Rate limit API calls to prevent abuse | Azure API Management policies, Azure Front Door rate limiting |
| Block traffic from unauthorized geographies | Azure WAF geo-filtering, Azure Front Door rules |

### Data protection

| Requirement | Azure technologies |
|---|---|
| Encrypt data in transit | Transport Layer Security (TLS)/mutual TLS (mTLS) enforcement in API Management and Application Gateway |
| Protect application secrets and certificates | Azure Key Vault, managed identities (eliminate secrets where possible) |
| Prevent data leakage through APIs | API Management response transformation policies, Defender for APIs sensitive data detection |
| Classify and protect data in SaaS applications | Microsoft Defender for Cloud Apps, Microsoft Purview Information Protection |

### Secure development and supply chain

| Requirement | Azure technologies |
|---|---|
| Static code analysis for vulnerabilities | GitHub CodeQL, Microsoft Security DevOps Extension for static application security testing (SAST) |
| Dynamic application testing in runtime | Dynamic application security testing (DAST) in staging environments, Microsoft Defender for Containers |
| Software supply chain security | GitHub Dependabot, Azure Artifacts, software bill of materials (SBOM) generation |
| Secret scanning and push protection | GitHub Advanced Security secret scanning |
| Infrastructure-as-code security validation | Checkov, Terrascan, Template Analyzer via Security DevOps Extension |
| Secure pipeline infrastructure | Azure Key Vault for secrets, managed identity for pipeline auth, approval gates |

### Monitoring, detection, and response

| Requirement | Azure technologies |
|---|---|
| Application-layer threat detection | Microsoft Defender for App Service, Defender for Containers, Defender for APIs |
| Security posture assessment and scoring | Microsoft Defender for Cloud with cloud security posture management (CSPM), Secure Score |
| Attack path identification | Defender CSPM attack path analysis |
| DevOps security monitoring | Azure DevOps Audit Streaming to Microsoft Sentinel |
| WAF event correlation and incident response | Azure WAF logs to Microsoft Sentinel |
| SaaS application risk assessment | Microsoft Defender for Cloud Apps Cloud Discovery |

## Mapping requirements to application scenarios

Different application types require different combinations of these technologies. Here are common scenarios and their recommended security technology stacks:

### Internet-facing web application

A public-facing web application that processes customer data requires the broadest set of controls:

- Azure Front Door with WAF for edge protection and DDoS
- Application Gateway with WAF for regional layer 7 inspection
- Microsoft Entra ID for user authentication with Conditional Access
- Managed identities for backend service authentication
- Azure Key Vault for secrets and certificates
- Defender for Cloud (CSPM) for continuous posture monitoring
- Defender for App Service for runtime threat detection

### Internal API platform

An internal API platform serving other line-of-business applications focuses on identity, network isolation, and governance:

- Azure API Management in internal virtual network mode
- OAuth 2.0 with Microsoft Entra ID for service-to-service authentication
- Managed identities on APIM for backend authentication
- API Management policies for rate limiting and request validation
- Defender for APIs for threat detection and sensitive data identification
- Subscription key scoping per consuming application

### Containerized microservices

A Kubernetes-hosted microservices architecture requires supply chain and runtime security:

- Azure Container Registry with vulnerability scanning and quarantine
- Microsoft Defender for Containers for runtime protection
- Workload identity federation for pod-to-Azure-resource authentication
- Network policies for inter-service segmentation
- SAST and DAST integrated into the continuous integration and continuous delivery (CI/CD) pipeline
- Image signing for deployment integrity

### CI/CD pipeline

The development pipeline itself is a critical workload requiring protection:

- Azure Key Vault integrated with pipelines for secrets management
- Workload identity federation (no stored secrets) for pipeline-to-Azure authentication
- Microsoft Security DevOps Extension for multi-scanner SAST
- GitHub Advanced Security for secret scanning and dependency analysis
- Azure DevOps Audit Streaming to Microsoft Sentinel for monitoring
- Approval gates and environment-level permissions for production deployments

## Identifying gaps

After mapping technologies to requirements, review your architecture for gaps:

- Are there requirements without corresponding technology? This indicates a need for extra services or custom controls.
- Are there technologies deployed without corresponding requirements? This indicates potential cost savings or simplification opportunities.
- Do multiple technologies overlap on the same requirement? Evaluate whether the overlap provides defense in depth (good) or redundant cost without added security value (optimize).
- Are there trust boundaries without security controls? Every crossing of a trust boundary, as identified in your threat models, should have authentication, authorization, and monitoring.


