Microsoft Copilot for Security is accessible within Microsoft Purview data security solutions, including Data Loss Prevention (DLP), Insider Risk Management, Communicatoin Compliance, and eDiscovery (Premium), 

In this exercise, you explore the Copilot summarization capabilities availale in each of these solutions. You start by verifing that the Microsoft Purview plugin is enabled.

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

For this exercise you will work in both the standalone experience and the embedded experience.  Copilot standalone experience and Microsoft Copilot in Microsoft Purview.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is recommended that you open the link in a split screen window. To do so, select the right mouse key and select 'Open link in split screen window'.


#### Task: Enable the Microsoft Purview plugin

In this task you will enable the Microsoft Purview plugin.  For this task you will work in the standalone experience.  

1. Open the environment by selecting this link (use the right mouse key and select,'Open link in split screen window'): Microsoft Copilot for Security.  

1. From the Microsoft Copilot for Security landing page, select the sources icon in the promptbar.
    1. Expand the Microsoft plugins
    1. Scroll down so that the Microsoft Purview plugin is visible.
    1. Select the information icon. Note the instructions then close the plugins page.

1. Select the home menu (hamburger icon)
    1. Select owner settings.
    1. Enable the toggle for “Allow Copilot for Security to access data from your Microsoft 365 services.”

1. Now that you’ve enabled Copilot to access data from your M365 services, return to the plugins page and enable the Microsoft Purview plugin.

#### Task 2: 

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with a specific Microsoft Purview solution, users should have previously been assigned the required Purview role.

In this task, you, as an admin, will work in the Microsoft Purview portal to validate your role permissions for the Insider Risk Management role group.

1. Open the environment by selecting this link (use the right mouse key and select,'Open link in split screen window'): Microsoft Purview portal.

1. Select View all solutions, then select Settings.
1. Expand Roles and scopes, then select Role groups.
    1. Select Insider Risk Management and validate the user is listed in the role group.  
    1. Close the Insider Risk Management window.

1. From the left navigation panel, select Home to return to the landing page of the new Microsoft Purview portal.

1. Keep tihs browser tab open, you will use it for the next task.

#### Task 3: Gain comprehensive summary of Insider Risk Management alerts

In this task you'll explore the value Copilot provides in summarizing an Insider Risk Management alert. You start by first reviewing an alert, without Copilot for Security. It can be challenging to know where to start your investigation when risky activities are detected over a long period of time.  You'll then see how Copilot can address this same task with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Insider Risk Management solution, users should have previously been assigned an appropriate role.

1. From the Microsoft Purview portal, select Insider Risk Management.
1. Select Alerts

1. In the search bar, enter **86e52569**.  Select this alert.
    1. This alert deals with Potential data theft - Employee Departure. Under User details, you can gain more context on why the user was identified as a high impact user by selecting **View all details**.  Review the user details then select the **X** to close the User details window.
    1. The page is currently displaying all risk factors.  If you scroll down, there are even more details to consume! Including all of the risk factors for this user’s activity and the content detected in the alert.
    1. Select the **Activity explorer** tab, to quickly review a timeline of potentially risky activity and filter for specific risk activities associated with the alert. Select, the first activity on the list, labeled **Email sent to external recipient**.  Review the information provided then select **X** to close the window.
    1. Select the **User activity tab**. Here you view a scatter plot, over a 1 month, 3 month, or 6 month timeline; alongside details of each event – such as the user exfiltrated data one day before submitting their resignation.
    1. Clearly, there is a lot of insightful details to analyze!

1. With Copilot for Security, you can gain a comprehensive summary of an alert – in the single click of a button!  Select **Summarize**.
    1. This comprehensive summary provides key details, including alert severity, user details like their HR offboarding event and much more! 
    1. These summaries help accelerate investigations by helping you quickly gain context into user intent and timing of risky activities, enabling you to tailor your investigation with specific dates in mind and quickly pinpoint sensitive files at risk.

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal. 


#### Task: Gain comprehensive summary of Data Loss Prevention alerts.

In this task you'll explore the value Copilot provides in summarizing a Data loss prevention alert. As in the previous task, you start by first reviewing an alert, without Copilot for Security. You'll then see how Copilot can address this same task with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Data Loss Prevention solution, users should have previously been assigned an appropriate role.

1. Select **Data loss prevention**, then select **Alerts**

1. Investigating DLP alerts can be overwhelming due to the large number of sources to analyze, including apps, cloud services, email, endpoints and chat, and the varying rules and conditions of a policy.

1. Select the alert labeled, **DLP policy match for document cardholder transaction Log.xlsx in OneDrive**.
    1. The alert page opens to the **Details** page The details tab provides additional details, such as name of alert, location and user involved.  You can expand this view by selecting **View details**.
    1. Select the **Events** tab. For the selected event, you can view event details, impacted entities and more.
    1. Select the **Classifiers** tab.  Under classifiers, you can view the specific sensitive information types or trainable classifiers that were matched.
    1. You can also select File Activity.  There is lots of information to analyze.

1. Now view the information that Copilot can generate with the click of a button.
    1. Return to the Alerts page and select the same alert. **DLP policy match for document cardholder transaction Log.xlsx in OneDrive**.
    1. Select **Get a summary from Security Copilot**.
    1. This comprehensive summary provides key details, including policy rules, source, files involved and more. Additionally, the summary pulls the user risk levels from Insider Risk Management, providing integrated insights across data security solutions. These summaries provide you with a better starting point for further investigation.

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal.

#### Task: Gain contextual summary of Communication Compliance policy matches.

In this task you'll explore the capability of Copilot in Microsoft Purview Communication Compliance. Reviewing communication violations can be time-consuming, especially when reviewing lengthy content like meeting transcripts, email attachments, Teams attachments, or extensive text. Copilot can address this, and more, with the click of a button.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview Communication Compliance solution, users should have previously been assigned an appropriate role.

1. From the New Microsoft Purview portal, select **View all solutions**, then select **Communication Compliance**, listed under Risk & Compliance.

1. Select **Policies**.

1. Select **Regulatory compliance** policy to identify potential regulatory compliance violations.

1. From the list of violations triggered by the policy, select the Teams communication with the subject **Happy new year valued customers!** to expand the list.  Select the first item from the expanded view.

1. Communication Compliance is able to pinpoint the timestamps when a potential violation has occurred and highlight conditions matched, but there is still a good bit of text to read through.
    1. With Copilot for Security, you can gain a comprehensive summary of an alert in the single click of a button!  Select **Summarize**.  
    1. You can also ask follow up questions. Use copy/paste to enter **Does this violation indicate unauthorized disclosure?**

1. From the left navigation panel, select **Home** to return the Microsoft Purview portal.


#### Task: Gain contextual summary of evidence collected in eDiscovery review sets (Preview)

In this task you'll explore the capability of Copilot in Microsoft Purview eDiscovery (Premium). You start a search in eDiscovery, without Copilot for Security.

Microsoft Copilot assumes the permissions of the user when it tries to access the data to answer queries. To access data associated with the Microsoft Purview eDiscovery solution, users should have previously been assigned an appropriate role.

1. From the New Microsoft Purview portal, select **View all solutions**, then select **eDiscovery**, listed under Risk & Compliance.

1. Select **Cases**.
1. Select **Fabrikam vs Contoso**.
