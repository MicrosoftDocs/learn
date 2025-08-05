In this exercise, you investigate activity related to a departing employee who may have copied and archived sensitive content before their account was disabled. You'll review the alert, evaluate the user's actions, escalate the case, and examine the broader context in Microsoft Defender.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page might not be enabled and text-based inputs that fall outside of the specified script might not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

**Tasks:**

1. Investigate alert details and user activity
1. Create and escalate a case
1. Correlate incident data in Microsoft Defender

## Task 1 - Investigate alert details and user activity

In this task, you'll open a simulated version of Microsoft Purview to investigate an insider risk alert. You'll review the alert, examine user activity, and use built-in tools to summarize key behaviors.

Complete this task in the simulation: **[Open simulated Microsoft Purview portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=0&azure-portal=true)**.

1. In the [simulated Microsoft Purview portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=0&azure-portal=true), go to **Solutions** > **Insider Risk Management** > **Alerts**.

1. Select the alert titled *Potential data theft - Employee Departure* (Alert ID `4bdf001f`) at the top of the list.

1. On the **Alert details** page, review the risk indicators in the **All risk factors** tab. Select the cards to filter and explore activity in **Activity explorer**.

1. Select the **Activity explorer** tab. Use filters and the activity sequence to examine the user's actions, such as copying files, archiving data, or accessing personal services.

1. Select the **User activity** tab. Use the timeline filters and scatterplot to evaluate when activity occurred. Select activity bubbles or event links to view associated actions in **Activity explorer**.

1. In the Copilot pane, select:

   - **Show key actions performed by the user in the last 10 days**
   - **Summarize user's last 30 days of activity**

You have successfully reviewed the alert, explored user activity, and gathered context using both visual tools and Copilot summaries.

## Task 2 - Create and escalate a case

In this task, you organize your findings by creating a case and escalating it for further review in eDiscovery.

1. From the alert page, select **Confirm all alerts & create case**.

1. Enter the case name:
   `Employee departure - Data exfiltration`

1. Enter the case description:
   `Sensitive data copied and archived pre-departure. Theft suspected.`

1. Select **Done** to create the case.

1. Go to the **Cases** tab and select the new case.

1. On the **Case overview** page, review case details and alert context.

1. Select the **Alerts**, **User activity**, and **Content detected** tabs to review evidence. These tabs show the triggering activity, affected files, and detected information types.

1. Select **Case actions** > **Escalate for investigation**.

1. Enter the escalation case name:
   `Employee departure exfiltration investigation`

1. Enter the escalation note:
    `Sensitive data exfiltrated before departure. HR to review.`

1. Select **Save**, then select **Done** to complete the escalation.

1. Select **Resolve case**.

1. Set the resolution to **Confirmed policy violation**.

1. For **Action taken**, enter:
    `Confirmed exfiltration before departure. HR notified.`

You have successfully created, escalated, and resolved the insider risk case based on your investigation.

## Task 3 - Correlate incident data in Microsoft Defender

In this task, you'll switch to a simulated version of Microsoft Defender to review how the insider risk alert is connected to a larger incident. You'll explore the attack timeline, related alerts, and additional evidence across Microsoft 365 services.

Complete this task in the simulation: **[Open simulated Microsoft Defender portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=1&azure-portal=true)**.

1. In the [simulated Microsoft Defender portal](https://app.highlights.guide/start/d3e09027-0dbb-40cf-a5b9-8a08308a7350?token=16d48b6c-eace-4a1f-8050-098d29d23a89&link=1&azure-portal=true), go to **Incidents & response** > **Incidents & alerts** > **Incidents**.

1. Select **Add filter** > **Service/detection sources**, choose **Microsoft Insider Risk Management**, then select **Apply**.

1. In the search bar, enter `4bdf001f` and press **Enter**.

1. Select the incident titled **Exfiltration incident involving one user alert**.

1. On the **Attack story** tab, select **Play** to view the sequence of events. Select individual steps to explore how the incident progressed.

1. Select the **Alerts** tab to review related alerts tied to this user.

1. Explore the **Assets**, **Investigation**, **Evidence**, **Response**, **Summary**, and **Similar incidents** tabs to understand the scope and details of the incident.

You have successfully correlated the insider risk alert with a broader incident in Microsoft Defender, validating your investigation and supporting response actions across teams.
