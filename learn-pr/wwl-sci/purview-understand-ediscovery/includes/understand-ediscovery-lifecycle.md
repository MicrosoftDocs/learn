eDiscovery in Microsoft Purview follows a structured workflow designed to help legal, compliance, and security teams find and manage content relevant to an investigation. This process ensures that electronically stored information (ESI) is identified, preserved, and reviewed in a consistent and defensible way.

Here's a high-level overview of the eDiscovery workflow:

:::image type="content" source="../media/ediscovery-workflow.png" alt-text="Diagram illustrating the eDiscovery workflow from trigger event to case creation, search, holds, and review actions in Microsoft Purview." lightbox="../media/ediscovery-workflow.png":::

## Step 1: Start with a trigger event

Every eDiscovery case begins with a trigger event. This event could be a legal request, a regulatory inquiry, or an alert from another Microsoft Purview solution, like Insider Risk Management. Trigger events indicate that something needs deeper investigation, which prompts the creation of a new case.

## Step 2: Create and manage the case

A case brings together everything related to the investigation. It consolidates the searches, review sets, and any applied holds used throughout the lifecycle. You can also assign people to the case to control who has access. Microsoft Purview also supports integration with Insider Risk Management so you can escalate directly from a risk case to eDiscovery.

## Step 3: Search and evaluate content

With the case created, the next step is to run searches to find relevant content. You can search across Exchange, SharePoint, OneDrive, and Teams using keywords or other filters. Search statistics help refine results, and you can preview content to make sure you're capturing what matters. If needed, you can revise or rerun queries to adjust your results as the case develops.

## Step 4: Take action on search results

Once results are in, you have a few paths depending on the goals of the investigation:

- **Export content** if it's ready to be shared with legal or external reviewers.
- **Add content to a review set** if you need to organize, filter, or analyze it further.
- **Place a hold** on relevant content to preserve it during the investigation.

Holds can target full content locations or specific items based on a query. They help prevent deletion or changes while the case is ongoing.

## Step 5: Review and take action

Review sets are where deeper analysis happens. The investigation team can search within a review set, apply filters, tag items, redact sensitive information, or export selected content. You can also run analytics to reduce the volume of data and help prioritize what gets reviewed first.
