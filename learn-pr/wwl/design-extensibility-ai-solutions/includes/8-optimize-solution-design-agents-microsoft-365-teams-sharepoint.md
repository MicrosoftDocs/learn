## Overview

Microsoft 365 now supports SharePoint and Teams-integrated agents built through Copilot Studio. These agents can retrieve content from SharePoint, automate site-level tasks, answer organizational questions, and participate in Teams conversations. Optimizing solution design requires understanding how these agents work, how they use Microsoft 365 data, and how to architect them for reliability, governance, and business value.

This unit equips solution architects to design, deploy, and optimize Microsoft 365 agents that operate across Teams and SharePoint environments.

By the end of this unit, learners will be able to:

Explain how Microsoft 365 agents integrate with Teams and SharePoint

Design agents that use SharePoint sites, lists, and libraries as knowledge sources

Optimize agent behavior using Microsoft 365 grounding and permissions

Apply governance and lifecycle management best practices

Evaluate solution patterns for enterprise-grade Teams and SharePoint automation

## Understanding Microsoft 365 agents in Teams and SharePoint

Microsoft 365 agents built in Copilot Studio can:

### A. Operate inside Teams

Respond to user questions in chats and channels

Automate workflows triggered by Teams messages

Provide contextual answers using Microsoft 365 data

### B. Operate inside SharePoint

Retrieve content from sites, lists, and libraries

Answer site-specific questions

Support site owners with content management tasks

Provide contextual help based on site structure

### C. Use Microsoft 365 grounding

Agents automatically:

Respect user permissions

Use Microsoft Graph to retrieve files, lists, and pages

Provide grounded answers based on enterprise content

This ensures accuracy, security, and compliance.

## Designing SharePoint-integrated agents

Based on the SharePoint agent creation guidance, solution architects should design agents that:

### A. Use SharePoint as a Knowledge Source

Agents can access:

Site pages

Document libraries

Lists

News posts

Policies and procedures

Wiki content

### B. Support site-level scenarios

Examples:

"Find the latest HR policy on this site."

"Summarize the documents in the Project Alpha library."

"Help me create a new page template."

"What permissions does this site use?"

### C. Use Site Context Automatically

When installed on a SharePoint site, the agent:

Knows which site it's on

Uses that site's content as its primary grounding source

Adapts responses to the site's structure

### D. Provide authoring and management assistance

Agents can help site owners:

Draft page content

Suggest metadata

Improve accessibility

Recommend site organization improvements

## Designing Teams-integrated agents

Teams agents support:

### A. Conversational Automation

Answer questions in chats and channels

Provide summaries, insights, and recommendations

Trigger workflows based on user messages

### B. Multi-user collaboration

Agents can:

Participate in group conversations

Provide shared knowledge

Support project teams with contextual answers

### C. Task Automation

Examples:

"Create a task for this message."

"Summarize the last 10 messages in this channel."

"Find the latest project document in SharePoint."

## Optimizing solution design across Microsoft 365

To optimize solution design, architects should focus on:

### A. Grounding Strategy

Use SharePoint sites as primary knowledge sources

Use Microsoft Graph for cross-tenant retrieval

Ensure content is well-structured and tagged

### B. Permissions & Security

#### Agents inherit user permissions

They cannot access content the user cannot

They respect SharePoint and Teams security boundaries

They require proper app registration and consent

### C. Prompt & Behavior Design

#### Agents should

Provide concise, contextual answers

Ask clarifying questions when needed

Use SharePoint metadata to improve accuracy

### D. Governance & Lifecycle

Version control for agent updates

Monitoring usage and performance

Periodic content review for SharePoint grounding

Alignment with AI CoE governance

## Solution patterns for Microsoft 365 agents

### Pattern 1 SharePoint Knowledge Assistant

#### Purpose:

Answer sitespecific questions

Help users find documents

Provide summaries and insights

### Pattern 2 Teams Project Assistant

#### Purpose:

Support project teams

Summarize channel activity

Retrieve documents from SharePoint

Automate task creation

### Pattern 3 Organizational Policy Assistant

#### Purpose:

Retrieve policies from SharePoint

Provide grounded answers

Ensure compliance and accuracy

### Pattern 4 Site Owner Support Agent

#### Purpose:

Help maintain SharePoint sites

Suggest improvements

Draft pages and content

## References

<https://spknowledge.com/2026/01/05/creating-and-managing-sharepoint-agents-in-copilot-studio/> 