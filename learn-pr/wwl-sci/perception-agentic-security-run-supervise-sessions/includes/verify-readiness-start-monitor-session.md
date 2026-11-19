---
no_index_ks: true
---

A suitable playbook still needs the right input and access to do useful work. Check these before starting so a missing source or unavailable agent doesn't interrupt the analysis.

## Check the input, agents, and access

### Check the input and scope

Open the playbook details and check Required inputs and Agents. Confirm the article, incident, or subscription the team wants analyzed. Some playbooks, such as Plan for posture remediation, don't require an external source.

For threat-intelligence extraction, confirm that the selected URL points to the full technical article containing the indicators and attacker behaviors the team needs, rather than a brief summary.

For an environment assessment, check that the selected subscription includes the resources the team needs examined. Correct an input that prevents the requested analysis. If the team can use a narrower result, make that limit clear before proceeding.

### Confirm the agents are ready and you have access

Every participating agent must be configured and enabled. If a required agent is missing, disabled, or ready for setup, contact the Perception administrator before starting.

To start sessions, you need the Security Reader or Security Admin role and Run access to every participating agent. If you can't start or interact with the session, ask the administrator to check your execution, steering, and viewing access. See Playbook access requirements and Agent configuration settings.

### Check what data the agents can use

Your access doesn't give the agent access to the same resources. Its identity needs permission to read the data required for the work. Ask the administrator to resolve known access gaps before starting.

If a gap emerges during the session, record what couldn't be assessed. Missing device telemetry, for example, can leave part of an incident unexplained. It doesn't show that the device is free of threats.

## Start the session from Playbooks

To start Extract threat intelligence with an approved MDTI article URL:

1. In the Microsoft Defender portal, open Perception > Playbooks.
2. Select Extract threat intelligence and check Required inputs and Agents in its detail pane.
3. Select New session and provide the approved MDTI article URL as the required input.
4. Select Start session and confirm that the new session appears in Sessions. Open it.
5. In Inputs, confirm that the URL matches the approved article. If it doesn't, stop the incorrect session and start a new one with the approved URL.

Keep the article URL and session reference together so plan review, findings review, and handoff refer to the same work.

## Monitor what actually runs

Open the session from Perception > Sessions. In the Contents sidebar, use Tasks to inspect what the agents are doing. While work is In progress, routine updates don't require a response. Intervene when an agent needs a decision, reports missing data, or proposes work that might be unrelated or unauthorized.

When the session is Waiting for input, find the request in the session conversation. For extraction, the Threat Intelligence Agent pauses for review of its initial task plan. That pause is expected. Review and respond to the plan before allowing the analysis to proceed.

Use Inputs to check the selected source and Outputs to review generated files. In session views labeled Progress and Artifacts, review agent activity under Progress and generated reports under Artifacts. See Work with a session for the session layout and controls.

Use the activity record to distinguish what was planned from what actually ran. In a coordinated session, check each agent's contribution rather than relying only on the combined summary. A report might be available even though another agent's work failed.

When work finishes, review errors and missing contributions before using the output. If an agent reports failures, establish which findings depend on the missing work and keep those limits visible in the review.
