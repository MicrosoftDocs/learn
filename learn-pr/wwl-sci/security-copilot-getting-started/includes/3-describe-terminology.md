In this unit, we introduce you to some basic terminology.

### Terminology

The following terms are important for understanding the way Copilot works:

- Session – a particular conversation within Copilot. Copilot maintains context within a session.
- Prompt – a specific statement or question within a session. A user enters a prompt in the prompt bar.
- Capability/Skill – a function Copilot uses to solve part of a problem
- Plugin/Skillset – A collection of skills by a particular resource
- Orchestrator – Copilot’s system for composing capabilities (skills) together to answer a user’s prompt

***Prompt bar and sessions***

At the center of Microsoft Copilot for Security is the prompt bar. You use the prompt bar to tell Copilot what insights you want from your security data, this is referred to as the prompt. In other words, the prompt is the text-based, natural language input you provide in the prompt bar that instructs Copilot to generate a response. Although you interact with Copilot in natural language, it’s helpful to be specific in the prompts (specific questions or statements) that you provide. For those that are relatively new to the security analyst role and engaging with AI, effective prompting may take some practice. For this reason, Copilot provides promptbooks that provide a series of preselected prompts and prompt suggestions (more details on this in a subsequent module).

:::image type="content" source="../media/prompt-bar.png" lightbox="../media/prompt-bar.png" alt-text="A screen capture of the Microsoft Copilot for Security prompt bar.":::

As you make requests and as Copilot responds, you may have some additional follow-up requests. The entirety of the dialog is referred to as a session. Copilot maintains context within a session.

***Plugins and capabilities***

In the previous unit, we mentioned that Copilot integrates with various sources through plugins, including Microsoft's own security products such as Microsoft Sentinel, Microsoft Defender XDR, and Microsoft Intune, non-Microsoft solutions, and open-source intelligence feeds. The integration enabled by the plugin, for any specific data source, provides Copilot with a collection of capabilities (skills). Each capability (skill) is like a function in software, it’s designed to do a specialized task within the scope of the data source. For example, the plugin to Microsoft Defender XDR includes a collection of individual capabilities that are used only by Microsoft Defender XDR. These include:

- The ability to summarize an incident.
- Support incident response teams in resolving incidents through guided responses (a set of recommended actions based on the specific incident).
- The ability to analyze scripts and code.
- The ability to generate KQL queries from natural language input.
- The ability to generate incident reports.

A plugin for Microsoft Sentinel may have similar capabilities but runs only within the scope of Microsoft Sentinel.

Copilot currently supports plug-ins for Microsoft services and non-Microsoft services, including websites and custom plug-ins that can be enabled.

:::image type="content" source="../media/new-microsoft-plugins.png" lightbox="../media/new-microsoft-plugins.png" alt-text="A screen capture of the plugins window, showing the Microsoft plugins, including Entra, Intune, Microsoft Defender XDR, and more.":::

Some plugins require setup and configuration. This is common with other, non-Microsoft plugins that may need to be set up and configured for account authentication.

:::image type="content" source="../media/plugins-other-web.png" lightbox="../media/plugins-other-web.png" alt-text="A screen capture of the plugins window, showing the non-Microsoft plugins, including ServiceNow, Splunk, the public web, and custom plugins.":::


***Orchestrator***

The orchestrator is Copilot’s system for composing capabilities (skills) together to answer a user’s prompt. This function is illustrated in more detail in the subsequent unit that describes how Copilot processes prompt requests.
