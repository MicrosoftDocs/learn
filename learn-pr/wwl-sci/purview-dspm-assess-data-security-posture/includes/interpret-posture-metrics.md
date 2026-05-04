The **Posture** page in Data Security Posture Management (DSPM) is where you assess the organization's data security state at a glance. The dashboard answers four questions: how well is sensitive data identified, how broadly is it protected, how quickly are alerts handled, and whether things are getting better or worse. Each signal is partial on its own. Assessment depends on reading them in combination.

## Key posture metrics

Start by identifying the biggest coverage gaps and how wide they are.

Three metrics each represent a different dimension of coverage, and each has a 30-day trend indicator:

- **Data discovery**: The percentage of classified and labeled assets. Low coverage here limits every downstream control that depends on labels.
- **Data protection**: The percentage of activities covered by data loss prevention (DLP) policies. Low coverage means sensitive data exists in locations where no policy restricts what happens to it.
- **Data investigation**: The percentage of data protection alerts triaged. Low coverage here means alerts are accumulating without review, which delays incident response.

Read the percentage and the trend together. For example, a card at 41% with an upward arrow means coverage is climbing from a worse starting point. The same 41% trending down means coverage that used to be higher is slipping. The number reflects current coverage. The arrow shows direction of change.

Pair the cards too. The combinations point to different root causes:

- **Low discovery + low protection** is a compounding problem. Data that isn't classified is harder to protect with policies. Both classification and policy scope need attention simultaneously.
- **High discovery + low protection** means labels are being applied but DLP policies haven't been extended to match. The gap is specifically in policy scope, not classification.

:::image type="content" source="../media/interpret-posture-metrics-key-metrics.png" alt-text="Screenshot showing three posture metric cards for discovery, protection, and investigation, each with a percentage and a 30-day trend arrow.":::

## Data snapshot

The data snapshot shifts focus to where risk concentrates and whether data is leaving the organization.

The data snapshot divides assets into two groups based on recent access. Stale content hasn't been accessed recently, and fresh content has. Within each group, the snapshot shows labeled versus not labeled, alongside recent exfiltration trends. The assessment logic depends on the combination.

Fresh data with high exfiltration activity is the most immediate concern. Actively used content is leaving the organization. If that data is also unlabeled, DLP policies likely aren't covering it. Stale data with exfiltration activity is a different signal. Someone is accessing archived content they might not need, which warrants investigation.

A large volume of unlabeled fresh data means the content people work with daily lacks the sensitivity labels that DLP and access controls depend on. That's a gap that affects every protection policy downstream.

The snapshot reflects only what DSPM can see based on enabled analytics and connected data sources. Workloads that aren't producing analytics data don't appear. Absence from the snapshot doesn't confirm absence of risk.

:::image type="content" source="../media/interpret-posture-metrics-data-snapshot.png" alt-text="Screenshot showing the data snapshot split into stale and fresh assets, with labeled versus unlabeled counts and a 30-day exfiltration trend.":::

## Posture trends

Trends are most useful when you compare them against actions you've taken. If a trend shifted without a corresponding action, that's worth investigating.

The posture trends graph tracks risk indicators across the same monthly window. The graph itself is less valuable than the habit of reading it against known actions. Three patterns matter:

- **A flat line near zero followed by recurring spikes** suggests a new or intermittent risk that existing policies don't address.
- **A sharp spike coinciding with a known organizational event** has a likely explanation, but validate it before dismissing it.
- **A sustained upward trend without a corresponding policy change** signals that something shifted in the data estate without a matching response.

Flat trends after action are equally important. A new policy deployed two weeks ago should show some movement in the relevant indicator. If the line stayed flat, the policy is likely scoped too narrowly or targeting the wrong content. Flat lines after action deserve investigation just as much as unexpected spikes.

:::image type="content" source="../media/interpret-posture-metrics-posture-trends.png" alt-text="Screenshot showing the posture trends graph with a flat exfiltration line and a sharp spike at the end of the window.":::

## Top objectives to protect sensitive data

The dashboard also surfaces the highest-priority objectives based on risk, providing a quick read on which gaps are urgent before the full objectives view is opened. Reading and prioritizing those objectives in detail is covered next.

## Trace metrics to their source

Every metric on the dashboard originates from a specific source solution. Labeling coverage gaps come from information protection, policy coverage gaps come from DLP, and risky user behavior indicators come from Insider Risk Management. When a metric shows a gap, the source identifies which team or control to engage next and prevents misdirected investigation. Spot the gap on the dashboard, trace it to the source, and hand it to the right owner.
