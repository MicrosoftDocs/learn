Understanding what data security posture management (DSPM) is responsible for is only part of the picture. Risk evaluation depends on how posture is assessed across the environment and how that assessment changes over time.

DSPM doesn't rely on point-in-time checks or one-off scans. It builds its view of risk through continuous discovery and assessment, using signals that already exist across Microsoft Purview.

## Continuous discovery and assessment

Data environments don't stay still. Files are created, shared, moved, and reused. Access changes. New apps appear. AI accelerates all of this.

DSPM continuously assesses where sensitive data exists and how it’s being used. Instead of asking whether a scan ran or a policy fired, DSPM looks at what the environment looks like _now_ and how that picture changes over time.

This ongoing assessment is what allows DSPM to surface trends and shifts in exposure, not just isolated findings. Posture reflects patterns and conditions over time, not individual events or momentary findings.

## What "posture" represents in DSPM

In DSPM, posture represents the overall state of data risk and protection across the organization.

Posture isn't a compliance score and it's not a single metric. It's a composite view built from:

- The presence and location of sensitive data
- How broadly that data is accessible
- How it's being used
- Whether protections like labels and policies are applied consistently

This view helps you understand readiness and exposure at a higher level. Instead of reacting to individual events, posture supports decisions about where to focus effort and which risks deserve attention first.

## Metrics, trends, and prioritization

Because DSPM evaluates posture over time, it can surface metrics and trends that aren't visible when working inside individual tools.

These insights help answer questions like:

- Is exposure increasing or decreasing?
- Are protections improving in high-risk areas?
- Where are gaps persisting despite existing controls?

DSPM uses these signals to prioritize recommendations and actions. The goal isn't to surface everything that could be improved. The goal is to highlight what matters most based on current risk and potential exposure.

## Coverage gaps and prerequisites

What DSPM can evaluate depends on what's configured in the environment.

If auditing isn't enabled, certain activity signals won't be available. If devices aren't onboarded or policies aren't deployed, coverage will be incomplete. DSPM reflects these gaps clearly so it's apparent where visibility is limited.

This transparency is important. Posture insights are only as complete as the data behind them. DSPM doesn't hide missing coverage or infer what it can't see.

## AI interactions as a signal source

AI interactions introduce a different type of signal into posture evaluation.

Prompts and responses represent data in use, not data sitting at rest. Sensitive information might be shared, summarized, or transformed without creating a traditional file or triggering a familiar workflow. DSPM treats these interactions as signals that contribute to overall posture, not as a separate category of risk.

By including AI activity alongside more traditional signals, DSPM provides a clearer view of how sensitive data is actually being used across the environment.

## Why data in use matters for posture

Focusing only on data at rest leaves gaps in modern environments.

Risk increasingly comes from how data is accessed, shared, and reused, especially through AI-driven experiences. Posture evaluation needs to account for this active use of data, not just where it's stored or how it's labeled.

DSPM incorporates data in use into its posture model to support reasoning about exposure in environments where data is constantly moving and being acted on.
