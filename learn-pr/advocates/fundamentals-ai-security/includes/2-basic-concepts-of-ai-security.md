AI security is the practice of protecting AI systems—including models, training data, inference pipelines, and AI-enabled applications—from threats that exploit the unique characteristics of artificial intelligence. While traditional cybersecurity focuses on protecting computer systems, networks, and data, AI security extends those goals to address risks specific to how AI systems learn, reason, and generate output. Security professionals working in the AI security space must design and implement controls that protect the assets, data, and information within AI-enabled applications.

## How is AI security different from traditional cybersecurity?

AI security differs from traditional cybersecurity because of the way AI systems learn and produce output. The output of generative AI models isn't always the same—even when given the same input. This nondeterministic behavior poses challenges when you design security controls, because traditional controls often assume that the same input produces the same output every time.

The natural language interfaces that make generative AI useful also expand the attack surface. Constraining input to a UI element or API is a well-understood security control for traditional applications, but you can't restrict a natural language interface in the same way without undermining the core value of the AI system.

Other considerations specific to AI security include, but aren't limited to:

- Integrity of the AI model
- Integrity of the training data
- Responsible AI (RAI) concerns
- Adversarial AI attacks
- AI model theft
- Overreliance on AI
- Nondeterministic (creative) nature of generative AI

One of the biggest challenges with AI security is that the field is developing rapidly. New model capabilities, new integration patterns (such as AI agents with tool access), and new attack techniques emerge regularly. This pace makes it challenging for security professionals to keep up to date with the scope and capabilities of the technology and to have the correct security controls in place.

## Why does responsible AI matter for cybersecurity?

Responsible Artificial Intelligence (Responsible AI) is an approach to developing, assessing, and deploying AI systems in a safe, trustworthy, and ethical way. AI systems are the product of many decisions made by those who develop and deploy them. From system purpose to how people interact with AI systems, Responsible AI can help proactively guide these decisions toward more beneficial and equitable outcomes. That means keeping people and their goals at the center of system design decisions and respecting enduring values like fairness, reliability, and transparency.

Leading responsible AI frameworks share a common set of principles for building AI systems: fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability. These principles are the cornerstone of a responsible and trustworthy approach to AI.

:::image type="content" source="../media/responsible-ai-principles.png" alt-text="Hexagonal diagram of the six responsible AI principles surrounding a central AI label." lightbox="../media/responsible-ai-principles.png":::

AI harms are issues specific to AI systems that can span cybersecurity, privacy, and ethics. AI blurs the lines between these traditionally separate domains. It's important that security professionals understand responsible AI holistically in order to create secure and responsible AI systems.

Examples of security-specific AI harms:

- Privacy violations through unauthorized data access or inference
- Excessive overreliance on AI for critical decisions

Examples of other AI harms:

- Producing content that violates policies (for example, harmful, offensive, or violent content)
- Providing access to dangerous capabilities of the model (for example, producing actionable instructions for criminal activity)
- Subversion of decision-making systems (for example, making a loan application or hiring system produce attacker-controlled decisions)
- Causing the system to produce newsworthy harmful output that damages organizational reputation
- IP infringement

## AI security frameworks and threat taxonomies

Security professionals use industry-standard frameworks to classify and communicate AI security risks. Widely adopted frameworks include:

- **OWASP Top 10 for LLM Applications**: The Open Worldwide Application Security Project (OWASP) maintains a ranked list of the most critical security risks specific to large language model applications. Categories include prompt injection, insecure output handling, training data poisoning, and model theft—the same attack types covered in this module. Major cloud security benchmarks now explicitly direct security teams to use this framework when training on AI-specific threats.
- **MITRE ATLAS (Adversarial Threat Landscape for Artificial-Intelligence Systems)**: A knowledge base of adversarial tactics and techniques observed against AI systems, structured similarly to the MITRE ATT&CK framework that security professionals already use for traditional systems. MITRE ATLAS provides the attack IDs and technique descriptions that AI red teams reference when designing test scenarios.
- **NIST AI Risk Management Framework (AI RMF)**: Published by the National Institute of Standards and Technology, this framework provides guidance for managing risks throughout the AI lifecycle. It emphasizes governance, transparency, and ongoing testing and monitoring.
- **ISO/IEC 42001**: An international standard for AI management systems that provides requirements for establishing, implementing, and improving AI governance, including security controls.

These frameworks complement each other. Security teams often use them together—for example, OWASP to prioritize application risks, MITRE ATLAS to model adversarial behavior, and NIST AI RMF or ISO 42001 for organizational governance.

The attack techniques you'll learn about in the following units—including jailbreaking, prompt injection, model manipulation, and data exfiltration—all map to entries in both OWASP and ATLAS. As you build your AI security knowledge, using these taxonomies helps you communicate risk in terms your colleagues and compliance teams recognize. You can find links to each of these frameworks in the resources section of this module's summary unit.