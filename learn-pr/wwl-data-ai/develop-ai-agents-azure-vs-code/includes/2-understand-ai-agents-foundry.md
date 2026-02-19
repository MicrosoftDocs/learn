An AI agent is a software service that uses generative AI to understand and perform tasks on behalf of users or other programs. Unlike traditional applications that follow predetermined rules, AI agents can operate independently by understanding context, making decisions, and taking actions to achieve specific goals. These agents combine advanced AI models with specialized tools to create intelligent automation that adapts to various scenarios.

The evolution of generative AI enables agents to behave intelligently on our behalf, transforming how we integrate AI into business processes and applications. Understanding what AI agents are and how to use them is crucial for automating tasks, making informed decisions, and enhancing user experiences.

## Why AI agents are useful

AI agents provide significant value across multiple dimensions:

**Automation of routine tasks** - AI agents handle repetitive and mundane activities, freeing human workers to focus on strategic and creative work. This leads to measurable increases in productivity and efficiency.

**Enhanced decision-making** - By processing vast amounts of data and providing insights, AI agents support better decision-making. They can analyze trends, predict outcomes, and offer recommendations based on real-time information. Unlike simple chat models that only generate text, AI agents use advanced algorithms and machine learning to analyze data and make informed decisions autonomously.

**Scalability** - AI agents scale operations without proportional increases in human resources. Organizations can grow their capabilities without significantly increasing operational costs.

**24/7 availability** - Like all software, AI agents operate continuously without breaks, ensuring tasks are completed promptly and services remain available around the clock.

## Examples of AI agent use cases

AI agents have diverse applications across industries:

### Personal productivity agents

Personal productivity agents assist with daily tasks like scheduling meetings, sending emails, and managing to-do lists. Microsoft 365 Copilot helps users draft documents, create presentations, and analyze data within the Microsoft Office suite.

### Research agents

Research agents continuously monitor trends, gather data, and generate reports. Financial services use them to track stock performance, healthcare organizations stay updated with medical research, and marketing teams analyze consumer behavior.

### Sales agents

Sales agents automate lead generation and qualification. They research potential leads, send personalized follow-up messages, and schedule sales calls. This automation lets sales teams focus on closing deals rather than administrative tasks.

### Customer service agents

Customer service agents handle routine inquiries, provide information, and resolve common issues. Integrated into chatbots on websites or messaging platforms, they offer instant support. For example, Cineplex uses an AI agent to process refund requests, significantly reducing handling time and improving customer satisfaction.

### Developer agents

Developer agents assist with software development tasks including code review, bug fixing, and repository management. They automatically update codebases, suggest improvements, and ensure coding standards are maintained. GitHub Copilot exemplifies this type of agent.

> [!TIP]
> To learn more about GitHub Copilot, explore the [GitHub Copilot fundamentals](/training/paths/copilot/) learning path.

## Security considerations for AI agents

As AI agents become more autonomous and integrated into enterprise systems, they introduce security considerations beyond traditional application threats. Because agents can access sensitive data, make decisions, and act independently, you must design with security in mind from the start.

Key security risks include:

| **Risk Area** | **Description** | **Example Impact** |
|----------------|-----------------|----------------------|
| **Data leakage and privacy exposure** | Agents often access sensitive business or user data. Without proper controls, they can unintentionally expose confidential information. | An agent summarizing internal files accidentally includes private data in customer-facing responses. |
| **Prompt injection and manipulation attacks** | Malicious users craft inputs that override an agent's intended behavior, tricking it into revealing data or performing unauthorized actions. | Hidden instructions in a message cause the agent to leak system credentials. |
| **Unauthorized access and privilege escalation** | Weak authentication or access controls let agents, or bad actors controlling them, access systems they shouldn't. | An agent connected to a CRM tool performs admin-level actions like exporting or deleting records. |
| **Data poisoning** | Attackers corrupt training or contextual data, causing agents to make biased, incorrect, or unsafe decisions. | A poisoned dataset causes a customer support agent to recommend harmful content. |
| **Supply chain vulnerabilities** | Agents rely on external APIs, plugins, or model endpoints, expanding the attack surface. | A compromised third-party plugin injects malicious code into the agent's workflow. |
| **Over-reliance on autonomous actions** | Highly autonomous agents may execute unintended actions if not carefully constrained or validated. | An agent mistakenly sends payments or publishes unverified content. |
| **Inadequate auditability and logging** | Without detailed logging, it's difficult to trace actions or detect malicious behavior early. | Security teams can't identify data misuse due to missing activity logs. |
| **Model inversion and output leakage** | Attackers might exploit model outputs to infer sensitive data used during training or prompting. | Repeated queries extract private information from a fine-tuning dataset. |

### Mitigation strategies

To reduce these risks, adopt a security-by-design approach that includes:

- Enforcing **role-based access controls (RBAC)** and **least privilege** permissions
- Adding **prompt filtering and validation** layers to prevent injection attacks
- Sandboxing or gating sensitive operations behind **human-in-the-loop approvals**
- Maintaining **comprehensive logging and traceability** for all agent actions
- Auditing **third-party dependencies** and integrations regularly
- Continuously retraining and validating models to detect **data drift** or **poisoning attempts**

By embedding these practices early in development, you can deploy AI agents safely and confidently in real-world environments.

## Microsoft Foundry Agent Service overview

Microsoft Foundry Agent Service is a fully managed service designed to empower developers to securely build, deploy, and scale high-quality AI agents without managing underlying compute and storage resources. The service allows you to create agents tailored to your needs through custom instructions and advanced tools.

Previously, creating agent-like experiences required significant coding effort using standard APIs. Microsoft Foundry Agent Service handles the complexity through a streamlined interface, enabling you to build agents via the Foundry portal or in your own applications with fewer than 50 lines of code.

### Key features of Microsoft Foundry Agent Service

The service offers several powerful capabilities:

**Automatic tool calling** - The service handles the entire tool-calling lifecycle, including running the model, invoking tools, and returning results. This eliminates complex integration code.

**Securely managed data** - Conversation states are securely managed with `conversations`, removing the need for manual state management.

**Out-of-the-box tools** - Built-in tools support file retrieval, code interpretation, and interaction with data sources like Bing, Azure AI Search, and Azure Functions.

**Model selection** - Choose from [various AI models](/azure/ai-foundry/agents/concepts/model-region-support?tabs=global-standard#available-models) to match your performance and cost requirements.

**Enterprise-grade security** - The service ensures data privacy and compliance with secure data handling and keyless authentication.

**Customizable storage solutions** - Use platform-managed storage or bring your own Azure Blob storage for full visibility and control.

These features provide a streamlined and secure way to build and deploy AI agents compared to developing with the Inference API directly.

> [!NOTE]
> You can explore more about agents in general with the [Fundamentals of AI agents](/training/modules/ai-agent-fundamentals) module.
