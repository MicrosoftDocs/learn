---
no_index_ks: true
---

A request to enable an agent doesn't yet tell you what access to configure or how to test it. Confirm the approved task and intended users before assigning permissions.

## Define the task before configuring access

Establish these requirements with the requester and the people who need to use the agent:

| Requirement | What to establish |
| --- | --- |
| Requester | Who approves the task and any change to its scope. |
| Users | Who needs to use the agent and which actions they must perform. |
| Task | The required result and how the team intends to use it. |
| Agent and workflow | The supported playbook and agents needed to produce that result. |
| Input | The required source or resource and authorization to use it. |
| Access boundary | The agent's required data access and the actions each person is permitted to perform. |

For example, an approved task to extract reported indicators and attacker behaviors needs Extract threat intelligence and the Threat Intelligence Agent. It doesn't require Protect against a threat or the other agents in that broader workflow. Microsoft manages the playbooks, so select a supported workflow rather than trying to edit its participating agents.

Choose a known input with the security practitioner for testing. For extraction, use an approved technical article with a few source facts to check, such as an indicator and an attacker behavior. Retain the source reference and supporting passages for comparison with the output.

## Confirm the prerequisites

Check the chosen agent's current prerequisites before setup. For the Threat Intelligence Agent, these include:

- **Environment**: Access to the Microsoft Defender portal and Perception preview, with unified role-based access control (RBAC) enabled across Defender workloads.
- **Services**: Microsoft Defender XDR availability and Microsoft Defender Threat Intelligence (MDTI) access for full threat-intelligence data and enrichment.
- **Access and authority**: Security Admin for setup, Security Reader and access to run the agent for the security practitioner, and a process for obtaining any missing role or permission grants. One person can hold more than one responsibility.

The agent also needs API permissions during setup. Confirm both service availability and permission grants.

Use the [Threat Intelligence Agent prerequisites](/security/agentic-security/threat-intelligence-agent?azure-portal=true) to confirm the current requirements before configuration.

## Agree on what the test must show

Agree on observable results, not just an enabled status. For an extraction capability, suitable criteria are:

- The intended security practitioner can start Extract threat intelligence with the selected article.
- The security practitioner can review and respond to the initial task plan.
- The agent processes the selected source. No unresolved access failure blocks the task.
- The security practitioner can open and download the report.
- The report contains the agreed source facts and supporting references.
- The required enrichment capability is available to the agent. Enrichment for individual indicators depends on the data the service provides.

For example, a test record might confirm the identity and grants, successful session start, and a usable report, but omit the security practitioner's response to the initial plan. Record plan response as Not tested until the security practitioner demonstrates it with their own account. Use the observed result to decide whether access needs correction.

## Start the setup record

Keep requirements, configuration checks, and test evidence in the team's case, ticket, or shared work area. The following headings provide a reusable structure:

```
Approved task, source, known facts, and acceptance criteria:
People who need access and their required actions:
Agent identity and API grants:
Service and scoped-resource checks:
Security practitioner role and agent settings:
Validation session, report, and results:
Readiness, limits, owners, and retest triggers:
```

Record the approved task, test input, expected results, criteria, and people who need access before setup. Mark checks you haven't performed as Pending, then add evidence as you configure and test. Mark a check as passed only when the evidence supports it.
