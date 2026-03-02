As organizations deploy AI-powered applications, security architects must evaluate whether proposed solutions adequately protect data, models, and infrastructure. Azure AI services introduce security considerations beyond traditional workloads, requiring evaluation of identity controls, network isolation, content safety mechanisms, and threat protection capabilities.

The Microsoft Cloud Security Benchmark v2 introduces a dedicated Artificial Intelligence Security domain with seven controls addressing AI platform security, application security, and monitoring. Use these controls as evaluation criteria alongside traditional security domains.

## Understand AI shared responsibility

The AI shared responsibility model extends traditional cloud responsibilities across three AI-specific layers that determine what security controls you must evaluate versus what Microsoft provides.

**AI Platform layer** encompasses the underlying model infrastructure, including foundation models, safety systems, and compute resources. Microsoft maintains responsibility for model training security, platform abuse monitoring, and base safety mechanisms. For PaaS AI services like Azure OpenAI, customers share responsibility for prompt engineering security, model customization risks, and application integration.

**AI Application layer** covers the interfaces, plugins, orchestration, and grounding data that shape AI behavior. Customers hold primary responsibility for securing RAG implementations, managing plugin permissions, implementing content safety configurations, and protecting grounding data sources from poisoning or unauthorized access.

**AI Usage layer** addresses how end users interact with AI systems. Organizations must establish acceptable use policies, monitor for policy violations, and implement controls that prevent misuse while maintaining productivity.

Responsibility allocation varies by deployment model. SaaS AI solutions like Microsoft 365 Copilot place more responsibility with Microsoft, who manages model lifecycle and base safety configurations. PaaS AI solutions like Azure OpenAI shift responsibility to customers for model selection, fine-tuning security, and comprehensive prompt protection. Understanding this division helps security architects focus evaluation efforts on controls within organizational responsibility.

:::image type="content" source="../media/ai-shared-responsibility-v2.png" lightbox="../media/ai-shared-responsibility-v2.png" alt-text="Diagram showing the AI shared responsibility model.":::

## Evaluate identity and access controls

Strong identity management forms the foundation of AI services security. When evaluating solutions, assess whether the architecture implements appropriate authentication and authorization mechanisms.

Evaluate whether the solution uses Microsoft Entra ID for authentication rather than API keys. Microsoft Entra ID integration enables conditional access policies, multifactor authentication, and centralized identity governance. API keys should be disabled where possible, as they cannot support fine-grained access control or audit trails at the user level.

Assess role-based access control configurations for least privilege. The **Cognitive Services OpenAI User** role provides inference-only access, while **Cognitive Services OpenAI Contributor** enables model deployment and management. Evaluate whether the proposed role assignments align with the principle of least privilege for each identity type.

For service-to-service authentication, verify that solutions use managed identities rather than stored credentials. Managed identities eliminate credential management overhead and reduce the risk of credential exposure. Evaluate whether system-assigned or user-assigned managed identities are appropriate for the workload's lifecycle requirements.

## Evaluate network security architecture

Network isolation prevents unauthorized access to AI services and protects data in transit. Evaluate whether the proposed architecture implements appropriate network controls.

Assess whether the solution uses private endpoints to eliminate public internet exposure for AI services. Private endpoints route traffic through Azure Private Link, keeping communications within the Azure backbone network. Verify that private DNS zones are configured correctly for name resolution.

For Azure AI Foundry deployments, evaluate the managed virtual network configuration. The three isolation modes—Public, Private with Internet Outbound, and Private with Approved Outbound—offer different security postures. Evaluate whether the chosen mode aligns with organizational security requirements and data classification.

Review network security group configurations for any virtual network integrations. Verify that inbound and outbound rules restrict traffic to necessary communications only. Assess whether Azure Firewall or other network filtering provides additional protection for internet-bound traffic.

## Evaluate content safety controls

AI-specific content safety mechanisms protect against prompt attacks and harmful content generation. Evaluate whether solutions implement comprehensive safety controls throughout the request-response lifecycle. MCSB v2 control AI-2 requires multi-layered content filtering across input prompts, processing, and outputs.

### Prompt protection evaluation

Assess Prompt Shields configuration for detecting prompt injection attacks. Prompt Shields identifies both direct user attacks (attempts to change system rules, role-play scenarios, encoding attacks) and indirect attacks embedded in documents. Evaluate severity thresholds and whether configurations block detected attacks or only generate alerts.

### Content filtering evaluation

Review content filter configurations for harmful content categories (hate speech, sexual content, violence, self-harm). Evaluate whether severity thresholds align with risk tolerance. Verify protected material detection is enabled to prevent output of copyrighted text or code from public repositories.

### Output validation evaluation

Evaluate groundedness detection configurations for RAG-based applications. Groundedness detection identifies when model outputs contain information not supported by provided source materials, reducing risks of incorrect information. Verify whether groundedness correction is enabled to automatically align responses with source documents.

For applications using AI agents, assess Task Adherence API implementation. This capability detects when tool use by AI agents is misaligned, unintended, or premature, preventing agents from taking unauthorized actions.

### Safety meta-prompts evaluation (MCSB AI-3)

Evaluate system message configurations that establish model behavior boundaries. Safety meta-prompts should define the model's role explicitly and include instructions to reject malicious inputs. Assess whether meta-prompts instruct models to prioritize system instructions over user inputs to counter prompt injection attempts.

## Evaluate AI application security controls

Beyond content filtering, AI applications require security controls specific to model governance, agent functions, and human oversight.

### Model governance evaluation (MCSB AI-1)

Assess whether the solution implements formal model approval processes. Only models that have been verified through trusted processes should deploy to production. Evaluate model provenance tracking to ensure organizations can identify the source and modification history of deployed models. Unverified models may contain backdoors, poisoned training data, or supply chain compromises.

### Agent function privileges (MCSB AI-4)

For solutions using AI agents with plugins or functions that interact with external systems, evaluate least privilege implementation. Agent functions should have explicit capability manifests listing authorized actions, with all others denied by default. Assess whether sandboxed execution environments isolate function runtime from unauthorized system interactions. Overly permissive agent functions create risks for privilege escalation and lateral movement.

### Human-in-the-loop requirements (MCSB AI-5)

Evaluate whether the solution implements human review for critical AI actions, especially when interacting with external systems or processing sensitive data. Human checkpoints detect errors, adversarial manipulation, or unintended behaviors before execution. Assess which operations require human approval and whether approval workflows are enforced programmatically.

## Evaluate threat protection capabilities

Microsoft Defender for Cloud provides AI-specific security posture management and threat protection. Evaluate whether solutions use these capabilities for comprehensive security monitoring. MCSB v2 controls AI-6 and AI-7 address monitoring and continuous red teaming requirements.

### AI security posture management

Assess whether Defender Cloud Security Posture Management (CSPM) is enabled for AI workload discovery. Defender CSPM automatically discovers AI workloads across Azure OpenAI Service, Azure AI Foundry, Azure Machine Learning, and multicloud environments including Amazon Bedrock and Google Vertex AI.

Evaluate whether the solution addresses security recommendations from Defender for Cloud. Recommendations cover identity configuration, data security, and internet exposure risks specific to AI workloads. Review attack path analysis findings that identify scenarios where training or grounding data might be exposed to threats.

### Runtime threat protection

Assess whether threat protection for AI workloads is enabled. This capability uses Azure AI Content Safety prompt shields and Microsoft threat intelligence to detect malicious activity including:

- Direct and indirect prompt injection attacks
- Sensitive data leakage through model queries
- Data poisoning attempts
- Wallet abuse or denial of service attacks

Evaluate alert integration with security operations. Verify that AI security alerts flow to Microsoft Defender XDR or Microsoft Sentinel for investigation and response workflows.

### Continuous AI red teaming (MCSB AI-7)

Assess whether the organization performs continuous adversarial testing of AI systems. AI red teaming uses tools like PyRIT (Python Risk Identification Tool) and the Azure AI Red Teaming Agent to simulate attacks including prompt injection, jailbreaking, and data poisoning. Evaluate whether red teaming is integrated into CI/CD pipelines for predeployment validation and whether test scenarios align with MITRE ATLAS tactics for AI-specific threats.

## Evaluate data protection and availability

Assess encryption configurations for data at rest, verifying customer-managed keys where compliance requires key management control. Evaluate data residency configurations to ensure AI services and connected resources (search indexes, storage accounts) meet data sovereignty requirements.

For fine-tuned models, verify data lifecycle policies ensure training data deletion after fine-tuning completes unless retention is required.

Evaluate availability controls including quota monitoring and alerting, rate limiting at API Management, and Azure DDoS Protection for internet-facing deployments.

## Key evaluation criteria summary

When evaluating Azure AI services security, verify the solution addresses MCSB v2 AI-specific controls:

| MCSB Control | Key evaluation points |
| ------------ | --------------------- |
| **AI-1: Approved models** | Model provenance, supply chain verification, formal approval processes |
| **AI-2: Content filtering** | Multi-layered filtering for inputs, processing, and outputs |
| **AI-3: Safety meta-prompts** | System instructions that resist prompt injection, explicit behavior boundaries |
| **AI-4: Agent privileges** | Least privilege for plugins/functions, capability manifests, sandboxed execution |
| **AI-5: Human-in-the-loop** | Human approval for critical actions, programmatic enforcement |
| **AI-6: Monitoring** | Defender for AI, jailbreak detection, data exfiltration monitoring |
| **AI-7: Red teaming** | Continuous adversarial testing, PyRIT integration, MITRE ATLAS alignment |

Additionally evaluate traditional security controls:

| Area | Key evaluation points |
| ---- | --------------------- |
| **Identity** | Microsoft Entra ID authentication, managed identities, least privilege RBAC |
| **Network** | Private endpoints, managed virtual network isolation, NSG configurations |
| **Data protection** | Customer-managed keys, data residency compliance, data lifecycle policies |
| **Availability** | Quota monitoring, rate limiting, DDoS protection |

This evaluation framework ensures AI solutions meet both AI-specific and traditional security requirements.
