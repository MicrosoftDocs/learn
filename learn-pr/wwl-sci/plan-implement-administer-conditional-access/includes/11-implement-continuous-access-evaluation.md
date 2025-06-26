The Conditional Access optimization agent helps you ensure all users are protected by policy. It recommends policies and changes based on best practices aligned with Zero Trust and Microsoft learning.

The Conditional Access optimization agent evaluates policies such as requiring multifactor authentication (MFA). The agent will enforce device based controls (device compliance, app protection policies, and domain-joined devices). Finally, the agent can help block legacy authentication and device code flow.

The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies.

### Requirement to use the Conditional Access optimization agent

- You must have at least the **Microsoft Entra ID P1 license**.
- You must have available **security compute units (SCU)**.
- To activate the agent the first time, you need the Security Administrator or higher role.
- You can assign Conditional Access Administrators with Security Copilot access.
  - For more information, see Assign Security Copilot access
- Device-based controls require **Microsoft Intune licenses**.

### Conditional Access optimization agent key features

The Conditional Access optimization agent scans your tenant for new users and applications and determines if Conditional Access policies are applicable. The key features include:

| Feature | Description |
| :---  | :--- |
| Require MFA | The agent identifies users who aren't covered by a Conditional Access policy that requires MFA and can update the policy. |
| Require device-based controls | The agent can enforce device-based controls, such as device compliance, app protection policies, and domain-joined devices. |
| Block legacy authentication | User accounts with legacy authentication are blocked from signing in. |
| Policy consolidation | The agent scans your policy and identifies overlapping settings. For example, if you have more than one policy that has the same grant controls, the agent suggests consolidating those policies into one. |
| Block device code flow | The agent looks for a policy blocking device code flow authentication. |
| One-click remediation | When the agent identifies a suggestion, you can select Apply suggestion to have the agent update the associated policy with one click. |

## Give the Conditional Access optimization agent a try


In this exercise, you explore key capabilities in the Conditional Access optimization agent in Microsoft embedded experience of Security Copilot.

**As you explore, keep in mind that unless otherwise stated, the information displayed and the configuration settings are for the currently logged in Security Administrator**.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature isn't available within the simulation." When this occurs, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature is not available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role for the active workspace, SecurityCopilot_Workspace. In this exercise, you explore the standalone experience of Microsoft Security Copilot.

This exercise should take approximately **30** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.



1.	Open [https://Entra.Microsoft.com (simulation)](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fapp.highlights.guide%2Fstart%2F673ccf96-b6de-43aa-b267-5c8efe51639c%3Ftoken%3D16d48b6c-eace-4a1f-8050-098d29d23a89&data=05%7C02%7CRobert.Stewart%40microsoft.com%7C002283d502a5447b6fc608ddb25b8a73%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638862828426563227%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=krYm%2BX%2FduKbjtZI5t27fNvWrdUIw2Vj2Ufta3fJpB0o%3D&reserved=0&azure-portal=true) with at least the Security Administrator role.
 
2.	Launch the Security Copilot Agents screen:
-	Option-1 : Select the Try Security Copilot agents free for 60 days
-	Option-2 : Open Conditional Access from the menu on the left.  Then select the Conditional Access Optimization agent.

### Option-1:
1.	Select the “free 60 day trial” button.
2.	Select “View Details” on the page:
 
### Option-2:
1.	Open the “Conditional Access” item in the left-side menu.
2.	On the “Overview” tab, select “Conditional Access Optimization Agent”.
 
### Exploring the Conditional Access Agent
 
1.	Review the “Overview” tab.

   - Agent is active – Note the last time the agent ran and the upcoming schedule.
   - Performance highlights – Review the cost in SCUs for the agent.  See how many unprotected users the agent has found to protect.
   - About this agent – Quick description of the agent and how it works.
   - Recent suggestions – Review of all existing Conditional Access policies and suggestions on how they could be merged, updated, removed, or enhanced.
   - Recent Activity – Status on the last few attempts of the Conditional Access Optimization Agent to run, and the results.

2.	In the “Agent is active” box select the “View run” link.

3.	Review the process flow of the agent and see what new information was detected since the last completion.
   - Take note that is search for three common access rights optimizations:
      - App / Application drift – new applications were deployed and need to be protected.
      - User drift – please where new users were found, or user rights changed that leave them unprotected by policy.
      - Policy merge – places where 2 or more policies could be merged to provide the same result, with easier management.

4.	Select the breadcrumb Conditional Access Optimization Agent (Preview) at the top of the page to return to the Overview page.

5.	Select the Activities tab in the top menu.  Review the history of when the Conditional Access Optimization agent has run and the results.

6.	Select several different “View activity” buttons on the right of the screen to see the progression of the Conditional Access Optimization agent as it runs each 24-hour period.

7.	Open the second item on the list.  Note that 4 new applications were found, and recommended policy changes over time.

8.	Use the breadcrumbs to return to the Overview page.

9.	Select the “Suggestions” from the tab menu.

10.	Explore the suggestion history.  You have one item for each day the agent has been run.

11.	Select the “Review suggestion” button for the first item.

12.	Note the policy wants to add 2 users to an existing Conditional Access policy to add users to CA99 – Mitigate Risk Users with Password Reset policy.

13.	Select the “Policy impact” tab at the top of the page to see a graph of this policy change over time.

14.	Switch back to the “Policy details” tab, then Select the “Review policy changes” to see the proposed changes and the JSON update to be made.

15.	Use the “Back” button in the browser to return to the Overview page.

16.	Select “Suggestions” from the menu.

17.	Select the “x” in the upper right of the screen to close the dialog.

### Explore Conditional Access Optimization Agents in CA-Policies 

1.	Open Conditional Access from the menu on the left.

2.	Select “Policies” from the CA menu.

3.	Review the list of policies, you should see three types:

   - Microsoft – global policies sent out by Microsoft, like require MFA.
   - User – polices created by an authorized user in your organization.
   - Conditional Access Optimization Agent – Report Only policies created by the agent for your review.  You can choose to apply them depending your business and security goals.

4.	Scroll down the list to find the CA99 policy we reviewed earlier.
 
5.	Select the “New agent suggestion” item.

6.	Note that on four occasions the Conditional Access Optimization agent found new user, and has an “Apply suggestion” for each.

7.	Read over the description of what the suggestion is going to do.

8.	Select the “Apply suggestion” button.

**Result** – The agent, has monitored your users each day and found users that we not protected by Risky User policies.  It suggested that you update your policy to include the new users, and provided you with a button to make the change.  In one click you have protected the users.

9.	Exit out to Microsoft Entra to finish the simulation.
