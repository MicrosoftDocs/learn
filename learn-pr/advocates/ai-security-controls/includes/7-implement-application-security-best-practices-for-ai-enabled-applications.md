AI-enabled applications are still applications, and therefore it's still important to follow secure coding and other application security best practices. AI introduces new attack surfaces—such as prompt interfaces, agent tool calls, and model endpoints—but these exist alongside all the traditional application security risks. Organizations should extend their existing security practices to cover AI-specific components rather than treat AI security as a separate discipline.

## Secure software development lifecycle (SDLC)

Integrate security at every stage of the AI application development process:

- **Design phase**: Conduct threat modeling that includes AI-specific threats (prompt injection, data poisoning, model theft). Identify which components handle sensitive data and which interact with external systems.
- **Development phase**: Follow secure coding practices. Validate all inputs—including prompts—before processing. Sanitize data passed between the AI orchestrator and tool endpoints.
- **Testing phase**: Include AI-specific test cases in your security testing: prompt injection attempts, jailbreak scenarios, and data exfiltration probes alongside traditional vulnerability testing.
- **Deployment phase**: Apply least-privilege access, encrypt data in transit and at rest, and configure monitoring before going live.
- **Operations phase**: Monitor for anomalies, apply patches promptly, and conduct regular security reviews that include the AI components.

Adopting a DevSecOps approach—where security is embedded into the CI/CD pipeline—helps balance security requirements with development velocity.

## AI agent tool security

AI agents that can call external tools (APIs, databases, file systems) require additional security controls. Each tool interaction is a potential point of privilege escalation or data leakage:

- **Capability manifests**: Define a capability manifest for each tool an agent can call. List only the authorized actions and prohibit all others by default.
- **Scoped, short-lived credentials**: Use short-lived, scoped tokens for each tool invocation rather than long-lived credentials. This limits the blast radius if a token is compromised.
- **Sandboxed execution**: Run agent functions in sandboxed execution environments to isolate runtime and prevent unauthorized system calls.
- **Input/output sanitization**: Sanitize and validate all data passed between the agent orchestrator and tool endpoints. This prevents injection attacks from propagating through the tool chain.
- **Audit logging**: Monitor and audit every tool call—log which tools were invoked, what data was accessed, and by which agent identity. This provides the forensic trail needed to investigate incidents.

:::image type="content" source="../media/agent-tool-security-architecture.png" alt-text="Diagram of AI agent tool security controls including manifests, credentials, and sandboxing." lightbox="../media/agent-tool-security-architecture.png":::

## Principle of least privilege

Apply least-privilege access consistently across all AI system components:

- Limit permissions for users, applications, AI agents, and service accounts to the minimum necessary for their function
- Use role-based access control (RBAC) to manage permissions at the agent level, separate from the permissions of the developers who built the agent
- Review and revoke unnecessary permissions regularly
- Reduce the blast radius of a compromised account by ensuring no single identity has broad access

## Secure data storage and transmission

Protect data throughout the AI pipeline:

- Encrypt sensitive data at rest and in transit, including model files, training data, conversation logs, and API payloads
- Use secure protocols (TLS 1.2 or later) for all data exchanges between AI system components
- Store secrets, API keys, and credentials in dedicated secret management systems—never in code, configuration files, or prompts
- Apply retention policies to conversation logs and interaction data to minimize exposure

## Monitoring and observability

Monitor AI application behavior for security anomalies:

- Track model response patterns for signs of jailbreaking, prompt injection, or data exfiltration attempts
- Monitor agent tool calls for unexpected behavior—calls to unauthorized endpoints, unusually large data transfers, or out-of-scope actions
- Set up alerts for anomalous usage patterns, such as sudden spikes in API calls or unusual query patterns that might indicate a model extraction attack
- Maintain comprehensive audit logs that capture user identity, agent identity, actions taken, and data accessed

## Regular security testing and auditing

Conduct ongoing security assessments that include AI-specific scenarios:

- **Vulnerability assessments**: Scan AI system components for known vulnerabilities, including model serving frameworks, vector databases, and orchestration tools
- **Penetration testing**: Include AI-specific attack scenarios (prompt injection, jailbreaking, data exfiltration) in penetration tests
- **Code reviews**: Review code that handles prompt construction, tool-call routing, and data retrieval for security flaws
- **Red team exercises**: Conduct regular AI-focused red team exercises to test the effectiveness of security controls. The next module in this learning path covers AI red teaming in detail.
