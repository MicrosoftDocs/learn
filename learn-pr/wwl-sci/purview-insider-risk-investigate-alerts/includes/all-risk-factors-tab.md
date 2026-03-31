The **All risk factors** tab in Microsoft Purview Insider Risk Management provides a summary of potentially risky activity associated with an alert. This view helps investigators understand why an alert might be significant by showing which risk signals are present, even if those signals weren’t the direct cause of the alert.

Use this tab to evaluate the broader context of a user's behavior and decide whether to investigate further, dismiss the alert, or take action.

:::image type="content" source="../media/all-risk-factors-tab.png" alt-text="Screenshot showing the All risk factors tab in Microsoft Purview Insider Risk Management." lightbox="../media/all-risk-factors-tab.png":::

## Risk factors shown in this tab

The All risk factors tab surfaces several types of behavior that might increase a user's overall risk level:

- **Top exfiltration activities**: Lists the most frequent exfiltration actions, such as archiving or uploading files.
- **Cumulative exfiltration**: Shows whether repeated actions build over time to indicate rising risk.
- **Sequences of activities**: Highlights related activities that form a recognizable risk sequence.
- **Priority content**: Indicates whether the user interacted with files marked as sensitive or business-critical.
- **Unallowed domains**: Flags any file or data transfers to domains that aren't permitted by policy.
- **Unusual behavior or high-impact user status**: Detects abnormal patterns or identifies users whose role or access level contributes to elevated risk.

Not all alerts are directly caused by these factors, but the tab helps you assess what else might be happening that could influence the user’s risk level.

> [!TIP]
> Risk signals shown on this tab might not be the reason the alert was triggered. Always check the activity listed in the alert summary before deciding how to respond.

## Use the Content detected section

The **Content detected** section on this tab shows specific items involved in each risk activity. Selecting a listed item allows you to:

- View metadata such as file name, type, location, and sensitivity label if present
- Open the **Activity explorer** to see how that item fits into a broader timeline of activity

:::image type="content" source="../media/all-risk-factors-content-detected.png" alt-text="Screenshot showing the Content detected section of the All risk factors tab in Microsoft Purview Insider Risk Management." lightbox="../media/all-risk-factors-content-detected.png":::

This view helps you validate whether the behavior was risky and supports more informed decisions.

## Important behavior to understand

- **Risk factor summaries don't always match the trigger.** An alert might be triggered by access to priority content, but the tab could instead highlight unrelated risky browsing activity or sequences that increase concern.
- **Sequences can include excluded events.** Even if a file type is excluded from scoring, it can still appear in a sequence if it contributes to broader risky behavior. For example, a .png file might normally be excluded but still appears if used during an obfuscation attempt.
- **Use the Content detected section to investigate further.** This section links to Activity explorer, where you can view detailed events and associated content. It serves as a key entry point for deeper review.
