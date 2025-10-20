Developer-led AI environments are often built and deployed quickly using decentralized tools. These environments include platforms like Copilot Studio, Azure AI services, Copilot in Fabric, and custom apps registered in Microsoft Entra. Without visibility into how these tools are used or what data they rely on, it's difficult to identify and mitigate security and compliance risks.

Microsoft Purview Data Security Posture Management (DSPM) for AI allows you to discover which AI agents and apps exist across your environment. It also helps you understand how they use sensitive data and identify where additional protections might be needed.

## Discover AI apps across Microsoft platforms

Lack of visibility into AI apps makes it difficult to judge risk without a discovery process. DSPM for AI can surface apps and agents created across various services, including:

- **Copilot Studio**: Agents created for Microsoft Teams or internal business processes
- **Azure AI services**: Custom solutions that use Azure OpenAI or other large language models
- **Copilot in Fabric**: AI-generated experiences such as Power BI Q\&A
- **Microsoft Entra-registered apps**: AI apps that request access to Microsoft 365 data using organizational identities

Discovery is based on signals collected from across Microsoft 365 and Microsoft Entra. For apps and agents to appear in the DSPM for AI Reports dashboard, they must be correctly onboarded. They also need to be authorized to use supported services.

Once discovered, apps and agents appear in the **Copilot experiences and agents** tab of the DSPM for AI Reports dashboard. Each entry includes metadata such as app name, platform, last activity, and associated users. You can filter by service, sort by activity, or focus on specific risk types using the built-in views.

:::image type="content" source="../media/posture-management-ai-reports-dashboard.png" alt-text="Screenshot showing reports of total interactions for Copilot, agents, and enterprise AI apps in the last 30 days." lightbox="../media/posture-management-ai-reports-dashboard.png":::

## Review data risk in connected sources

Even when you know what apps exist, they might connect to unprotected content, creating hidden exposure points. If AI apps reference content stored in SharePoint, it's important to understand whether that content is properly protected. The **Data risk assessments** tab in DSPM for AI allows you to scan SharePoint sites to identify potential issues such as:

- Files that contain sensitive information types
- Files that are unlabeled or haven't been scanned
- Items that are overshared or accessible to more users than intended

These assessments don't track AI usage directly, but they help you evaluate the data posture of the SharePoint sites that copilots and agents might rely on. For example, a Copilot Studio agent connected to a SharePoint site with broadly shared or unlabeled content could unintentionally expose sensitive information.

You can use these results to apply file-level protections, restrict AI access to specific sites, or configure retention based on data classification.

## Follow recommendations related to developer AI apps

Recommendations help translate discovery insights into actions, so you can reduce risk without manually inspecting every app. The **Recommendations** tab in DSPM for AI includes guidance for apps and agents created using services like Copilot Studio, Fabric, Azure AI, and Microsoft Entra.

Some recommendations in DSPM for AI specifically address apps created in developer environments. For example:

- **Protect sensitive data referenced in Copilot and agent responses** guides you to review how apps are returning sensitive data and helps you decide whether to apply data loss prevention (DLP) or labeling policies.
- **Secure data in Azure AI apps and agents** can apply to custom AI services deployed through Azure or apps registered in Microsoft Entra.
- **Secure interactions in Microsoft Copilot experiences** automatically captures activity from Copilot Studio agents and copilots embedded in Teams or Fabric.

   :::image type="content" source="../media/posture-management-ai-enterprise-app-recommendation.png" alt-text="Screenshot showing confirmation of a policy created to capture enterprise AI app interactions for compliance and data management." lightbox="../media/posture-management-ai-enterprise-app-recommendation.png":::

Some recommendations guide you through creating or updating a DLP policy. Others help you configure retention, apply sensitivity labels, or expand coverage using collection policies. Reviewing these recommendations allows you to take targeted actions based on how developer AI apps use sensitive or regulated content.

## Extend coverage with collection policies

Some AI activity won't appear in default reports, so collection policies let you capture additional signals for full visibility. If your organization uses other services or needs to expand DSPM for AI coverage, you can configure collection policies to capture additional signals. These policies define which locations or activities should be tracked and can include:

- **Prompts and responses** from browser-based Copilot interactions
- **Activity** from apps deployed through Microsoft Entra
- **Interactions** across Microsoft 365 workloads not covered by default

   :::image type="content" source="../media/collection-policies.png" alt-text="Screenshot showing a list of DSPM collection policies for AI interactions and sensitive info detection on the Collection policies page." lightbox="../media/collection-policies.png":::

Once collected, this activity appears in the **activity explorer**, where you can review the prompt history, filter by user or app, and inspect patterns over time.

## Use DSPM for AI insights to guide protections

DSPM for AI doesn't enforce protections directly, but it gives admins the visibility needed to decide where to apply Microsoft Purview controls.

For example:

- If a Copilot Studio agent accesses sensitive files in SharePoint, you might update your DLP policy to restrict summarization or sharing.
- If an Entra-registered app interacts with unlabeled content, you could apply sensitivity labels to the source files.
- If a Fabric experience uses unrestricted data, you might move or reclassify the dataset.

DSPM for AI gives you the visibility to make informed decisions across Microsoft 365, especially when securing developer AI apps that interact with sensitive or regulated data.
