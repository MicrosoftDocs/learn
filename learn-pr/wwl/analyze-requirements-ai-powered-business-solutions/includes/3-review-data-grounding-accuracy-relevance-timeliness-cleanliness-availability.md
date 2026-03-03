## Learning Objectives

After completing this unit, learners will be able to:

- Evaluate the quality of grounding data across five dimensions: **accuracy, relevance, timeliness, cleanliness, availability**.
- Explain why grounding is essential for reliable AI agent behavior.
- Identify data sources appropriate for grounding AI using Microsoft 365 and Copilot Studio.
- Apply best practices when preparing and validating grounding data.

## 1. Understanding Grounding in AI Agents

Grounding ensures that an AI agent responds using **trusted, domain-specific organizational data**, increasing accuracy and reducing inaccurate information.

Microsoft Copilot and Copilot Studio use **semantic indexing** to map enterprise content across Microsoft Graph into rich lexical and semantic representations. This enables more contextually precise retrieval.

AI systems must be connected to **approved, access-controlled data** so they produce trustworthy outcomes that respect organizational security boundaries.

To support advanced grounding, the **Copilot Retrieval API** retrieves relevant text passages from SharePoint, OneDrive, and connected sources, honoring user permissions.

## 2. The Five Dimensions of Grounding Data Quality

### 2.1 Accuracy

Data should reflect real, verifiable facts. Inaccurate content leads to incorrect or harmful agent outputs.<br>AI agents must use **trusted and validated datasets** during retrieval to avoid generating incorrect responses. 

**Indicators of accuracy:**

- Verified by SMEs

- Matched to authoritative sources

- Free from errors or outdated assumptions

### 2.2 Relevance

Grounding data must match the **intended use case** of the agent.

When data is irrelevant, semantic search may retrieve conceptually similar—but contextually wrong—content.

Relevance ensures the model surfaces information aligned with the user's scenario, workflow, or business domain.

### 2.3 Timeliness

AI outputs degrade when data is stale.

The **semantic index** in Microsoft 365 continuously updates as content changes, ensuring the grounding layer reflects the latest documents, conversations, and knowledge.

**Timeliness includes:**

- Modified dates

- Seasonal or compliance-related updates

- Data refresh schedules

### 2.4 Cleanliness

Clean data reduces noise and increases retrieval precision.

Data Pollution in AI refers to the degradation of data quality that negatively impacts the performance and reliability of AI systems.

Cleaner data improves embedding quality and helps the agent retrieve the most appropriate content.

**Clean data characteristics:**

- Clear structure

- No duplicates

- Minimal irrelevant metadata

- Stable formatting and predictable layout

### 2.5 Availability

Agents can only ground responses from **data the user has access to**.

The Retrieval API respects permissions and will not return content beyond a user's access scope.

**Availability depends on:**

- Storage in SharePoint/OneDrive or connected systems

- Proper indexing in Microsoft Graph

- Clear access controls

## 3. Dimensions of Grounding Data Quality

| **Dimension** | **Definition** | **Impact on Agent Performance** |
|---|---|---|
| **Accuracy** | Data is correct and verified | Reduces inaccurate information and misinformation |
| **Relevance** | Data aligns to the task/intent | Ensures responses match the intended scenario |
| **Timeliness** | Data is current and up to date | Keeps outputs aligned with latest policies or info |
| **Cleanliness** | Data is structured and free of noise | Improves retrieval precision |
| **Availability** | Data is accessible and indexable | Ensures agent can ground reliably per permissions |

## 4. Diagram: How Microsoft Copilot Grounds AI Responses

:::image type="content" source="../media/copilot-grounds-ai-responses.png" alt-text="Diagram showing how Microsoft Copilot grounds AI responses using the semantic index and Retrieval API pipeline.":::

## 5. Best Practices for Reviewing Grounding Data

- **Evaluate content quality before upload**: remove outdated or conflicting information.

- **Store authoritative content in SharePoint or OneDrive** so it becomes part of the semantic index.

- **Ensure consistent formatting** to improve data cleanliness and retrieval precision.

- **Review permissions regularly** so agents ground from valid data sources only.

- **Collaborate with domain SMEs** to validate accuracy and contextual fit.

**References**

- [Add knowledge to ground an agent](/training/modules/agents-copilot-studio-online-workshop/add-knowledge)

- [Ground AI using trusted data](/training/modules/build-effective-generative-ai-solutions-organization/3-ground-ai-using-trusted-data)

- [Semantic indexing for Microsoft 365 Copilot](/microsoftsearch/semantic-index-for-copilot)

- [Microsoft 365 Copilot Retrieval API](/microsoft-365-copilot/extensibility/api/ai-services/retrieval/copilotroot-retrieval)

- [Manage Grounding With Bing in Microsoft Foundry and Azure](/azure/ai-foundry/agents/how-to/manage-grounding-with-bing)