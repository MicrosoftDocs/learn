
In this exercise, you explore key capabilities of the Microsoft Security Copilot Conditional Access optimization agent that is embedded in Microsoft Entra.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, not all links on a page are enabled and text-based inputs that fall outside of the specified script aren't supported. A pop-up stating, "This feature isn't available within the simulation" message displays. When you receive this message, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role (security administrator role in Microsoft Entra) where you explore the key capabilities of the Microsoft Security Copilot Conditional Access optimization agent. As you explore, keep in mind that the information displayed and the configuration settings are based on the Copilot owner (security administrator) role of Avery Howard.

This exercise should take approximately **10** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Exploring the Conditional Access Agent

1. Open the simulated environment by selecting  [Microsoft Entra admin center](https://app.highlights.guide/start/673ccf96-b6de-43aa-b267-5c8efe51639c?token=16d48b6c-eace-4a1f-8050-098d29d23a89&azure-portal=true).

1. There are two ways to access the agent:
    1. From the left navigation panel, select **Conditional Access** then from the **Overview** tab, select **Conditional Access Optimization Agent**.
    1. From the main landing page of the Microsoft Entra admin center, select **Go to agents** then from the Security Copilot agents page, select **View details**.

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

1. From the breadcrumb, select **Conditional Access Optimization Agent** to return to the **Overview** page.

1. Select the **Activities** tab in the top menu. The list shows when the agent ran, the duration of the run, the number of suggestions offer, and status. You can also view the activity map for each completed run.
    1. Select **View activity** to view the activity map for that run.
    1. Close the activity map by selecting **X**.

1. Select the **Suggestions** from the tab menu.
    1. Select the **Review suggestion** button for the first item on the list, "Add 2 users to existing policy: CA99 - Mitigate Risk Users with Password Reset."
    1. A panel opens to the **Policy details** tab that provides more information on the selected suggestion. The policy wants to add two users to CA99 – Mitigate Risk Users with Password Reset policy.
    1. Select the **Policy impact** tab at the top of the page to see a graph of this policy change over time.
    1. Switch back to the **Policy details** tab, then select the **Review policy changes** to see the proposed changes.
    1. Select the **JSON view** tab to view the JSON updates that would be applied if the suggestions were approved. The changes are highlighted.
    1. Close this page by selecting the **X** on the top-right corner of the page to return to the Suggestions page.

1. Select the **Settings** tab to view information on agent settings.

1. Select the **X** in the upper right of the screen to return the Security Copilots agents page that shows the tile for the Conditional Access agent.

1. Keep the browser tab open, you need it for the next task.

#### Task: Explore Conditional Access Optimization Agents in CA-Policies

1. From the left navigational panel on the Microsoft Entra admin center page, select **Conditional Access** then select **Policies**.

1. Review the list of policies, you should see three types (you'll need to scroll-down on the page to view all the types of policies):

   1. Microsoft – global policies sent out by Microsoft, like require MFA.
   1. User – conditional access policies created by an authorized user in your organization.
   1. Conditional Access Optimization Agent – Report Only policies created by the agent for your review. You can choose to apply them depending on business and security goals.

1. Scroll down the list to find the "CA99 - Mitigate Risk Users with Password Reset" policy we reviewed earlier and from that line item, select **New agent suggestion**.
    1. This time, the information listed includes multiple suggestions. On four occasions the Conditional Access Optimization agent found new users that aren't in scope of a policy requiring a password change for high risk uses, and has an **Apply suggestion** for each.
    1. Select the **Apply suggestion** button for one or more of these suggestions to have the agent apply the change to the policy.

1. Exit Microsoft Entra to finish the simulation.

#### Review

In this exercise, you explored the Conditional Access Optimization agent. This agent scans your tenant for new users and applications and determines if Conditional Access policies are applicable, suggests updates to applicable policies, and enables quick remediation through the "Apply suggestions" option. By selecting the "Apply suggestions" button, you add protection for the impacted users and improve security for your organization.
