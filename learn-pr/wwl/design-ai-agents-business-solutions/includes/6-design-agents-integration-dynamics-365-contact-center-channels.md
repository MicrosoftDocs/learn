## Learning objectives

By the end of this unit, learners  will be able to:
- Describe how AI agents integrate with Dynamics 365 Contact Center channels
- Design contact center-ready agents that use customer context, conversation signals, and routing metadata
- Apply best practices for enabling Copilot and agent context features to support omnichannel service experiences
- Map Customer Service workflows to Copilot-enabled agent behaviors within voice, digital messaging, and live chat channels

## Introduction

Dynamics 365 Contact Center provides a unified, intelligent platform for customer engagement across **voice, chat, messaging, and digital channels**. AI agents integrated into Contact Center help organizations:

- Deliver fast, accurate responses

- Reduce agent workload

- Provide consistent customer experiences

- Surface contextual insights and recommended actions

To design effective AI agents, developers must understand how **channel context**, **agent context**, and **Copilot features** work together to support seamless interactions.

## Contact center channels and AI agent integration

AI agents can be integrated into the following Dynamics 365 Contact Center channels:

| **Channel** | **AI Integration Opportunity** |
|---|---|
| **Voice** | Real-time call summarization, call transcription, intent extraction, automated actions |
| **Live Chat** | Suggested replies, contextual answers, retrieving knowledge articles, escalation triggers |
| **Digital Messaging (SMS, WhatsApp)** | Automated conversational flows, routing, sentiment detection |
| **Omnichannel Widget** | Embedded AI assistant providing workflow guidance and customer insights |

### How AI integrates

AI agents can participate in customer interactions by:

- Observing and understanding conversation content

- Accessing customer and case context

- Using pre-configured workflows to automate actions

- Providing Copilot-powered suggestions to human agents

## Designing agent context

Agent context is the set of structured data that informs your AI agent about:

- The customer's identity

- Case history

- Current channel

- Conversation transcript

- Routing queues and priority

- Skills and preferences

When you configure agent context:

- Define entity types - such as Customer, Case, Product, Subscription

### Map agent context fields

Example fields:

- CaseID

- CustomerType

- Channel

- IssueCategory

- SentimentScore

### Expose the right data to the agent

Only the needed attributes should be included to improve accuracy, reduce noise, and meet privacy standards.

## Enabling Copilot features

Copilot features enhance agent performance with:

- **Conversation summaries** - Automatically structured recaps

- **Suggested actions** - Next-step recommendations

- **Knowledge retrieval** - Surfacing relevant articles

- **Customer insights** - Signals drawn from CRM history

- **Automated drafting** - Case notes, follow-up messages, emails

Copilot should be enabled per environment and per user role, ensuring correct permissions.

## Design considerations for AI agents

When creating AI agents for Contact Center integration:

### Ensure omnichannel awareness

Agents should understand the customer's channel and adapt communication style and capabilities accordingly.

### Align with workstreams

Associate agent behaviors to appropriate workstreams:

- Voice workstream

- Messaging workstream

- Persistent chat workstream

### Use guardrails

Implement constraints:

- Avoid unsupported actions

- Maintain safe language

- Follow escalation rules

### Maintain data security

Expose only required context attributes to maintain:

- Privacy

- Compliance

- Least-privileged access

## Chart: Components of an integrated contact center agent

| **Component** | **Description** |
|---|---|
| **Channel Context** | Voice, chat, messaging, identifying platform-specific behaviors |
| **Agent Context Model** | Structured data fields used for grounding |
| **Copilot Features** | Summaries, suggestions, knowledge retrieval |
| **AI Workflows** | Automated flows triggered by AI signals |
| **Security & Permissions** | Ensures safe access to customer data |

## References

Because all linked articles returned "expired," this unit's based on safe instructional content aligned to the following provided resources:

- _Get started with Dynamics 365 Contact Center - Training |_ [*Microsoft Learn*](/training/modules/get-started-contact-center/)

- _Configure agent context |_ [*Microsoft Learn*](/dynamics365/customer-service/develop/enable-bot-context)

- _Enable Copilot features |_ [*Microsoft Learn*](/dynamics365/contact-center/administer/configure-copilot-features)

