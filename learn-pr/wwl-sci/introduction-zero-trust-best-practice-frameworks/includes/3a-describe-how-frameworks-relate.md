As a cybersecurity architect, you don't choose one framework and ignore the others. Each framework serves a different purpose and scope, and they're designed to complement each other. Understanding how they relate helps you select the right guidance for the right situation.

## Different scopes, shared principles

All of these frameworks share Zero Trust as a foundational security philosophy, but they operate at different levels:

- **CAF** operates at the **organizational level**. It guides the entire cloud adoption journey from strategy through operations, including security as one of its seven methodologies. CAF helps you decide *how to adopt the cloud* securely.
- **WAF** operates at the **workload level**. It helps you design and improve individual workloads across five quality pillars, one of which is security. WAF helps you decide *how to build and operate workloads* securely.
- **MCRA** operates at the **architecture level**. It provides reference diagrams and best practices for end-to-end security across the hybrid technology estate. MCRA helps you decide *what your security architecture should look like*.
- **MCSB** operates at the **control level**. It provides prescriptive security controls organized into domains, mapped to compliance standards. MCSB helps you decide *which specific controls to implement and monitor*.
- **Zero Trust adoption framework** operates at the **strategy level**. It provides a phased business-driven approach to implementing Zero Trust across the organization. It helps you decide *how to plan and execute your Zero Trust transformation*.

## How the frameworks connect

The Microsoft cloud security benchmark draws from multiple sources, including the Cloud Adoption Framework and the Azure Well-Architected Framework, along with industry standards such as CIS, NIST, and PCI-DSS. When you implement MCSB controls, you're applying guidance that's already aligned with these broader frameworks.

CAF references WAF for workload-level design and optimization. When CAF guides you to adopt or govern workloads, WAF provides the detailed design principles for those individual workloads. Similarly, CAF's security methodology draws on MCRA for reference architecture guidance.

MCRA includes the Zero Trust RaMP, which prioritizes security modernization initiatives. These initiatives map to the Zero Trust technology pillars and provide the tactical steps that the Zero Trust adoption framework organizes into a broader strategic plan.

The Zero Trust adoption framework adapts CAF's lifecycle phases (Define strategy, Plan, Ready, Adopt, Govern, Manage) but applies them to security transformation across the entire digital estate rather than to individual workload adoption.

## Choosing the right framework

The following table summarizes when to use each framework:

| Framework | When to use | Primary audience |
|---|---|---|
| **CAF** | When you're looking to create and implement business and technology strategies for cloud adoption. | Cloud architects, IT professionals, business decision makers |
| **WAF** | When you're looking to improve the quality of an individual cloud workload. | Cloud architects, IT professionals |
| **MCRA** | When you need a starting template for security architecture, a comparison reference, or need to learn about Microsoft cybersecurity capabilities. | Cloud architects, IT professionals |
| **MCSB** | When you need guidance on implementing specific security controls and monitoring compliance against industry standards. | Cloud architects, IT professionals |
| **Zero Trust adoption framework** | When you want a phased, business-driven approach to implementing Zero Trust from strategy through management. | Security architects, IT teams, project managers |
| **Zero Trust RaMP** | When you want to get started with Zero Trust and make progress quickly by prioritizing the highest-impact areas. | Cloud architects, IT professionals, business decision makers |

## Think of it as a system

Rather than selecting one framework, think of these frameworks as a system within which organizations plan, design, implement, and measure their security posture. The Zero Trust adoption framework and CAF guide your strategy and lifecycle. MCRA provides the reference architecture. WAF shapes individual workload design. MCSB provides the controls and compliance monitoring. Together, they enable a comprehensive approach to cybersecurity that spans from strategic planning to operational detail.
