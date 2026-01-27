Organizations increasingly use generative AI applications to enhance productivity and decision-making. These AI workloads process, store, and generate data that may include sensitive information from your organization. As a cybersecurity architect, you need to design security controls that protect data used in AI applications while enabling innovation.

## Security considerations for AI data

AI workloads introduce unique data security challenges that differ from traditional applications. When users interact with AI services, their prompts may contain sensitive organizational data. The AI models process this data to generate responses, which may also contain or reference sensitive information.

Consider these key security dimensions when designing for AI workloads:

| Dimension | Consideration | Risk if unaddressed |
|-----------|---------------|---------------------|
| **Data ingestion** | Data used to ground AI responses (RAG) | Unauthorized access to sensitive documents |
| **Prompt data** | User inputs containing business information | Data leakage through prompts |
| **Response data** | AI-generated outputs | Disclosure of protected information |
| **Model training data** | Data used for fine-tuning | IP exposure, compliance violations |
| **Interaction history** | Stored prompts and responses | Discovery and retention gaps |

### Applying MCSB controls to AI workloads

The Microsoft Cloud Security Benchmark controls apply to AI workloads:

- **DP-1 (Discovery and classification)**: Identify and classify data used in AI grounding and fine-tuning
- **DP-2 (Monitor anomalies)**: Detect unusual AI usage patterns that may indicate data exfiltration
- **DP-3 (Encrypt in transit)**: Secure communications between users, AI services, and data sources
- **DP-4 (Encrypt at rest)**: Protect stored prompts, responses, and training data
- **DP-5 (Customer-managed keys)**: Use CMK for sensitive AI workloads where required

## Securing Azure OpenAI and AI services

[Azure OpenAI Service](/azure/ai-services/openai/overview) provides enterprise-grade security controls for generative AI workloads. When designing security for Azure OpenAI:

### Network isolation

Implement network controls to protect AI service communications:

- **Private endpoints**: Deploy Azure OpenAI with private endpoints to eliminate public internet exposure
- **Virtual network integration**: Ensure AI services communicate through your private network
- **Service endpoints**: Use service endpoints when private endpoints aren't feasible
- **Network security groups**: Control traffic flow to and from AI services

### Identity and access control

Apply Zero Trust principles to AI service access:

- **Managed identities**: Use system-assigned or user-assigned managed identities for service-to-service authentication
- **Role-based access control**: Assign Cognitive Services User role for inference, Cognitive Services Contributor for management
- **Conditional Access**: Enforce policies for users accessing AI applications
- **Document-level access control**: When using Azure OpenAI on your data, security filters trim search results based on user permissions

### Data protection for "on your data" scenarios

When grounding AI responses with organizational data (retrieval-augmented generation):

1. **Data remains in your control**: Azure OpenAI doesn't copy your data; it retrieves from your designated sources
2. **Access permissions flow through**: Users only receive responses based on data they're authorized to access
3. **Encryption applies**: Data in Azure AI Search and storage maintains encryption at rest and in transit
4. **Private connectivity**: Configure private endpoints between Azure OpenAI, AI Search, and storage accounts

### Data residency and processing

Azure OpenAI provides control over where data is processed:

- **Standard deployments**: Data processed within your specified Azure geography
- **Global deployments**: Data may be processed in any region where the model is available
- **Data zone deployments**: Data processed within a specified data zone (for example, EU)
- **Data at rest**: Always stored in your designated geography regardless of deployment type

## Threat detection for AI workloads

### Microsoft Defender for Cloud AI threat protection

[Microsoft Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection) provides threat protection specifically for AI services:

- **Prompt injection detection**: Identifies attempts to manipulate AI behavior through malicious prompts
- **Jailbreak detection**: Detects attempts to bypass AI safety guardrails
- **Data leakage alerts**: Monitors for sensitive data exposure in AI interactions
- **Credential theft detection**: Identifies attempts to extract credentials through AI manipulation

Defender for Cloud integrates with Azure AI Content Safety to provide layered protection. Security alerts flow to Microsoft Defender XDR for correlation with other security signals.

### Azure AI Content Safety

[Azure AI Content Safety](/azure/ai-services/content-safety/overview) provides guardrails for AI applications:

| Capability | Protection provided |
|------------|---------------------|
| **Prompt Shields** | Detects user input attacks and prompt injection attempts |
| **Groundedness detection** | Identifies when AI responses aren't grounded in source data |
| **Protected material detection** | Scans for copyrighted content in AI outputs |
| **Content filtering** | Blocks harmful content including hate speech, violence, and self-harm |

### AI security posture management

[Defender CSPM](/azure/defender-for-cloud/ai-security-posture) discovers and assesses AI workloads across your environment:

- **AI Bill of Materials discovery**: Identifies AI components, data sources, and dependencies
- **Attack path analysis**: Detects risks where data exposure could occur through AI workloads
- **Security recommendations**: Provides guidance for hardening AI security posture
- **Multicloud coverage**: Discovers AI workloads in Azure, AWS (Bedrock), and GCP (Vertex AI)

## Governance and compliance for AI data

### Microsoft Purview for AI

[Microsoft Purview](/purview/ai-microsoft-purview) extends data governance to AI interactions:

**Data Security Posture Management (DSPM) for AI**:
- Discovers AI usage across your organization
- Provides insights into data flowing through AI applications
- Offers one-click policies for AI data protection

**Sensitivity labels and AI**:
- Labels applied to source documents flow through to AI responses
- Encryption with usage rights prevents AI from accessing protected content unless users have EXTRACT permission
- Visual markings help users understand sensitivity of AI-referenced content

**Data Loss Prevention for AI**:
- Endpoint DLP policies can block or warn when users paste sensitive data into third-party AI applications
- Policies detect sensitive information types in AI prompts

**Retention and eDiscovery**:
- User prompts and AI responses are stored in user mailboxes
- Retention policies can automatically retain or delete AI interaction history
- eDiscovery searches can locate AI interactions for legal holds

### Compliance considerations

When designing AI data security, address these compliance requirements:

- **Data residency**: Ensure AI processing occurs in compliant geographies
- **Audit logging**: Capture AI interactions in the unified audit log
- **Right to erasure**: Enable users to delete their AI activity history
- **Consent and transparency**: Inform users how their data is used in AI systems
- **Regulatory assessments**: Use Compliance Manager templates for AI regulations (EU AI Act, etc.)

## Bringing it together

Securing data in AI workloads requires applying familiar security principles—network isolation, identity controls, encryption, and monitoring—to new scenarios. Azure OpenAI provides enterprise controls for network isolation and data residency. Microsoft Defender for Cloud detects AI-specific threats like prompt injection and jailbreak attempts. Microsoft Purview extends governance to AI interactions through DSPM for AI, sensitivity labels, and retention policies. Together, these capabilities help you protect sensitive data throughout the AI lifecycle while enabling your organization to innovate with generative AI.
