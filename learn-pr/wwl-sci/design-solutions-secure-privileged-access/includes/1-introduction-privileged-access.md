
Organizations should make securing privileged access the top security priority because of the significant potential business impact and high likelihood of attackers compromising this level of access.

Privileged access includes IT administrators with control of large portions of the enterprise estate and other users with access to business-critical assets. Attackers frequently exploit weaknesses in privileged access security during [human operated ransomware attacks](https://www.microsoft.com/security/blog/2020/03/05/human-operated-ransomware-attacks-a-preventable-disaster/) and targeted data theft.

The [Microsoft Cloud Security Benchmark (MCSB) v2](/security/benchmark/azure/mcsb-privileged-access) identifies privileged access as a core security control area. Control PA-1 specifically requires organizations to separate and limit highly privileged/administrative users and implement just-in-time access mechanisms.

## Zero Trust principles for privileged access

The [Zero Trust](/security/zero-trust/zero-trust-overview) security model provides the foundation for modern privileged access strategies. When designing privileged access solutions, apply these core principles:

- **Verify explicitly**: Always authenticate and authorize based on all available data points, including user identity, location, device health, service or workload, data classification, and anomalies.
- **Use least privilege access**: Limit user access with just-in-time (JIT) and just-enough-access (JEA), risk-based adaptive policies, and data protection.
- **Assume breach**: Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

## Privileged access strategy

The following diagram summarizes the recommended privileged access strategy to create an isolated virtual zone where sensitive accounts can operate with low risk.

:::image type="content" source="../media/end-to-end-approach-v2.png" alt-text="Diagram showing an end to end approach is required for meaningful security." lightbox="../media/end-to-end-approach-v2.png":::

Securing privileged access effectively seals off unauthorized pathways completely and leaves a select few authorized access pathways that are protected and closely monitored. For more information, see [Privileged Access Strategy](/security/privileged-access-workstations/privileged-access-strategy).

Building this strategy requires a holistic approach combining multiple technologies to protect and monitor those authorized escalation paths using Zero Trust principles. The strategy requires multiple complementary initiatives that establish a holistic technology approach, clear processes, and rigorous operational execution to build and sustain assurances over time.

## AI and privileged access considerations

As organizations adopt AI services and agents, privileged access management must extend to AI workloads. Consider these security architect design considerations:

- **AI model administration**: Users who manage, train, or fine-tune AI models may require privileged access to sensitive training data and model parameters.
- **AI agent identities**: Autonomous AI agents that perform tasks on behalf of users require carefully scoped permissions following least privilege principles.
- **Prompt injection risks**: AI systems processing untrusted inputs could be manipulated to escalate privileges or access unauthorized resources.
- **Monitoring AI activities**: AI agents performing privileged operations should be subject to the same logging, monitoring, and access review requirements as human administrators.

The [Microsoft Cloud Adoption Framework](/azure/cloud-adoption-framework/) provides guidance on governing AI workloads as part of your broader privileged access strategy.