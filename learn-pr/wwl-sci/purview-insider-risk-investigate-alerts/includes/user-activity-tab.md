## Investigate ongoing risk with the User activity tab

The **User activity** tab in Microsoft Purview Insider Risk Management shows a visual timeline of potentially risky behavior over time. This view helps investigators assess whether a user’s activity is ongoing, escalating, or part of a broader pattern.

Use this tab to evaluate risk across multiple alerts and understand how individual actions fit into a larger risk profile.

:::image type="content" source="../media/user-activity-tab.png" alt-text="Screenshot showing the User activity tab in Microsoft Purview Insider Risk Management." lightbox="../media/user-activity-tab.png":::

## Identify patterns over time

This view uses colored bubbles to show activity categories and risk scores across a timeline. Bubbles represent distinct risk events. Select any bubble to open a details pane that includes:

- Date of the event
- Risk category (for example, Exfiltration or Obfuscation)
- Risk score
- Number of associated files or emails, with links for review

This visual layout makes it easier to spot repeated behaviors or concerning trends.

## Understand risk sequences

Sequences are shown with connecting lines between bubbles. These indicate related events that are part of a broader risk pattern. When a sequence is selected, the details pane includes:

- Name and date range of the sequence
- Combined risk score
- Total number of events and links to associated content

This view helps connect the dots between activities that might seem low-risk individually but are more significant together.

## Use the scatter plot to visualize risk patterns

The User activity tab includes a **color-coded scatter plot** that shows potentially risky activity over time. Each bubble represents a scored event. The vertical position indicates the risk score, and the horizontal position shows when the event occurred.

Use this visual timeline to:

- See when risk activity happened and how it changed over time
- Spot clusters or gaps in activity
- Identify risk sequences, shown with connecting lines and icons

## Filter and sort user activity

To focus your analysis, use the filters and sorting options at the top of the page:

- **Risk category**: Filter for sequences or high-risk events
- **Activity type**: Narrow to specific behaviors, such as AI usage or deletion
- **Date range**: View activity over 1, 3, or 6 months
- **Sort by**: Organize the timeline by risk score or event date
- **Review status**: Filter out activity that has already been reviewed

These filters make it easier to review large amounts of user activity.

## Interpret the full user timeline

The User activity tab provides a complete view of risk-assigned behavior:

- Shows events that span multiple alerts
- Displays cumulative exfiltration risk as a visual trend line
- Highlights sequences that include excluded file types if relevant to the risk pattern
- Uses a color-coded legend to categorize risk events

This comprehensive view supports better decision-making during investigations and case reviews.
