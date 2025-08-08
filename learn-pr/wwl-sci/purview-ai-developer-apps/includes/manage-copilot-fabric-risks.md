Copilot in Microsoft Fabric allows users to interact with data using natural language. In tools like Power BI, users can ask questions, generate reports, and summarize data without needing to write formulas or build visuals manually. These experiences are designed for productivity, but they can introduce risk if Copilot accesses sensitive content without proper controls in place.

Microsoft Purview supports visibility, lifecycle management, and investigation for Copilot interactions in Fabric. You can assess data risks, preserve prompt and response content, and respond to compliance requirements using retention, audit, and eDiscovery tools.

> [!NOTE]
> Microsoft Purview doesn’t currently enforce real-time data loss prevention (DLP) for Copilot in Fabric. DSPM provides visibility into Copilot activity, but not response blocking.

## Understand how Copilot in Fabric uses data

When users prompt Copilot in Power BI, the responses are based on datasets that might include sensitive or regulated information. While row-level security and dataset permissions still apply, Copilot can summarize or reference information in new ways. If underlying datasets aren't properly labeled or scoped, Copilot might return more than intended.

Sensitivity labels applied to Power BI datasets can influence how Copilot summarizes or references content. Maintaining consistent labeling across published data models helps reduce the risk of unintentional exposure.

Understanding which datasets Copilot can access and how that access is logged is key to managing these risks.

## Capture activity using DSPM collection policies

To bring Copilot in Fabric activity into Microsoft Purview, configure collection policies in Data Security Posture Management (DSPM) for AI. These policies let you:

- Detect when Copilot is used in Fabric
- Capture prompts and responses for review
- Identify interactions that include sensitive data

Once collected, this content appears in **activity explorer**, where you can filter by user, prompt source, and time range. DSPM doesn't block the activity, but it gives you the information needed to evaluate whether a policy or classification update is required.

## Retain interactions for compliance and reporting

If logging is enabled, prompts and responses from Copilot in Fabric can be stored in Exchange Online. You can apply Microsoft Purview retention policies to this content by selecting the **Microsoft Copilot Experiences** location when creating a policy.

> [!NOTE]
> Microsoft Purview doesn’t currently enforce real-time data loss prevention (DLP) for Copilot in Fabric. DSPM provides visibility into Copilot activity, but not response blocking.

Retention policies allow you to:

- Preserve interactions for a required duration
- Keep a record of agent activity even if the dataset changes
- Support regulatory, legal, or internal recordkeeping needs

This ensures that generated content isn't lost and can be reviewed later if needed.

## Use audit and eDiscovery for investigations

When Copilot activity is logged, it also becomes available in Microsoft Purview **Audit** and **eDiscovery**.

- In **Audit**, you can view metadata such as who used Copilot, when the prompt occurred, and what service was used. These events don't include prompt content but help establish timelines.
- In **eDiscovery**, you can search for stored interactions, filter by user or keyword, and export results for legal or compliance review.

These tools support investigation needs even when more granular policy enforcement isn't available in Fabric.
