Azure SRE Agent is most useful when a team can define a clear operational workflow, provide relevant evidence through supported connections, and govern the agent's access and actions. Use the following criteria to decide whether it fits your scenario.

## Use Azure SRE Agent when

Consider Azure SRE Agent when your team:

- Repeatedly correlates signals across Azure resources, observability tools, incident platforms, and source control.
- Needs faster, evidence-grounded incident investigation and a consistent path from diagnosis to verification.
- Performs recurring health, compliance, deployment, or reporting workflows that can be clearly scoped.
- Wants natural-language investigation across connected operational data.
- Needs to preserve synthesized incident findings and resolution patterns across team members or on-call shifts.
- Can assign least-privilege access, choose an appropriate run mode, and monitor agent activity.

Start with a bounded workflow whose success criteria are easy to measure. ReadOnly or Review mode and resource-level permissions can help a team evaluate investigation quality and control behavior before expanding scope.

## Consider another approach or delay adoption when

Azure SRE Agent might not be the right immediate choice when:

- A deterministic script or existing automation already handles a simple, stable operation reliably.
- Required tools or data sources can't be connected through a supported integration or custom MCP server.
- The organization hasn't approved the service's identity, networking, data retention, or regional configuration.
- The workflow can't tolerate an incorrect AI-generated conclusion and no meaningful human or technical control can be applied.
- The team lacks owners for permissions, integrations, instructions, extensions, and ongoing evaluation.
- Current language, regional availability, or cost requirements don't match the service. Consult the current product documentation because these conditions can change.

## Evaluate a pilot

Before broader adoption, define a pilot with:

- A recurring and measurable operational problem.
- The minimum resources, data sources, and permissions required.
- A run mode and approval path appropriate to the risk.
- Expected evidence, outputs, and verification steps.
- Measures such as investigation time, engineer effort, action accuracy, and successful verification.
- A review of audit telemetry, retained data, and failure cases.

Adopt the service more broadly only when the pilot demonstrates useful outcomes and acceptable control. Increase permissions or autonomy independently and gradually rather than treating adoption as a single all-or-nothing decision.
