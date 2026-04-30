Not every protection gap is the same kind of problem. A gap where an entire category of sensitive data has no data loss prevention (DLP) coverage needs a different response than a gap where a few specific SharePoint sites are overshared. The first needs a rule applied broadly. The second needs targeted fixes at the item level.

## Where remediation lives in Data Security Posture Management

Data Security Posture Management (DSPM) organizes remediation around objectives. Each objective groups a category of risk with the actions available to address it. When you open an objective, you see:

- Risk indicators showing what's exposed
- Outcome metrics showing the current protection state
- Remediation pathways you can act on directly

Objectives cover areas like oversharing, exfiltration, Copilot exposure, and data discovery.

You don't need to leave the objective to remediate. DLP policies, sensitivity labels, Insider Risk Management policies, and data risk assessments are all available from within the objective's workflow.

## Two types of remediation

DSPM offers two fundamentally different ways to close a gap, and picking the wrong one either over-applies controls or misses the actual problem.

**Policy-based remediation** creates rules that apply consistently across a defined scope. One-click policies let you build DLP, sensitivity label, or Insider Risk Management policies directly from an objective. These work best when the gap is broad, such as sensitive data that exists without any DLP coverage or Copilot accessing content that no restriction policy protects. The policy applies a rule everywhere, regardless of individual items.

**Item-level remediation** identifies specific files, sites, or items that are overshared and lets you fix each one directly. Data risk assessments surface oversharing conditions across SharePoint sites, OneDrive locations, and Fabric workspaces, including:

- Anonymous or external sharing links
- Missing sensitivity labels
- Broad access beyond what's necessary

Targeted actions like removing a sharing link or applying a sensitivity label address each instance. This works best when the problem is concentrated rather than widespread. Data risk assessments are specific to the "Prevent oversharing" objective and don't apply to exfiltration or Copilot exposure gaps.

:::image type="content" source="../media/select-remediation-approaches.png" border="false" alt-text="Diagram showing broad coverage gaps mapping to one-click policies and concentrated oversharing mapping to data risk assessments.":::

## Matching the gap to the pathway

| Risk condition | Recommended pathway | Why |
| --- | --- | --- |
| Category-wide coverage gap, like no DLP for a sensitive information type | One-click policy | The gap is broad and needs a rule applied consistently |
| Oversharing in specific SharePoint sites, OneDrive locations, or Fabric workspaces | Data risk assessment | The problem is concentrated and needs item-level fixes |
| AI interactions surfacing protected content | Copilot-specific one-click policy | The objective's workflow scopes a DLP policy to Copilot interactions |
| Multiple complementary gaps across objectives | Multiple pathways | Some gaps need both a broad policy and targeted fixes |

## Confirming it worked

Outcome metrics update after you apply remediation. Coverage percentages shift, trends change direction, and risk indicators reflect the new state. If you apply a policy and the metrics don't improve, that's a signal. Either the policy scope doesn't match the actual gap, or the gap requires a different type of action. A DLP policy prevents future sharing violations, but it doesn't retroactively remove existing anonymous links. That kind of gap still needs item-level remediation even after the policy is active.
