Now that you understand what AI agents are and what the GitHub Copilot SDK offers, it's time to explore how AI agents are used in real business contexts. This unit examines five scenarios where AI agents go beyond simple question-and-answer interactions to deliver measurable business value. Each scenario describes the agent's role, how it works, and why it matters.

## E-commerce customer service agent

An online retail company deploys an AI agent to handle customer support and order operations. This agent is integrated into the company's web portal and assists customers with tasks like checking order status, initiating returns, processing refunds, and answering product questions. Rather than just answering questions, the agent takes actions in the order system on the customer's behalf.

### How agents work in a customer service scenario

When a customer says, "I received the wrong item, order 12345. I want to return it," the agent identifies the order number and issue. It calls a tool to retrieve order details from the backend system, verifies that the item was indeed incorrect, and then initiates a return request through another tool. The agent can also proactively offer a refund or replacement based on company policy.

The agent connects to the company's backend APIs through registered tools. It has tools for looking up orders, creating return requests, issuing refunds, and sending customer communications. When a customer says, "My order arrived damaged, what can I do?", the agent verifies the order details through an API call, then responds with both empathy and action: "I've initiated a return for you and scheduled a courier pickup for tomorrow. You'll receive a refund that's applied to your original payment method."

If the agent encounters a request outside its capability (like a complex policy dispute), it escalates to a human support representative and provides the context it gathered during the conversation.

### Why agents matter in a customer service scenario

This type of agent provides instant, 24/7 support that resolves issues rather than just providing information. The support team can focus on complex cases that require human judgment, while the agent handles routine inquiries autonomously. Guardrails ensure the agent operates within boundaries—for example, it won't process a refund above a certain amount without human approval, and it logs all actions for audit purposes.

> [!NOTE]
> The lab exercise in this module implements a simplified version of this e-commerce customer service scenario using the GitHub Copilot SDK.

## Sales CRM lead management agent

A software company integrates an AI agent with their Customer Relationship Management (CRM) system to qualify leads, enrich contact records, and handle initial customer outreach.

### How agents work in a sales CRM scenario

When a new lead arrives, the agent gathers information about the prospective customer, scores the lead based on predefined criteria, and updates the CRM record accordingly.

For high-scoring leads, the agent can assign the lead to a sales representative and draft a personalized introduction email. It can also answer basic product questions from prospects via email, acting as an automated sales development representative. The agent always involves a human salesperson when conversations move beyond the basics.

### Why agents matter in a sales CRM scenario

This approach automates the time-consuming parts of sales—research, data entry, and initial outreach—so that sales representatives can focus on qualified prospects and closing deals. Every inquiry receives a quick, informed follow-up, and lead scoring is applied consistently across all prospects.

## Finance and accounting automation agent

An enterprise finance department uses an AI agent to handle routine financial operations: invoice processing, expense reconciliation, and transaction matching.

### How agents work in a finance automation scenario

Each day, the agent processes incoming invoices by extracting relevant data (vendor name, amounts, due dates), then cross-references them against purchase orders in the enterprise resource planning (ERP) system.

If the invoice matches the purchase order within acceptable variance thresholds, the agent approves it for payment. When the agent detects discrepancies—like an invoice amount that exceeds the purchase order by more than the allowed tolerance—it flags the issue and routes it to a human accountant with a detailed explanation.

At month-end, the agent reconciles bank transactions against the company's ledger, identifying unmatched entries and creating draft journal entries for review.

### Why agents matter in a finance automation scenario

This agent follows its rules precisely—it never approves an invoice that exceeds policy thresholds—which improves both speed and compliance. Accounting staff shift from data entry to exception handling and analysis.

## Supply chain and inventory management agent

A retail business uses an AI agent to monitor inventory levels across warehouses, track supply shipments, and respond to real-time changes in demand or supply.

### How agents work in a supply chain scenario

The agent continuously checks stock levels, incoming shipment ETAs, and current sales velocity.

When the agent detects that a product is selling faster than forecasted in one region while another region has surplus stock, it can create a transfer request to rebalance inventory. If a supplier shipment is delayed, the agent updates inventory availability forecasts and alerts supply chain managers with recommendations. It can also identify slow-moving products and suggest redistribution or order adjustments.

### Why agents matter in a supply chain scenario

This type of agent helps reduce both stockouts (lost sales) and excess inventory (wasted expenditures). It makes the supply chain more responsive by detecting and addressing problems faster than periodic human reviews allow.

## IT operations and incident response agent

A technology company uses an AI agent as a first responder to system alerts and incidents.

### How agents work in an IT operations scenario

When a monitoring alert fires (such as high CPU usage on a database server), the agent investigates by running diagnostic scripts, analyzing logs, and attempting known remediation steps.

For example, if the agent detects a long-running query causing high CPU, it can terminate the query and verify that performance returns to normal. If it resolves the issue, it logs the actions taken and closes the incident. If the issue persists after exhausting its troubleshooting steps, the agent escalates to a human engineer with the diagnostic context it gathered.

### Why agents matter in an IT operations scenario

This agent is particularly valuable for its speed—it can begin investigating within seconds of an alert, rather than the minutes it takes for a human to notice and respond. Initial deployments typically restrict the agent to safe, reversible actions (like restarting services or clearing temp files) and require human approval for riskier operations.

## Comparing scenarios

The following table summarizes the key characteristics of each scenario:

| Scenario | Domain | Agent's role | Key benefit |
|---|---|---|---|
| E-commerce support | Retail | Resolves customer issues end-to-end | 24/7 instant service with autonomous resolution |
| Sales CRM | B2B sales | Qualifies leads and manages outreach | Consistent lead handling and faster follow-up |
| Finance automation | Financial operations | Processes invoices and reconciles transactions | Faster processing with policy compliance |
| Supply chain | Operations | Monitors inventory and rebalances stock | Fewer stockouts with reduced excess inventory |
| IT operations | DevOps | Investigates and remediates system alerts | Faster incident response with lower downtime |

A pattern emerges across all five scenarios: AI agents handle complex, multi-step tasks that previously required a human's constant attention. They serve as force multipliers for teams by taking on routine work and letting humans focus on exceptions and strategy.

## Summary

AI agents are transforming how businesses operate across domains. From customer service to finance to IT operations, agents are taking on tasks that require reasoning, tool use, and context management. By automating multi-step workflows and integrating with real systems, AI agents deliver faster, more consistent outcomes while freeing human workers to focus on higher-value activities. The GitHub Copilot SDK provides a powerful platform for building these agents, enabling you to bring the benefits of AI-driven automation to your applications.
