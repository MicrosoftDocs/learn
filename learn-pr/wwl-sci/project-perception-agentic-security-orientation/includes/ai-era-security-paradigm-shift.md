Your SOC still does everything it did before. Threat intelligence analysts still write actor profiles. Detection engineers still author rules. Attack-path specialists still map exposures. So why can't a well-run SOC keep up with today's attackers?

## The attacker side is running at machine speed

[The physics of cybersecurity are changing](https://blogs.microsoft.com/blog/2026/07/27/rethinking-security-for-the-age-of-ai/?azure-portal=true). Autonomous systems can now reason, adapt, and operate continuously, and the cost of offensive operations is falling. Attackers generate exploits faster and scale campaigns further than human-paced tooling was designed to counter. When the attacker's tooling adapts during the intrusion and iterates faster than a SOC can respond, purely static patterns, known-signature detection, and human-paced tuning can't keep up on their own.

## Where machine-paced attackers gain their advantage

In many SOCs, different specialists own different areas of work and use different tools. Each specialist moves quickly inside their own area, and automation or SOAR platforms already speed up work there. What lengthens the wall clock is coordination between specialists: findings sit in ticket queues, wait for schedules, and move through email threads before the next specialist can pick them up.

A threat intelligence analyst can produce a good actor profile in an hour. The profile then waits for the attack-path specialist's queue, then the detection engineer's queue, then the posture engineer's queue. **By the time the whole workflow finishes, the advisory is often days old and the attacker has moved**.

Machine-paced attackers exploit exactly those handoff gaps. They iterate through reconnaissance, exploit, and lateral movement faster than those handoffs can propagate a single new advisory across the SOC. The specialist work itself is right. What has to change is running each area as a _separate project_.

## Where analyst hours go inside each area

Handoffs between areas aren't the only place time gets lost. Inside each area, mechanical prep work sits alongside judgment work: pulling the same signals from the same tools, running the same lookup queries, packaging findings so the next area can pick them up. That prep is necessary, but it isn't judgment work.

The judgment work is different. An experienced analyst asks whether a finding is real, whether it changes the risk picture, and whether the recommended action fits the environment. Those decisions need human judgment, not tool speed. The more time goes to prep, the less remains for judgment, and decisions run on incomplete inputs.

## How coordinated multi-agent defense works

**Coordinated multi-agent defense runs your existing security operations as one coordinated workflow.** Specialized agents do the tactical work inside each area. A shared context layer lets each agent read what the previous one produced without waiting for a ticket. An orchestration layer sequences the work for each playbook, running steps one after another, in parallel, or looping back based on what earlier steps produced. Humans stay in control of critical decisions through approval gates woven into the workflow.

Threat intelligence output flows straight into attack path analysis without a queue. Attack path analysis flows straight into posture prioritization. Work that used to move across separate human-paced projects, each waiting on the previous specialist's queue, now closes as one machine-speed workflow.

That workflow also shifts where analyst attention lands. Agents carry the mechanical prep between the steps, so analyst hours go to the judgment calls, not to the prep work around them.

## Red, Blue, and Green team agents

Project Perception labels its agents as [Red team, Blue team, or Green team](/security/agentic-security/agentic-security-agent-categories?azure-portal=true) agents, based on the kind of work each does. Coordinated multi-agent defense uses those team labels as its top-level structure, and you'll see them named this way in the product itself. Agents and playbooks live under the **Agents** and **Playbooks** pages of Perception, and the team label appears on each agent.

:::image type="content" source="../media/project-perception-red-blue-green.png" alt-text="Diagram that shows three agent teams: Red identifies weaknesses, Blue investigates and assesses risk, Green remediates and hardens." lightbox="../media/project-perception-red-blue-green.png":::

| Team | Primary areas covered | What SOCs already call this |
| --- | --- | --- |
| **Red team agents**: identify weaknesses | Attack path analysis | Automated pen testing, breach and attack simulation, or purple team exercises. Asks "if an attacker targeted us with these techniques, what paths would they exploit?" If your organization doesn't run this as a daily practice, this team's work will likely feel the least familiar. |
| **Blue team agents**: investigate and assess risk | Threat intelligence analysis, alert triage, incident investigation, detection engineering | Where most day-to-day security operations already live. |
| **Green team agents**: remediate and harden | Posture prioritization and remediation ranking | Close to the vulnerability management and exposure management practices you might already run. Answers "what should we fix first, and why?" |

Each Project Perception agent carries a team label (Red, Blue, or Green) and a primary area of work, and its playbooks connect sequences of work across all three teams.

## Where this leaves you

Coordinated multi-agent defense runs your existing security operations as one connected workflow, handled by Red, Blue, and Green team agents, with humans in control of critical decisions. Project Perception's agents and playbooks map directly onto that shape.
