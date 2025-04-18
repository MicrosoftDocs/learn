In this unit, we introduce you to some basic terminology.

### Terminology

The following terms are important for understanding the way Microsoft Security Copilot works:

- Session – A particular conversation within Copilot. Copilot maintains context within a session.
- Prompt – A specific statement or question within a session. A user enters a prompt in the prompt bar.
- Capability – A function Copilot uses to solve part of a problem.  A capability may sometimes be referred to as a skill.
- Plugin – A collection of capabilities by a particular resource.
- Workspace - Copilot workspaces are separate Copilot work environments within the tenant in which your Copilot instance is operating.
- Orchestrator – Copilot’s system for composing capabilities together to answer a user’s prompt.

***Prompt bar and sessions***

At the center of Security Copilot is the prompt bar. You use the prompt bar to tell Copilot what insights you want from your security data, this is referred to as the prompt. In other words, the prompt is the text-based, natural language input you provide in the prompt bar that instructs Copilot to generate a response. Although you interact with Copilot in natural language, it’s helpful to be specific in the prompts (specific questions or statements) that you provide. For those that are relatively new to the security analyst role and engaging with AI, effective prompting may take some practice. For this reason, Copilot provides promptbooks that provide a series of preselected prompts and prompt suggestions (more details on this in a subsequent module).

:::image type="content" source="../media/prompt-bar-new.png" lightbox="../media/prompt-bar-new.png" alt-text="A screen capture of the Microsoft Security Copilot prompt bar.":::

As you make requests and as Copilot responds, you may have some follow-up requests. The entirety of the dialog is referred to as a session. Copilot maintains context within a session.

***Plugins and capabilities***

In the previous unit, we mentioned that Copilot integrates with various sources through plugins, including Microsoft's own security products such as Microsoft Sentinel, Microsoft Defender XDR, and Microsoft Intune, non-Microsoft solutions, and open-source intelligence feeds. The integration enabled by the plugin, for any specific data source, provides Copilot with a collection of capabilities. Each capability is like a function in software, it’s designed to do a specialized task within the scope of the data source. For example, the plugin to Microsoft Defender XDR includes a collection of individual capabilities that are used only by Microsoft Defender XDR. These include:

- The ability to summarize an incident.
- Support incident response teams in resolving incidents through guided responses (a set of recommended actions based on the specific incident).
- The ability to analyze scripts and code.
- The ability to generate KQL queries from natural language input.
- The ability to generate incident reports.

A plugin for Microsoft Sentinel may have similar capabilities but runs only within the scope of Microsoft Sentinel.

Copilot currently supports plug-ins for Microsoft services and non-Microsoft services, including websites and custom plug-ins that can be enabled.

:::image type="content" source="../media/microsoft-plugins-updated.png" lightbox="../media/microsoft-plugins-updated.png" alt-text="A screen capture of the plugins window, showing the Microsoft plugins, including Entra, Intune, Microsoft Defender XDR, and more.":::

:::image type="content" source="../media/non-microsoft-plugins-updated.png" lightbox="../media/non-microsoft-plugins-updated.png" alt-text="A screen capture of the plugins window, showing the non-Microsoft plugins, including ServiceNow, Splunk, the public web, and custom plugins.":::

Some plugins require setup and configuration, as depicted by the Set up button or the gear icon. For Microsoft plugins, set up may be required where resource specific information needs to be specified. For non-Microsoft sources, set up may be required for account authentication.

***Workspaces***

Copilot workspaces are separate Copilot work environments within the tenant in which your Copilot instance is operating.

To help you better understand the concept of workspaces, we'll use the analogy of house with multiple rooms. Each room is configured to be optimized for its function and the people that will use that room. When someone enters the house, they may have access to some rooms but not others.

:::image type="content" source="../media/workspace-overview.png" lightbox="../media/workspace-overview.png" alt-text="Illustration of a house which is like a tenant and a room in the house is like a workspace in Security Copilot.":::

You can think of Copilot Workspaces fitting into this analogy. A Copilot workspace is analogous to a room in a house. You can also think of the house as analogous to a tenant. In the same way that a house has multiple rooms, the tenant in which Copilot is operating can have multiple workspaces.

:::image type="content" source="../media/workspace-manage-v2.png" lightbox="../media/workspace-manage-v2.png" alt-text="A screenshot of the manage workspaces page that lists the available workspaces.":::

Through the tenant-switching capability in Security Copilot, a user can select in which tenant they'll be working. In our analogy, this is a Copilot user getting access to the house. Once the tenant is selected, a Copilot user can access and work in any workspace (room in the house) to which they have access, within the context of their role permissions in that workspace.

Workspaces are powered by capacities and each workspace must have its own capacity.

Using workspaces, you can efficiently map and monitor costs based on team needs and budgets, ensuring that teams have the capacity they need and resources are allocated effectively. Having workspaces also allows you to store session data according to geo-specific regulations and adhere to local data protection laws. These are just a few of the benefits of using workspaces.

Refer to the training unit, "Describe workspaces", which is linked in the Summary and resource section of this module, for more information on Copilot workspaces.

***Orchestrator***

The orchestrator is Copilot’s system for composing capabilities together to answer a user’s prompt. This function is illustrated in more detail in the subsequent unit that describes how Copilot processes prompt requests.
