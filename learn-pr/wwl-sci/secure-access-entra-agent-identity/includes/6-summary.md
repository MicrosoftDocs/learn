Contoso Financial Services started this module with a landscape of agent identities running without access conditions—agents created months ago, still active, holding permissions beyond what their role required. By the end, the security team has a set of controls in place and a repeatable process for managing agent identity security going forward.

## Review what you accomplished

You mapped how agent identities authenticate to Microsoft services through the OAuth 2.0 client credentials flow and identified the key difference that shapes every control decision: agents authenticate non-interactively. They can't respond to MFA prompts or device compliance checks. That constraint focuses enforcement on Conditional Access workload identity policies—the mechanism designed for exactly this authentication pattern.

With that foundation, you created Conditional Access policies scoped to agent service principals. You used report-only mode to validate policy challenges before enforcement, targeted the specific service principals representing Copilot Studio agents, and set access conditions appropriate to each agent's risk level. The most important pattern: block policies for inactive or over-privileged agents are effective, reversible, and leave the identity record intact for audit purposes.

You also worked through the full lifecycle—from blocking creation of new agents by product, to monitoring the Microsoft Entra audit log for "Add service principal" events. The event indicates new agent creation, to configuring periodic access reviews that require business owners to confirm each agent should remain active. The result is a governance loop: creation is controlled, activity is visible, and continued access requires periodic validation.

In this module, you learned how to:

- Map how AI agents authenticate and identify where Conditional Access applies
- Configure Conditional Access policies scoped to agent identities
- Control agent access
- Manage agent identity lifecycle events

## What's next

You now have controls on agent identity access. The next step is assessing the risk those identities represent—specifically, how much damage a compromised agent could cause. In the next module, you'll use Microsoft Defender XDR to discover AI agents in your environment and assess their blast radius and attack paths.
