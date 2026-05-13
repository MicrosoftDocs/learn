With plugins configured and governed, the next step is deploying agents that automate security workflows. The Security Copilot agent library provides a catalog of Microsoft built and partner-built agents ready for you to discover and set up.

## Browse the agent library

To access the agent library:

1. Sign in to Security Copilot at `https://securitycopilot.microsoft.com`.
2. In the left navigation, select **Agents**.

The library displays available Microsoft agents and partner agents. Microsoft builds and maintains a set of agents (by Microsoft). Partner agents, built by external vendors and can require purchase through the Security Store before setup can begin. Depending on your role, you can set up agents or run ones that are already configured.

Agents are also available from within embedded experiences. Agents tailored to identity management appear within the Microsoft Entra admin center, while SOC-focused agents surface in Defender. Each workspace in Security Copilot controls which agents are available and which plugins those agents can use—so embedded agents surface within the context of whichever workspace they're associated with.

## Set up a Microsoft built agent

Microsoft built agents require setup before use. The setup process configures the agent's identity, trigger, and operating parameters.

1. In the agent library, select the agent you want to use.
2. Select **Set up** to open the agent details page.
3. **Select an identity for the agent.** You have two options:
   - **Create an agent identity**: a dedicated nonhuman identity used exclusively by this agent. Microsoft recommends this option because it improves auditability and limits the blast radius if the identity is ever compromised.
   - **Assign an existing user account**: use the credentials of an existing user to run the agent. Appropriate when the user account already has the required permissions and a dedicated identity isn't needed.
4. Follow the setup instructions and configure the parameters presented for this agent:

   | Parameter | Description |
   |-----------|-------------|
   | Trigger | The event or schedule that initiates the agent |
   | Permissions | The authorization level the agent needs to access data and perform actions |
   | Identity | The credentials the agent uses when it runs |
   | Plugins | Data sources and capabilities the agent can invoke |
   | Products | Microsoft products this agent requires |
   | Role-based access | The roles or permissions required to turn on and/or run the agent |

5. After completing setup, you're taken to the agent page. Select **Run** to view the agent output or manage the agent.

Some agents require only a few parameters; others involve configuring multiple plugins, connection details, and trigger schedules. Check each agent's documentation to understand its requirements before deployment.



   :::image type="content" source="../media/agent-workspace-context.png" alt-text="Diagram of three Security Copilot workspaces—SOC, Compliance, and Sandbox—each containing their own scoped agents and plugins, illustrating workspace-level agent scoping." lightbox="../media/agent-workspace-context.png":::



## Understand agent workspace context

Microsoft built agents run within the context of the workspace you're signed into when you set them up. Agents configured in the SOC workspace consume SOC workspace capacity and have access to the plugins enabled for that workspace.

This workspace context matters for Contoso. The SOC Director sets up threat-hunting agents in the SOC workspace so they consume dedicated SOC capacity and have access to the Defender XDR and Microsoft Sentinel plugins. The Security Architect sets up experimental agents in the sandbox workspace, where misconfigurations or excessive capacity use don't affect production teams.

With Microsoft built agents deployed, you're ready to explore partner agents available through the Security Store—including agents that can require your organization to purchase a subscription and obtain Global Administrator approval before setup can complete.
