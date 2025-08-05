In this exercise, you investigate activity related to a departing employee who might have copied and archived sensitive content before their account was disabled. You review the alert, evaluate the user's actions, escalate the case, and examine the broader context in Microsoft Defender.

**Tasks:**

1. Investigate alert details and user activity
1. Create and escalate a case
1. Correlate incident data in Microsoft Defender

## Task 1 - Investigate alert details and user activity

In this task, you review the insider risk alert and analyze the user's activity using key investigation tools.

1. In Microsoft Purview, go to **Solutions** > **Insider Risk Management** > **Alerts**.

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

In this task, you use Microsoft Defender to view how the insider risk alert contributes to a broader security incident.

1. In **Microsoft Defender**, go to **Incidents & response** > **Incidents & alerts** > **Incidents**.

1. Select **Add filter** > **Service/detection sources**, choose **Microsoft Insider Risk Management**, then select **Apply**.

1. In the search bar, enter `4bdf001f` and press **Enter**.

1. Select the incident titled **Exfiltration incident involving one user alert**.

1. On the **Attack story** tab, select **Play** to view the sequence of events. Select individual steps to explore how the incident progressed.

1. Select the **Alerts** tab to review related alerts tied to this user.

1. Explore the **Assets**, **Investigation**, **Evidence**, **Response**, **Summary**, and **Similar incidents** tabs to understand the scope and details of the incident.

You have successfully correlated the insider risk alert with a broader incident in Microsoft Defender, validating your investigation and supporting response actions across teams.
