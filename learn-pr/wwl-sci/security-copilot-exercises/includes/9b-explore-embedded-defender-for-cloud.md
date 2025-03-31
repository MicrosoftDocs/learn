In this exercise, you explore real world scenarios that highlight the benefits and value of Security Copilot in Defender for Cloud.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message will display stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature is not available within the simulation.":::
>
> Also, Microsoft Security Copilot was previously referred to as Microsoft Copilot for Security. Throughout this simulation, you'll find that the user interface still reflects the original name.

### Exercise

As an Azure Security Engineer at a global enterprise, you’re tasked with protecting virtual machines that support critical business functions. Recently, monitoring tools flagged two issues:

1. Exposed Management Ports: Several VMs had open RDP and SSH ports, creating easy targets for brute-force attacks. Defender for Cloud advises that management ports should be closed on your virtual machines.
1. Unresolved Vulnerabilities: Routine scans uncovered vulnerabilities on certain machines that could be exploited by attackers, making it essential to resolve these issues.

This exercise should take approximately **30** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task

Your tasks in this exercise are to address the identified security findings—exposed management ports and unresolved vulnerabilities—using Microsoft Security Copilot, integrated with Defender for Cloud. You will:

- Analyze with Copilot and review recommendations to understand the risks posed by exposed management ports.
- Assess with Copilot and review insights to determine the impact of unresolved vulnerabilities.
- Examine with Copilot and follow guided steps to update NSG rules for improved protection.
- Evaluate Workflow Automation by reviewing how a Logic App triggers automated remediation workflows.

1. Open the simulated environment by selecting this link: **[Microsoft Azure](https://app.highlights.guide/start/XXXXXXXXXXXXXXXXXXXXXX&azure-portal=true)**.
1. From the Azure portal, navigate to Microsoft Defender for Cloud using one of the following methods:
    - From the Azure services page, select the hamburger menu icon, scroll down the list, and select the **Microsoft Defender for Cloud** icon.
    - From the Azure services page, under "Azure services," select the **Microsoft Defender for Cloud** icon.
    - From the Azure services page, under "Navigate," select the Microsoft Defender for Cloud icon.
    - From the Azure services page, in the "Search resources, services, docs (G + /)" window,” type **Defender for Cloud** and press Enter.

1. Navigate to the **Recommendations** section.
1. In the Title list, select **Management ports should be closed on your virtual machines**.
1. In the top left area of the page, under the Resource section, select **woodgrove-srv1**.
1. Under Overview, scroll down and expand **Networking** then select **Network settings** under **Rules** and review the inbound port rules.
1. Navigate back to Microsoft Defender for Cloud by either:
    1. Selecting the back arrow in the top left area of your browser, or
    1. Selecting the Microsoft link at the top of your page that reads **Management ports should be closed on your virtual machines**
1. In the lower right area of the page, under **Tactics & Techniques**, select the **Read more** link on the right side of Initial Access. Review the MITRE ATT&CK Initial Access techniques. After reviewing, select the **X** at the top of the page to close the MITRE | ATT&CK page.
1. In the lower right area of the page, under Tactics & Techniques, select the **External Remote Services** link on the right side of Initial Access. Review the MITRE ATT&CK Initial Access techniques. After reviewing, select the **X** at the top of the page to close the MITRE | ATT&CK page.
1. Select the **Graph** tab and examine each attack path to gain a detailed view of how an attacker might navigate your environment. Once you have identified the priority areas, switch to the **Take Action** tab to review the step-by-step guidance for addressing those specific vulnerabilities.
1. Under the **Remediate** and **Quick Fix** sections, select **Learn more** to open the **Remediate recommendation** page. After reviewing, close the Remediate recommendations page to return to the recommendation for **Management ports should be closed on your virtual machines**."
1. Under the **Fix** button, select **Learn more** in **Understanding just-in-time (JIT) VM access**. After reviewing that page, close the Just-In-Time VM access page to return to the recommendation for **Management ports should be closed on your virtual machines.**"
1. Select **Summarize with Copilot**.
1. Review the Copilot-generated recommendation summary that explains the risks and vulnerabilities.
1. Under **Workflow Automation**, select the Trigger Logic App button to review how to trigger a logic app.
1. Under **Trigger a Logic App** and the **Select the logic app** section, select **Learn more** to review how to automate remediation responses. After reviewing, select the **X** at the top of the page to close it, then select the **X** at the top right corner to close the Trigger a Logic App page.
1. Select **Summarize with Copilot**.
1. Review the Copilot-generated recommendation.
1. Select **Help me remediate this recommendation**.
1. Review the Copilot-generated remediation script. After reviewing, select the **X** in the top right corner to close the page.
1. Under the **Take Action** tab in the **Remediate/Quick Fix** section, select the **Fix** button to generate an Automated Remediation Script that enables you to efficiently and consistently remediate identified vulnerabilities.
1. Review the automated remediation script based on standard remediation steps. After reviewing, select the **Close** button at the bottom to close the page.
1. Return to **Recommendations** by selecting the link in the top left area of the page or by selecting the back navigation button.
1. In the Title list, select **Machines should have vulnerability findings resolved.**
1. Select the **Findings** tab and, in the **Severity, ID, and Security** list, select **JAWXDR Update Microsoft Windows Server 2019 (OS and built-in applications).**
1. Review the General information section and select the Solution link labeled **Microsoft Defender Vulnerability Management**. Review the security recommendations, then close the window and continue to review **Remediation, Weaknesses, and Affected Resources**. After reviewing, close the **Update Microsoft Windows Server 2019 (OS and built-in applications)** window by selecting the **X** at the top of the page.
1. Select **Summarize with Copilot**.
1. Review the Copilot-generated recommendation summary that explains the risks and vulnerabilities.
1. Select **Help me remediate this recommendation?**
1. Review the Copilot-generated resolution steps, then close the window.

**Review**: This exercise simulated a real-world remediation process to help you quickly respond to security threats while streamlining governance and automation practices.