This unit discusses the available security and compliance controls for Microsoft Copilot for Microsoft 365.

## How does Microsoft Copilot for Microsoft 365 use and protect organizational data?

Microsoft Copilot for Microsoft 365 only surfaces organizational data to which individual users have at least view permissions. The permissions model within your Microsoft 365 tenant can help ensure that data won't unintentionally leak between users, groups, and tenants. Microsoft Copilot for Microsoft 365 presents only data that each individual can access using the same underlying controls for data access used in other Microsoft 365 services. Semantic Index honors the user identity-based access boundary so that the grounding process only accesses content that the current user is authorized to access. For more information, see Microsoft’s privacy policy and service documentation.

We already implement multiple forms of protection to help prevent customers from compromising Microsoft 365 services and applications or gaining unauthorized access to other tenants or the Microsoft 365 system itself. Here are some examples of those forms of protection:

* Logical isolation of customer content within each tenant for Microsoft 365 services is achieved through Microsoft Entra authorization and role-based access control. For more information, see Microsoft 365 isolation controls.
* Microsoft uses rigorous physical security, background screening, and a multi-layered encryption strategy to protect the confidentiality and integrity of customer content.
* Microsoft 365 uses service-side technologies that encrypt customer content at rest and in transit, including BitLocker, per-file encryption, Transport Layer Security (TLS) and Internet Protocol Security (IPsec). For specific details about encryption in Microsoft 365, see Encryption in the Microsoft Cloud.
* Your control over your data is reinforced by Microsoft's commitment to comply with broadly applicable privacy laws, such as the GDPR, and privacy standards, such as ISO/IEC 27018, the world’s first international code of practice for cloud privacy.
* For content accessed through Microsoft Copilot for Microsoft 365 plug-ins, encryption can exclude programmatic access, thus limiting the plug-in from accessing the content. 

When you enter prompts using Microsoft Copilot for Microsoft 365, the information contained within your prompts, the data they retrieve, and the generated responses remain within the Microsoft 365 service boundary, in keeping with our current privacy, security, and compliance commitments. Microsoft Copilot for Microsoft 365 uses Azure OpenAI services for processing, not OpenAI’s publicly available services. Azure OpenAI doesn't cache customer content and Copilot modified prompts for Copilot for Microsoft 365.

## Data stored about user interactions with Microsoft Copilot for Microsoft 365

When a user interacts with Microsoft Copilot for Microsoft 365 apps (such as Word, PowerPoint, Excel, OneNote, Loop, or Whiteboard), we store data about these interactions. The stored data includes the user's prompt and Copilot's response, including citations to any information used to ground Copilot's response. 

To view and manage this stored data, admins can use Content search or Microsoft Purview. Admins can also use Microsoft Purview to set retention policies for the data related to chat interactions with Copilot. For more information, see the following articles:

* Overview of Content search
* Microsoft Purview data security and compliance protections for generative AI apps
* Learn about retention for Copilot for Microsoft 365

## Regulatory compliance

Microsoft Copilot for Microsoft 365 is integrated into Microsoft 365 and adheres to all existing privacy, security, and compliance commitments to Microsoft 365 commercial customers. For more information, see [Microsoft Compliance](https://learn.microsoft.com/compliance).
