Access the capabilities of Microsoft Security Copilot through an immersive standalone experience or intuitive embedded experiences within other Microsoft security products. The underlying system combines a foundational language model with proprietary Microsoft technologies to boost the efficiency and capabilities of Defenders.

Microsoft security solutions like Microsoft Defender XDR, Microsoft Sentinel, and Microsoft Intune seamlessly integrate with Security Copilot. Embedded experiences in these solutions allow you to access Security Copilot and its prompting capabilities within the context of your work.

Extend and integrate services with Security Copilot using plugins from Microsoft and third-party security products. These plugins bring extra context from event logs, alerts, incidents, and policies from both Microsoft security products and supported third-party solutions like ServiceNow.

Security Copilot also taps into threat intelligence and authoritative content through plugins. These plugins can search across Microsoft Defender Threat Intelligence articles, intel profiles, Microsoft Defender XDR threat analytics reports, and vulnerability disclosure publications.

:::image type="content" source="../media/security-copilot-diagram.png" alt-text="Diagram of how Security Copilot works." lightbox="../media/security-copilot-diagram.png":::

### How Microsoft Security Copilot works

1. **User Prompts:** Security products send user prompts to Security Copilot.
2. **Preprocessing:** Security Copilot preprocesses the input prompt using a method called grounding, which enhances the prompt’s specificity. It accesses plugins for preprocessing, then sends the refined prompt to the language model.
3. **Response Generation:** The language model generates a response, which Security Copilot then post-processes. This includes accessing plugins to gain contextualized information.
4. **Response Delivery:** Security Copilot returns the response, allowing the user to review and assess it.
5. **Iterative Processing:** Security Copilot iteratively processes and orchestrates these sophisticated services to produce results that are relevant and actionable based on your organizational data.

By applying these capabilities, Microsoft Security Copilot helps you achieve more efficient and effective security outcomes tailored to your organization’s specific context.