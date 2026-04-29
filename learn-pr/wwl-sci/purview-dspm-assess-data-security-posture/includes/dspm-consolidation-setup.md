Data Security Posture Management (DSPM) consolidates signals from data loss prevention (DLP), information protection, and Insider Risk Management into a single posture view organized around four questions:

- What sensitive data does the organization have?
- Where is that data stored?
- Who can access it?
- How is it protected?

These four questions structure everything you see in DSPM, from the dashboard metrics to the objectives to the discovery surfaces. Knowing the questions helps you read the tool with intent rather than browsing.

## How DSPM layers summary and detail

DSPM organizes this work from summary to detail, with each layer building on the one before it:

- **Posture dashboard**: High-level metrics and trends that answer the four questions at a glance.
- **Data security objectives**: Specific gaps broken down from those metrics and ranked by risk, so you know where to focus.
- **Discovery surfaces**: AI observability, asset explorer, and reports let you examine the underlying data, including which apps handle sensitive content, which assets lack labels, and how posture changes over time.

:::image type="content" source="../media/dspm-consolidation-layers.png" alt-text="Diagram showing DSPM layers from posture dashboard to objectives to discovery surfaces including AI observability, asset explorer, and reports." border="false":::

Start on the posture dashboard, then move into objectives and the discovery surfaces when you need detail.

When the posture dashboard highlights a gap, that signal originates from DLP, information protection, or Insider Risk Management data that DSPM aggregates. Understanding where signals come from helps you interpret what the dashboard shows and decide where to act first.

DSPM also surfaces AI-specific exposure through AI observability, AI-tagged reports, and Copilot-specific objectives. AI tends to widen exposure quickly, which is why those surfaces exist, but the assessment approach is the same one you use for exfiltration, labeling gaps, or insider risk: identify the gap, trace it to the source solution, and decide where it matters most.

## Enable analytics

DSPM depends on analytics from DLP and Insider Risk Management to produce its posture view. The first time DSPM is opened from **Solutions** > **DSPM (preview)** in the Microsoft Purview portal, a setup prompt asks to enable both. The initial scan can take up to three days to populate.

DSPM is a consolidation layer, not a source. The dashboard reflects what DLP and Insider Risk Management analytics produce. When those aren't running, an empty card looks identical to a card showing genuinely low activity. That ambiguity is the reason the enablement step matters for assessment, not just access. Reading the dashboard during the scan window without knowing this leads to the most common early misread: treating absence of data as evidence of low risk.

## Permissions

Confirm role assignment before assessing posture. Without the correct access level, parts of the surface either appear empty or don't appear at all.

- **Compliance Administrator or equivalent**: Full access, including settings and objective management.
- **Security Reader or Data Security Viewers**: Posture data without configuration controls.
- **Data Security Viewers**: Also the role gate for Security Copilot features inside DSPM.

For complete details, see [Permissions for Data Security Posture Management](/purview/data-security-posture-management-permissions?azure-portal=true).

Role scope changes what's visible, which means two people looking at the same tenant can see different metrics and different options. That matters whenever assessment work is shared. Reproducing a finding from a colleague's report, or comparing notes during a review, depends on both readers having a comparable view. A missing option usually reflects role boundary, not a missing feature.

## Security Copilot in DSPM

When Security Copilot is available in the tenant, it appears in three places inside DSPM:

- **Posture page**: Suggested prompts expand a metric into follow-up questions, such as which policies cover an affected workload or what activity occurred on sensitive data within a given time period.
- **Objective cards**: A Copilot button on each card supports questions like "what's driving this trend?" or "which workloads are most affected?"
- **Asset explorer**: The Posture Agent tab accepts natural-language descriptions instead of structured filters.

Assessment work moves between reading a signal and asking a follow-up question about it. What's driving a trend, which policies cover an affected workload, which assets are missing labels. The prompt boxes on the posture page and objective cards, along with the Posture Agent tab in asset explorer, are where those follow-up questions get asked.

> [!NOTE]
> Security Copilot inside DSPM requires the Data Security Viewers role group and provisioned security compute units (SCUs). Without SCUs, the prompts and the Posture Agent don't appear.
