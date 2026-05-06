Contoso Financial Services started this module unable to answer a basic question: if one of our AI agents were compromised, what could an attacker reach? By the end, the security team has a methodology for answering that question for every agent in their environment—and a prioritized list of agents that need immediate remediation.

## Review what you accomplished

You used the AI agent inventory in Microsoft Defender XDR to discover every AI agent operating across the Contoso environment—including 12 agents that business units created independently through Copilot Studio, none of which were on the security team's radar. The inventory provided a single view of agent names, product sources, associated identities, and initial risk signals.

From there, you assessed blast radius—the scope of resources, data, and capabilities accessible to each agent identity if compromised. By examining permissions, knowledge sources, and blueprint-defined actions, you identified which agents could cause limited, contained damage and which could cause organization-wide exposure. The HR agent's three-component blast radius—employee records, all-user profile data, and unrestricted email send capability—placed it at the top of the remediation list.

You also analyzed attack paths, following the structured paths that show how an attacker could move from a compromised agent identity to sensitive data or privileged operations. The analysis output isn't a theoretical risk model—it's a prioritized work order. Each attack path points to a specific permission, knowledge source, or action that can be removed to close it.

In this module, you learned how to:

- Discover AI agents in Microsoft Defender XDR using the AI agent inventory
- Assess the blast radius of agent identities by examining permissions, knowledge sources, and blueprint configuration
- Analyze attack paths that could result in unauthorized access if an agent identity is compromised

## What's next

You now have visibility into which agents exist and which present the greatest risk. The next step is adding real-time protection to the highest-risk agents operating in your environment. In the next module, you'll enable runtime protection for Copilot Studio agents using Microsoft Defender for Cloud Apps—intercepting and inspecting agent sessions in real time.
