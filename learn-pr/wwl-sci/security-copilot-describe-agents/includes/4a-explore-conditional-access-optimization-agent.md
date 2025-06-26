


In this exercise, you explore key capabilities of the Microsoft Security Copilot Conditional Access optimization agent that is embedded in Microsoft Entra.

**As you explore, keep in mind that unless otherwise stated, the information displayed and the configuration settings are for the currently logged in Security Administrator**.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, not all links on a page are enabled and text-based inputs that fall outside of the specified script aren't supported. A pop-up stating, "This feature isn't available within the simulation" message displays. When you receive this message, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role (security administrator role in Microsoft Entra) for the active workspace, SecurityCopilot_Workspace where you explore the key capabilities of the Microsoft Security Copilot Conditional Access optimization agent.

This exercise should take approximately **10** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

1. Open the simulated environment by selecting  [Microsoft Entra admin center](https://app.highlights.guide/start/673ccf96-b6de-43aa-b267-5c8efe51639c?token=16d48b6c-eace-4a1f-8050-098d29d23a89&azure-portal=true).
 


### Option-1:
1. Select the "free 60 day trial" button.
1. Select **View Details** on the page:
 
### Option-2:
1.	Open the **Conditional Access** item in the left-side menu.
2.	On the **Overview** tab, select **Conditional Access Optimization Agent**.
 
### Exploring the Conditional Access Agent

1. Review the **Overview** tab.

   1. Agent is active – Note the last time the agent ran and the upcoming schedule.
   1. Performance highlights – Review the cost in Security Compute Units (SCUs) for the agent. See how many unprotected users the agent found to protect.
   1. About this agent – Quick description of the agent and how it works.
   1. Recent suggestions – Review of all existing Conditional Access policies and suggestions on how they could be merged, updated, removed, or enhanced.
   1. Recent Activity – Status on the last few attempts of the Conditional Access Optimization Agent to run, and the results.

1. Select the **View run** link within the **Agent is active** box.

1. Review the process flow of the agent and see what new information was detected since the last completion.
   1. Take note that is search for three common access rights optimizations:
      1. App / Application drift – new applications were deployed and need to be protected.
      1. User drift – new users were found, or user rights changed that leave them unprotected by policy.
      1. Policy merge – places where two or more policies could be merged to provide the same result, with easier management.

1. Select the breadcrumb **Conditional Access Optimization Agent** to return to the Overview page.

1. Select the Activities tab in the top menu. Review the history of when the Conditional Access Optimization agent ran and the results.

1. Select several different **View activity** buttons to see the progression of the Conditional Access Optimization agent as it runs each 24-hour period.

1. Open the second item on the list. Notice, four new applications were found, and recommended policy changes over time.

1. Use the breadcrumbs to return to the Overview page.

1. Select the **Suggestions** from the tab menu.

1. Explore the suggestion history. You have one item for each day the agent ran.

1. Select the **Review suggestion** button for the first item.

1. Notice, the policy wants to add two users to an existing Conditional Access policy. The goal is to add users to CA99 – Mitigate Risk Users with Password Reset policy.

1. Select the **Policy impact** tab at the top of the page to see a graph of this policy change over time.

1. Switch back to the **Policy details** tab, then select the **Review policy changes** to see the proposed changes and the JSON update to be made.

1. Use the browser **Back** button to return to the **Overview** page.

1. Select **Suggestions** from the menu.

1. Select the **X** in the upper right of the screen to close the dialog.

### Explore Conditional Access Optimization Agents in CA-Policies 

1. Open Conditional Access from the menu on the left.

1. Select **Policies** from the Conditional Access menu.

1. Review the list of policies, you should see three types:

   1. Microsoft – global policies sent out by Microsoft, like require MFA.
   1. User – conditional access policies created by an authorized user in your organization.
   1. Conditional Access Optimization Agent – Report Only policies created by the agent for your review. You can choose to apply them depending on business and security goals.

1. Scroll down the list to find the CA99 policy we reviewed earlier.
 
1. Select the **New agent suggestion** item.

1. On four occasions the Conditional Access Optimization agent found new user, and has an **Apply suggestion** for each.

1. Read over the description of what the suggestion is going to do.

1. Select the **Apply suggestion** button.

    **Result** – The agent, monitors your users each day and found users that weren't protected by Risky User policies. It suggested you update your policy to include the new users, and provided you with a button to make the change. In one button you added protection for the users.

1. Exit Microsoft Entra to finish the simulation.
