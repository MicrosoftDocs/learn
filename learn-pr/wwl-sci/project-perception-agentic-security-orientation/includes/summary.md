Project Perception's current agent catalog covers six areas of security operations work: threat intelligence analysis, alert triage, incident investigation, detection engineering, attack path analysis, and posture prioritization. Running those areas as separate human-paced projects can't keep up with machine-paced attackers who exploit the handoff gaps between them. Coordinated multi-agent defense runs the same areas of work as one continuous workflow at machine speed, with humans in control of critical decisions. Findings move across the coordinated workflow without manual handoffs between them, with humans still gating high-impact actions. Project Perception is Microsoft's implementation of coordinated multi-agent defense, exposed in the Microsoft Defender portal as **Perception**.

You now have the framework to reason about where Project Perception fits alongside the tools your SOC already runs.

In this module, you learned how to:

- Explain why human-paced security operations struggle to keep up with machine-paced attackers
- Describe how coordinated multi-agent defense runs those tasks as one continuous workflow, with Red team agents that identify weaknesses, Blue team agents that investigate and assess risk, and Green team agents that remediate and harden security posture
- Map Project Perception's named agents and playbooks onto that model, with each agent specialized in a primary area of security operations work and one additional Red team agent for externally facing web applications
- Recognize when a situation calls for a Project Perception playbook by identifying the areas of work involved and the shape of work required

When a situation arrives, distinguish work that benefits from focused agent-supported execution from work that requires coordination across several capabilities. The number of security areas involved helps describe scope, but doesn't determine the tool choice. A focused Perception agent or playbook can support one area, while a need spanning several areas still requires a supported, suitable option.

> [!TIP]
> **When a situation arrives, run this:**
>
> 1. **Name the objective and areas of work.** What outcome does your organization need, and which security areas does it touch?
> 1. **Assess execution and coordination needs.** Would focused agent support help, or do several capabilities need connected handoffs?
> 1. **Confirm support and feasibility.** Check whether Perception offers a supported agent or playbook for the objective and whether its requirements and authorized scope can be met.
> 1. **Choose the response that fits.** Use existing analyst tools, a focused agent or playbook, a coordinated playbook, or a combination. If a prerequisite is missing, resolve it or use existing workflows.

## Resources

- [Rethinking security for the age of AI (Microsoft Security blog)](https://blogs.microsoft.com/blog/2026/07/27/rethinking-security-for-the-age-of-ai/?azure-portal=true)
- [What is Project Perception?](/security/agentic-security/agentic-security-overview?azure-portal=true)
- [Get started with Project Perception](/security/agentic-security/agentic-security-get-started?azure-portal=true)
