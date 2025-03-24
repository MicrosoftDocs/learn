

[Security Copilot](/copilot/security/microsoft-security-copilot) is a generative AI security product that empowers security and IT professionals respond to cyber threats, process signals, and assess risk exposure at the speed and scale of AI. It has its own and embedded experiences in Microsoft Defender XDR, Microsoft Sentinel, and Intune.

### How does Security Copilot work?
Security Copilot capabilities can be accessed through a standalone experience and through embedded experiences in other Microsoft security products. The foundation language model and proprietary Microsoft technologies work together in an underlying system that helps increase the efficiency and capabilities of defenders.

- Microsoft security solutions such as Microsoft Defender XDR, Microsoft Sentinel, Microsoft Intune integrate seamlessly with Security Copilot. embedded experiences available in Microsoft security solutions  give access to Security Copilot and prompting capabilities in the context of their work within those solutions.
- Plugins from Microsoft and third-party security products are a means to extend and integrate services with Security Copilot. Plugins bring more context from event logs, alerts, incidents, and policies from both Microsoft security products and supported third-party solutions such as ServiceNow.
- Security Copilot also has access to threat intelligence and authoritative content through plugins. Plugins can search across Microsoft Defender Threat Intelligence articles and intel profiles, Microsoft Defender XDR threat analytics reports, and vulnerability disclosure publications, among others.

:::image type="content" source="../media/security-copilot-diagram.png" alt-text="Image of how Security Copilot works with other products.":::

Here's an explanation of how Security Copilot works:

- User prompts from security products are sent to Security Copilot.
- Security Copilot then preprocesses the input prompt through an approach called grounding, which improves the specificity of the prompt to help you get answers that are relevant and actionable to your prompt. Security Copilot accesses plugins for preprocessing, then sends the modified prompt to the language model.
- Security Copilot takes the response from the language model and post-processes it. This post-processing includes accessing plugins to gain contextualized information.
- Security Copilot returns the response, where the user can review and assess the response.

Security Copilot can be used with any data source that Defender XDR and Microsoft Sentinel support, including SAP RISE/ECS. Below shows the stand-alone experience.

:::image type="content" source="../media/sap-rise-security-copilot.png" alt-text="Screenshot of Security Copilot experience with SAP RISE/ECS incidents.":::

In addition to that the Security Copilot experience is embedded on the Defender XDR portal. Next to an AI-generated summary, recommendations, and remediation like password reset for SAP are provided out-of-the-box. Learn more about automatic SAP attack disruption [here](/azure/sentinel/sap/deployment-attack-disrupt).

:::image type="content" source="../media/sap-rise-security-copilot-defender-portal.png" alt-text="Screenshot of embedded Security Copilot experience in Defender with SAP RISE/ECS incidents.":::


