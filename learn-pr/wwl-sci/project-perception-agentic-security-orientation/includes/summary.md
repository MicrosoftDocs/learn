Project Perception's current agent catalog covers six areas of security operations work: threat intelligence analysis, alert triage, incident investigation, detection engineering, attack path analysis, and posture prioritization. Running those areas as separate human-paced projects can't keep up with machine-paced attackers who exploit the handoff gaps between them. Coordinated multi-agent defense runs the same areas of work as one continuous workflow at machine speed, with humans in control of critical decisions. Findings move across the coordinated workflow without manual handoffs between them, with humans still gating high-impact actions. Project Perception is Microsoft's implementation of coordinated multi-agent defense, exposed in the Microsoft Defender portal as **Perception**.

You now have the framework to reason about where Project Perception fits alongside the tools your SOC already runs.

In this module, you learned how to:

- Explain why human-paced security operations struggle to keep up with machine-paced attackers
- Describe how coordinated multi-agent defense runs those tasks as one continuous workflow, with Red team agents that identify weaknesses, Blue team agents that investigate and assess risk, and Green team agents that remediate and harden security posture
- Map Project Perception's named agents and playbooks onto that model, with each agent specialized in a primary area of security operations work and one additional Red team agent for externally facing web applications
- Recognize when a situation calls for a Project Perception playbook by identifying the areas of work involved and the shape of work required

One operational question drives the day-to-day work. When a situation arrives, name the areas of work it touches, count them, pick the likely shape (work that stays inside one area, a coordinated playbook across several areas, or both at once), and confirm an available agent or playbook supports the objective.

> [!TIP]
> **When a situation arrives, run this:**
>
> 1. **Name the areas of work.** Which of the six does the situation touch? Threat intelligence analysis, alert triage, incident investigation, detection engineering, attack path analysis, posture prioritization.
> 1. **Count them.** One, several that need coordination, or several with an analyst also working inside one.
> 1. **Pick the likely shape.** Work that stays inside one area, a coordinated playbook across several areas, or both at once.
> 1. **Confirm availability.** Check the **Playbooks** page in Perception for an agent or playbook that covers the objective and areas involved.

## Resources

- [Rethinking security for the age of AI (Microsoft Security blog)](https://blogs.microsoft.com/blog/2026/07/27/rethinking-security-for-the-age-of-ai/?azure-portal=true)
- [What is Project Perception?](/security/agentic-security/agentic-security-overview?azure-portal=true)
- [Get started with Project Perception](/security/agentic-security/agentic-security-get-started?azure-portal=true)
