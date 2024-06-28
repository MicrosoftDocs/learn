Microsoft Copilot for Security is accessible within Microsoft Purview data security and compliance solutions, including Data Loss Prevention (DLP), Insider Risk Management, Communication Compliance, and eDiscovery (Premium).

In this exercise, you explore the Copilot summarization capabilities available in each of these solutions. You start by verifying that the Microsoft Purview plugin is enabled.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message will display stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature is not available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard. You have the Copilot owner role and you have specific role permissions required for access to each of the afore mentioned Microsoft Purview solutions.

You'll work with specific Microsoft Purview solutions, using the new Microsoft Purview portal, and access the embedded Copilot capabilities of those solutions.

This exercise should take approximately **30** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.


#### Task: Enable the Microsoft Purview plugin

In this task, you enable the Microsoft Purview plugin. For this task, you work in the standalone experience.

1. Open the simulated environment by selecting this link: **[Microsoft Copilot for Security]( https://app.highlights.guide/start/cccb66cb-3ca0-4d88-92dd-b6bee0f2c563?link=0&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**.

1. From the Microsoft Copilot for Security landing page, select the sources icon in the prompt bar.
    1. Expand the Microsoft plugins
    1. Scroll down so that the Microsoft Purview plugin is visible.
    1. Select the information icon. Note the instructions then close the plugins page.

1. Select the home menu (hamburger icon)
    1. Select owner settings.
    1. Enable the toggle for “Allow Copilot for Security to access data from your Microsoft 365 services.”
    1. To exit out of the manage sources window, select the **X**.
    1. Return to the Copilot home page, by selecting the home menu (hamburger) icon and selecting **Home**.

1. Now that you’ve enabled Copilot to access data from your Microsoft 365 services, return to the plugins page and enable the Microsoft Purview plugin.
    1. From the promptbar, select the **Sources icon**.
    1. From the manage sources window, under the Microsoft plugins, select **Show 11 more**.
    1. Enable the toggle switch next to Microsoft Purview to enable the plugin.
    1. Close the manage sources window by selecting the **X**.

#### Task: Gain comprehensive summary of Insider Risk Management alerts

For this and all subsequent tasks, you explore the Copilot functionality embedded in Microsoft Purview.

In this task, you explore the value Copilot provides in summarizing an Insider Risk Management alert. You start by first reviewing an alert, without Copilot for Security. It can be challenging to know where to start your investigation when risky activities are detected over a long period of time. You'll then see how Copilot can address this same task with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Insider Risk Management solution, the Copilot user should have previously been assigned an appropriate role.

1. Open the environment by selecting this link: **[Microsoft Purview Portal](https://app.highlights.guide/start/cccb66cb-3ca0-4d88-92dd-b6bee0f2c563?link=3&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**. A pop-up window appears that says, "Welcome to the new Microsoft Purview portal!"
    1. Select the box where it says **"This is a public preview. I agree to the terms of data flow disclosure, the preview section of the Product Terms, and Privacy Statements."**
    1. Select **Try now**.
    1. You can close the Explore all solutions pop-up by selecting the **X**. Alternatively, you can select Next to go through the information. If you go through all six information windows, you'll need to scroll-up to get back to the top of the page, when you're done.

1. From the Microsoft Purview portal, select **Insider Risk Management**.

1. Select **Alerts**.

1. Select the first alert on the list, alert ID: **86e52569**.
    1. This alert is associated with the policy, 'Potential data theft - Employee Departure.' Under User details, you can gain more context on why the user was identified as a high impact user by selecting **View all details**. Review the user details then select the **X** to close the User details window.
    1. The current page shows **All risk factors**. If you scroll down, there are even more details to consume.
    1. Select the **Activity explorer** tab, to quickly review a timeline of potentially risky activity and filter for specific risk activities associated with the alert. Select, the first activity on the list, labeled **Files accessed on SPO**. Review the information provided then select **X** to close the window.
    1. Select the **User activity tab**. Here you view a scatter plot, over a one month, three months, or six months timeline; alongside details of each event.

1. With Copilot for Security, you can gain a comprehensive summary of an alert – in the single click of a button! From the top of the alert page, select **Summarize**.
    1. This comprehensive summary provides key details, including alert severity, user details like their HR offboarding event and much more! 
    1. These summaries help accelerate investigations by helping you quickly gain context into user intent and timing of risky activities, enabling you to tailor your investigation with specific dates in mind and quickly pinpoint sensitive files at risk.

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal. You'll return to this page in the next task.

#### Task: Gain comprehensive summary of Data Loss Prevention alerts.

In this task, you explore the value Copilot provides in summarizing a Data loss prevention alert. As in the previous task, you start by first reviewing an alert, without Copilot for Security. You then discover how Copilot can address this same task with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Data Loss Prevention solution, users should have previously been assigned an appropriate role.

1. Select **Data loss prevention**, then select **Alerts**

1. Investigating DLP alerts can be overwhelming due to the large number of sources to analyze, including apps, cloud services, email, endpoints and chat, and the varying rules and conditions of a policy.

1. Select the alert labeled, **DLP policy match for document cardholder transaction Log.xlsx in OneDrive**.
    1. A side panel opens listing some details of this alert, including the alert status, severity, the DLP policy match, location, and user involved. From the bottom of the page, select **View details**. This opens a new browser tab.
    1. Select the **Events** tab. For the selected event, you can view event details, impacted entities and more.
    1. Select the **Classifiers** tab. Under classifiers, you can view the specific sensitive information types or trainable classifiers that were matched.
    1. You can also select File Activity. There's much information to analyze.
    1. Close this browser tab, but be sure to keep the 'Alerts|Microsoft Purview' tab open.

1. Now view the information that Copilot can generate with the click of a button.
    1. From the Alerts|Microsoft Purview tab, which is showing the side panel with information about the alert, select **Get a summary from Security Copilot**.
    1. This comprehensive summary provides key details, including policy rules, source, files involved and more. Additionally, the summary pulls the user risk levels from Insider Risk Management, providing integrated insights across data security solutions. These summaries provide you with a better starting point for further investigation.

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal. You'll return to this page in the next task.

#### Task: Gain contextual summary of Communication Compliance policy matches

In this task, you explore the capability of Copilot in Microsoft Purview Communication Compliance. Reviewing communication violations can be time-consuming, especially when reviewing lengthy content like meeting transcripts, email attachments, Teams attachments, or extensive text. Copilot can address this, and more, with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Communication Compliance solution, users should have previously been assigned an appropriate role.

1. From the New Microsoft Purview portal, select **View all solutions**, then select **Communication Compliance**, listed under Risk & Compliance.

1. Select **Policies**.

1. Select **Regulatory compliance** policy to identify potential regulatory compliance violations.

1. From the list of violations triggered by the policy, select the Teams communication with the subject **Happy new year valued customers!** to expand the list. Select the first item from the expanded view.

1. Communication Compliance is able to pinpoint the timestamps when a potential violation has occurred and highlight conditions matched, but there's still a good bit of text to read through.
    1. With Copilot for Security, you can gain a comprehensive summary of an alert in the single click of a button! Select **Summarize**.
    1. You can also ask follow-up questions. Use copy/paste to enter **Does this violation indicate unauthorized disclosure?**

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal. You'll return to this page in the next task.

#### Task: Gain contextual summary of evidence collected in eDiscovery review sets (Preview)

In this task, you explore the capability of Copilot to Microsoft Purview to gain a contextual summary of evidence collected in an eDiscovery review set.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview eDiscovery solution, users should have previously been assigned an appropriate role.

Let’s start by showing you how to review evidence collected in eDiscovery review sets, without Copilot for Security.

Legal investigations can take hours, days, even weeks to sift through the list of evidence collected in review sets, requiring costly resources like outside council to manually go through each document to determine the relevancy to the case.

1. From the New Microsoft Purview portal, select **View all solutions**, then select **eDiscovery**, listed under Risk & Compliance.

1. For this simulation, you're taken directly to the page for cases. From the cases page, select **Contoso stock manipulation**, then select the tab **Review sets**.

1. From the review sets page, open the review set listed **RS - Stock manipulation Teams conversation + cloud attachments**
    1. From the bottom of the Overview page, select **Open review set**.
    1. Using the filter, filter for Teams conversations:
        1. Filter - **File class**.
        1. Select an operator - **Equals any of**.
        1. Select Any -  **Conversation**.
    1. From the results, select item **#4**.
        1. Information about the conversation appears in the window to the right. **Scroll** to view the source history. There's quite a bit of text included in this teams conversation. It can be time-consuming to sift through the information.
        1. With Copilot for Security, you can gain a comprehensive summary of the conversation in the review set – in the single click of a button! Select **Summarize**. Copilot also provides prompt suggestions and the prompt bar for you to enter your own prompts in furtherance of the investigation. This helps you save time and conduct investigations more efficiently!

1. Refer back to the list of Teams conversations. This time, select item **#13** .
    1. The subject is displayed in a non-English language. This is common challenge with multi-national corporation whose employees speak various languages. The window with the source conversations shows a conversation history with non-English language. Select **Summarize** to view a summary in English, which is my default language for Copilot.
    1. Expand item 13 by selecting the **>**. Within Microsoft Teams, you can send cloud attachments, which are links to documents. The first item under the expanded view is an attached document. Select **Summarize** to. So you can see the attachment shared within the Teams chat is rather lengthy.

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal. You'll return to this page in the next task.

#### Task: Create Keyword Query Language (KeyQL) queries using natural language to search in eDiscovery (Premium)

In this task, you explore the capability of Copilot in Microsoft Purview eDiscovery (Premium) to create Keyword Query Language (KeyQL) queries using natural language. Users provide a prompt in natural language and Copilot generates a query in KeyQL language, making your search iterations faster and more accurate. This feature also enables analysts, at all levels, to conduct advanced investigations using KeyQL.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview eDiscovery solution, users should have previously been assigned an appropriate role.

1. From the New Microsoft Purview portal, select **View all solutions**, then select **eDiscovery**, listed under Risk & Compliance.

1. For this simulation, you're taken directly to the page for cases.
1. Select **Fabrikam vs Contoso**.
1. Select **Create a search**.
    1. Enter a search name.
    1. Enter a description.
    1. Select **Create**.
1. Add a data source
    1. Select **Add data sources**.
    1. In the search bar, enter **Sales**.
    1. From the search results, select **Sales**.
    1. From the bottom of the page, select **Save**.
1. Now use Copilot draft a query in natural language. Select **Draft a query with Copilot**.
    1. From the box labeled natural language prompt, select **View prompts**. This is a great starting point. You could look at suggested prompts to determine how to craft a natural language query for suggested prompts. For example, Find all emails containing the words budget and finance and have attachments.
    1. For this example, however, you know what you are looking for. You’ve been told that you need to find all conversations related to a recent acquisition. Use copy/paste to enter **Find all conversations that contain the keywords; acquisition, stock, Bitdefender, Frostvision, offshore**.
    1. When you enter your natural language prompt, you can have Copilot refine the query to ensure a more accurate query output. Select **Refine** then **Accept**.
    1. Select **Generate KeyQL**. Copilot for Security refines the prompt and then in a simple click, can generate the query within seconds!  
    1. The purpose of this exercise is to show how easily Copilot can generate the code for a query using natural language. In your production environment, running a query would simply require you to copy the KeyQL code into the run box and select run.

#### Review

With Microsoft Copilot in Microsoft Purview, data security and compliance admins can use the power of AI to assess risk exposure more quickly than is otherwise possible, directly from within Microsoft Purview solutions.

In this exercise, you explored the powerful functionality of Copilot to aid in your compliance investigations with DLP, Insider Risk Management, Communication Compliance, and eDiscovery.
