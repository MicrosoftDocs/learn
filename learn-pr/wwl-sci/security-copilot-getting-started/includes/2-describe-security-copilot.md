
The top security challenges organizations face include:
- An increase in the number and sophistication of attacks.
- A talent shortage that is driving the need for automation, integration, and consolidation of security tools.
- Visibility into security, privacy, compliance, and governance.

Organizations need to act quickly to address all the security challenges they face, but working at human speed, even if there weren't a talent shortage, isn't enough. Organizations need to work at machine speed.

Microsoft Copilot for Security is an AI-powered, cloud-based security analysis tool that enables analysts to respond to threats quickly, process signals at machine speed, and assess risk exposure more quickly than may otherwise be possible.  

### Use cases

At launch, Copilot supports the following use cases:

- Security posture management. Copilot delivers information on anything that might expose an organization to a known threat. It then gives the analyst prescriptive guidance on how to protect against those potential vulnerabilities.
- Incident response. Copilot can quickly surface an incident. For a surfaced incident, Copilot can enrich it with context from other data sources, assess its scale and impact, and provide information on what the source might be. Copilot can then guide the analyst through the response and remediation steps with guided recommendations. Copilot provides a single pane of glass visibility by pulling in data from other sources like Defender and Sentinel and then correlating and analyzing that data all together.
- Security reporting. Copilot can deliver customizable reports that are ready to share and easy to consume, allowing analysts to focus more on high value tasks pertinent for securing the organization.

### Standalone and embedded experience

You can experience Copilot through the dedicated site, also referred to as the standalone experience.  Users interact with Copilot through the prompt bar. In the prompt bar, users make requests in natural language and receive response outputs as text, images, or documents.

:::image type="content" source="../media/security-copilot-standalone-v2.png" lightbox="../media/security-copilot-standalone-v2.png" alt-text="Diagram that shows the landing page for the Microsoft Copilot for Security standalone experience.  The prompt bar is at the bottom center of the page.":::

Additionally, some Microsoft security products embed Copilot capabilities directly within the products’ user interface. This experience is referred to as the embedded experience. Microsoft 365 Defender, for example, enables Copilot capabilities including summarizing incidents, analyzing scripts, generating KQL queries, and more.

:::image type="content" source="../media/security-copilot-embedded-m365-xdr-v3.png" lightbox="../media/security-copilot-embedded-m365-xdr-v3.png" alt-text="Diagram that shows the advanced hunting page of Microsoft Defender XDR, The page includes a button for Copilot that When selected opens a side panel for natural language to KQL query assistant.":::

More information on both the standalone and embedded experience will be covered in subsequent modules.  Images shown throughout the rest of this module are based on the standalone experience.

### Natural language processing (NLP)

Copilot is built using OpenAI models for natural language processing (NLP) and is designed to integrate with existing security tools and processes, making it easier for organizations to improve their overall security posture.  But what exactly does this mean?  

With the OpenAI large language models (LLM) for NLP, Microsoft Copilot for Security is able to read, decipher, understand, and make sense of human languages, enabling users to interact with it using natural language.  And although the OpenAI LLM models are trained on a vast amount of information that enables it with broad general knowledge and problem solving abilities, it’s not enough.  Security analysts expect their copilot to be specifically trained on security and that is where the integration with existing security tools and processes comes into play.

### Integration with Security-specific sources

Copilot combines the Open AI LLM with a security-specific model from Microsoft. This security-specific model is informed by Microsoft’s unique global threat intelligence and more than 65 trillion daily signals and incorporates a growing set of security-specific skills (plug-ins).  Through these plug-ins, Microsoft Copilot for Security integrates with various sources, including Microsoft's own security products including Microsoft Sentinel, Microsoft 365 Defender, and Microsoft Intune, third-party vendors, and open-source intelligence feeds. Through this information, Copilot is able to learn and leverage advanced threat intelligence, at machine speed, to help analysts identify and respond to emerging threats.

The information you give Copilot will only be accessible to your organization. Your data is your data, and it's protected by comprehensive enterprise compliance and security controls. Your data isn't used to train the foundation AI models.

:::image type="content" source="../media/security-copilot.png" alt-text="Diagram showing key attributes of Microsoft Copilot for Security, including hyperscale AI infrastructure, cyber-trained model with security skills, threat intelligence from 65 trillion signals and end-to-end security tooling.":::

Microsoft Copilot for Security is the first security product to enable defenders to move at the speed and scale of AI.
