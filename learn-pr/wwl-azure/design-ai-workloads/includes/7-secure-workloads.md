## Secure AI

When you build AI solutions in Azure, it’s important to [make security a priority](/azure/cloud-adoption-framework/scenarios/ai/secure) from the very beginning. AI systems create new attack surfaces that traditional security tools don’t fully cover. Follow these basic steps to get started.

:::image type="content" source="../media/security-areas.png" alt-text="Diagram of the main security areas.":::

### Discover AI security risks

Start by identifying vulnerabilities in your AI systems with frameworks like [MITRE ATLAS](https://atlas.mitre.org/) or [OWASP’s Generative AI guidance](https://genai.owasp.org/). Then review how sensitive data moves through your AI workflows, using tools like Microsoft Purview to spot potential leaks or insider risks. Make sure to test your models. Issues like data leakage or prompt injection only show up through real‑world testing. And since threats evolve quickly, run regular assessments so your defenses stay up to date.

### Secure AI resources

To protect your AI investments, make sure every part of your AI environment is secured. Start by keeping a complete inventory of all your AI assets—anything unknown becomes a weak spot. Use tools like [Azure Resource Graph Explorer](/azure/governance/resource-graph/overview) and Microsoft Defender for Cloud to automatically find and track them.

Next, secure how your AI components communicate. Managed identities, virtual networks, and Azure API Management help prevent unauthorized access and keep data safe in transit.

### Secure AI data

AI workloads depend on sensitive data and artifacts, so you need strong protection across the board. Start by defining clear data boundaries so each workload only accesses what it should. Use Microsoft Purview to classify data and set access policies, Azure role based permissions to restrict who can access what, and Azure Private Link to isolate data at the network level.

Because AI models can accidentally surface sensitive information, use tools like Microsoft Purview Data Loss Prevention. Also consider content filtering, and custom detection rules to block or redact anything that shouldn’t be exposed. For Microsoft Copilot Studio, make sure to configure data loss prevention policies for agents.

Finally, protect your AI artifacts, models, and datasets, from theft or tampering. Store the data in Azure Blob Storage with private endpoints, enforce encryption in transit and at rest, and apply strict access controls and monitoring to catch unauthorized activity.

### Detect AI security threats

AI systems face constantly changing threats, so continuous monitoring is essential to prevent breaches and downtime. Automated detection helps you spot issues fast and keeps your AI workloads running smoothly.

To catch risks early, use automated tools. Microsoft Defender for Cloud’s AI security posture management can detect and remediate generative AI threats across your environment in real time.

Next, build incident response plans tailored to AI. Plans should outline how you handle AI-specific threats—like data loss or model compromise—and include clear escalation paths. Make sure to test and update these plans regularly.

Finally, monitor each AI platform. Different architectures have different risks, so platform-specific monitoring ensures you’re covering all potential attack paths.

### Tool Summary

This table provides a summary of some of the security tools and processes. 

| Step| Tools and processes |
| - | - |
| Discover AI security risks| MITRE ATLAS, OWASP’s Generative AI guidance, Microsoft Purview |
| Secure AI resources| Azure Resource Graph Explorer, Microsoft Defender for Cloud, Managed Identities, Azure API Management |
| Secure AI data| Role based permissions, Azure Private Link, Microsoft Purview Data Loss Prevention, Azure Blob Storage |
| Detect AI security threats| Microsoft Defender for Cloud’s AI security posture management, incident response plans, escalation paths, monitoring |


 
