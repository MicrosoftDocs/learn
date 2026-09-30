Many workplace tasks require the same instructions and reference materials every time. Agents can help you turn repeatable tasks into reusable support. In Microsoft 365 Copilot Chat, you can create an agent with a clear purpose, tailored instructions, and relevant knowledge sources. You don't need coding experience to get started.

In this module, you'll build an agent that helps you prepare for customer meetings. You'll create its first version, test how it responds, and refine its instructions to improve the results.

>[!IMPORTANT]
> To complete the exercises in this module, you need a Microsoft 365 Copilot license and access to Microsoft 365 Copilot Chat. Agent Builder must also be available in your organization. Administrators can control whether Agent Builder is available to users. For more information, see [Agent Builder in Microsoft 365 Copilot](/microsoft-365/copilot/extensibility/agent-builder).

Before you begin, it helps to understand the elements you'll define while planning and configuring the agent. Some elements, such as the description, instructions, knowledge, and suggested prompts, appear directly in Agent Builder. Purpose and expected output are planning concepts that you express through those configuration fields.

| **Agent component** | **What it defines** |
| :---: | :---: |
| Purpose and audience | The job the agent is designed to perform and for whom |
| Instructions | How the agent should approach the task |
| Knowledge | The approved information the agent can reference |
| Expected output and success criteria | What the agent should help you produce and how it knows it has been successful |

## Example scenario

Customer meeting preparation is a strong first-agent scenario because it is repeatable, follows a recognizable process, and produces an output that a person can review before using.

Suppose you work on a sales team and regularly prepare for customer meetings. Before each meeting, you review account information, product materials, and previous notes to identify important details and potential discussion topics.

Although every customer is different, the preparation process often follows the same steps. Repeating those steps takes time and can make it difficult to prepare consistently.

You have decided to create a customer meeting preparation agent in Microsoft 365 Copilot Chat. The agent will use your instructions and selected knowledge sources to help summarize relevant information, identify key topics, and create a meeting preparation brief.

>[!NOTE]
> Only add files and knowledge sources that are approved for use by your organization. Access to organizational information is based on each user's existing permissions. If a user doesn't have permission to access a source, the agent can't use that source to provide information to that user. Confirm that the intended users can access required sources before sharing the agent.

## Learning objectives

By the end of this module, you'll be able to:

- Identify a focused, repeatable task that is appropriate for a first agent.
- Create an agent in Microsoft 365 Copilot Chat by defining its purpose, instructions, knowledge, and expected output.
- Test an agent with typical, incomplete, and out-of-scope requests.
- Refine an agent's instructions based on the results of testing.
