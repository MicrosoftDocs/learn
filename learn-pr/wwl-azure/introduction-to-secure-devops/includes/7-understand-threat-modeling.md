Threat modeling is a core element of the Microsoft Security Development Lifecycle (SDL) and a fundamental security practice for building secure applications. It's an engineering technique that helps you systematically identify threats, attacks, vulnerabilities, and countermeasures that could affect your application.

## What is threat modeling

**Purpose:** Threat modeling provides a structured approach to understanding security risks in your application. Rather than hoping you've thought of all possible security issues, threat modeling guides you through a systematic process to identify and address threats.

**Benefits:** You can use threat modeling to:

- **Shape application design:** Influence architecture decisions based on security considerations rather than adding security as an afterthought.
- **Meet security goals:** Ensure your application meets your organization's security objectives and compliance requirements.
- **Reduce risk:** Systematically reduce security risks by identifying and addressing threats during design rather than discovering them in production.
- **Prioritize security work:** Focus security efforts on the most significant threats rather than trying to address everything at once.
- **Communicate security concerns:** Provide a common language for developers, security teams, and stakeholders to discuss security.

**Accessibility:** The approach has been designed with non-security experts in mind. Threat modeling is accessible to all developers, not just security specialists, through clear guidance on creating and analyzing threat models.

## The five-stage threat modeling process

Threat modeling follows a systematic five-stage process:

:::image type="content" source="../media/threat-modeling-98beb5cb.png" alt-text="Diagram showing the five threat modeling stages: Define security requirements, Diagram application architecture, Identify threats, Mitigate threats, and Validate mitigations.":::

### 1. Define security requirements

**Establish security goals:** Before analyzing threats, clarify what security means for your application:

**Confidentiality requirements:**

- What data must remain confidential?
- Who should have access to sensitive information?
- How long must data remain confidential?
- What are the consequences of confidentiality breaches?

**Integrity requirements:**

- What data or operations must be protected from unauthorized modification?
- How do you detect if data has been tampered with?
- What are the consequences of integrity violations?

**Availability requirements:**

- What uptime guarantees are needed?
- What's acceptable downtime for different components?
- What's the business impact of unavailability?

**Compliance requirements:**

- What regulatory requirements apply (GDPR, HIPAA, PCI DSS, etc.)?
- What industry standards must be met (ISO 27001, SOC 2, etc.)?
- What contractual security obligations exist with customers?

**Example requirements:** "Customer payment information must remain confidential. Only authorized payment processing systems can access this data. All access must be logged for audit purposes. Data must be encrypted in transit and at rest."

### 2. Create an application diagram

**Visualize your architecture:** Create a diagram that represents your application's architecture, showing:

**System components:**

- Web servers, application servers, databases, microservices.
- External services and APIs your application depends on.
- Authentication and authorization systems.
- Load balancers, caching layers, message queues.

**Data flows:**

- How data moves between components.
- What data each connection transmits.
- Direction of data flow.
- Data transformation points.

**Security boundaries:**

- Trust boundaries where privilege levels change.
- Network boundaries between different security zones.
- Process boundaries between different execution contexts.
- Physical boundaries between different locations or clouds.

**Example elements:**

- Users connecting through the internet.
- Web application firewall at the network edge.
- Web servers in a DMZ.
- Application servers in a protected network.
- Database servers in a highly restricted network.
- External payment gateway for processing transactions.

### 3. Identify threats

**Systematic threat identification:** Use structured approaches to identify potential threats:

**STRIDE methodology:** STRIDE is a threat categorization framework:

- **S**poofing: Threats involving identity impersonation.
- **T**ampering: Threats involving unauthorized modification of data.
- **R**epudiation: Threats where users deny performing actions.
- **I**nformation Disclosure: Threats involving unauthorized information access.
- **D**enial of Service: Threats that prevent legitimate users from accessing systems.
- **E**levation of Privilege: Threats where users gain unauthorized permissions.

**Apply STRIDE to data flows:** Examine each data flow in your diagram and consider how each STRIDE category might apply:

- Can an attacker spoof the source of this data?
- Can this data be tampered with during transmission or storage?
- Can legitimate actions on this data flow be repudiated?
- Could sensitive information be disclosed through this flow?
- Could this flow be used to cause denial of service?
- Could this flow be exploited to gain elevated privileges?

**Common threat examples:**

- **SQL injection:** Attacker manipulates database queries through unsanitized user input (Tampering, Information Disclosure, Elevation of Privilege).
- **Session hijacking:** Attacker steals session tokens to impersonate users (Spoofing, Elevation of Privilege).
- **Man-in-the-middle:** Attacker intercepts communications between components (Information Disclosure, Tampering).
- **DDoS attack:** Attacker overwhelms systems with traffic (Denial of Service).

### 4. Mitigate threats

**Develop countermeasures:** For each identified threat, develop appropriate mitigations:

**Mitigation strategies:**

- **Eliminate:** Remove the vulnerable component or feature entirely if it's not essential.
- **Prevent:** Implement controls that make the threat impossible (e.g., input validation prevents injection attacks).
- **Detect:** Implement monitoring and alerting to detect threat exploitation attempts.
- **Respond:** Develop incident response procedures for when threats are exploited.

**Example mitigations:**

- **SQL injection threat:** Use parameterized queries and input validation to prevent injection attacks.
- **Session hijacking threat:** Implement secure session management with HTTPS, secure cookies, and short session timeouts.
- **Man-in-the-middle threat:** Enforce TLS for all communications and implement certificate pinning.
- **DDoS threat:** Use cloud-based DDoS protection services and implement rate limiting.

**Document decisions:** Record mitigation decisions including:

- Which threats are addressed.
- What mitigation approach was chosen.
- Why this approach is appropriate.
- Who is responsible for implementation.
- Any residual risks that remain.

### 5. Validate mitigations

**Verify effectiveness:** After implementing mitigations, validate that they effectively address identified threats:

**Security testing:**

- Penetration testing to verify threats can't be exploited.
- Security code reviews to confirm mitigations are properly implemented.
- Automated security scanning to detect missed vulnerabilities.
- Red team exercises to test defenses against realistic attack scenarios.

**Continuous validation:** Threats and mitigations evolve:

- New threats emerge as technology changes.
- Existing mitigations may become ineffective.
- Application changes may introduce new vulnerabilities.

## Threat modeling in the development lifecycle

**Ongoing process:** Threat modeling shouldn't be a one-time activity. It should be part of your typical development lifecycle:

**Initial design:** Conduct comprehensive threat modeling during initial application design to influence architectural decisions.

**Feature development:** Perform threat modeling when adding significant new features that change security boundaries or introduce new data flows.

**Regular updates:** Periodically review and update threat models even without major changes, as the threat landscape evolves.

**Incident response:** Update threat models after security incidents to incorporate lessons learned.

**Progressive risk reduction:** This iterative approach enables you to refine your threat model and progressively reduce risk over time rather than attempting to address all risks at once.

## Microsoft Threat Modeling Tool

Microsoft provides a free tool that makes threat modeling more accessible and structured:

**Purpose:** The Microsoft Threat Modeling Tool makes threat modeling easier for all developers through a standard notation for visualizing system components, data flows, and security boundaries.

**Automated threat identification:** The tool helps threat modelers identify classes of threats they should consider based on the structure of their software design. As you create your application diagram, the tool automatically suggests potential threats based on the components and data flows you've defined.

**Key capabilities:** The Threat Modeling Tool enables any developer or software architect to:

**Communicate security design:**

- Create visual representations of system architecture.
- Use consistent notation that security teams and developers understand.
- Document security-relevant architecture decisions.
- Share threat models with stakeholders for review and feedback.

**Analyze designs:**

- Identify potential security issues using proven methodologies (STRIDE).
- Automatically generate threat lists based on application structure.
- Prioritize threats based on severity and likelihood.
- Compare different design alternatives from a security perspective.

**Manage mitigations:**

- Suggest mitigations for identified threats.
- Track mitigation implementation status.
- Document security decisions and rationale.
- Generate reports for security reviews and compliance.

**Getting started:**

- The tool is free and available for download from Microsoft.
- It includes templates for common application types.
- Built-in guidance helps new users learn threat modeling concepts.
- Integration with Azure DevOps enables linking threats to work items.

## Additional resources

For more information about threat modeling, see:

- [Threat Modeling Tool feature overview](/azure/security/azure-security-threat-modeling-tool-feature-overview).
- [Microsoft Threat Modeling Tool](https://blogs.msdn.microsoft.com/secdevblog/2018/09/12/microsoft-threat-modeling-tool-ga-release/).
