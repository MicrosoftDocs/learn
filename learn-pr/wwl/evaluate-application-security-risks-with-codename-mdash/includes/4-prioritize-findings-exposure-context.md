After MDASH reports findings, Caldova needs a simple way to decide what to review first.

## Separate severity from confidence

**Severity** describes the possible impact of a vulnerability. MDASH uses Critical, High, Medium, and Low.

**Confidence** describes how certain the scanner is that the finding is real. MDASH uses Likely, Suspect, and Unlikely.

These values answer different questions. A critical finding can still need investigation. A likely low-severity finding can be real but less urgent.

MDASH organizes findings into three triage groups:

| Triage group | Meaning | Typical response |
|:--|:--|:--|
| Validated by AI scanner | The scanner has strong evidence for an important finding. | Assign it for remediation. |
| Flagged for review | The potential impact is high, but more evidence is needed. | Investigate it. |
| Low priority | The potential impact is lower. | Defer or schedule it according to policy. |

The following image shows findings grouped by severity with confidence and source-code information.

:::image type="content" source="../media/mdash-scan-findings.png" alt-text="Screenshot of a Codename MDASH scan summary showing critical and high findings with CWE identifiers, source-code locations, and likely confidence values." lightbox="../media/mdash-scan-findings.png":::

## Add application context

Severity and confidence don't tell the complete story. Reviewers also consider:

- Whether the finding is on the main branch.
- Whether the code is used in a deployed application.
- Whether an attacker can reach the affected feature.
- Whether the application handles sensitive data.
- Whether a newer scan still reports the issue.

For Caldova, business context changes the priority. A finding that exposes another customer's pharmacy order affects sensitive customer information. A finding that lets an attacker pause pharmacy operations can interrupt medication delivery. Both require more attention than an issue in unused test code.

This context helps teams avoid treating every code weakness as equally urgent. MDASH can connect findings with deployment information, but people still provide business context.

The Defender portal also shows findings across repositories. Teams can identify repositories with many recommendations or weakness types that appear repeatedly. These patterns can guide secure coding training or focused remediation work.

## Make a triage decision

Caldova uses four steps for an important finding:

1. **Review the evidence.**
2. **Check whether the affected code is exposed.**
3. **Consider the possible impact on customer orders and pharmacy operations.**
4. **Choose an action**, such as remediate, investigate, defer, or accept.

This process avoids two mistakes: treating every AI result as confirmed and ignoring every uncertain result. MDASH organizes the evidence, but security and engineering teams remain responsible for the decision.
