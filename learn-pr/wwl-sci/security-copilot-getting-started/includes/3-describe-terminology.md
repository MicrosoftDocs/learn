In this unit, we introduce you to some basic terminology and describe, at a high level, how Microsoft Security Copilot works from the perspective of its workflow.

### Terminology

The following terms are important for understanding the way Security Copilot works:

- Session – a particular conversation within Security Copilot.  Security Copilot will maintain context within a session.
- Prompt – a specific statement or question within a session.  A user enters a prompt in the prompt bar.
- Capability/Skill – a function Security Copilot uses to solve part of a problem
- Plugin/Skillset – A collection of skills by a particular resource
- Orchestrator – Security Copilot’s system for composing capabilities (skills) together to answer a user’s prompt

***Prompt bar and sessions***

At the center of Microsoft Security Copilot is the prompt bar. You use the prompt bar to tell Security Copilot what insights you want from your security data, this is referred to as the prompt.  In other words, the prompt is the text-based, natural language input you provide in the prompt bar that instructs Security Copilot to generate a response. Although you interact with Security Copilot in natural language, it’s helpful to be specific in the prompts (specific questions or statements) that you provide. For those that are relatively new to the security analyst role and engaging with AI, effective prompting may take some practice. For this reason, Security Copilot provides promptbooks that provide a series of preselected prompts and prompt suggestions (more details on this in a subsequent module).

:::image type="content" source="../media/prompt-bar-unit-1.png" alt-text="A screen capture of the Microsoft Security Copilot prompt bar.":::

As you make requests and as Security Copilot responds, you may have some additional follow-up requests.  The entirety of that dialog is referred to as a session.  Security Copilot maintains context within a session.

***Plugins and capabilities***

In the previous unit, we mentioned that Security Copilot integrates with various sources through plugins, including Microsoft's own security products such as Microsoft Sentinel, Microsoft 365 Defender, and Microsoft Intune, third-party solutions, and open-source intelligence feeds.   The integration enabled by the plugin, for any specific data source, provides Security Copilot with a collection of capabilities (skills).  Each capability (skill) is like a function in software, it’s designed to do a specialized task within the scope of the data source.  For example, the plugin to Microsoft 365 Defender includes a collection of individual capabilities that are used only by Microsoft 365 Defender. These include:

- The ability to summarize an incident.
- Support incident response teams in resolving incidents through guided responses (a set of recommended actions based on the specific incident).
- The ability to analyze scripts and code.
- The ability to generate KQL queries from natural language input.
- The ability to generate incident reports.

A plugin for Microsoft Sentinel may have similar capabilities but they run only within the scope of Microsoft Sentinel.

Security Copilot currently supports plug-ins for Microsoft (first party) services and non-Microsoft (third party) services, including websites and custom plug-ins that can be enabled.

:::image type="content" source="../media/first-party-plugins-resized.png" alt-text="A screen capture of the plugins window, showing the Microsoft plugins, including Entra, Intune, Microsoft Defender XDR, and more.":::

:::image type="content" source="../media/third-party-plugins-resized.png" alt-text="A screen capture of the plugins window, showing the non-Microsoft plugins, including ServiceNow, Splunk, the public web, and custom plugins.":::

***Orchestrator***

The orchestrator is Security Copilot’s system for composing capabilities (skills) together to answer a user’s prompt. This function is illustrated in more detail in the subsequent unit that describes how Security Copilot processes prompt requests.
