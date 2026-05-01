Data loss prevention (DLP) and Insider Risk Management generate alerts based on the same sensitive data activity you trace through Data Security Posture Management (DSPM). Two triage agents, one for DLP and one for Insider Risk Management, automatically categorize those alerts by priority and can take automated actions like removing sharing links or revoking permissions. While you're investigating activity patterns in DSPM, these agents are responding to the alerts that activity generates.

That parallel creates a question DSPM is well-positioned to surface. Are the triage agents getting it right? If your DSPM investigation reveals a pattern, but the corresponding alerts were categorized as "Less urgent," the agents may not be weighing risk correctly for your organization. That gap is what you're looking for.

## What triage agents are

Microsoft Purview provides two triage agents:

- **DLP triage agent**: Categorizes DLP alerts based on sensitivity risk, exfiltration risk, and policy risk
- **Insider Risk Management triage agent**: Categorizes IRM alerts based on user risk, file risk, and activity risk

Both agents place alerts into one of three groups: "Needs attention," "Less urgent," or "Not categorized." They provide explanations for each categorization, which makes it possible to evaluate whether the reasoning matches your context.

Beyond categorization, the agents can take automated actions on detected risks, including removing public sharing links, applying DLP policies, and revoking permissions. These actions happen without manual approval, so their appropriateness is also something you need to verify.

## How DSPM connects to triage agent decisions

DSPM surfaces signals that can indicate triage agents aren't performing as expected:

- **The Data investigation metric** on the posture page shows what percentage of alerts have been triaged. A low percentage means alerts are accumulating without agent response.
- **Activity patterns that don't match alert priority**: If DSPM investigation surfaces a concentrated exfiltration pattern for a user, but the corresponding DLP alerts were categorized as "Less urgent," the agent's risk weighting may not match your organizational context.
- **Automated actions visible in objectives**: The **View agent activity** option in data security objectives shows what actions triage agents took, when they took them, and what triggered them. If you're investigating an event in DSPM and notice the agent already acted on it, you can evaluate whether that action was proportionate.
- **Security Copilot alert summaries**: Security Copilot in DSPM can surface alert context and user risk profiles, giving you the data to cross-reference against what the triage agent decided.

The investigation flow is: DSPM surfaces a concern → you check whether existing alerts match what you're seeing → you evaluate whether triage agents handled those alerts appropriately.

## When triage agent decisions need attention

Common situations where DSPM investigation reveals a governance gap:

- You see a sustained activity pattern in reports, but corresponding alerts were consistently marked "Less urgent" because the agent assessed each one individually without connecting the pattern
- An automated action removed access that DSPM activity data shows was legitimate for that user's role
- A high-risk agent or user shows repeated sensitive data interactions in AI observability or activity explorer, but alert categorization doesn't reflect that cumulative risk
- The agent categorized an alert based on label sensitivity, but your organizational context assigns different business importance to that data than the label implies

In each case, DSPM gave you the evidence. The governance step is taking that evidence to the triage agent's categorization and evaluating whether it made the right call.

## Providing feedback and reviewing actions

When you identify a mismatch between what DSPM shows and how the triage agent responded:

- **For categorization disagreements**: Select **Is this incorrect?** on the triage agent's categorization in DLP or IRM to provide feedback. This improves future categorization for your organization.
- **For automated action concerns**: Review the action scope and outcome through **View agent activity** in DSPM objectives. Determine whether the action was proportionate to the risk DSPM evidence shows.

Triage errors affect which alerts get your attention first. Automated action errors affect operations directly. Both deserve review, but automated actions demand closer scrutiny because their impact is immediate.

## Scope of this governance work

The detailed mechanics of how each triage agent works, the specific panels and fields in DLP and IRM dashboards, and the full procedural workflows for managing triage agents belong in DLP and IRM focused content. From a DSPM investigation perspective, the skill is recognizing when your investigation evidence contradicts automated decisions and knowing how to act on that contradiction.
