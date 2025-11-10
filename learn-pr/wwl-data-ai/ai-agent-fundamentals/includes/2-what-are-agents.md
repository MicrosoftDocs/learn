AI agents are smart software services that combine generative AI models with contextual data and the ability to automate tasks based on user input and environmental factors that they perceive.

For example, an organization might build an AI agent to help employees manage expense claims. The agent might use a generative model combined with corporate expenses policy documentation to answer employee questions about what expenses can be claimed and what limits apply. Additionally, the agent could use a programmatic function to automatically submit expense claims for regularly repeated expenses (such as a monthly cellphone bill) or intelligently route expenses to the appropriate approver based on claim amounts.

An example of the expenses agent scenario is shown in the following diagram.

![Diagram of an expenses agent answering questions and submitting claims.](../media/expenses-agent.png)

The diagram shows the following process:

1. A user asks the expense agent a question about expenses that can be claimed.
1. The expenses agent accepts the question as a prompt.
1. The agent uses a knowledge store containing expenses policy information to ground the prompt.
1. The grounded prompt is submitted to the agent's language model to generate a response.
1. The agent generates an expense claim on behalf of the user and submits it to be processed and generate a check payment.

In more complex scenarios, organizations can develop *multi-agent* solutions in which multiple agents coordinate work between them. For example, a travel booking agent could book flights and hotels for employees and automatically submit expense claims with appropriate receipts to the expenses agent, as shown in this diagram:

![Diagram of a travel booking agent working with an expenses agent.](../media/multi-agent.png)

The diagram shows the following process:

1. A user provides details of an upcoming trip to a travel booking agent.
1. The travel booking agent automates the booking of flight tickets and hotel reservations.
1. The travel booking agent initiates an expense claim for the travel costs through the expense agent.
1. The expense agent submits the expense claim for processing.

## Understand security risks of AI Agents

As AI agents become more autonomous and integrated into enterprise systems, they introduce new security considerations that go beyond traditional application threats. Because agents can access sensitive data, make decisions, and act independently, developers and organizations must design with security in mind from the start.

The table below summarizes key security risks to consider when developing or deploying AI agents:

| **Risk Area** | **Description** | **Example / Impact** |
|----------------|-----------------|----------------------|
| **Data Leakage and Privacy Exposure** | AI agents often access sensitive business or user data to perform tasks. Without proper controls, they can unintentionally expose or share confidential information. | An agent summarizing internal files accidentally includes private data in a customer-facing chat. |
| **Prompt Injection and Manipulation Attacks** | Malicious users can craft inputs that override an agent’s intended behavior, tricking it into revealing data or performing unauthorized actions. | A user embeds hidden instructions in a message, causing the agent to leak system credentials. |
| **Unauthorized Access and Privilege Escalation** | Weak authentication or access controls can let agents—or bad actors controlling them—access data or systems they shouldn’t. | An AI agent connected to a CRM tool performs admin-level actions, like exporting or deleting records. |
| **Data Poisoning** | Attackers may corrupt training or contextual data, causing the agent to make biased, incorrect, or unsafe decisions. | A poisoned dataset causes a customer support agent to recommend fraudulent or harmful content. |
| **Supply Chain Vulnerabilities** | Agents often rely on external APIs, plugins, or model endpoints, which expand the attack surface. | A compromised third-party plugin injects malicious code into the agent’s workflow. |
| **Over-Reliance on Autonomous Actions** | Highly autonomous agents may execute unintended actions if not carefully constrained or validated. | An agent mistakenly sends payments or publishes unverified content. |
| **Inadequate Auditability and Logging** | Without detailed logging, it’s difficult to trace actions or detect malicious behavior early. | Security teams cannot identify data misuse due to missing or incomplete activity logs. |
| **Model Inversion and Output Leakage** | Attackers might exploit model outputs to infer sensitive data used during training or prompting. | Repeated queries extract private information that was part of a fine-tuning dataset. |

### Mitigation Strategies
To reduce these risks, developers should adopt a **security-by-design** approach that includes:

- Enforcing **role-based access controls (RBAC)** and **least privilege** permissions.  
- Adding **prompt filtering and validation** layers to prevent injection attacks.  
- Sandboxing or gating sensitive operations behind **human-in-the-loop approvals**.  
- Maintaining **comprehensive logging and traceability** for all agent actions.  
- Auditing **third-party dependencies** and integrations regularly.  
- Continuously retraining and validating models to detect **data drift** or **poisoning attempts**.  

By embedding these practices early in development, organizations can deploy AI agents safely and confidently in real-world environments.
