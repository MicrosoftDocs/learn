Evaluating your organization's security posture requires a consistent framework that can be applied across Azure, AWS, GCP, and on-premises environments. The Microsoft Cloud Security Benchmark (MCSB) v2 serves as this evaluation framework, providing defined security controls you can measure your environment against.

## Using MCSB to evaluate security posture

MCSB enables you to evaluate security posture by comparing your current configurations and practices against defined security controls. This evaluation process helps you:

- **Identify gaps**: Compare your current security configurations against MCSB control requirements to find areas that need improvement.
- **Prioritize improvements**: Use MCSB's risk-based guidance to focus on controls that address your highest risks.
- **Measure progress**: Track compliance against MCSB controls over time to demonstrate security posture improvement.
- **Benchmark across clouds**: Apply the same evaluation criteria across Azure, AWS, and GCP since MCSB provides implementation guidance for each platform.

For security posture management specifically, MCSB provides the Posture and Vulnerability Management (PV) domain. These controls define what a mature security posture looks like and give you the criteria to evaluate against.

## MCSB controls for security posture evaluation

The PV domain contains seven controls that serve as evaluation criteria for your security posture. Use the following table to assess your environment's alignment with each control:

| Control | What to evaluate | Questions to ask |
|---------|------------------|------------------|
| PV-1: Define and establish secure configurations | Whether security configuration baselines exist for each resource type and are applied during deployment. | Do you have documented baselines? Are configurations enforced at deployment time? |
| PV-2: Audit and enforce secure configurations | Whether you continuously monitor for configuration drift and can enforce compliance across environments. | Can you detect when configurations change? Do you have remediation policies in place? |
| PV-3: Define secure configurations for compute | Whether VMs and containers are deployed from hardened images with defined security baselines. | Are you using hardened images? Are OS security baselines defined and documented? |
| PV-4: Audit and enforce compute configurations | Whether compute resources are monitored for configuration deviations with automated remediation. | Do you have visibility into compute configuration drift across all cloud providers? |
| PV-5: Perform vulnerability assessments | Whether regular vulnerability scans cover all resource types with tracked remediation. | Are scans scheduled regularly? Do you have a centralized view of findings across clouds? |
| PV-6: Remediate vulnerabilities automatically | Whether patches and updates are deployed automatically using risk-based prioritization. | Is patching automated? Are critical vulnerabilities prioritized appropriately? |
| PV-7: Conduct red team operations | Whether penetration testing and red team exercises validate your security controls. | Do you conduct regular security testing? Are findings tracked to remediation? |

## Conducting an MCSB-based evaluation

To evaluate your security posture using MCSB:

1. **Assess current state**: For each PV control, document your current capabilities and identify where you meet, partially meet, or don't meet the control requirements.

2. **Identify gaps**: Compare your assessment against the control descriptions to find areas where your posture falls short of the benchmark.

3. **Plan remediation**: Prioritize gaps based on risk and create a roadmap to address them, using MCSB's implementation guidance for your specific cloud platforms.

For detailed control requirements and platform-specific guidance, see [Posture and vulnerability management](/security/benchmark/azure/mcsb-posture-vulnerability-management) in the official MCSB documentation.