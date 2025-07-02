Microsoft Entra agents are designed to automate repetitive tasks, enhance security operations, and integrate seamlessly into existing workflows. For Security Operations Analysts, these agents can significantly reduce manual workloads, allowing teams to focus on strategic initiatives and complex problem-solving.

The Conditional Access optimization agent, a Security Copilot Agent embedded in Microsoft Entra, ensures all users are protected by policy. It recommends policies and changes based on best practices aligned with Zero Trust and Microsoft's learnings. The agent provides the following functionality:

- Evaluates policies requiring multifactor authentication (MFA)
- Enforces device based controls (device compliance, app protection policies, and Domain Joined Devices)
- Blocks legacy authentication and device code flow.

### Information about the agent and prerequisites

The Conditional Access Optimization Agent, which is available in Microsoft Entra as part of the Copilot embedded experience, is characterized as follows:

- **Trigger**: The agent runs every 24 hours but can also run manually.
- **Permissions**: The agent reviews your policy configuration but acts only with your approval of the suggestions.
- **Identity**: The agent runs in the context of the administrator who configured the agent.
- **Products**: You must have Microsoft Entra Conditional Access (at least Microsoft Entra ID P1). Device-based controls in Conditional Access require Microsoft Intune licenses. You must also have Security Copilot available and provisioned with security compute units (SCU). On average, each agent run consumes less than one SCU. 
- **Plugins**: The Microsoft Entra is mandatory.
- **Role-based access**: You must be assigned the Security Administrator or Global Administrator role during the preview. These roles also have access to Security Copilot by default.

### Getting started

Follow these steps to configure and run the Conditional Access optimization agent:

1. Go to agents - Once you sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with at least a Security Administrator role, from the Microsoft Entra home page, select **Go to agents** from the agent notification card.
1. Available agents - The Security Copilot agents page, shows tiles for the available agents. The page currently only shows the Conditional Access Optimization Agent, but more agents are coming soon.
1. Start Agent - In the Conditional Access Optimization Agent tile, select **View details**. If you have not previously run the agent, you'll see the option to **Start agent** to begin the agent's first run.
1. Overview page - If you have previously run the agent, selecting view details, brings you to the Overview page. The Overview page shows you see most recent and next scheduled runtimes, performance highlights, recent suggestions, and recent activity.
1. Policy details - Selecting a suggestion takes you to the policy details page where you can view the agent summary, user impact, policy details, make edits, and more.
   1. Newly created policies are created in report-only mode. As a best practice, organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.
   1. After administrators evaluate the policy settings using policy impact or report-only mode, they can move the Enable policy toggle from Report-only to On. Policies created by the agent are tagged with Conditional Access Optimization Agent in the Conditional Access policies pane.

# [Go to agents](#tab/go-to-agents)
:::image type="content" source="../media/conditional-access-agent-home-page.png" lightbox="../media/conditional-access-agent-home-page.png" alt-text="Screenshot of the Microsoft Entra home page that includes the agent notification tile.":::

# [Available agents](#tab/available-agents)
:::image type="content" source="../media/conditional-access-agent-tile.png" lightbox="../media/conditional-access-agent-tile.png" alt-text="Screenshot of the Security Copilot agents page showing that lists available agents.":::

# [Start agent](#tab/start-agent)
:::image type="content" source="../media/conditional-access-agent-view-details.png" lightbox="../media/conditional-access-agent-view-details.png" alt-text="Screenshot showing the Conditional Access Optimization Agent details page. From here, you can select start if you haven't previously run the agent.":::

# [Overview page](#tab/overview-page)
:::image type="content" source="../media/conditional-access-agent-overview-page-v2.png" lightbox="../media/conditional-access-agent-overview-page-v2.png" alt-text="Screenshot showing the Conditional Access Optimization Agent overview page showing the most recent and next scheduled runtimes, performance highlights, recent suggestions, and recent activity.":::

# [Policy details](#tab/policy-details)
:::image type="content" source="../media/conditional-access-agent-policy-details-page.png" lightbox="../media/conditional-access-agent-policy-details-page.png" alt-text="Screenshot showing the Conditional Access Optimization Agent policy details page.":::

---

#### Settings

The agent is configured to run every 24 hours based on when it's initially configured. Toggling Trigger to off under the settings page of the agent and back on at a specific time reconfigures the agent to run at that time.

Use the checkboxes under Objects to specify what the agent should monitor when making policy recommendations. By default the agent looks for both new users and applications in your tenant over the previous 24 hour period.

The agent runs under the Identity and permissions of the user who enabled the agent in your tenant. Because of this requirement, you should avoid using an account that requires elevation like those that use Privileged Identity Management (PIM) for just-in-time elevation.

You can tailor policy to your needs using the optional Custom Instructions field. This allows you to provide a prompt to the agent as part of its execution. For example: "The user "Break Glass" should be excluded from policies created." When you save the custom instruction prompt Security Copilot will attempt to interpret and the results appear in the settings page.

:::image type="content" source="../media/conditional-access-agent-settings-page.png" lightbox="../media/conditional-access-agent-settings-page.png" alt-text="Screenshot showing the Conditional Access Optimization Agent settings page.":::

#### Feedback

Use the Give Microsoft feedback button at the top of the agent window to provide feedback to Microsoft about the agent.

Feedback ensures the agent continues to deliver high-quality, actionable insights tailored to your organization’s needs.

#### Remove agent

If you no longer wish to use the Conditional Access optimization agent, you can remove it using the Remove agent button at the top of the agent window.

### Limitations

While the Conditional Access optimization agent offers significant benefits, during the public preview it has some limitations:

- During the preview, avoid using an account to set up the agent that requires role activation with Privileged Identity Management. Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs
- The agent currently runs as the user who enables it.
- In preview, you should only run the agent from the Microsoft Entra admin center.

