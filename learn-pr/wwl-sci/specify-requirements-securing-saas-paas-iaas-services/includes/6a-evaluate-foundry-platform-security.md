Microsoft Foundry is the primary platform for building and deploying AI applications on Azure. Security architects must evaluate Foundry-specific security controls beyond the general AI security requirements covered in the previous unit. This unit focuses on the platform architecture, access controls, network isolation, data protection, and operational security unique to Microsoft Foundry deployments.

## Evaluate the resource and project architecture

Microsoft Foundry uses a two-level architecture that separates governance from development.

- **Foundry resource**: The top-level Azure resource where administrators configure security settings, networking, encryption, and model deployments. All governance decisions, including managed network configuration, customer-managed keys, and Azure Policy enforcement, are scoped here.
- **Projects**: Isolated development boundaries within the Foundry resource where teams build agents, run evaluations, and manage files. Projects inherit the security configuration of their parent Foundry resource.

This separation enables centralized security controls at the resource level while development teams work within scoped project boundaries. Evaluate whether the architecture correctly places governance decisions at the resource level and restricts project-level permissions to development activities. Verify that each project maps to a distinct workload or team boundary, preventing unauthorized cross-project data access.

## Evaluate identity and access controls

Foundry divides operations into control plane (resource management) and data plane (runtime usage), each with its own RBAC surface.

### Authentication method evaluation

Foundry supports two authentication methods: Microsoft Entra ID and API keys. Evaluate whether the solution uses Entra ID for production workloads, which enables conditional access, managed identities, and granular RBAC. API keys remain available for rapid prototyping but lack per-user traceability and should be disabled via Azure Policy for production environments.

### RBAC assignment evaluation

Evaluate whether RBAC assignments reflect the control plane and data plane separation:

- **Azure AI User**: The minimum least-privilege starting point for developers and project managed identities at the Foundry resource scope. Provides data plane access without resource management capabilities.
- **Azure AI Project Manager**: Enables creating projects, managing deployments, and conditionally assigning the Azure AI User role. Appropriate for team leads who need both development and management capabilities.
- **Azure AI Account Owner** or **Azure AI Owner**: Reserve for IT administrators who need full resource management, encryption, and networking control. Azure AI Owner additionally includes data plane access. Assess whether development teams are scoped to Azure AI User or Azure AI Project Manager rather than these broader roles.

Verify that each project's managed identity has only the RBAC roles required on connected resources. Common role assignments include:

- **Storage Blob Data Contributor** on storage accounts
- **Search Index Data Contributor** on search indexes
- **Key Vault Secrets User** on Key Vault resources

### Managed identity evaluation

Evaluate whether project managed identities are used for service-to-service authentication rather than stored credentials. When a project creator has sufficient permissions (Owner at subscription or resource group scope), the managed identity role assignments are created automatically. For restricted environments, verify that managed identity assignments are provisioned through infrastructure as code or administrative processes.

## Evaluate connection security

Foundry connections define how the resource and projects authenticate to dependent Azure services such as Azure OpenAI, search indexes, storage accounts, and custom endpoints.

### Authentication method for connections

Evaluate whether connections use Microsoft Entra ID authentication rather than API keys. Foundry connections support the following authentication methods, with availability varying by connector type:

- **Managed identity** (system or user-assigned) — preferred for keyless credential management
- **Service principal** (client ID/secret or certificate)
- **API key** — for services that don't support Entra ID
- **SAS token** — for specific storage scenarios

### Key Vault integration

For connections that require secrets (API keys, connection strings), verify that a dedicated Azure Key Vault is configured through a Key Vault connection at the Foundry resource level. This dedicated vault should:

- Store only Foundry-managed secrets — not be shared with other workload components
- Have access restricted to the Foundry resource managed identity
- Use Azure Monitor and activity logs for auditing create, update, and delete events on secrets

If customer-managed keys are used for encryption, evaluate whether your security governance policies permit colocation of encryption keys and connection secrets in the same vault.

### Connection scope and lifecycle

Assess whether connections are scoped at the project level rather than broadly at the resource level, limiting blast radius if a connection is compromised. Evaluate whether unused connections are removed and whether connection inventory is reviewed regularly. Use Azure Activity Log to track connection lifecycle events.

## Evaluate network isolation

Foundry network isolation has two dimensions: inbound access to the Foundry resource and outbound access from compute resources.

### Inbound access

Evaluate whether public network access is disabled for the Foundry resource. When disabled, access requires a private endpoint connection through Azure Private Link. Verify that:

- Private endpoints are configured in the organization's virtual network
- Private DNS zones are configured correctly for name resolution
- Default resources (storage account, Key Vault, container registry) also have public access disabled and private endpoints configured

### Outbound access (managed virtual network)

Foundry provides a managed virtual network for compute resources. Evaluate which isolation mode is configured:

- **Allow Internet Outbound**: Allows all outbound internet access while isolating compute resources within a managed network. Suitable for workloads that need to access external packages or services but not recommended for regulated environments.
- **Allow Only Approved Outbound**: The most restrictive mode. Outbound traffic is allowed only to approved destinations via private endpoints or FQDN rules. Required for regulated environments.
- **Disabled**: No managed virtual network isolation. Compute uses public networking by default unless a custom virtual network is configured. Not recommended for production workloads handling sensitive data.

Verify that the managed virtual network is provisioned before compute resources are created. Evaluate whether FQDN outbound rules are configured for necessary external dependencies (such as Python packages, Hugging Face models, or Visual Studio Code integration).

### Connected resource isolation

Verify that dependent resources use consistent network isolation:

- Storage accounts: Private endpoints for blob and file services
- Key Vault: Private endpoint with firewall rules allowing the Foundry managed identity
- Container registry: Private endpoint if custom images are used
- Search indexes: Private endpoint for RAG-based applications

## Evaluate data protection

### Encryption at rest

Evaluate whether customer-managed keys (CMK) are required for encryption at rest. Foundry supports CMK through Azure Key Vault integration. When enabled, the Foundry resource encrypts data at rest using the customer's key rather than Microsoft-managed keys. Verify Key Vault access policies and key rotation schedules.

### Data isolation between projects

Foundry enforces data isolation across projects. Secrets stored through connections can't be retrieved across projects via APIs. Evaluate whether the project boundary provides sufficient isolation for your data classification requirements, or whether separate Foundry resources are needed for different data sensitivity levels.

### Vulnerability management

Foundry follows a shared responsibility model for vulnerability management. Microsoft manages platform-level patches for managed compute, hosted images, and base packages. Customers are responsible for:

- Keeping custom environments and container images updated
- Recreating compute instances to apply the latest security patches
- Monitoring Defender for Cloud recommendations for AI workload vulnerabilities

## Evaluate model deployment governance

### Azure Policy enforcement

Evaluate whether Azure Policy is configured to control model deployments at the Foundry resource level:

- **Cognitive Services Deployments should only use approved Registry Models**: Restricts which models can deploy by matching model asset IDs. Prevents unauthorized or untested models from reaching production.
- **Configure Azure AI Services resources to disable local key access**: Forces Entra ID authentication by disabling API key access at the resource level.

### Model catalog evaluation

Assess whether the organization has established a model governance process for the Foundry model catalog. Evaluate model provenance tracking to ensure teams can identify the source, licensing, and modification history of deployed models. Models from the catalog should go through a verification and approval process before production deployment.

## Evaluate monitoring and diagnostics

### Diagnostic settings

Verify that diagnostic settings are enabled for the Foundry resource, routing the following categories to Log Analytics:

- **Audit**: Administrative operations and configuration changes
- **RequestResponse**: API requests and model responses for compliance
- **AllMetrics**: Usage metrics including token consumption and compute utilization

Azure Monitor provides segmented metrics by scope — resource-level metrics for management operations and project-level metrics for agent activity and evaluation performance.

### Security monitoring integration

Ensure the Foundry resource is covered by the Defender for Cloud capabilities described in the previous unit, including CSPM discovery and runtime threat protection. Additionally, verify that Azure Activity Log is configured to track all Foundry control plane operations including connection management, role assignments, and policy changes.

## Key evaluation criteria summary

When evaluating Microsoft Foundry platform security, verify the solution addresses:

| Area | Key evaluation points |
| ---- | --------------------- |
| **Architecture** | Resource/project separation, project isolation boundaries, workload segmentation |
| **Identity** | Entra ID authentication, API keys disabled, Foundry RBAC roles (Azure AI User, Project Manager, Account Owner, Owner), managed identities |
| **Connections** | Entra ID preferred, dedicated Key Vault, project-scoped connections, lifecycle management |
| **Network** | Public access disabled, private endpoints, managed VNet isolation mode, connected resource isolation |
| **Data protection** | Customer-managed keys, project data isolation, vulnerability management |
| **Model governance** | Azure Policy for approved models, disable local auth, model provenance tracking |
| **Monitoring** | Diagnostic settings, Defender for Cloud, Azure Activity Log |
