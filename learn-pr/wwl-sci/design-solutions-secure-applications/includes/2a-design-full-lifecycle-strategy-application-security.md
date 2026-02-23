The standards and practices from the previous unit provide the foundation for secure development. This unit builds on that foundation by describing how to design a strategy that secures applications across their full lifecycle, from initial requirements through production operations and eventual decommissioning.

The Azure Well-Architected Framework Security pillar defines a structured approach to integrating security into a software development lifecycle (SDLC). As an architect, your responsibility is to design the strategy that ensures security considerations are embedded in every phase, not added as an afterthought.

## Collect and document security requirements

The lifecycle begins with security requirements. During this phase, gather both functional and nonfunctional security requirements for the application. Functional requirements include authentication mechanisms, authorization models, and data protection controls. Nonfunctional requirements address availability, compliance obligations, and operational security needs.

Document the security requirements in an agreed-upon specification and ensure they're reflected in the development backlog. Include explicit statements about security investments and the tradeoffs the business accepts if those investments aren't approved. For example, document the need for a web application firewall (WAF) in front of a public-facing application. If business stakeholders don't approve the cost, they must accept the risk that application-layer attacks might succeed.

This documentation creates accountability and provides the basis for security testing later in the lifecycle.

## Translate security requirements to technical requirements

During the design phase, convert security requirements into technical specifications. This step prevents ambiguity during implementation and ensures developers understand exactly what security controls to build.

**Define the security dimension of the system architecture.** Overlay the architecture with security controls on isolation boundaries, using your segmentation strategy. Specify the types of identities needed for each component, the encryption methods required for data at rest and in transit, and the network controls that restrict access.

**Evaluate platform-provided affordances.** Understand the shared responsibility model and avoid duplicating controls that Azure provides natively. For example, instead of building custom WAF logic in application code, use Azure Application Gateway or Azure Front Door. Use managed services such as Azure Key Vault for secret management and managed identities for service-to-service authentication instead of implementing custom solutions.

**Select approved frameworks and supply chain components.** Your design should mandate the use of trusted frameworks and libraries. Maintain a list of approved and prohibited dependencies and enforce it through guardrails in the development pipeline. Automate dependency scanning to verify that all components meet security requirements.

**Define security design patterns.** Identify patterns that support segmentation, strong authorization, and uniform application security. Patterns like the Quarantine pattern help verify and block software that could introduce vulnerabilities. For more information, see the Azure Well-Architected architecture design patterns that support security.

**Perform threat modeling.** Conduct initial threat modeling during the design phase to confirm that design choices align with security requirements and to expose gaps that require mitigation. For workloads handling highly sensitive data, consider engaging specialized security experts. Threat modeling isn't a one-time activity but a continuous process that evolves with the software.

## Secure development and testing practices

During the development and testing phase, the goal is to prevent security defects and tampering in code, build, and deployment processes.

**Require secure coding training.** Development teams need formal, specialized training on secure coding practices. Web and API developers need specific training on cross-site scripting prevention, and back-end developers benefit from training on database-level attacks like SQL injection.

**Integrate security testing tools.** Use Static Application Security Testing (SAST) to analyze code for vulnerabilities during development and Dynamic Application Security Testing (DAST) to test running applications for runtime issues. Integrate both into continuous integration and continuous delivery (CI/CD) pipelines so they execute automatically. Follow industry standards such as Open Worldwide Application Security Project (OWASP) for secure coding practices and use linters and code analyzers to prevent credentials from being pushed to source code repositories.

**Write minimal code.** Reduce the code footprint to limit the attack surface. Reuse validated libraries rather than duplicating code. Use Azure managed services to avoid writing custom implementations for capabilities like authentication, encryption, and secret management.

**Protect developer environments.** Developer workstations and build agents are high-value targets. Protect them with strong network and identity controls, apply security updates promptly, and enforce the same security rigor you apply to production components. Prefer Microsoft-hosted build agents, which provide clean virtual machines for each pipeline run, over self-hosted agents that require ongoing maintenance and hardening.

## Protect code in deployment pipelines

Your pipeline is only as secure as its weakest component. If an attacker compromises the pipeline, they can inject code that bypasses all other security controls.

**Maintain a component inventory.** Track every component integrated into your application, including third-party libraries and framework components. Store the inventory outside the build environment and regularly compare it against what's in your build process to detect unauthorized additions.

**Secure pipeline tasks and secrets.** Pull pipeline tasks from trusted sources like Azure Marketplace. Segment pipeline secrets across different stages so that development pipelines don't have access to production secrets. Use workload identities for pipeline authentication and managed identities for service-to-service authentication instead of storing long-lived credentials.

**Separate environments.** Keep data from different environments segregated. Never use production data in lower environments, and avoid connecting nonproduction applications to production databases or networks.

**Use progressive exposure.** Deploy features incrementally to subsets of users. If issues are discovered, the blast radius is contained. As confidence in the feature's security grows, expand the release to broader audiences.

## Protect code in production

Production is the last point where you can catch security gaps before they're exploited.

**Keep versioned artifact catalogs.** Maintain a catalog of all deployed assets and their versions. This information supports incident triage, rollback, and correlating deployed components against published Common Vulnerabilities and Exposures (CVE) notices.

**Design for emergency fixes.** Your deployment pipeline must support both regular and emergency release paths. Create an emergency process that accelerates security fixes through simplified approval gates while maintaining appropriate testing safeguards. Security fixes should never introduce regressions.

## Maintain security throughout the lifecycle

Security posture degrades over time if not actively maintained. This phase ensures continuous improvement.

- **Patch management.** Keep software, libraries, and infrastructure components current with security updates.
- **Continuous improvement.** Regularly assess and refine the security of the development process through code reviews, feedback, and lessons learned from incidents and evolving threats.
- **Decommission unused assets.** Remove legacy assets that are no longer needed. Every unused component is another attack surface.
- **Incident integration.** When issues are found in production, feed them back into the development process to prevent recurrence.


