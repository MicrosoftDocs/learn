The **Activity explorer** tab in Microsoft Purview Insider Risk Management helps analysts investigate the full context of potentially risky behavior. This tab shows a timeline of user activity that contributes to the alert, with detailed metadata to support investigation, filtering, and review.

Use this tab to confirm what triggered the alert and identify patterns or supporting evidence that indicate whether further action is needed.

:::image type="content" source="../media/activity-explorer-tab.png" alt-text="Screenshot showing the Activity explorer tab in Microsoft Purview Insider Risk Management." lightbox="../media/activity-explorer-tab.png":::

## Review activity details

Each row in the Activity explorer represents an event associated with the alert or broader user activity. Columns show details such as:

- Date and time of the event
- Activity type (for example, file download or risky prompt)
- File name and location
- Associated sensitivity label, if present
- Risk score and related risk factors

You can select an item to open the activity details pane and review:

- Event metadata, such as file path or recipient
- Assigned risk score
- Indicators that contributed to the risk level

This level of detail supports deeper investigation of user behavior.

## Filter activity for investigation

To help focus your review, use filters at the top of the page to narrow the activity list. You can filter by:

- **Activity scope**: Show all scored activity for the user or only activity associated with this specific alert
- **Risk factor**: Focus on specific indicators like sequences, cumulative exfiltration, unallowed domains, or priority content
- **Review status**: Hide previously reviewed items to focus on new activity

Filtering helps streamline triage and identify which events require the most attention.

## Customize the view

Customizing the view helps you focus on relevant attributes during triage. To match your investigation workflow, you can:

- Select or remove columns using **Customize columns**
- Sort the view by date or risk score
- Save custom filter and column views for reuse

These options help personalize the workspace so investigators can focus on what matters most.

## Understand activity count discrepancies

The number of activities shown in Activity explorer might not always match the number of raw event logs. Common reasons include:

- **Cumulative exfiltration detection**: Similar activities are deduplicated and scored as a single risk event
- **Policy changes**: If policy settings change after events occur, prior events might be excluded
- **Excluded items in sequences**: Files excluded from risk scoring might still appear if they're part of a larger sequence

These factors explain why sequences or exfiltration activity counts might differ between views.

## Investigate excluded items in sequences

Even when a file type is excluded from scoring, it might still show up in a sequence if it contributes to broader risk. For example, a .png file normally excluded from policy might appear in a sequence if it was used during an obfuscation attempt.

In these cases:

- A score of 0 appears for the excluded event
- Excluded events are marked as **Excluded** in the activity details
- A link is available to filter and view all excluded events

This helps you understand the full context of a user's behavior, even when individual events aren't scored directly.

## Save views for future use

If you create a useful filter and column setup, you can select **Save this view** to reuse it later. Saved views include both filters and column selections, allowing consistent triage workflows across analysts or alert types.

Select **Views** to load saved views at any time. Views can be personal or shared depending on how your team manages investigations.
