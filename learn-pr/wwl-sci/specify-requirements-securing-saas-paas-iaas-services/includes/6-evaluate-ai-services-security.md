This unit presents security architecture guidance for AI workloads and services, including Azure OpenAI in Foundry Models, Microsoft Foundry, Foundry Search, and Foundry Content Safety. As a Security Architect, you design secure AI workloads that protect confidentiality, integrity, and availability while supporting responsible AI practices.

For comprehensive guidance, see [Azure Well-Architected Framework perspective on Azure OpenAI Service](/azure/well-architected/service-guides/azure-openai).

## AI security architecture overview

AI workloads and services introduce unique security considerations beyond traditional cloud workloads. Design your architecture to address:

- **Model security**: Protecting AI models from unauthorized access, theft, or manipulation
- **Data governance**: Managing sensitive data used for training, fine-tuning, and inference
- **Prompt security**: Defending against prompt injection, jailbreak attempts, and adversarial inputs
- **Output validation**: Ensuring AI-generated content meets safety, compliance, and quality standards
- **Responsible AI**: Implementing transparency, fairness, and accountability controls

### Defense-in-depth for AI workloads and services

Apply multiple security layers across your AI architecture:

| Layer | Security Controls | AI-Specific Application |
|-------|------------------|------------------------|
| **Identity & Access** | Microsoft Entra ID, role-based access control (RBAC), Conditional Access, managed identities | Controls who can submit prompts, access models, and retrieve responses. Prevents unauthorized API key usage and ensures accountability for AI interactions. |
| **Network** | Private endpoints, network isolation, virtual networks, Azure Firewall | Prevents prompt and response data from traversing public internet. Blocks unauthorized exfiltration of training data and model outputs. Restricts AI services to communicate only with approved data sources. |
| **Data** | Customer-managed keys, data residency, encryption at rest and in transit | Protects sensitive training data, fine-tuned models, and prompt/response pairs. Ensures compliance with data sovereignty requirements for AI workloads. |
| **Application** | Content filters, Prompt Shields, guardrails, rate limiting | Detects and blocks malicious prompts (jailbreaks, injections). Prevents generation of harmful content. Stops abuse through quota exhaustion attacks. |
| **Monitoring** | Azure Monitor, diagnostic logs, Microsoft Defender for Cloud | Tracks prompt patterns, detects anomalous AI usage, identifies potential data leakage through model queries, and provides audit trails for compliance. |

## Security design principles for AI

Start your design with the [Azure security baseline for Azure OpenAI](/security/benchmark/azure/baselines/azure-openai-security-baseline) and [Microsoft Foundry security baseline](/security/benchmark/azure/baselines/azure-ai-foundry-security-baseline). The [Security design principles](/azure/well-architected/security/principles) guide your technical approach.

### Plan your security readiness

- **Threat modeling**: Identify AI-specific threats including prompt injection, data leakage, model theft, and adversarial attacks
- **Compliance requirements**: Understand industry regulations (GDPR, HIPAA, CCPA) and how they apply to AI data processing
- **Data classification**: Classify training data, prompts, and responses based on sensitivity
- **Responsible AI**: Align with [Microsoft's Responsible AI principles](/azure/ai-services/responsible-use-of-ai-overview)

### Design to protect confidentiality

- **Data at rest**: Use [customer-managed keys](/azure/ai-services/openai/encrypt-data-at-rest#customer-managed-keys-with-azure-key-vault) for encryption, implement key rotation
- **Data in transit**: Enforce TLS 1.2+ for all communications
- **Data residency**: Choose Azure regions that meet data sovereignty requirements
- **Training data**: Delete training, validation, and training results data after fine-tuning completes
- **Secrets management**: Store API keys, connection strings, and certificates in Azure Key Vault
- or application gateway to prevent abuse and manage costs.
- **Network isolation**: Use [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) to keep traffic off the public internet

### Design to protect integrity

- **Identity-based access**: Use Microsoft Entra ID with RBAC instead of API keys
- **Least privilege**: Grant minimum permissions needed (e.g., Cognitive Services OpenAI User for inference, Contributor for model management)
- **Prompt security**: Implement [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) to detect and block jailbreak attempts
- **Content filtering**: Configure [Azure AI Content Safety](/azure/ai-services/content-safety/overview) to detect harmful content in prompts and responses
- **Model validation**: Verify model outputs before presenting to users
- **Audit logging**: Enable diagnostic logs for all AI service operations
- **Managed identities**: Use [system-assigned or user-assigned managed identities](/azure/ai-services/openai/how-to/managed-identity) to eliminate credential management.

### Design to protect availability

- **Quota management**: Monitor and alert on token usage to prevent quota exhaustion from malicious or misconfigured applications.
- **Rate limiting**: Implement throttling at the application gateway or API Management layer.
- **Distributed denial of service (DDoS) protection**: Use Azure DDoS Protection for internet-facing endpoints.
- **Backup and recovery**: Maintain copies of custom models and training data.
- **Multi-region deployment**: Design for failover across Azure regions for business-critical.

## AI-specific content safety and security controls

### Content safety and guardrails

[Foundry Content Safety](/azure/ai-services/content-safety/overview) is an AI service that detects harmful user-generated and AI-generated content in applications and services that provides multiple layers of protection.

- **Content filters**: Configure severity thresholds (Low/Medium/High) for harmful content categories. Test with sample prompts to validate behavior.
- **Prompt Shields**: Enable detection for both user prompt attacks and indirect attacks from documents. Monitor detection rates and adjust sensitivity as needed.
- **Groundedness detection**: Reduce inaccurate information by validating outputs against source documents.
- **Protected material detection**: Identify and block generation of copyrighted code or text.
- **Custom categories API (preview)**: Create and manage your own content categories for enhanced moderation and filtering that matches your specific policies or use cases.
- **Analyze text/image API**: Scan for potentially harmful content with the Analyze Image API and the Analyze Text API
- **Custom blocklists**: Create organization-specific term lists to enforce additional policies.

### Content security

When using Microsoft Foundry for AI development:

- Configure private networking for the hub and all connected services (Azure OpenAI, AI Search, Storage, Key Vault)
- Enable [diagnostic logging](/azure/ai-services/diagnostic-logging) and send to Log Analytics for centralized monitoring
- Use managed identities for all service-to-service authentication
- Implement role-based access control at both the hub and project levels

## AI threat scenarios and mitigations

### Prompt injection attacks

**Threat**: Attackers manipulate model behavior through crafted prompts to bypass safety controls or extract sensitive information.

**Mitigations**: Enable Prompt Shields, implement input validation, use system messages to reinforce boundaries, monitor suspicious patterns.

### Data exfiltration

**Threat**: Sensitive training data or organizational information is extracted through model queries.

**Mitigations**: Use private endpoints, implement data loss prevention (DLP) policies, restrict model access to necessary data sources, enable groundedness detection.

### Model theft

**Threat**: Attackers attempt to extract or replicate proprietary fine-tuned models.

**Mitigations**: Use customer-managed keys, implement strong RBAC, enable audit logging, use private endpoints, monitor for anomalous query patterns.

### Quota exhaustion

**Threat**: Malicious actors or bugs consume all available tokens, causing denial of service.

**Mitigations**: Implement rate limiting, set quota alerts, use Azure DDoS Protection, authenticate, and track usage per identity.

## Key recommendations summary

| Recommendation | Benefit |
|----------------|---------|
| **Use Microsoft Entra ID with RBAC** | Centralizes identity management, enables fine-grained access control, supports conditional access and MFA |
| **Implement private endpoints** | Keeps traffic private, reduces attack surface, prevents data exfiltration |
| **Use customer-managed keys** | Provides control over encryption keys, supports compliance, enables key rotation |
| **Configure content filters** | Prevents harmful content generation, reduces legal and reputational risk |
| **Enable Prompt Shields** | Detects and blocks jailbreak attempts and prompt injection attacks |
| **Deploy Microsoft Foundry securely** | Centralizes AI development with built-in security controls and unified monitoring |
| **Monitor with Defender for Cloud** | Provides security posture management, threat detection, and AI-specific recommendations |
| **Implement rate limiting** | Prevents abuse, manages costs, ensures fair resource usage |
