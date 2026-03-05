AI agents are smart applications that use **language models** to understand what you need and then **take action** to help you. They can answer questions, make decisions, and complete tasks automatically. What makes agents special is that they **remember your conversation** and can **actually do things**, not just chat with you like a typical chatbot.

:::image type="content" source="../media/ai-agent-architecture.png" alt-text="Diagram of an agent's components consisting of a language model, instructions, and tools.":::

## Identify the expense agent's capabilities

Recall the expense management agent from the introduction—an AI agent that helps employees manage expense claims by answering policy questions and automating claim submissions. Let's examine the three essential capabilities that make this agent effective:

- **Knowledge integration and reasoning**: Uses a generative model with corporate policy documentation to answer questions accurately.

- **Task automation through functions**: Executes programmatic functions to submit expense claims automatically.

- **Intelligent decision-making**: Routes expenses to appropriate approvers based on business rules and claim amounts.

An example of the expenses agent scenario is shown in the following diagram.

:::image type="content" source="../media/expenses-agent.png" alt-text="Diagram of an expenses agent answering questions and submitting claims.":::

The diagram shows the following process:

1. A user asks the expense agent a **question about expenses** that can be claimed.
1. The expenses agent accepts the question as a **prompt**.
1. The agent uses a **knowledge store** containing expenses policy information to **ground the prompt**.
1. The grounded prompt is submitted to the agent's **language model** to **generate a response**.
1. The agent **generates an expense claim** on behalf of the user and submits it to be processed and generate a check payment.

## Explore the travel agent's capabilities

In the previous unit, you also learned about a travel booking agent that extends this scenario into a multi-agent solution. This agent books flights and hotels, then automatically coordinates with the expense agent to submit claims. Here's how the travel agent demonstrates multi-agent coordination:

- **Service integration**: Books flights and hotels through external travel service APIs.
- **Cross-agent communication**: Initiates expense claims through the expense agent with appropriate receipts.
- **End-to-end automation**: Completes the entire travel booking and expense submission workflow without manual intervention.

An example of the multi-agent scenario is shown in the following diagram:

:::image type="content" source="../media/multi-agent.png" alt-text="Diagram of a travel booking agent working with an expenses agent.":::

The diagram shows the following process:

1. A user provides **details of an upcoming trip** to a travel booking agent.
1. The travel booking agent **automates the booking** of flight tickets and hotel reservations.
1. The travel booking agent **initiates an expense claim** for the travel costs through the expense agent.
1. The expense agent **submits the expense claim** for processing.

## Understand security risks of AI agents

As AI agents become more autonomous and integrated into enterprise systems, they introduce new security considerations that go beyond traditional application threats. Because agents can access sensitive data, make decisions, and act independently, developers and organizations must design with security in mind from the start.

| **What you might experience** | **Risk area** | **What's happening** |
|-------------------------------|---------------|----------------------|
| *"The agent just shared confidential salary data in a customer chat!"* | **Data leakage and privacy exposure** | The agent accessed sensitive information but lacked proper controls to prevent exposing it externally. |
| *"Someone tricked the agent into revealing our database password."* | **Prompt injection and manipulation attacks** | A malicious user crafted an input that overrode the agent's intended behavior. |
| *"Our support agent is now deleting customer records—but it shouldn't have that permission!"* | **Unauthorized access and privilege escalation** | Weak access controls allowed the agent to perform actions beyond its intended scope. |
| *"The agent started recommending fraudulent products after we updated the training data."* | **Data poisoning** | Someone corrupted the agent's training or contextual data, causing unsafe outputs. |
| *"A third-party plugin we integrated is now sending our data to an unknown server."* | **Supply chain vulnerabilities** | External dependencies introduced security vulnerabilities into the agent's workflow. |
| *"The agent automatically processed a refund without verifying the request."* | **Over-reliance on autonomous actions** | The agent executed an action without proper validation or human oversight. |
| *"We can't figure out who accessed what data or when."* | **Inadequate auditability and logging** | Missing or incomplete logs make it impossible to trace agent actions or detect misuse. |
| *"Someone extracted customer information by repeatedly querying the agent."* | **Model inversion and output leakage** | The attacker exploited model outputs to infer sensitive data from training or prompting. |

### Protect your agents with security best practices

To reduce these risks, adopt a **security-by-design** approach from day one. Here's how to build safer AI agents:

- **Control access tightly**: Enforce **role-based access controls (RBAC)** and **least privilege** permissions—agents should only access what they absolutely need.

- **Validate all inputs**: Add **prompt filtering and validation** layers to catch and block injection attacks before they reach your agent.

- **Add human oversight for critical actions**: Sandbox or gate sensitive operations behind **human-in-the-loop approvals**—don't let agents make high-stakes decisions alone.

- **Track everything**: Maintain **comprehensive logging and traceability** for all agent actions—you need to know who did what, when, and why.

- **Monitor your supply chain**: Audit **third-party dependencies** and integrations regularly—external plugins and APIs can be attack vectors.

- **Keep your models healthy**: Continuously retrain and validate models to detect **data drift** or **poisoning attempts**—agent quality degrades over time without maintenance.

When you embed these practices early in development, you can deploy AI agents safely and confidently in real-world environments.
