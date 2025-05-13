Microsoft Security Copilot is accessible within Microsoft Purview data security and compliance solutions, including Data Loss Prevention (DLP), Insider Risk Management, Communication Compliance, and eDiscovery (Premium).

In this exercise, you explore the Copilot summarization capabilities available in each of these solutions. You start by verifying that the Microsoft Purview plugin is enabled.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page might not be enabled and text-based inputs that fall outside of the specified script might not be supported. A pop-up message displays stating, "This feature isn't available within the simulation." When this message occurs, select OK and continue the exercise steps.  
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::
>
> Also, Microsoft Security Copilot was previously referred to as Microsoft Copilot for Security. Throughout this simulation, you might find that the user interface still reflects the original name.

## Exercise

For this exercise, you're logged in as Avery Howard. You have the Copilot owner role and the specific role permissions required to access each of the Microsoft Purview solutions used in this exercise.

You work with specific Microsoft Purview solutions, using the new Microsoft Purview portal, and access the embedded Copilot capabilities of those solutions.

This exercise should take approximately **30** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, open the link in a new browser window. This allows you to view the instructions and the exercise environment at the same time. To do so, select the right mouse key and select the option.

<!--- 

Note: I didn't script in this section to Zarmada, but it still feels relevant. Please leave in if this is still relevant to the lab.

--->
### Task: Enable the Microsoft Purview plugin

In this task, you enable the Microsoft Purview plugin. For this task, you work in the standalone experience.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/6fca2b1c-bf14-4c26-9eda-48be3c0b5013?token=045faae1-1078-4eac-bf56-e12472eddaf9&link=1&azure-portal=true)**.

1. From the Microsoft Security Copilot landing page, select the **Sources icon** ![sources icon](../media/sources-icon.png) in the prompt bar.
    1. From the manage sources window, under the Microsoft plugins, select **Show 11 more**.
    1. Scroll down so that the Microsoft Purview plugin is visible.
    1. Select the **Information icon** ![screenshot of information icon](../media/information-icon.png). Note the instructions then close the plugins page by selecting the **X** on the top-right corner of the manage sources window.

1. Select the **Home menu** ![screenshot of the home menu icon](../media/home-menu-icon.png), often referred to as the hamburger icon.
    1. Select **Plugin settings**.
    1. Enable the toggle switch next to **Allow Security Copilot to access data from your Microsoft 365 services**.
    1. Return to the Copilot home page, by selecting **Microsoft Security Copilot** on the top-left of the page next to the home menu (hamburger) icon.

1. Now that Copilot is enabled to access data from your Microsoft 365 services, return to the plugins page and enable the Microsoft Purview plugin.
    1. From the prompt bar, select the **Sources icon**.
    1. From the manage sources window, under the Microsoft plugins, select **Show 13 more**.
    1. Enable the toggle switch next to Microsoft Purview to enable the plugin.
    1. Close the manage sources window by selecting the **X**.

### Task: Investigate risky activity using Security Copilot

For this and all subsequent tasks, you explore the Copilot functionality embedded in Microsoft Purview.

In this task, you investigate an alert related to potential data exfiltration. You begin by reviewing the alert manually to identify key risk indicators, then use **Security Copilot** to accelerate your investigation. In particular, you look for file activity related to **EmployeeInfo_EDM.csv**, which contains sensitive employee information and was involved in exfiltration events.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Insider Risk Management solution, the Copilot user must be assigned an appropriate role.

1. Open the environment by selecting this link: **[Microsoft Purview Portal](https://app.highlights.guide/start/6fca2b1c-bf14-4c26-9eda-48be3c0b5013?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**. A pop-up window appears that says, "Welcome to the new Microsoft Purview portal!"
    1. Select the box where it says **"This is a public preview. I agree to the terms of data flow disclosure, the preview section of the Product Terms, and Privacy Statements."**
    1. Select **Try now**.
    1. You can close the Explore all solutions pop-up by selecting the **X**. Alternatively, you can select Next to go through the information. If you go through all six information windows, you need to scroll-up to get back to the top of the page, when you're done.

1. From the Microsoft Purview portal, **Solutions** > **Insider Risk Management** > **Alerts**.

1. Select the first alert on the list with alert ID **ad18a3a1**.

1. Review the alert:
   1. Check the alert name, associated policy, severity, and risk score. Review when the alert was triggered and why.
   1. Open **User details** to view the user profile, including group membership and priority status. Then close the panel.
   1. In the **All risk factors** tab, look at exfiltration activity, sequence activity, priority content, and sensitive info types.
   1. Select the **Activity explorer** tab and examine key events around the alert date.
   1. Use the **User activity** tab to review patterns in user behavior across a broader time range.

1. Use **Security Copilot** to guide deeper review:
   1. From the alert page, select **Summarize** to generate a quick summary of the alert and the user's recent behavior.
   1. In the Copilot pane, select the predefined prompt **Summarize user's last 30 days of activity**.
   1. When the summary loads, select **View activity** to open the full user activity view.
   1. In the left pane, select **Unusual activities**.
   1. Expand the first sequence activity listed for **February 25, 2025**.
   1. Select the **2 events** link to view the actions included in that sequence.
   1. Find the entry for **EmployeeInfo_EDM.csv**. Expand the details and review the associated actions for this file.

### Task: Review data loss prevention policy insights using Security Copilot

For this task, you explore how Security Copilot can help identify strengths and gaps in your Data Loss Prevention (DLP) policy coverage.

In large environments, it can be difficult to quickly assess whether existing policies provide the necessary coverage across locations, data types, and organizational boundaries. Security Copilot can surface insights and help you focus your attention where it matters most.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Loss Prevention** > **Policies**.

1. Scroll through the list of DLP policies to get a sense of how many policies exist and how they're named. These might represent different locations, classifications, or business units.

1. Select **Copilot** > **Get insights on existing policies**.

1. When the Security Copilot pane opens, review the **General insights** shown by default.

1. Explore each insights category:
    1. Select **Insights by location**, then choose **Exchange**. Review the insights displayed.
    1. Repeat this process for **Endpoint**.
    1. Select **Insights by Administrative units** and review the results.
    1. Select **Insights by Classification of data** and review the results.

1. At the bottom of the Copilot pane, select each of the predefined prompts to run them and review the responses.

1. In the Copilot input field, type **Are there any gaps based on the policies I currently have created?** and review the answer provided.

Use these insights to understand how your current DLP policies are distributed and whether they align with your organization's data protection needs. Review the results to identify any opportunities to improve coverage.

### Task: Investigate data loss prevention alerts using Security Copilot

In this task, you use Security Copilot to investigate a DLP alert and examine user activity and sensitive information involved in the alert. You explore different views available in the alert pane and use predefined Copilot prompts to guide your investigation.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Loss Prevention** > **Alerts**.

1. Scroll through the alert list and select the alert for **DLP policy match for document 'POS-Leavers_0325.xlsx' on a device**.
1. When the alert opens:
    1. Review the tabs for **Details**, **Events**, and **User activity summary**.
    1. The Security Copilot pane should open. Use it to investigate the alert further.

1. On the **Details** tab:
    1. Scroll through the alert details.
    1. Select **Summarize** > **Summarize alert**.
    1. Review the generated summary in the Copilot pane.

1. In the Copilot pane, select the prompt **What activity was performed on the data in this alert?** and review the response.

1. Next, select the prompt **Describe the sensitive info, file labels, or data triggering this alert** and review the results.

1. Back on the **Details** tab:
    1. Select **Summarize** > **Summarize user activity** to generate a summary of related user actions.

1. In the Copilot pane:
    1. Select **Show key actions performed by the user in the last 10 days**.
    1. Review the user activity for broader context.

1. Go to the **Events** tab and view the file that triggered the alert.

1. Go to the **User activity summary** tab:
    1. Scroll through to view any related insider risk activities.

Use this information to build a clearer picture of what triggered the alert, how sensitive data was handled, and whether user behavior suggests further review is needed.

### Task: Investigate eDiscovery cases and build a query using Security Copilot

In this task, you explore how Security Copilot supports case investigation and query creation in Microsoft Purview eDiscovery. You start by reviewing a case summary, then create a custom search to locate files labeled as confidential and shared externally.

In this scenario, you're assisting with a case investigating the possible exposure of confidential data. Multiple searches are already added to the case as part of an initial review. Your role is to use Security Copilot to help summarize case details, analyze activity, and build a more targeted search.

1. In the Microsoft Purview portal, go to **Solutions** > **eDiscovery** > **Cases**.

1. On the **Cases** page, select **Sensitive content review**.

1. At the top of the case page, select **Summarize this case**.

1. The Security Copilot pane opens with a summary of the case. Review the generated content.

1. In the Copilot pane, select the predefined prompts:
   1. **How many hold policies in this case have errors?**
   1. **Which hold policies in this case have errors?**

   The response should confirm that no hold policies are associated with the case, and therefore, no hold policies have errors.

1. Based on the case summary and current findings, you're asked to search for confidential files that might be shared externally. To begin this part of the investigation, select the **Create a search** button.

1. Name the search **Confidential data search**.

1. Under the query input, select **Draft a query with Copilot**.

1. Explore the available options in the Copilot promptbook. You can select each option and choose **Generate KeyQL** to view how the query is built.

1. In the query input box, type **Search for files marked as confidential that were shared with external users.**

1. Select **Generate KeyQL** to convert the prompt into a query.

Once your query is generated, continue the investigation by reviewing the search results. Identify files that match your criteria and determine whether they need to be added to a review set or exported for further examination.

This task shows how Security Copilot can support your investigative process by summarizing key details and offering relevant prompts. It also helps construct searches that reflect the scope of the case.

## Review

In this exercise, you used Security Copilot to support investigations in Microsoft Purview. You reviewed insider risk alerts, explored DLP policies and alerts, and worked with an eDiscovery case.

Each task showed how Copilot can help summarize information, identify patterns, and guide the next steps. You used built-in prompts and natural language input to focus your investigation and gather relevant context.

These actions reflect how Copilot can assist with common tasks across data security and compliance workflows.
