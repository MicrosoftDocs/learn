As a Security Architect, you need to address the unique security challenges that AI workloads introduce to your cloud environment. The Cloud Adoption Framework provides dedicated guidance for securing AI through its AI adoption scenario, which complements the Secure methodology you've already learned.

AI workloads create new attack surfaces that traditional security measures can't fully address. You must integrate AI-specific security considerations into your cloud adoption strategy, planning, and operations to protect these valuable assets.

## AI security within the Cloud Adoption Framework

The CAF AI adoption scenario includes security guidance that spans the same phases as the Secure methodology—Strategy, Plan, Ready, Adopt, Govern, and Manage. This guidance addresses AI-specific risks while aligning with your broader security strategy.

Key AI security activities across CAF phases include:

- **Strategy**: Define AI security objectives and responsible AI principles
- **Plan**: Assess AI skills gaps and plan for AI-specific security controls
- **Ready**: Prepare secure AI infrastructure and establish AI security baselines
- **Adopt**: Implement AI security controls during model deployment
- **Govern**: Establish AI governance policies and risk management
- **Manage**: Monitor AI systems for threats and maintain AI security posture

:::image type="content" source="../media/cloud-adoption-framework-ai.png" alt-text="Diagram that shows the Cloud Adoption Framework stages define strategy, plan, ready, adopt, and govern and manage." lightbox="../media/cloud-adoption-framework-ai.png":::

## Discovering AI security risks

AI workloads introduce classes of risk that traditional threat modeling may not address. You must systematically evaluate AI-specific vulnerabilities to build effective defenses.

### Identify AI system risks

Begin with your established threat modeling framework (such as STRIDE), then reference AI-specific risk inventories to ensure AI attack techniques are adequately represented:

- **MITRE ATLAS**: Provides a knowledge base of adversary tactics and techniques targeting AI systems, similar to how MITRE ATT&CK covers traditional attacks
- **OWASP Generative AI risks**: Documents top security risks specific to large language models (LLMs) and generative AI applications

These frameworks help identify risks like prompt injection, training data poisoning, model theft, and sensitive information disclosure that aren't covered by traditional security assessments.

### Assess AI data risks

Sensitive data in AI workflows increases the risk of insider threats and data leaks. AI systems often process, store, or generate data that requires special protection:

- Training data may contain sensitive information that could be extracted
- Model outputs might inadvertently reveal confidential data
- AI interactions create new data flows that need classification and protection

Assess enterprise-wide AI data risks and prioritize them based on data sensitivity levels. Use data loss prevention techniques tailored for AI workflows.

### Test AI models for security vulnerabilities

AI models contain unique vulnerabilities that attackers can exploit:

- **Prompt injection**: Manipulating inputs to override system instructions or extract unauthorized information
- **Data leakage**: Extracting training data or sensitive information through carefully crafted queries
- **Model inversion**: Reconstructing training data or model parameters from outputs
- **Jailbreaking**: Bypassing safety controls to generate harmful or unauthorized content

Test models using adversarial simulations and red team both generative AI and traditional AI models to simulate real attacks. Static reviews alone can't uncover all AI-specific vulnerabilities.

### Conduct periodic risk assessments

New threats emerge as AI models, usage patterns, and threat actors evolve. Run recurring assessments to identify vulnerabilities in models, data pipelines, and deployment environments. Use assessment findings to guide risk mitigation priorities.

## Protecting AI resources and data

AI systems contain valuable assets that require strong protection against unauthorized access and attacks.

### Secure AI resources

Implement comprehensive security measures to protect all components of your AI infrastructure:

- **Create a complete AI asset inventory**: Unknown AI assets create security gaps that attackers exploit. Use resource discovery tools to identify AI resources across subscriptions and maintain this inventory through automated scanning.
- **Secure AI communication channels**: Implement managed identities for secure authentication, use virtual networks to isolate AI communications, and secure API endpoints that expose AI capabilities.
- **Apply platform-specific security controls**: Different AI deployment models (PaaS vs. IaaS) face distinct threats. Follow dedicated security guidance based on your deployment model.

### Secure AI data

AI workloads rely on data and artifacts that require robust protection:

- Protect training data from unauthorized access and tampering
- Secure model weights and parameters as high-value intellectual property
- Implement access controls for AI inference endpoints
- Monitor for data exfiltration through AI interactions

## AI governance and responsible AI

AI governance integrates with your broader security governance to ensure AI systems operate safely and ethically.

### Responsible AI principles

Microsoft's Responsible AI framework provides principles that support secure AI deployment:

- **Fairness**: Ensure AI systems treat all people fairly
- **Reliability and safety**: AI systems should perform reliably and safely
- **Privacy and security**: AI systems should be secure and respect privacy
- **Inclusiveness**: AI systems should empower everyone and engage people
- **Transparency**: AI systems should be understandable
- **Accountability**: People should be accountable for AI systems

These principles inform security decisions by establishing boundaries for acceptable AI behavior and creating accountability for AI-related risks.

### AI risk management

The NIST AI Risk Management Framework (AI RMF) provides a structured approach to managing AI risks that complements your existing risk management processes. Key functions include:

- **Govern**: Establish AI risk management culture and accountability
- **Map**: Understand AI system context and potential impacts
- **Measure**: Assess and track AI risks
- **Manage**: Prioritize and respond to AI risks

Integrate AI risk management into your broader risk framework rather than treating it as a separate process.

## Monitoring and detecting AI threats

AI systems require specialized monitoring to detect threats that traditional security tools may miss.

### AI-specific threat detection

Implement monitoring that addresses AI-unique attack patterns:

- Detect prompt injection attempts and jailbreak patterns
- Monitor for unusual query patterns that might indicate data extraction
- Track model behavior changes that could indicate compromise
- Alert on unauthorized model access or modification

### Integration with security operations

AI threat detection should feed into your existing security operations:

- Integrate AI alerts with your SIEM for correlation with other security events
- Include AI systems in incident response playbooks
- Train SOC analysts on AI-specific threats and investigation techniques
- Establish escalation paths for AI security incidents

## Bringing it all together

Securing AI workloads requires extending your security strategy to address AI-specific risks while maintaining alignment with your broader cloud security posture. The CAF AI adoption scenario provides structured guidance for this integration.

As a Security Architect, focus on these key AI security outcomes:

- Integrate AI risk assessment into your threat modeling processes
- Implement controls that address AI-specific vulnerabilities like prompt injection and data leakage
- Establish AI governance that incorporates responsible AI principles
- Monitor AI systems with detection capabilities tailored to AI threats

By applying CAF Secure methodology principles to AI workloads—and augmenting them with AI-specific controls—you can enable AI adoption while maintaining the security posture your organization requires.
