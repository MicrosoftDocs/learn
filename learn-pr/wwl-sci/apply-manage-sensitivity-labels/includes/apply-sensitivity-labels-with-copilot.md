Sensitivity labels don't just protect files and emails at rest. They also govern how AI-driven tools like Microsoft 365 Copilot interact with your organization's data. When Copilot drafts a document, summarizes an email thread, or generates a presentation, it checks the sensitivity labels on the source content. It then carries those protections forward into the new output. Understanding how Copilot inherits labels, how encryption settings limit what it can do, and where the current boundaries are helps you configure labels that work with Copilot. The goal is to protect sensitive content without blocking the AI-assisted workflows your users depend on.

## How Copilot works with sensitivity labels

Microsoft 365 Copilot uses large language models to help users draft, summarize, create, and analyze content across Word, Excel, PowerPoint, Outlook, and Teams. Copilot connects with Microsoft Graph, which means it can access emails, chats, and documents that users have permission to access.

Copilot doesn't bypass your data protection controls. When Copilot accesses labeled content, it checks the user's permissions against any encryption the label applies. If the label restricts access, Copilot honors those restrictions the same way any Office app would.

For example, if a document is labeled **Highly Confidential** with encryption that limits access to specific teams, Copilot can't summarize that document for a user outside those teams. The label's protection follows the content into every Copilot interaction.

## Label inheritance when Copilot generates content

One of the most important behaviors to understand is label inheritance. When Copilot creates new content based on labeled source files, it automatically inherits the sensitivity label from the source. If multiple source files are involved, Copilot applies the label with the highest priority.

This inheritance rule means when someone uses Copilot to draft a proposal by referencing a financial analysis labeled **Highly Confidential** and a competitive brief labeled **Confidential**, the generated proposal inherits the Highly Confidential label. Only team members with the right permissions can access the final output.

A few things to keep in mind about how inheritance works in practice:

- An inherited label replaces a lower-priority label that was manually applied, but it won't override a higher-priority one.
- An inherited label replaces default labels from policies or document libraries when the inherited label has higher priority.
- If the inherited label can't be applied (for example, the destination item is read-only or the user doesn't have permission to change the label), Copilot won't add the content to the destination item.
- Label inheritance is currently supported in Copilot for Word, PowerPoint, and Outlook.

## Encryption and Copilot access

Sensitivity labels that apply encryption control what Copilot can do with the content. Copilot checks the user's usage rights before accessing labeled and encrypted data:

- If a user has both **View** and **Extract** (copy) rights, Copilot can summarize and reference that content.
- If a user only has **View** rights without **Extract**, Copilot is limited to referencing the content with a link so the user can open it directly. Summarization isn't available without the Extract right.
- Content protected with **Double Key Encryption (DKE)** is inaccessible to Copilot entirely. Copilot doesn't return items protected by DKE, and if a DKE item is open, Copilot is unavailable in that app.

These behaviors mean the encryption settings you choose when applying labels directly affect how Copilot interacts with your data. Understanding this connection helps you apply labels that balance protection with productivity.

## Before you deploy Copilot with sensitivity labels

Before users start working with Copilot and labeled content, verify that your environment is ready:

- **Infrastructure**: Confirm your network configurations and software versions support both Copilot and sensitivity labels.
- **Licensing**: Microsoft 365 Copilot is a separate add-on license that requires a base Microsoft 365 subscription (such as E3 or E5). Sensitivity labels require Microsoft Purview Information Protection, which is included in E5 or available as an add-on for E3. Assign both licenses to users who interact with Copilot and labeled content.
- **Label publishing**: Labels must be published from the Microsoft Purview portal to both content creators and Copilot users. If a label isn't published to the user, inheritance won't apply.
- **Encryption review**: Labels that restrict the Extract right limit what Copilot can do with that content. Audit which labels apply encryption and what usage rights they grant before enabling Copilot for teams that work with sensitive data.

## Limitations and considerations

Applying sensitivity labels with Copilot involves several limitations worth understanding before you deploy:

- **Label inheritance scope**: Label inheritance works in Copilot for Word, PowerPoint, and Outlook. It isn't yet supported when Copilot creates content from items encrypted with user-defined permissions, or when encryption was applied independently from the label.
- **Double Key Encryption (DKE)**: Copilot can't access data protected by DKE. Copilot won't return items protected by DKE, and Copilot is unavailable in an app when a DKE item is open.
- **Teams meetings and chat labels**: Copilot doesn't currently recognize sensitivity labels that protect Teams meetings and chat. Data returned from a meeting chat or channel chat won't display its sensitivity label in Copilot, and the label can't be inherited. This limitation doesn't apply to meeting invites, responses, and calendar events.

For additional limitations involving user-defined permissions, container labels, and Copilot Chat behavior, see [Considerations to manage Microsoft 365 Copilot for security and compliance](/purview/ai-m365-copilot-considerations?azure-portal=true).
