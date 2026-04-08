## Learning objectives

By the end of this unit, learners will be able to:
- Define key business terms required for Copilot features in Dynamics 365 Customer Service
- Map organizational vocabulary into structured fields that Copilot uses for summarization and assistance
- Understand how Copilot uses business terms to improve conversation summaries, case summaries, and agent experience
- Apply guidelines to configure, customize, and surface business terminology on customer service forms

## Introduction

Copilot in Dynamics 365 Customer Service enhances the agent experience by providing **real-time AI assistance**, including conversation summaries, case summaries, and automated insights. To ensure Copilot accurately reflects your organization's operations, you must define clear **business terms** that map to your specific customer experience processes. 

In Dynamics 365 Customer Experience, "business terms" refers to the standardized vocabulary your organization uses to describe data, processes, and concepts so that everyone—sales, service, marketing, IT, and leadership—speaks the same language. These terms ensure consistency across Dataverse, customer journeys, analytics, integrations, and governance.

What problem does this solve for a Customer Service organization?

Without aligned business terms, Copilot produces vague or inconsistent summaries.

- Agents lose trust in AI assistance
- Supervisors see inconsistent case outcomes
- Customers receive replies that don't match the organization's tone or terminology

In Dynamics 365 Customer Service, business terms are primarily stored in Dataverse fields, option sets, and classification metadata. Copilot reads these values directly when generating summaries and recommendations.

Business terms help Copilot:

- Use correct language in summaries

- Interpret customer service information more accurately

- Increase clarity and consistency across teams

- Align AI-generated content with business rules, terminology, and compliance needs

## Role of business terms in Copilot

Business terms allow Copilot to reflect the "voice of your organization." These include:

- Product names

- Service categories

- **Internal terminology** (e.g., SLA tiers, service channels)

- **Department or team names**

- **Case classifications and outcome terms**

Copilot references these business terms when generating:

- Conversation summaries

- Case summaries

- Automated insights displayed on custom forms

- Recommendations and next steps

For more information about business terms, see [Tailor Copilot specific business terminology](/dynamics365/release-plan/2024wave2/sales/dynamics365-sales/tailor-copilot-specific-business-terminology).

## Configuring business terms in Dynamics 365 Copilot

Dynamics 365 provides configuration controls that allow administrators to model their business vocabulary for Copilot.

### Turn on Copilot features

Administrators can enable Copilot features from **Customer Service admin center > Copilot**.

Enabling Copilot activates:

- Conversation summaries
- Case summaries
- Draft email replies
- Knowledge article suggestions
- Real-time agent assistance

Prerequisites include:

- Correct licensing
- Required security roles
- A Customer Service workspace environment
- Data availability for grounding

You can enable Copilot and its related summarization capabilities, including conversation summaries and case summaries.

For more information, see [Enable Copilot](/training/modules/configure-copilot/enable-copilot).

### Manage fields used for summaries

Copilot relies on the correct fields for summarization. You can:

- Select which fields Copilot should reference when producing summaries

- Exclude fields not relevant to your business

- Ensure the fields reflect accurate business terms and categories

For more information, see the following.

- [Enable Copilot](/training/modules/configure-copilot/enable-copilot)
- [Copilot map custom fields](/dynamics365/customer-service/administer/copilot-map-custom-fields)

For example, if your organization uses a custom field called _Issue Type_, you can map this field so Copilot includes it in case summaries. If you have legacy fields that no longer reflect your process, you can exclude them.

**If business terms are not defined or mapped correctly, Copilot may:**

- Misinterpret case categories
- Use outdated terminology
- Produce summaries that don't match internal processes
- Recommend incorrect next steps

### Customize conversation summaries

Copilot's conversation summaries are configurable so organizations can tailor the structure, terminology, and tone to match their customer service processes. These settings help ensure that summaries are not only accurate but also aligned with internal expectations for documentation, compliance, and agent handoff quality.

#### Summary Structure Options

- Paragraph Format
  - Produces a single, cohesive paragraph
  - Best for organizations that prefer narrative-style summaries or use free-form notes
  - Useful for quick reading during escalations or when agents need a fast overview
  - Works well in environments where agents are trained to interpret unstructured summaries
  
- Structured Format
  - Breaks the summary into predefined sections such as Customer Issue, Actions Taken, Pending Items, Next Steps, Resolution Status
  - Admins can select which fields and data points Copilot should include
  - Ideal for organizations with strict documentation standards or regulated industries
  - Improves consistency across agents and reduces variability in note-taking

#### Configuring business terms Copilot emphasizes

- Mapping key fields (Issue Type, Product Line, Service Tier)
- Ensuring option sets use clear, standardized terminology
- Prioritizing fields that reflect how the organization classifies cases
- Removing outdated or unused terms that could confuse Copilot

#### Customizing phrasing for next steps and outcomes

- Defining preferred phrasing for next steps
- Aligning language with internal SLAs or compliance requirements
- Ensuring summaries reflect the tone and professionalism expected in customer communications
- Reinforcing consistent handoff language between frontline agents and escalation teams

### Display Copilot outputs on custom forms

To create a unified and consistent agent experience, Copilot outputs can be surfaced across various forms and dashboards in Dynamics 365 Customer Service. This ensures that AI-generated insights are visible at the right moment in the workflow.

Custom case forms

- Add Copilot summary fields directly to custom case forms
- Display conversation summaries, case summaries, or recommended next steps alongside standard case data
- Useful for organizations that have heavily customized case layouts or industry-specific fields
- Ensures agents see AI insights without switching screens

Agent dashboards

- Surface Copilot summaries in dashboards used for triage, queue management, or supervisor oversight
- Provide quick visibility into recent customer interactions, key issues across cases, and trends in customer sentiment or topics
- Helps supervisors quickly assess case quality and agent workload

Role-specific service forms

- Tailor Copilot outputs based on role: Tier 1 agents, escalation teams, supervisors
- Ensures each role sees the level of detail appropriate for their responsibilities
- Supports more efficient handoffs and reduces the need for agents to re-read long transcripts

## Chart: Business term types used by Copilot

| **Business Term Type** | **Purpose in Copilot** |
|---|---|
| **Product / Service Names** | Improve comprehension of customer issues |
| **Case Fields (priority, category)** | Inform case summaries |
| **Organizational Terms** | Improve accuracy of agent assistance |
| **Resolution Vocabulary** | Support next step guidance and case outcomes |
| **Customer Segments** | Tailor insights based on customer profile |

## Best practices for designing business terms

- Use consistent naming across departments

- Avoid abbreviations unless commonly understood internally

- Align terminology with CRM fields used in case classification

- Review and update terms regularly to maintain accuracy

- Ensure business terms reflect language customers use in conversations

- Establish ownership for maintaining business terms across departments

## References

- [Configure Copilot in Dynamics 365 Customer Service](/training/modules/configure-copilot/)

- [Business processes glossary](/dynamics365/guidance/business-processes/glossary)
