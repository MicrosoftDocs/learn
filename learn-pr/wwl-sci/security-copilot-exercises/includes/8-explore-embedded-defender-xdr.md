In this exercise, you investigate an incident in Microsoft Defender XDR. As part of the investigation, you explore the key features of Copilot in Microsoft Defender XDR, including incident summary, device summary, script analysis, and more. You also pivot your investigation to the standalone experience and use the pin board as a way to share details of your investigation with your colleagues.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::


### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. You work in Microsoft Defender, using the new unified security operations platform, to access the embedded Copilot capabilities in Microsoft Defender XDR. Towards the end of the exercise, you pivot to the standalone experience of Microsoft Security Copilot.

This exercise should take approximately **30** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Explore Incident summary and guided responses

1. Open the simulated environment by selecting this link: **[Microsoft Defender portal](https://app.highlights.guide/start/be8a91c3-3979-4048-ad38-fd38deaf7117?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. From the Microsoft Defender portal:
    1. Expand **Investigation & response**.
    1. Expand  **Incidents & alerts**.
    1. Select **Incidents**.

1. Select the first incident in the list, **Incident Id: 185856** named Human-operated ransomware attack was launched from a compromised asset (attack disruption).

1. This incident is complex. Defender XDR provides a great deal of information, but with 50 alerts it can be a challenge to know where to focus. On the right side of the incident page, Copilot automatically generates an **Incident summary** that helps guide your focus and response. Select **See more**.
    1. Copilot's summary describes how this incident evolved, including initial access, lateral movement, collection, credential access, and exfiltration. It identifies specific devices, indicates that the PsExec tool was used to launch executable files, and more.
    1. This information can be used for further investigation. You explore some of them in subsequent tasks.

1. Scroll down on the Copilot panel and just beneath the summary are **Guided responses**. Guided responses recommend actions in support of triage, containment, investigation, and remediation.
    1. The first item in the triage category it to Classify this incident. Select **Classify** to view the options. Review the guided responses in the other categories.
    1. Select the **Status** button at the top of the guided responses section and filter on **Completed**. Two completed activities show labeled as Attack Disruption. Automatic attack disruption is designed to contain attacks in progress, limit the impact on an organization's assets, and provide more time for security teams to remediate the attack fully.
1. Keep the incident page open, you'll use it in the next task.

#### Task:  Explore device and identity summary

1. From the incident page (under the Attack story tab), in the Alerts section, find and select the alert titled: **Suspicious RDP session**

1. Copilot  automatically generates an **Alert summary**, which provides a wealth of information for further analysis. For example, the summary identifies suspicious activity, it identifies data collection activities, credential access, malware, discovery activities, and more.

1. There's much information on the page, so to get a better view of this alert, select **Open alert page**. It's on the third panel on the alert page, next to the incident graph and below the alert title.

1. On the top of the page, is card for the device **parkcity-win10v**. Select the ellipses and note the options. Select **Summarize**. Copilot generates a **Device summary**. It's worth nothing that there are many ways you can access device summary and this way is just one convenient method. The summary shows the device is a VM, identifies the owner of the device, it shows its compliance status against Intune policies, and more.

1. Next to the device card is a card for the owner of the device. Select **parkcity\jonaw**. The third panel on the page updates from showing details of the alert to providing information about the user. In this case, *Jonathan Wolcott*, an account executive, whose Insider risk severity is classified as *High*. These details aren't surprising given what you learned from the Copilot incident and alert summaries. Select **Summarize** to obtain an identity summary generated by Copilot.

1. Keep the alert page open, you'll use it in the next task.

#### Task:  Explore script analysis

1. Let's Focus on the alert story. Select **Maximize ![maximize icon](../media/maximize-icon.png)**, located on the main panel of the alert, just beneath the card labeled 'partycity\jonaw' to get a better view of the process tree. From maximized view, you begin to get a clearer view of how this incident came to be. Many line items indicate that powershell.exe executed a script. Since the user Jonathan Wolcott is an account executive, it's reasonable to assume that executing PowerShell scripts isn't something this user is likely to be doing regularly.

1. Expand the first instance of **powershell.exe executed a script**. Copilot has the capability to analyze scripts. Select **Analyze**.
    1. Copilot generates an analysis of the script and suggests it could be a phishing attempt or used to deliver a web-based exploit.
    1. Select **Show code**. The code shows nested PowerShell modules and versions.

1. There are several other items that indicate powershell.exe executed a script. Expand the one labeled **powershell.exe -EncodedCommand...**. The original script was base 64 encoded, but Defender decoded that for you. For the decoded version, select **Analyze**. The analysis highlights the sophistication of the script used in this attack.

1. In the Copilot Script analysis, you have buttons for Show code and Show MITRE techniques

1. Select the **Show MITRE Techniques** button and select the link labeled: T1105: Ingress Tool Transfer

1. This opens the *MITRE | ATT&CK* site page describing the technique in detail.  

1. Close the alert story page by selecting the **X** (the X that is to the left of Copilot panel). Now use the breadcrumb to return to the incident. Select **Human-operated ransomware attack was launched from a compromised asset (attack disruption)**.

#### Task:  Explore file analysis

1. You're back at the incident page. In the alert summary, Copilot identified the file mimikatz.exe, which is associated with the 'Mimikatz' malware. You can use the file analysis capability in Defender XDR to see what other insights you can get. There are several ways to access files. From the top of the page, select the **Evidence and Response** tab.

1. From the left side of the screen select **Files**.
1. Select the first item from the list with the entity named **mimkatz.exe**.
1. From the window that opens, select **Open file page**.
1. Select the Copilot icon (if File analysis doesn’t automatically open), and Copilot generates a File analysis.
1. Review the detailed file analysis that Copilot generates.
1. Close the File page and use the breadcrumb to return to the incident. Select **Human-operated ransomware attack was launched from a compromised asset (attack disruption)**.

#### Task: Pivot to the standalone experience

This task is complex and requires the involvement of more senior analysts. In this task, you pivot your investigation and run the Defender incident promptbook, so the other analysts have a running start on the investigation. You pin responses to the pin board and generate a link to this investigation that you can share with more advanced members of the team to help investigate.

1. Return to the incident page by selecting the **Attack story** tab from the top of the page.

1. Select the ellipses next to Copilot's Incident summary and select **Open in Security Copilot**.

1. Copilot opens in the standalone experience and shows the incident summary. You can also run more prompts. In this case, you run the promptbook for an incident. Select the **prompt icon** ![prompt icon](../media/prompt-icon.png).
    <!--- 1. Select **See all promptbooks**. Not functional in the simulation -->
    1. Select the **Microsoft 365 Defender incident investigation** promptbook.
    1. The promptbook page opens and asks for the Defender Incident ID. Enter **185856**, then select the **Submit** button.
    1. Review the information provided. When you pivot to the standalone experience and run the promptbook, the investigation is able to invoke capabilities from a broader set security solution, beyond just Defender XDR, based on the plugins enabled.

1. Select the **box icon ![box icon](../media/box-icon.png)** next to the pin icon to select all the prompts and the corresponding responses, then select the **Pin icon ![pin icon](../media/pin-icon.png)** to save those responses to the pin board.

1. The pin board opens automatically. The pin board holds your saved prompts and responses, along with a summary of each one. You can open and close the pin board by selecting the **pin board icon ![pin board icon](../media/pinboard-icon.png)**.

1. From the top of the page, select **Share** to view your options. When you share the incident via a link or email, people in your organization with Copilot access can view this session. Close the window by selecting the **X**.

#### Task: Create and run a KQL query

Next, we'll use Copilot to help us create a KQL (Kusto Query Language) query to use with Advanced hunting in Defender XDR.

1. While still in standalone Security Copilot, enter the following prompt in the prompt form:
*Based on this incident, create a query to proactively hunt for this type of malware attack. Use the woodgrove-loganalyticsworkspace.*

1. Press the Submit prompt icon to run your prompt.
Copilot chooses Natural language to KQL for advanced hunting.

1. Copilot generates a KQL query and a response:

- **Read through the Explanation of the Kusto Query.**

- **Review the Breakdown of the Kusto Query.** This is very helpful if you’re just getting started with KQL.

1. Copy the KQL query Copilot generated and return to the Defender XDR portal.
*Note:* Copying the query into Notepad or another editor first can reduce formatting problems.

1. Defender XDR should still have the Investigations & response section open. Select **Hunting** and then **Advanced hunting** from the navigation menu.

1. In Advanced hunting, select the **New query +** to open a new window and paste the KQL query generated by Copilot into the form.
*Note:* You may need to make some edits to the query if there are errors. You may also need to adjust the time range if no results are found.

1. After running the KQL query, you can return to Copilot to refine the query or select the Copilot icon on the Advanced hunting query page to fine-tune hunting queries.

1. You can now close the browser tab to exit the simulation.

#### Review

This incident is complex. There's a great deal of information to digest and Copilot helps summarize the incident, individual alerts, scripts, devices, identities, and files. Complex investigations like this one might require the involvement of several analysts. Copilot facilitates this situation by easily sharing details of an investigation.
