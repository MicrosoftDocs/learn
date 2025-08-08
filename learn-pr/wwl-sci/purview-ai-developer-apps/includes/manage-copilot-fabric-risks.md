Copilot in Microsoft Fabric allows users to interact with data using natural language. In tools like Power BI, users can ask questions, generate reports, and summarize data without needing to write formulas or build visuals manually. These experiences are designed for productivity, but they can introduce risk if Copilot accesses sensitive content without proper controls in place.

Microsoft Purview supports retention, audit, and eDiscovery for Copilot in Fabric. These tools help you track activity and meet compliance needs across your environment.

> [!NOTE]
> Microsoft Purview doesn't currently enforce real-time DLP for Copilot in Fabric. DSPM provides visibility into Copilot activity, but not response blocking.

## Understand how Copilot in Fabric uses data

When users prompt Copilot in Power BI, the responses are based on datasets that might include sensitive or regulated information. While row-level security and dataset permissions still apply, Copilot can summarize or reference information in new ways. If underlying datasets aren't properly labeled or scoped, Copilot might return more than intended.

Sensitivity labels applied to Power BI datasets can influence how Copilot summarizes or references content. Maintaining consistent labeling across published data models helps reduce the risk of unintentional exposure.

Understanding which datasets Copilot can access and how that access is logged is key to managing these risks.

## Capture activity using DSPM collection policies

Data Security Posture Management (DSPM) for AI is the entry point for understanding how Copilot interacts with data across your environment. To bring Copilot in Fabric activity into Microsoft Purview, configure collection policies in DSPM for AI. These policies let you:

- Detect when Copilot is used in Fabric
- Capture prompts and responses for review
- Identify interactions that include sensitive data

Once collected, this content appears in **activity explorer**, where you can filter by user, prompt source, and time range. DSPM doesn't block the activity, but it gives you the information needed to evaluate whether a policy or classification update is required.

## Retain interactions for compliance and reporting

When logging is enabled in Fabric, prompt and response content can be retained using Microsoft Purview retention policies scoped to the **Microsoft Copilot Experiences** location.

> [!NOTE]
> While real-time policy enforcement isn't currently supported in Fabric, Microsoft Purview allows you to capture Copilot activity, assess risks, and investigate prompt data through logging, retention, audit, and eDiscovery.

Retention policies allow you to:

- Preserve interactions for a required duration
- Keep a record of interactions even if the underlying dataset changes
- Support regulatory, legal, or internal recordkeeping needs

This allows organizations to support investigations and ensure AI-generated content remains accessible.

## Use audit and eDiscovery for investigations

Logged Copilot activity in Fabric becomes available to **Microsoft Purview Audit** and **eDiscovery**, allowing you to review metadata, search interactions, and export content for legal or compliance purposes.

These tools support investigation needs even when more granular policy enforcement isn't available in Fabric.
