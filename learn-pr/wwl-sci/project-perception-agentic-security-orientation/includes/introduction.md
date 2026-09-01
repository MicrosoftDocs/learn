> [!IMPORTANT]
> Some information in this module relates to a prereleased product which may be substantially modified before it's commercially released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. Project Perception is currently in Limited Public Preview. Limited Public Preview Program means Perception is available to a small, invitation-only set of customers for a defined preview window before broader public availability.

A new threat advisory arrives. Somewhere in the estate, a novel actor is described using techniques your organization hasn't fully mapped. Three questions land at the same time:

- Are we exposed?
- Where?
- What should we do first?

Answering those questions spans several areas of work your SOC treats as separate projects. Machine-paced attackers exploit the _gaps between_ those areas. Handoffs across tickets, tools, and specialist schedules take days, and attackers who iterate faster than a specialist can open a ticket don't wait for handoffs to finish. This is the shape of security work in the AI era, and it's what Project Perception is built to change.

Project Perception is an agentic security system that coordinates specialized agents across the areas of work your team already runs. You access it in the Microsoft Defender portal's **Perception** section.

Before you move into setup and operational guidance for Perception, you need to know what it coordinates, how those areas of work connect, and when a coordinated playbook is the right response. Step-by-step setup and playbook walkthroughs sit in the [Project Perception documentation](/security/agentic-security/agentic-security-get-started?azure-portal=true).

For a shorter introduction to what Project Perception is and where it fits, see the [What is Project Perception?](/training/modules/project-perception-agentic-security-introduction/?azure-portal=true) module. You can take either module first.

In this module, you will:

- Explain why human-paced security operations struggle to keep up with machine-paced attackers
- Describe how coordinated multi-agent defense runs those tasks as one connected workflow, handled by Red, Blue, and Green team agents
- Map Project Perception's agents and playbooks onto that model
- Recognize when a situation calls for a Project Perception playbook by identifying the areas of work involved and the shape of work required

## Learning prerequisites

- Day-to-day familiarity with security operations concepts such as alerts, investigations, threat intelligence, and vulnerability management
- High-level familiarity with the Microsoft Defender portal and Microsoft Defender XDR workflows
- Basic familiarity with AI agents that act on a user's behalf

## Technical prerequisites

You don't need any of the following to complete this module. Before your team can run Project Perception in Perception, you'll need:

- Access to the Microsoft Defender portal
- [Unified role-based access control (URBAC)](/defender-xdr/manage-rbac?azure-portal=true) enabled across Microsoft Defender workloads, with each workload activated for the agents you want to run
- Workload-specific licenses per agent, for example Microsoft Defender XDR, Microsoft 365 E5, or Microsoft Entra ID P2, depending on which agent
- **Security Admin**, **Run**, or **Viewer** access assigned per agent inside Perception

Each agent's specific prerequisites, including workload activations, product plans, and API permissions, sit in the [Project Perception documentation](/security/agentic-security/agentic-security-agents?azure-portal=true).
