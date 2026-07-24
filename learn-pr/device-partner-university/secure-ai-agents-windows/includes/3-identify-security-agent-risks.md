As AI agents take on more responsibility, the types of security risks they introduce also change.

AI experiences that primarily generate responses can influence decisions, but AI agents go a step further. They can retrieve information, invoke tools and services, and perform actions across multiple systems. As a result, an incorrect decision or unintended action can have a direct impact on business processes, data, and applications.

Understanding where these risks occur is the first step toward securing AI agents. Windows helps organizations apply security controls such as identity, policy enforcement, monitoring, and runtime protection to reduce risk throughout an agent workflow.

## Why the risk changes

As you learned in the previous unit, AI agents differ from AI experiences because they can interact with data, tools, and business systems. Those additional capabilities also change the potential impact when something goes wrong.

The following comparison shows how moving from generating responses to performing actions introduces new security considerations.

| AI experiences | AI agents |
| --- | --- |
| Incorrect or misleading responses | Unintended or unauthorized actions that affect business systems |
| Limited to a single interaction | Multi-step actions across systems |
| User remains in control of execution | Agents may complete approved tasks with minimal user input |
| Lower impact on systems and data | Greater potential impact on systems, data, and workflows |

These differences help explain why securing AI agents requires more than traditional application security. The next step is understanding where those risks can occur during an AI agent workflow.

## Where risk occurs

AI agents typically complete tasks by retrieving information, interacting with tools and services, and performing actions. Each stage introduces distinct security risks that organizations must consider.

:::image type="content" source="../media/agent-security-foundation.png" alt-text="Illustration of security controls helping protect agent workflows, data access, and connected services.":::

Each stage of an AI agent workflow introduces different types of security risk.

| Workflow stage | Example activity | Potential security risk |
| --- | --- | --- |
| **Retrieve data** | Access CRM records, emails, or documents | Accessing data beyond approved permissions |
| **Invoke tools and services** | Connect to Microsoft Teams, Outlook, APIs, or business applications | Connecting to unauthorized tools or services |
| **Perform actions** | Create meetings, update records, or send communications | Performing actions without appropriate approval or oversight |

Together, these stages illustrate how an AI agent can introduce different security considerations as it progresses from accessing information to performing actions.

## Scenario: As the agent begins working

The meeting assistant now begins working toward its goal.

To prepare for the meeting, the agent retrieves customer information, connects to business applications, and drafts follow-up communications. Each step helps complete the task, but each one also introduces potential security risks if it isn't properly controlled.

The following example illustrates how an AI agent might complete a business task.

| Workflow step | Example |
| --- | --- |
| Goal | A user asks an AI agent to prepare for a customer meeting |
| Retrieve data | The agent gathers information from CRM records, emails, and documents |
| Invoke tools and services | The agent connects to business applications such as Microsoft Teams or Outlook |
| Perform actions | The agent creates a meeting, updates customer records, and drafts a follow-up email |

> [!TIP]
> As you review the workflow, consider which step would introduce the greatest risk in your organization.
>
> The answer may depend on the data being accessed, the tools being used, and the actions the agent is allowed to perform.

**Potential risks include:**

- Accessing data beyond approved permissions.
- Invoking tools or services that weren't intended for the task.
- Performing actions without the appropriate approval.
- Combining multiple actions in unexpected ways.

Unlike many traditional applications, AI agents can adapt their behavior as they work toward different goals. Because their actions may vary depending on the task and the information they receive, organizations need security controls that extend beyond traditional application security.

## Securing agent workflows

The risks introduced throughout an AI agent workflow require more than securing applications or data alone. Organizations must also govern how agents behave as they interact with systems and complete tasks.

Security capabilities help reduce risk while allowing AI agents to operate effectively.

| Security focus | Example | Why it matters |
| --- | --- | --- |
| **Visibility** | Review agent activity logs | Understand what agents are doing and when actions occur |
| **Access control** | Limit access to approved CRM data | Restrict agents to only the data, tools, and services they need |
| **Policy enforcement** | Require approval before sending emails | Apply rules that define what agents are allowed to do |
| **Runtime protection** | Monitor agent behavior during execution | Help ensure agents execute tasks safely while running |

As AI agents become more capable, organizations must shift from protecting individual applications to securing entire agent workflows.

In the next unit, you explore how identity and governance help enforce these protections so AI agents can securely access approved resources and perform authorized actions.