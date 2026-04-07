## Unit overview

Prompt actions in Copilot Studio allow creators to define how an agent should _respond_, _reason_, and _take action_ based on user input. The Prompt Coach template helps teams build high-quality prompts that follow guidance, constraints, and best practices for conversational design. This unit teaches how to design effective prompt actions that produce reliable, grounded, and consistent agent responses.

## Learning objectives

By the end of this unit, learners will be able to:
- **Design prompt actions** that guide Copilot Studio agents to respond with clarity, accuracy, and contextual awareness.
- **Use the Prompt Coach template** to create reusable action blocks that improve agent behavior.
- **Apply structured prompting techniques** (goal, context, constraints, examples) to produce predictable agent outputs.
- **Integrate prompt actions** into topics, tasks, and workflows within the Copilot Studio agent experience.

## 1. What are prompt actions?

Prompt actions allow your Copilot Agent to:

- Generate natural language responses.

- Perform reasoning tasks.

- Transform or summarize content.

- Follow structured instructions and constraints.

- Interact with user inputs and variables.

- Improve consistency across all agent responses.

- Prompt actions behave as **reusable instruction blocks** the agent can call when needed.

## 2. Designing high-quality prompt actions

### 2.1 Use the Prompt Coach template

The Prompt Coach template (from Copilot Studio) helps authors:

- Break prompts into structured sections.

- Maintain consistency and quality.

- Increase predictability and reduce hallucinations.

- Align output with organizational standards (tone, terminology, safety).

#### Core Prompt Coach structure

| **Section** | **Purpose** |
|---|---|
| **Goal** | What the agent must achieve |
| **Context** | Relevant information, data, or user scenario |
| **Instructions / Rules** | Tone, constraints, allowed content |
| **Examples (optional)** | Demonstrations of correct output |
| **Output Format** | The exact structure for the response |

### 2.2 Principles for effective prompt actions

**Focus on task clarity**

- State what the agent must do in direct language.

- Avoid ambiguity.

- Use imperative verbs ("Summarize…", "Rewrite…", "Extract…")

**Use organizational tone and language**

Follow Microsoft Writing Style:

- Clear.

- Concise.

- Action-oriented.

- Include only what the user needs.

**Control output**

Use constraints to keep output predictable:

- Word limits.

- Required fields (e.g., summary, next steps, risks).

- Excluded content (no speculation, no unverified data).

## 3. Embedding prompt actions in Copilot Studio

Prompt actions can be added to:

- **Topics** (as part of conversation responses).

- **Agent Flows** (as reasoning steps before taking action).

- **Fallback logic** (to improve clarity and user recovery).

- **Business processes** (e.g., "Summarize case details before escalating").

Prompt actions operate alongside:

- System instructions.

- Knowledge sources.

- Action blocks (Dataverse, connectors, APIs).

## 4. Chart: Prompt action types

| **Prompt Type** | **Description** | **Example Scenario** |
|---|---|---|
| **Transform** | Rewrites content | Create professional rewrite of customer message |
| **Summarize** | Produces short, clear summary | Summaries for cases, chats, notes |
| **Extract** | Pulls entities or fields | Extract order number and issue type |
| **Generate** | Produces new text | Draft email response to customer |
| **Classify** | Categorizes input | Identify request as billing, onboarding, or support |


## 5. Best practices for designing prompt actions

- Keep prompts modular; avoid mixing multiple tasks in one prompt.

- Apply constraints: tone, output length, structure, restricted content.

- Use examples sparingly but effectively.

- Test prompts using multiple phrasing inputs.

- Use Prompt Coach for alignment, quality, and consistency.

- Use guarded language to avoid unverified content.

- Document all prompt actions for governance and auditing.

## 6. References

[Agent template prompt coach](/microsoft-365-copilot/extensibility/agent-template-prompt-coach)
