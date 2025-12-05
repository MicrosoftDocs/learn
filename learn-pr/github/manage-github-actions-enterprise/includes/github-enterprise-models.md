In this unit, you'll explore the different GitHub Enterprise deployment models—GitHub Enterprise Cloud (GHEC) and GitHub Enterprise Server (GHES)—and learn how user management, security, and compliance differ across standard and enterprise-managed user setups.

## How users are managed
GitHub Enterprise Cloud (GHEC) is a cloud-based solution tailored for organizations that need the flexibility and scalability of GitHub's infrastructure while maintaining enterprise-grade security and compliance. It offers features such as centralized user management, data residency options, and integration with identity providers like SAML and SCIM for single sign-on and user provisioning. 

GHEC is ideal for globally distributed teams, as it ensures high availability, automated backups, and seamless access to GitHub’s robust collaboration tools. It supports regulatory compliance and provides detailed audit logs for governance. With GHEC, organizations can leverage GitHub’s advanced capabilities without managing on-premises infrastructure.

### Standard User Model
This is the traditional user model on GitHub, where users manage their own account.

**Characteristics of standard user model**:
- Users manage their accounts, including usernames, email addresses, and personal settings.
- Authentication methods are configured by users (e.g., OAuth, password).
- The connection to organizations or enterprise accounts is established through invitations.
- Admins have limited control over user accounts once they are connected to an enterprise organization.
- Often used in smaller-scale enterprises or organizations without strict centralized management needs.


###  The Enterprise Managed User (EMU) model
This is the model designed for organizations requiring centralized user account management, offering better control and compliance features.

**In EMU model**:
- User accounts are fully managed by the enterprise.
- Authentication is handled through the enterprise’s identity provider (e.g., SAML, SCIM).
- Admins have control over usernames, email addresses, and user lifecycle (creation, deactivation).
- Managed users can only join the enterprise they belong to and cannot independently join other organizations.
- Often used by larger enterprises or organizations requiring compliance with stricter governance policies.



### GitHub Enterprise Cloud (GHEC) with **Data Residency**
GitHub Enterprise Cloud (GHEC) with **Data Residency** is an important feature of GHEC for organizations that must comply with data protection regulations by ensuring specific data is stored in particular geographical regions.

**It allows users to**: 

1. **Data Residency Regions**:    
    - GitHub provides predefined regions (e.g., the United States, Europe)  based on your compliance needs.
     
2. **Data Types Covered**:    
    - **Repository Contents**: Code, issues, pull requests, and repository-related data.
    - **Metadata**: Includes audit logs, user events, and settings.
    
3. **Encryption and Security**:
    - All data in transit and at rest is encrypted.
    - Compliance with regional and global security standards (e.g., ISO 27001, SOC 2).

4. **Regional Storage and Failover**:
    - Data is stored in the selected region with high availability and disaster recovery mechanisms.
    - Certain types of backup data may be replicated outside the region but remain encrypted.

## GitHub Enterprise Server (GHES)
GitHub Enterprise Server (GHES) is a self-hosted version of GitHub designed for organizations that require complete control over their GitHub instance. It is ideal for companies that want to host their repositories and associated data on-premises or in a private cloud environment for compliance, security, or performance reasons.

### Key Features of GitHub Enterprise Server

1. **Self-Hosting**:    
    - GHES is deployed within the organization’s infrastructure, either on-premises or on a private cloud.
    - Provides full control over data storage, backups, and disaster recovery.
2. **Enhanced Security**:    
    - Data remains within the organization's environment, ensuring compliance with strict data residency, privacy, or security requirements.
    - Integrates with enterprise authentication systems (e.g., LDAP, SAML, Active Directory).
3. **Customization and Control**:    
    - Full control over repository settings, user access, and permissions.
    - Allows custom integrations and extensions, such as internal DevOps tools or CI/CD pipelines.
4. **Performance Optimization**:    
    - Optimized for organizations with large repositories or distributed teams.
    - Can be scaled to handle heavy workloads by allocating additional resources (e.g., CPU, RAM).
5. **Compliance**:    
    - Ideal for industries with strict regulatory requirements (e.g., healthcare, finance).
    - Offers audit logs, user activity monitoring, and data encryption to meet compliance standards.
    
### Components of GHES

1. **GitHub Application**:
    - The interface and core functionality (e.g., repositories, pull requests, issues) are similar to GitHub.com.
2. **Administrative Dashboard**:
    - Provides tools for managing users, teams, and organizations.
    - Includes settings for repository access, backups, and updates.
3. **System Administration Tools**:
    - Tools for managing server configuration, resource allocation, and performance monitoring.
4. **Backup and Disaster Recovery**:
    - Features for creating and restoring backups to prevent data loss.
5. **Monitoring and Logging**:
    - Built-in monitoring tools like Prometheus and Grafana for server health.
    - Logs for troubleshooting and auditing.
