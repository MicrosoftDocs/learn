In this exercise, you investigate a data loss prevention (DLP) alert triggered by activity in a user's OneDrive. You review the alert in Microsoft Purview, analyze sensitive content exposure, and explore the correlated incident in Microsoft Defender.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. Some links might not be enabled, and text inputs outside the scripted flow might not work. If a message appears stating "**This feature is not available within the simulation**," select **OK** and continue with the next step.
>
> :::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

**Tasks:**

- Investigate the DLP alert in Microsoft Purview
- Correlate incident data in Microsoft Defender

## Task 1 - Investigate the DLP alert in Microsoft Purview

In this task, you open a simulated version of Microsoft Purview to investigate a DLP alert triggered by a OneDrive file. You review policy matches, examine sensitive content details, and use Copilot to summarize the user's recent activity.

Complete this task in the simulation:
**[Open simulated Microsoft Purview portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=0&azure-portal=true)**

1. In the [simulated Microsoft Purview portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=0&azure-portal=true), go to **Solutions** > **Data Loss Prevention** > **Alerts**.

1. Select the alert titled **DLP policy match for document 'spreadsheet_2.xlsx' in OneDrive** (Alert ID `d24edfcb-1d7f-c8e8-3a00-08dd8f3aa543`).

1. On the **Alert details** page, select **View details**. A new tab opens showing the alert event in detail.

1. In the new tab, use the **Details**, **Classifiers**, **File activity**, and **Metadata** tabs to investigate the alert.

   Look for clues that explain why this activity triggered a DLP policy. For example, review the type of sensitive data involved, how it was classified, and when or how the file was accessed or modified. When you're done, select the **Overview** tab to see a summary of the alert, including the matched policy, severity, and user involved.

1. After reviewing the alert details, return to the original DLP alert tab by closing the current tab or selecting the first tab in your browser.

1. In the alert pane, select the **User activity** tab. Scroll through and expand the sequence of actions to view related user behavior.

1. In the Copilot pane, review the summaries to understand how the alert was triggered and what actions were taken on the file. Use this information to support your investigation.

You have successfully reviewed the DLP alert, examined sensitive content exposure, and used Copilot to summarize user activity.

## Task 2 - Correlate incident data in Microsoft Defender

In this task, you switch to a simulated version of Microsoft Defender to view how the DLP alert is correlated with a broader security incident. You explore the attack story, investigate supporting evidence, and review all related alerts.

Complete this task in the simulation:
**[Open simulated Microsoft Defender portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=1&azure-portal=true)**

1. In the [simulated Microsoft Defender portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=1&azure-portal=true), go to **Incidents & response** > **Incidents & alerts** > **Incidents**.

1. Select **Add filter** > **Service/detection sources**, then select **Add**.

1. In the filter, choose **Microsoft Data Loss Prevention**, then select **Apply**.

1. In the search bar, enter `spreadsheet` and press **Enter**.

1. In the results, expand each alert in the **Alerts** section to review the details.

1. Review each alert in the list by selecting it.

1. At the top of the incident page, review the **Severity** and **Status** to get a sense of how critical the incident is and whether it's still active.

1. On the incident page, start with the **Attack story** tab. Review the sequence of alerts and their relationships in the **Incident graph**. This helps show how the events are connected.

1. Select the **Assets** tab to view which users and services were involved in the incident. Confirm that the incident involved a OneDrive file and a specific user account.

1. In the **Summary** pane on the right, review the Copilot-generated **Incident summary** to get a narrative overview of what happened.

1. Select the **Investigations** tab. It might be empty in this simulation. In a real environment, this section would show automated investigation results or analyst-initiated actions.

1. Select the **Evidence and response** tab. Like the Investigations tab, this section might not contain any entries in this simulation.

You have successfully correlated the DLP alert with a broader incident in Microsoft Defender and identified supporting evidence across multiple sources.
