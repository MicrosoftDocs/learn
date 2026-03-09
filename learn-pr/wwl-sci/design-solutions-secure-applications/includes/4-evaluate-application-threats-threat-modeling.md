Posture evaluation tells you where your applications stand today. Threat modeling tells you where they're vulnerable to attack. While posture assessment examines configuration and compliance against security baselines, threat modeling takes a different approach. It systematically identifies potential attack vectors against your application's design, prioritizes risks, and drives specific mitigations.

As a cybersecurity architect, you use threat modeling to ensure that business-critical applications are designed with defense in depth. The earlier you identify threats, the cheaper and more effective your mitigations are.

## What is threat modeling?

Threat modeling is a structured analysis technique that identifies potential security threats during the design phase, before code is written. It answers four key questions:

1. **What are you building?** Define the system's architecture, data flows, trust boundaries, and external dependencies.
2. **What can go wrong?** Systematically identify potential threats using a proven methodology.
3. **What are you going to do about it?** Define mitigations for each identified threat, prioritized by risk.
4. **Did you do a good enough job?** Validate that mitigations are effective and no significant threats were missed.

Threat modeling isn't a one-time activity. It should occur initially during the design phase and continue throughout the application's evolution. Architectural changes, new integrations, and feature additions all warrant updated threat models.

## STRIDE methodology

The Microsoft SDL uses the STRIDE methodology for systematic threat identification. STRIDE is a mnemonic that categorizes threats into six types:

| Category | Description | Example |
|---|---|---|
| **Spoofing** | An attacker pretends to be someone or something else | Forging authentication tokens to impersonate a legitimate user |
| **Tampering** | Unauthorized modification of data or code | Modifying API request payloads in transit to alter transaction amounts |
| **Repudiation** | Denying an action without the other party being able to prove otherwise | A user denies placing an order because audit logs don't capture the action |
| **Information disclosure** | Exposing data to unauthorized parties | API responses returning more data fields than the consumer requires |
| **Denial of service** | Making a system unavailable to legitimate users | Flooding a public API with requests to exhaust backend connection pools |
| **Elevation of privilege** | Gaining higher access than authorized | Exploiting a misconfigured role assignment to gain administrative access |

For each component and data flow in your architecture, systematically evaluate potential threats across all six STRIDE categories. This prevents the common mistake of focusing only on familiar threat types and overlooking systemic risks.

## The threat modeling process

The following diagram illustrates the four-step process for threat modeling. Each step builds on the previous one, starting with understanding what you're building and ending with validation that your mitigations are effective.

:::image type="content" source="../media/security-development-lifecycle-approach-v2.png" alt-text="Diagram that shows the steps to use in threat modeling." border="true" lightbox="../media/security-development-lifecycle-approach-v2.png":::

### Step 1: Create a data flow diagram

Build a data flow diagram (DFD) that maps the system's key elements:

- **External entities:** users, external systems, third-party APIs that interact with the application.
- **Processes:** application components that transform or route data.
- **Data stores:** databases, caches, file systems, or message queues.
- **Data flows:** the movement of data between entities, processes, and stores.
- **Trust boundaries:** points where the level of trust changes, such as between the internet and your internal network, or between two different Azure subscriptions.

Trust boundaries are critical for architects. They represent the points where security controls must exist to prevent unauthorized access. Every data flow that crosses a trust boundary requires authentication, authorization, and validation.

### Step 2: Identify threats

Apply STRIDE to each element in the diagram. The Microsoft Threat Modeling Tool automates parts of this process by generating threat suggestions based on component types and data flow patterns. For example, a web API that receives data from external clients will automatically generate threats related to input validation, authentication bypass, and injection attacks.

Focus particularly on:

- **External-facing interfaces:** APIs, web applications, and services exposed to the internet.
- **Privileged operations:** administrative functions, deployment processes, and secret management.
- **Data handling:** how sensitive data moves through the system, where it's stored, who can access it, and whether it's encrypted appropriately.

### Step 3: Prioritize and mitigate

Not all threats carry equal risk. Prioritize based on the likelihood of exploitation and the business impact if the threat materializes. Consider using a risk matrix that factors in:

- **Attack complexity:** how difficult is it for an attacker to exploit the threat?
- **Impact severity:** what happens to the business if the attack succeeds?
- **Existing controls:** do current security measures already reduce the risk?

For each high-priority threat, define specific mitigations. Mitigations should follow defense-in-depth principles:

- **Apply the principle of least privilege** for all identities, services, and network access.
- **Use defense in depth** by layering multiple controls so that failure of one control doesn't expose the system entirely.
- **Fail securely** by designing components that default to a secure state when errors occur.
- **Validate all inputs** at trust boundary crossings to prevent injection attacks.

### Step 4: Validate

Review the threat model with both development and security stakeholders. Verify that mitigations address the identified threats and that the model accurately represents the current architecture. Track identified threats as work items in Azure DevOps or your project management system, with clear ownership and acceptance criteria.

## Microsoft Threat Modeling Tool

The [Microsoft Threat Modeling Tool](/azure/security/develop/threat-modeling-tool) supports the threat modeling process. It provides:

- Templates for common architecture patterns (web applications, APIs, microservices, IoT solutions).
- Automated threat identification based on component types and data flows.
- A reporting capability that generates actionable findings with associated security controls.
- STRIDE per Element analysis, which guides users through threats specific to each component.

The tool is designed for use by both security specialists and developers. It produces threat models that serve as versioned artifacts stored alongside architecture documentation in source control.

## Integrate threat modeling into development workflows

As an architect, you should design a process that scales threat modeling across the organization without creating bottlenecks:

- **Embed in project initiation.** Include security questionnaires in project templates that automatically assess risk level and determine whether formal threat modeling is required based on data classification and external exposure.
- **Automate architecture review triggers.** Configure pull request workflows to detect changes to system boundaries, authentication flows, or data handling logic, and route those changes to security architects for threat model validation.
- **Build a Security Champions program.** Train designated security champions in each development team on STRIDE methodology. Champions facilitate threat modeling sessions for their teams and escalate complex scenarios to the centralized security team.
- **Version-control threat models.** Store threat models as code (JSON/YAML definitions) alongside architecture documentation, enabling automated analysis and review as part of continuous integration and continuous delivery (CI/CD) processes.

## Threat modeling considerations for specific architectures

When applying threat modeling to your organization's workloads, consider how different application architectures shift the focus of your analysis:

- **Microservices:** focus on inter-service communication, service mesh security, API gateway controls, and blast radius containment.
- **Serverless:** focus on event source injection, function chaining abuse, and overprivileged execution roles.
- **Container-based:** focus on image integrity, container escape, host isolation, and network policy enforcement.
- **API-first:** focus on input validation, rate limiting, authentication and authorization at the gateway, and excessive data exposure.


