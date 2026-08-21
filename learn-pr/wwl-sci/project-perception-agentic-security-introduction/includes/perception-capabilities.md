The previous unit walked through how Project Perception is built. This unit walks through what it does. Project Perception ships a broad set of capabilities across security operations. The sections that follow show the primary areas of security work those capabilities target in the current preview.

## Turn threat intelligence articles into structured intelligence

**The problem.** A new advisory about a threat actor arrives. Extracting the actor profile, ATT&CK techniques, indicators of compromise, and CVEs by hand takes hours. By the time an analyst finishes reading, the findings haven't moved anywhere useful.

**What Project Perception does.** Reads the threat intelligence article and produces structured intelligence objects: a threat actor profile, MITRE ATT&CK technique mappings, indicators of compromise, CVEs, and KQL hunting queries ready to run in Microsoft Defender. The advisory becomes a machine-readable brief in minutes, not a person's read notes at the end of a shift.

## Map how an attacker could move through your environment

**The problem.** Knowing an actor's techniques is half the picture. The other half is knowing whether your specific environment presents the paths those techniques exploit.

**What Project Perception does.** Performs read-only, attacker-style reconnaissance on the Azure environment it's scoped to. Identifies privilege paths, choke points, and exposure risks. The output is a map, not an action. Project Perception doesn't modify or interact with what it examines.

## Rank which fixes matter most

**The problem.** A large environment produces more posture findings than any team can act on. Every finding claims to be important. The question is which ones actually reduce risk right now.

**What Project Perception does.** Ranks security posture findings by real-world risk. Weighs severity, exploitability, active exploitation status, internet reachability, and asset criticality. When threat context is available from another capability, Project Perception factors in how each finding maps to the current adversary rather than a generic priority score.

## Reconstruct what happened in an incident

**The problem.** Reconstructing a tier-2 attack story means correlating alerts, signals, and entities across the environment. That's expert work, and it takes time an active response often doesn't have.

**What Project Perception does.** Correlates alerts and signals for a Microsoft Defender incident. Produces a verdict, a timeline, an attack graph, a list of affected entities, and recommended remediation actions. A tier-2-level investigation report is available at the start of the response rather than at the end.

## Author detection rules that match a specific threat

**The problem.** Generic ATT&CK coverage isn't the same as a rule that would catch this actor's specific technique in this environment. Generic rules also produce more noise than a stretched team can triage.

**What Project Perception does.** Transforms threat intelligence into implementation-ready KQL detection rules tailored to specific threat actor techniques. The output is a rule you can review and deploy, not another generic template.

## Test externally facing web apps the way an attacker would

**The problem.** Externally facing web apps are one of the fastest-moving attack surfaces you own. A code change or dependency update between scheduled pen tests can make an app newly exploitable, and the gap between tests is where real attackers get in.

**What Project Perception does.** Safely tests externally facing web apps for exploitable vulnerabilities using real attacker-style validation. The output is evidence of what a real attacker could reach and exploit in the current state of the app.

## These capabilities run coordinated in playbooks

The capabilities aren't isolated tools that each run on their own. A playbook coordinates a sequence of them, and the output of one capability becomes the input to the next.

The _Protect against a threat_ playbook is the canonical example. When a threat actor advisory arrives, the playbook composes four capabilities across all three teams into one workflow: a Blue team agent extracts structured threat intelligence from the advisory, a Red team agent maps how that actor could exploit your environment, a Green team agent ranks which findings to fix first, and another Blue team agent authors detection rules for the actor's technique. Each step's output flows into the next through shared context. That's the closed loop in practice: Red, Blue, and Green team agents contributing capabilities to one connected workflow because the playbook and shared context handle every handoff, not a person.

## Humans stay in control at high-impact decisions

Project Perception is designed to speed up analysts, not to replace their judgment. [Approval gates](/security/agentic-security/agentic-security-supervise-work?azure-portal=true) pause a playbook before high-impact actions. Every session is an [immutable, transparent record](/security/agentic-security/agentic-security-application-card?azure-portal=true#safety-components-and-mitigations) of what the agents did and why. Analysts can stop a session, review reasoning, and redirect an agent that's heading in an unintended direction.

## Where this leaves you

Project Perception's current capabilities cover the arc of a modern security response: understand the threat, map how it lands in your environment, decide what to fix first, reconstruct what happened, close detection coverage gaps, and validate that externally facing web apps aren't exploitable. Coordinated playbooks stitch them together. Approval gates and audit logs keep humans in control of the decisions that matter.
