As a Security Architect, you must address the unique security challenges that AI introduces to your organization. AI security encompasses three core pillars: AI platform security (protecting models and training data), AI application security (securing applications throughout their lifecycle), and monitoring and response (detecting threats and responding to incidents).

The Microsoft Cloud Security Benchmark (MCSB) v2 includes dedicated AI security controls (AI-1 through AI-7) that address these pillars. These controls build on existing security foundations while addressing AI-specific risks like model theft, prompt injection, and adversarial attacks.

The following best practices and MCSB controls are technology-agnostic security principles. Separate learning paths in the SC-100 training content cover specific Microsoft solutions for AI security.

### AI platform security

AI platform security focuses on protecting the underlying infrastructure, models, and training data. Key practices include:

- **Use only approved models**: Deploy AI models only after formal verification through a trusted approval process. Maintain a centralized model registry to track provenance, verification status, and approval history. *MCSB Control: AI-1 (ensure use of approved models).*
- **Protect training data and models**: Treat AI models and training data as high-value assets. Apply data classification, access controls, and encryption. Prevent unauthorized access to model weights and parameters. *MCSB Controls: DP-1 (discover and classify data), DP-4 (encrypt at rest).*
- **Secure the AI development lifecycle**: Integrate security into MLOps pipelines. Scan for vulnerabilities in ML frameworks, validate data inputs, and test models for adversarial robustness before deployment. *MCSB Controls: DS-2 (supply chain security), DS-6 (secure DevOps lifecycle).*

| MCSB Control | Name |
|---------|------|
| [AI-1](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-1-ensure-use-of-approved-models) | Ensure use of approved models |
| [DP-1](/security/benchmark/azure/mcsb-data-protection#dp-1-discover-classify-and-label-sensitive-data) | Discover, classify, and label sensitive data |
| [DP-4](/security/benchmark/azure/mcsb-data-protection#dp-4-enable-data-at-rest-encryption-by-default) | Enable data at rest encryption by default |
| [DS-2](/security/benchmark/azure/mcsb-devops-security#ds-2-ensure-software-supply-chain-security) | Ensure software supply chain security |
| [DS-6](/security/benchmark/azure/mcsb-devops-security#ds-6-enforce-security-of-workload-throughout-devops-lifecycle) | Enforce security of workload throughout DevOps lifecycle |

### AI application security

AI application security addresses vulnerabilities in application logic, orchestration, and integrations with plugins or external systems. Key practices include:

- **Implement multi-layered content filtering**: Deploy content validation and filtering across all stages—input prompts, internal processing, and model outputs—to detect and block malicious content, adversarial inputs, and harmful outputs. *MCSB Control: AI-2 (multi-layered content filtering).*
- **Adopt safety meta-prompts**: Use system instructions to guide AI models toward intended, secure, and ethical behavior. Design meta-prompts that prioritize system instructions over user inputs to resist prompt injection attacks. *MCSB Control: AI-3 (safety meta-prompts).*
- **Apply least privilege for agent functions**: Restrict the capabilities and access permissions of agent functions or plugins to the minimum required. Use sandboxed execution environments and short-lived, scoped tokens. *MCSB Control: AI-4 (least privilege for agent functions).*
- **Ensure human-in-the-loop**: Implement human review and approval for critical actions, especially when interacting with external systems or sensitive data. Define high-risk operations that require human validation before execution. *MCSB Control: AI-5 (human-in-the-loop).*

| MCSB Control | Name |
|---------|------|
| [AI-2](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-2-implement-multi-layered-content-filtering) | Implement multi-layered content filtering |
| [AI-3](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-3-adopt-safety-meta-prompts) | Adopt safety meta-prompts |
| [AI-4](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-4-apply-least-privilege-for-agent-functions) | Apply least privilege for agent functions |
| [AI-5](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-5-ensure-human-in-the-loop) | Ensure human-in-the-loop |

### AI monitoring and response

Continuous monitoring and proactive testing are essential to detect AI-specific threats and validate security controls. Key practices include:

- **Establish monitoring and detection**: Deploy AI-specific threat detection to monitor model inference, API calls, and plugin interactions. Detect jailbreak attempts, prompt injection patterns, and data exfiltration through AI interactions. *MCSB Control: AI-6 (monitoring and detection).*
- **Perform continuous AI red teaming**: Proactively test AI systems using adversarial techniques to discover vulnerabilities before attackers exploit them. Simulate prompt injection, jailbreaking, and data poisoning scenarios. *MCSB Control: AI-7 (AI red teaming).*
- **Integrate threat intelligence**: Correlate monitoring data with AI-specific threat intelligence frameworks like MITRE ATLAS and OWASP Top 10 for LLM to identify known attack patterns. *MCSB Controls: AI-6 (monitoring), LT-1 (threat detection).*

| MCSB Control | Name |
|---------|------|
| [AI-6](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-6-establish-monitoring-and-detection) | Establish monitoring and detection |
| [AI-7](/security/benchmark/azure/mcsb-v2-artificial-intelligence-security#ai-7-perform-continuous-ai-red-teaming) | Perform continuous AI red teaming |
| [LT-1](/security/benchmark/azure/mcsb-logging-threat-detection#lt-1-enable-threat-detection-capabilities) | Enable threat detection capabilities |

### Bringing it all together

AI security builds on your existing security architecture while addressing unique risks. The MCSB v2 AI controls (AI-1 through AI-7) provide a comprehensive framework organized around three pillars:

- **Platform security** – Protect models, training data, and infrastructure through approved model governance and supply chain security
- **Application security** – Defend against prompt injection and adversarial attacks through content filtering, safety meta-prompts, least privilege, and human oversight
- **Monitoring and response** – Detect threats and validate controls through continuous monitoring and AI red teaming

By integrating these AI-specific controls with your existing security controls, you can enable responsible AI adoption while protecting both your AI investments and the broader environment they connect to.
