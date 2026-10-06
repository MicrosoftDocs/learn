Effective agents begin with a clear plan. Before configuring an agent, identify:

- Who the agent will support.
- What it should help users accomplish.
- Which approved knowledge sources it can use.
- How it should respond to supported, ambiguous, and out-of-scope requests.

For the Contoso scenario, you plan how to create an agent that uses an approved IT support guide to answer common employee questions. In this unit, you identify the decisions needed before you begin configuration.

:::image type="content" source="../media/copilot-studio-create-animation.gif" alt-text="Animation showing how to create an agent in Copilot Studio.":::

Use the following planning decisions to turn the support need into requirements that you can configure and test:

| Planning decision | Question to consider |
|---|---|
| **Purpose** | What problem should the agent help solve? |
| **Audience** | Who will interact with the agent? |
| **Scope** | Which requests should the agent handle? |
| **Knowledge sources** | Which approved information should the agent use? |
| **Behavior** | How should the agent respond to supported, ambiguous, and out-of-scope requests? |
| **Validation** | How will you determine whether the agent performs as intended? |

A useful agent plan connects the agent's purpose, instructions, knowledge, behavior, and validation criteria into a single design that can be implemented and tested.

## Define the agent's purpose and audience

A clear purpose describes the problem the agent should help solve. A focused purpose makes it easier to select relevant knowledge, write effective instructions, and evaluate the agent's responses.

Identify the intended audience at the same time. Consider what users already know, the terminology they use, and the type of assistance they expect. An agent designed for employees might use internal terminology, while an agent intended for customers might require different language and information.

For the Contoso scenario, you can define the purpose and audience as follows:

- **Purpose:** Help employees find answers to common internal IT support questions.
- **Audience:** Contoso employees who need assistance with approved software, device setup, password resets, and common technical issues.
- **Expected outcome:** Employees receive relevant guidance or are directed to the IT help desk when additional assistance is required.

A purpose should be specific enough to guide the agent's behavior. For example, “Help employees with IT support questions” provides clearer direction than “Help employees.”

## Establish the agent's scope and boundaries

The scope identifies the requests the agent is intended to handle. Boundaries identify requests that the agent shouldn't handle. Together, they help keep the agent focused on its intended use.

For the Contoso IT support agent, the scope includes questions covered by the approved IT support guide. Requests involving unsupported products, confidential account information, or issues that require a support technician fall outside that scope.

| Request type | Example | Planned behavior |
|---|---|---|
| **Supported** | "How do I reset my password?" | Provide guidance from the approved support guide. |
| **Ambiguous** | "My computer isn't working." | Ask for additional information before providing guidance. |
| **Out of scope** | "Which personal laptop should I purchase?" | Explain that the request is outside the agent's purpose. |
| **Knowledge gap** | "How do I connect a Linux device to the corporate network?" | Acknowledge that the approved guide doesn't contain enough information and identify an appropriate next step. |
| **Requires escalation** | "I followed the steps, but I still can't sign in." | Direct the employee to the IT help desk. |

Plan how the agent should respond in each situation. The agent can answer a supported request, ask a clarifying question when a request is ambiguous, explain when a request is outside its purpose, acknowledge a gap in the approved knowledge, or direct the employee to the IT help desk when additional assistance is required.

## Select appropriate knowledge

Knowledge sources provide information that an agent can use to formulate its responses. Select sources that are relevant to the agent's purpose, appropriate for its audience, and approved for use by your organization.

For the Contoso scenario, the approved IT support guide is the agent's knowledge source. Before using the guide, confirm that its information is accurate, current, and appropriate for all intended users.

Use the following criteria to evaluate a potential knowledge source:

- **Relevant:** The source contains information that supports the agent's defined purpose.
- **Authoritative:** An identifiable owner approves the source and is responsible for keeping it current.
- **Current:** The source doesn't contain outdated policies or procedures.
- **Accessible:** The intended users are permitted to access the information.
- **Appropriate:** The source doesn't expose sensitive or unnecessary information.

A source being accessible to the maker or intended users doesn't necessarily mean that it is approved for this agent, purpose, or audience.

> [!IMPORTANT]
> Use only knowledge sources that your organization has approved for the agent and its intended audience. Don't add passwords, credentials, personal information, confidential account information, regulated information, security-sensitive details, contractually restricted information, or other information that hasn't been approved for the agent, environment, and intended audience.

Adding more knowledge doesn't always make an agent more useful. Sources that contain unrelated, conflicting, or outdated information can make it more difficult to evaluate whether the agent is providing an appropriate response.

## Plan the agent's behavior

The agent's planned behavior describes how it should communicate and respond. These decisions will help you write its instructions when you create it in Copilot Studio.

Consider how the agent should:

- Use information from its approved knowledge source.
- Respond clearly and concisely for its intended audience.
- Ask a clarifying question when a request lacks necessary details.
- Acknowledge when it doesn't have enough information.
- Avoid inventing procedures or presenting uncertain information as fact.
- Direct users to the IT help desk when a request requires additional support.

For the Contoso agent, the planned behavior could be:

**Provide clear answers to internal IT support questions by using the approved Contoso IT support guide. Ask for clarification when a request is ambiguous. If the guide doesn't contain an answer or the issue requires additional assistance, direct the employee to the IT help desk.**

Defining this behavior before creating the agent provides a starting point for its instructions. You can refine those instructions later based on how the agent responds during testing.

## Define validation criteria

Validation criteria describe what the agent must do to satisfy the scenario requirements. Define these criteria before testing so that you can evaluate the agent consistently instead of relying on whether a response simply appears helpful.

The Contoso IT support agent should satisfy the following criteria:

- It answers supported questions by using the approved IT support guide.
- It provides responses that are relevant and understandable.
- It asks for clarification when a request is ambiguous.
- It doesn't present unsupported information as fact.
- It recognizes requests outside the scope of internal IT support.
- It directs employees to the IT help desk when additional assistance is required.

> [!TIP]
> Planning helps define an agent's purpose, scope, knowledge sources, behavior, and escalation process before you build it. For additional best practices and implementation recommendations, see the [Microsoft Copilot Studio implementation guidance](/microsoft-copilot-studio/guidance/overview).

Agent-generated responses can vary, even when users submit similar requests. Test representative requests and review the responses against the validation criteria to determine whether the agent behaves consistently with its intended purpose.

In the next exercise, you apply these planning decisions to document the purpose, audience, scope, knowledge source, expected behavior, escalation approach, and validation criteria for the Contoso IT support agent.
