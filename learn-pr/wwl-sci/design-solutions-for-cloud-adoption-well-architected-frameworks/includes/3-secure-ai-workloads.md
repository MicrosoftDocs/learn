
AI workloads present unique security challenges that require specialized guidance. The Cloud Adoption Framework's AI adoption scenario provides structured approaches for securing AI systems throughout their lifecycle.

## AI adoption in the Cloud Adoption Framework

The CAF AI adoption scenario extends the standard CAF methodologies with AI-specific guidance across six phases:

| Phase | Description |
| --- | --- |
| **AI Strategy** | Define how AI supports business objectives and assess organizational readiness |
| **AI Plan** | Create actionable plans for AI implementation |
| **AI Ready** | Prepare infrastructure, data, and teams for AI workloads |
| **Govern AI** | Establish policies and controls for AI governance |
| **Manage AI** | Operate and maintain AI systems effectively |
| **Secure AI** | Protect AI resources, data, and outputs from threats |

:::image type="content" source="../media/cloud-adoption-framework-ai.png" alt-text="Diagram that shows the Cloud Adoption Framework stages define strategy, plan, ready, adopt, and govern and manage." lightbox="../media/cloud-adoption-framework-ai.png":::

## Secure AI overview

The Secure AI guidance organizes AI security around three core activities:

1. **Discover AI security risks**
2. **Protect AI resources and data**
3. **Detect AI security threats**

These activities build upon traditional security practices while addressing the unique characteristics of AI systems.

## Discover AI security risks

Understanding AI-specific threats is the first step in securing AI workloads. The CAF guidance recommends using established threat frameworks:

### MITRE ATLAS

MITRE ATLAS (Adversarial Threat Landscape for AI Systems) documents tactics and techniques that adversaries use to attack AI systems. Use ATLAS to:

- Understand potential attack vectors against your AI workloads
- Map your current security controls to known threats
- Identify gaps in your AI security posture

### OWASP AI security guidance

The Open Web Application Security Project (OWASP) provides guidance specific to AI and machine learning security. Key areas include:

- Input validation for AI systems
- Model security and integrity
- Data poisoning prevention
- Output validation and filtering

### Risk assessment for AI workloads

When assessing AI security risks, consider:

- **Training data sensitivity**: What data was used to train the model, and what are the confidentiality requirements?
- **Model intellectual property**: Is the model itself a valuable asset that requires protection?
- **Inference data exposure**: What data is exposed during model inference?
- **Output risks**: Could model outputs cause harm if manipulated or misused?

## Protect AI resources and data

Protecting AI systems requires controls across multiple layers:

### Identity and access controls

Apply Zero Trust principles to AI resource access:

- Implement strong authentication for AI platform access
- Use role-based access control for AI resources
- Apply Just-In-Time access for administrative operations
- Monitor and audit access to AI systems

### Data protection

AI workloads involve multiple data types that require protection:

| Data Type | Protection Considerations |
| --- | --- |
| Training data | Classification, access controls, encryption, retention policies |
| Model artifacts | Integrity verification, access controls, version management |
| Inference data | Privacy protection, minimization, encryption in transit |
| Output data | Validation, filtering, access controls |

### Network security for AI

Secure AI workloads at the network layer:

- Deploy AI services in private virtual networks where possible
- Use private endpoints for Azure AI services
- Implement network segmentation between AI components
- Control egress traffic to prevent data exfiltration

### Azure AI service security features

Azure AI services include built-in security capabilities:

- **Customer-managed keys**: Control encryption keys for data at rest
- **Private endpoints**: Access services without public internet exposure
- **Managed identities**: Eliminate credential management for service-to-service access
- **Virtual network integration**: Deploy services within your network boundary

## Detect AI security threats

Detecting threats to AI systems requires specialized monitoring:

### Microsoft Defender for Cloud AI protections

Microsoft Defender for Cloud provides AI-specific threat detection:

- **AI workload threat detection**: Identifies suspicious activities targeting AI resources
- **Prompt injection detection**: Detects attempts to manipulate AI system inputs
- **Data exfiltration monitoring**: Alerts on unusual data access patterns
- **Model theft detection**: Identifies attempts to extract model information

### Security monitoring for AI

Establish monitoring practices for AI workloads:

- Log all access to AI resources and data
- Monitor model inference patterns for anomalies
- Track data flows in and out of AI systems
- Alert on unusual API usage patterns

### Incident response for AI systems

Adapt incident response procedures for AI-specific scenarios:

- **Prompt injection incidents**: Procedures for handling manipulated inputs
- **Data poisoning detection**: Response to suspected training data contamination
- **Model compromise**: Steps for handling potential model theft or tampering
- **Output manipulation**: Response to suspicious or harmful outputs

## AI security in Azure landing zones

AI workloads should be deployed within your Azure landing zone architecture:

### No separate AI landing zone required

From an Azure landing zone perspective, AI is just another workload that can be deployed, governed, and secured within application landing zone subscriptions. The existing landing zone design areas apply:

- Use the security design area guidance for AI resources
- Apply identity and access management controls consistently
- Leverage governance policies for AI resources
- Utilize management capabilities for AI operations

### AI-specific considerations

While using the standard landing zone architecture, consider AI-specific needs:

- GPU compute requirements may influence subscription design
- Data residency requirements for training and inference data
- Integration with data engineering and analytics platforms
- Specialized networking for high-bandwidth AI workloads

## Responsible AI and security

Security practices should align with responsible AI principles:

- **Transparency**: Understand and document AI system behaviors
- **Accountability**: Establish clear responsibility for AI security
- **Privacy**: Protect personal data used in AI systems
- **Fairness**: Ensure security controls don't introduce bias
- **Reliability**: Maintain AI system integrity and availability

By integrating responsible AI principles with security practices, you create AI systems that are both trustworthy and well-protected.
