As a security architect, you specify security requirements for web workloads that protect applications from common threats while enabling business functionality. Web applications face unique risks including exploitation of code vulnerabilities, data interception, and distributed denial-of-service attacks.

## Specify network security requirements

Network security controls restrict who can access your web applications and how traffic flows to and from them.

### Private connectivity

Specify requirements to minimize public internet exposure:

- **Private endpoints**: Require Azure Private Link endpoints to route traffic through your virtual network for internal applications. Private endpoints eliminate exposure to the public internet while allowing secure access from corporate networks.
- **Virtual network integration**: Enable outbound virtual network integration for applications that need to access resources in Azure virtual networks or on-premises networks through VPN or ExpressRoute.
- **Disable public network access**: When private endpoints provide all necessary connectivity, require that public endpoints be disabled entirely.

### Access restrictions

For applications that require public access, specify controls to limit exposure:

- **IP access restrictions**: Define allow lists of IP addresses and subnets that can access the application. Block all traffic from IP addresses not explicitly permitted.
- **Service endpoints**: Restrict inbound access to specific subnets in your virtual networks using service endpoints combined with IP access restrictions.

### DDoS and application layer protection

Specify deployment of protective services in front of web applications:

- **Web Application Firewall (WAF)**: Require [Azure WAF](/azure/web-application-firewall/overview) deployed through Azure Front Door or Application Gateway to protect against common exploits like SQL injection, cross-site scripting, and other OWASP Top 10 vulnerabilities.
- **WAF policy mode**: Deploy WAF policies in detection mode initially to log threats without blocking legitimate traffic. After validating rule effectiveness, require prevention mode for production workloads.
- **Managed rule sets**: Use Azure-managed rule sets that are automatically updated to protect against new attack signatures, including the Microsoft Threat Intelligence Collection for enhanced coverage.
- **DDoS Protection**: Enable Azure DDoS Protection on virtual networks hosting web application infrastructure to defend against volumetric attacks.

### WAF bypass prevention

Specify controls to ensure traffic cannot bypass WAF inspection:

- Configure access restrictions on App Service to accept traffic only from your WAF's IP addresses
- Use private endpoints combined with WAF deployment to ensure all traffic passes through inspection
- Lock down the application's direct endpoint using service endpoints or IP restrictions

## Specify identity and access requirements

Identity controls determine who can access your web application and with what permissions.

### Application authentication

Specify authentication requirements based on the application's audience:

- **Microsoft Entra authentication**: Require Microsoft Entra ID as the identity provider for corporate applications. Use App Service built-in authentication to handle authentication without custom code.
- **Conditional Access policies**: Define conditions under which users can access applications, including device compliance, location, and risk level requirements.
- **Multifactor authentication**: Require MFA for applications accessing sensitive data or performing privileged operations.
- **Disable local authentication**: Restrict the use of local authentication methods. Require Microsoft Entra ID as the default authentication method for data plane access.

### Application identity

Specify how the application authenticates to other services:

- **Managed identities**: Require managed identities for applications that access Azure resources like Key Vault, SQL Database, or Storage. Managed identities eliminate credentials in code or configuration.
- **Unique identities per application**: Assign distinct identities to each application to maintain isolation and enable granular access control. Don't share identities across applications.

### Management access

Specify controls for administrative operations:

- **Azure RBAC**: Implement role-based access control for management operations using built-in roles like Web Plan Contributor and Website Contributor.
- **Least privilege**: Assign the minimum permissions necessary for each administrative role.
- **Customer Lockbox**: Enable Customer Lockbox to require approval before Microsoft support can access your application data during support scenarios.

## Specify data protection requirements

Data protection requirements ensure confidentiality and integrity of information in transit and at rest.

### Transport security

Specify requirements for encrypting data in transit:

- **HTTPS only**: Require HTTPS-only mode to redirect all HTTP requests to HTTPS. All communication between clients and applications must be encrypted.
- **Minimum TLS version**: Require TLS 1.2 or higher for all connections. Disable TLS 1.0 and 1.1 which contain known vulnerabilities.
- **TLS certificates**: Require properly configured TLS/SSL certificates for custom domains. Store certificates in Azure Key Vault for centralized management and automatic renewal.
- **Mutual TLS**: For B2B scenarios or high-security applications, require client certificate authentication to verify client identity.

### Secret management

Specify requirements for protecting sensitive configuration:

- **Azure Key Vault integration**: Store all secrets, certificates, and encryption keys in Key Vault rather than application settings or code.
- **Key Vault references**: Use App Service Key Vault references to access secrets securely using managed identities.
- **No credentials in code**: Prohibit storing credentials, connection strings, or API keys in source code or configuration files checked into version control.

### Customer-managed keys

For regulatory compliance scenarios, specify:

- Requirements for customer-managed encryption keys where needed
- Key rotation schedules and procedures
- Key Vault integration for key lifecycle management

## Specify monitoring requirements

Monitoring enables detection and response to security threats.

### Logging

Specify logging requirements for security investigation:

- **Resource logs**: Enable App Service resource logs including HTTP logs, application logs, and failed request traces.
- **Web server logs**: Capture detailed request information for security analysis.
- **Azure Monitor integration**: Send logs to Azure Monitor Logs for centralized analysis and long-term retention.
- **Retention periods**: Define log retention requirements aligned with compliance obligations.

### Threat detection

Specify threat detection capabilities:

- **Microsoft Defender for App Service**: Enable [Microsoft Defender for App Service](/azure/defender-for-cloud/defender-for-app-service-introduction) to identify attacks targeting applications and receive security alerts.
- **Security alerts**: Configure alerts for abnormal patterns like repeated authentication failures, unusual traffic volumes, or suspicious application behavior.
- **Application Insights**: Deploy Application Insights for application performance monitoring and anomaly detection.

## Specify secure deployment requirements

Deployment practices affect the security of production applications.

### DevSecOps

Specify security requirements for deployment pipelines:

- **Controlled deployment sources**: Deploy code only from controlled and secured Azure Pipelines. Prevent deployment from untrusted sources.
- **Code scanning**: Require static application security testing (SAST) and software composition analysis before deployment.
- **Dependency management**: Scan dependencies for known vulnerabilities and maintain updated packages.

### Configuration

Specify secure configuration requirements:

- **Disable remote debugging**: Remote debugging must be disabled for production workloads to reduce attack surface.
- **Disable FTP**: Disable FTP access or enforce FTPS-only to prevent unencrypted credential transmission.
- **Disable basic authentication**: Disable username/password authentication for SCM and FTP endpoints in favor of Microsoft Entra ID authentication.

### Isolation

For high-security workloads, specify:

- Separate App Service Plans for applications processing sensitive data
- App Service Environment for complete network isolation
- Separate subscriptions or management groups for security boundary enforcement

Apply the [Azure security baseline for App Service](/security/benchmark/azure/baselines/app-service-security-baseline) to ensure deployments meet Microsoft cloud security benchmark controls.
