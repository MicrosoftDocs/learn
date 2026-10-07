Before you create an agent, translate the support need into clear requirements. In this exercise, you create a planning brief for the Contoso IT support agent that defines its audience, scope, knowledge, behavior, escalation approach, and validation criteria.

You can reuse the same planning process later for an agent in your own organization or scenario. Keep the completed planning brief available because you'll use it when you configure and test the agent in later exercises.

:::image type="content" source="../media/support-agent-planning-session.jpg" alt-text="Photo of a team planning a support agent.":::

## Create the planning brief

Begin by creating a structure in which you can record your planning decisions.

1. Open a blank document or another location where you can record your work.

1. Add the following structure:

   ```text
   Contoso IT support agent planning brief

   Purpose

   Audience

   In-scope requests

   Out-of-scope requests

   Knowledge source

   Expected behavior

   Escalation

   Validation criteria
   ```

1. Save the planning brief so that you can use it in later exercises.

> [!TIP]
> If you're adapting this exercise for your own support scenario, replace the Contoso requirements with the purpose, audience, requests, and approved knowledge sources for your agent.

## Define the purpose and audience

Start by identifying the problem the agent should help solve and the people it should support. A focused purpose should explain who the agent supports and what it helps them accomplish.

1. Under **Purpose**, write a one-sentence statement that describes the problem the agent should help solve.

   Avoid a broad statement such as "Help employees with technology."

1. Under **Audience**, identify:

   - Who will interact with the agent.
   - What type of assistance they need.
   - What they might already know.
   - What terminology is appropriate for them.

1. Review the purpose and audience together. Confirm that the purpose addresses a specific need of the intended audience.

For the Contoso scenario, consider the following requirements:

- The agent supports Contoso employees.
- Employees need help finding guidance about approved software, device setup, password-reset procedures, and common technical issues.
- The agent should help employees find relevant information or determine when they need assistance from the IT help desk.

## Classify employee requests

The support agent might receive different types of requests. Some requests can be answered by using the approved support guide. Other requests might require clarification, fall outside the agent's scope, reveal a gap in the available knowledge, or require assistance from a support technician.

Use the following request types:

| Request type | Description |
| --- | --- |
| **Supported** | The request is within scope and can be answered by using the approved guide. |
| **Ambiguous** | The employee hasn't provided enough information to identify the issue. |
| **Out of scope** | The request falls outside the agent's intended purpose or involves sensitive information. |
| **Knowledge gap** | The request is clear and within scope, but the approved guide doesn't contain enough information. |
| **Requires escalation** | The issue requires account access, investigation, or assistance from a support technician. |

A request can reveal a knowledge gap and require escalation. When this happens, classify the request according to the immediate response you expect from the agent and record the knowledge gap in your explanation.

For this exercise, assume that the approved guide doesn't contain information about connecting Linux devices to the corporate network.

Review the following employee requests:

| Employee request |
| --- |
| "How can I reset my password?" |
| "My computer isn't working." |
| "Which personal laptop should I purchase?" |
| "I followed the sign-in instructions, but I still can't access my account." |
| "Where can I find the approved software list?" |
| "Can you tell me my manager's password?" |
| "How do I connect a Linux device to the corporate network?" |

1. Classify each request by using one of the request types.

1. Describe how the agent should respond.

1. Explain why the response is appropriate for the agent's purpose and boundaries.

1. Record your decisions in the following table:

   | Employee request | Request type | Expected agent response | Reason |
   | --- | --- | --- | --- |
   | "How can I reset my password?" |  |  |  |
   | "My computer isn't working." |  |  |  |
   | "Which personal laptop should I purchase?" |  |  |  |
   | "I followed the sign-in instructions, but I still can't access my account." |  |  |  |
   | "Where can I find the approved software list?" |  |  |  |
   | "Can you tell me my manager's password?" |  |  |  |
   | "How do I connect a Linux device to the corporate network?" |  |  |  |

> [!IMPORTANT]
> Classify requests for passwords, credentials, personal information, or other sensitive data as out of scope. The agent should never request, retrieve, or expose this information.

## Establish the scope and boundaries

Use your request classifications to define what the agent should and shouldn't support.

1. Under **In-scope requests**, list the types of requests the agent should support.

   For the Contoso scenario, consider requests about:

   - Approved software.
   - Device setup.
   - Password-reset guidance.
   - Common technical issues covered by the approved guide.

1. Under **Out-of-scope requests**, list the types of requests the agent shouldn't address.

   Consider requests involving:

   - Personal technology recommendations.
   - Unsupported products.
   - Information unrelated to internal IT support.
   - Passwords, credentials, or confidential account information.

1. Identify requests that are related to IT support but require assistance from a support technician.

1. Confirm that every in-scope request can be supported by information in the approved IT support guide.

1. Confirm that the scope supports the agent's purpose without expanding beyond the available information.

Your plan should distinguish among requests that the agent can answer, requests that require clarification, requests outside its purpose, knowledge gaps, and issues that require escalation.

## Evaluate the knowledge source

Knowledge sources should be relevant, authoritative, current, accessible, and appropriate for the intended audience.

For this scenario, assume that the Contoso IT support guide:

- Is maintained and approved by the Contoso IT team.
- Contains current procedures for common employee IT issues.
- Is available to all Contoso employees.
- Contains no passwords, credentials, personal information, or other sensitive data.
- Contains information about approved software, device setup, password-reset procedures, and common technical issues.
- Doesn't contain information about connecting Linux devices to the corporate network.

1. Under **Knowledge source**, identify the approved Contoso IT support guide.

1. Evaluate the guide by using the following criteria:

   | Criterion | Question to consider | Result and explanation |
   | --- | --- | --- |
   | Relevant | Does the guide contain information that supports the agent's purpose? |  |
   | Authoritative | Is the guide maintained or approved by an appropriate owner? |  |
   | Current | Does the guide contain current policies and procedures? |  |
   | Accessible | Is the information available to the intended users, and are they permitted to access it? |  |
   | Appropriate | Can the guide be used without exposing sensitive or unnecessary information? |  |

1. For each criterion, record whether the guide satisfies the criterion and briefly explain your decision.

1. If you identify a concern, describe what should be resolved before the source is added to the agent.

> [!IMPORTANT]
> Use only knowledge sources approved for the agent and its intended audience. Don't add passwords, credentials, personal information, or other sensitive data to knowledge sources, exercise files, or agent instructions.

## Define the expected behavior

Describe how the agent should communicate and respond to different types of requests. You'll use this description when you configure the agent's instructions.

1. Under **Expected behavior**, describe how the agent should respond to:

   - A supported request that the guide can answer.
   - An ambiguous request that requires more information.
   - An out-of-scope request.
   - A knowledge gap in which the guide doesn't provide enough information.
   - An issue that requires assistance from a support technician.

1. Confirm that the planned behavior directs the agent to:

   - Use information from the approved guide.
   - Communicate clearly and concisely.
   - Ask a relevant clarifying question when necessary.
   - Acknowledge when it doesn't have enough information.
   - Avoid inventing procedures or presenting unsupported information as fact.
   - Explain when a request falls outside its scope.
   - Direct employees to the IT help desk when additional assistance is required.

1. Write a short planned-behavior statement.

   You can begin with the following sentence:

   > Provide clear answers to internal IT support questions by using the approved Contoso IT support guide.

1. Complete the statement by defining how the agent should handle ambiguous, out-of-scope, knowledge-gap, and escalation requests.

## Define the escalation approach

An escalation approach defines when the agent should stop providing guidance and direct the employee to human support.

1. Under **Escalation**, identify situations in which the agent should direct an employee to the IT help desk.

   Include situations in which:

   - The employee followed the documented procedure, but the issue wasn't resolved.
   - The approved guide doesn't contain enough information.
   - The request requires account access, investigation, or assistance from a technician.
   - Continuing without human assistance could result in incorrect or inappropriate guidance.

1. Write the message that the agent should provide when it escalates a request.

1. Confirm that the escalation message:

   - Briefly explains why additional assistance is needed.
   - Directs the employee to the IT help desk.
   - Doesn't claim that the issue has been resolved.
   - Doesn't make commitments on behalf of the help desk.

## Create validation criteria

Validation criteria describe the observable behavior you expect from the completed agent. You'll use these criteria later to evaluate its responses.

1. Under **Validation criteria**, add the following table:

   | Request type | Representative request | Validation criterion |
   | --- | --- | --- |
   | Supported | "Where can I find the approved software list?" | The agent provides relevant guidance from the approved Contoso IT support guide. |
   | Ambiguous | "My computer isn't working." | The agent asks a relevant clarifying question instead of assuming the employee's intent. |
   | Out of scope | "Which personal laptop should I purchase?" | The agent explains that personal purchasing recommendations are outside its internal IT support scope. |
   | Knowledge gap |  |  |
   | Requires escalation |  |  |

1. Review the **Supported**, **Ambiguous**, and **Out-of-scope** examples. Confirm that each criterion describes observable agent behavior.

1. Complete the **Knowledge gap** and **Requires escalation** rows with a representative request and an observable validation criterion.

1. Add at least one representative request of your own. Choose a request that could reveal whether the agent's purpose, instructions, knowledge, or boundaries require further refinement.

1. Review each criterion and confirm that it describes behavior you can observe.

> [!TIP]
> Avoid general validation criteria such as "The response is good" or "The agent works correctly." Describe the specific information or behavior that should appear in the response.

## Check your work

Review your completed planning brief before continuing. Confirm that it includes:

- A focused purpose.
- A defined audience.
- In-scope and out-of-scope requests.
- An evaluated and approved knowledge source.
- Expected behavior for each request type.
- An escalation approach.
- Observable validation criteria.

## Exercise result

You created a planning brief that defines the support agent's purpose, audience, scope, knowledge source, expected behavior, escalation approach, and validation criteria.

Save the completed planning brief and keep it available. In the next unit, you'll examine how these planning decisions map to the settings you configure when creating an agent in Microsoft Copilot Studio.
