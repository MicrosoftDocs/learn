Designing and evaluating the security posture of hybrid and multicloud environments starts with selecting the right security framework. The Microsoft Cloud Security Benchmark (MCSB) provides a foundation for both designing your security architecture and evaluating your current posture against industry best practices.

## Designing with MCSB as your security framework

MCSB serves as more than an evaluation checklist—it's a design framework that guides your security architecture decisions. When designing your posture management solution, consider how MCSB fits into your overall approach.

**When to use MCSB as your primary baseline**: MCSB is appropriate as your primary security standard when:
- Your organization operates across Azure, AWS, and GCP (MCSB provides implementation guidance for all three)
- You need a comprehensive framework covering network, identity, data, and application security
- You want alignment with industry frameworks without maintaining separate mappings

**Mapping to regulatory requirements**: MCSB maps to common regulatory frameworks including PCI-DSS, ISO 27001, NIST SP 800-53, and CIS Controls. Design your compliance strategy by:
- Using MCSB as the operational baseline
- Mapping MCSB controls to your specific regulatory requirements
- Identifying gaps where regulations require controls beyond MCSB

**Designing exception management**: Not all MCSB controls apply to every workload. Design an exception process that documents:
- Which controls don't apply and why
- Compensating controls in place
- Review cadence for exceptions

## Evaluating posture against MCSB

With your design in place, use MCSB to evaluate your current security posture. The Posture and Vulnerability Management (PV) domain defines what mature posture management looks like:

| Control | Evaluation criteria | Design questions |
|---------|---------------------|------------------|
| PV-1: Define secure configurations | Security baselines exist for each resource type | Do you have documented baselines enforced at deployment? |
| PV-2: Audit and enforce configurations | Continuous monitoring detects drift | Can you detect configuration changes with automated remediation? |
| PV-3: Define compute configurations | VMs and containers deploy from hardened images | Are OS security baselines defined and documented? |
| PV-4: Audit compute configurations | Compute resources monitored for deviations | Do you have visibility across all cloud providers? |
| PV-5: Perform vulnerability assessments | Regular scans cover all resource types | Do you have centralized findings across clouds? |
| PV-6: Remediate vulnerabilities | Patches deploy using risk-based prioritization | Is patching automated with critical vulnerabilities prioritized? |
| PV-7: Conduct red team operations | Penetration testing validates controls | Are findings tracked to remediation? |

## Conducting an MCSB-based evaluation

To evaluate your security posture using MCSB:

1. **Assess current state**: For each PV control, document your current capabilities and identify where you meet, partially meet, or don't meet the control requirements.

2. **Identify gaps**: Compare your assessment against the control descriptions to find areas where your posture falls short of the benchmark.

3. **Plan remediation**: Prioritize gaps based on risk and create a roadmap to address them, using MCSB's implementation guidance for your specific cloud platforms.

For detailed control requirements and platform-specific guidance, see [Posture and vulnerability management](/security/benchmark/azure/mcsb-posture-vulnerability-management) in the MCSB documentation.