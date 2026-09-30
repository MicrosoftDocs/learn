Creating an agent is only the first step. Testing helps you understand how well the agent follows its instructions, uses available information, and produces the expected output.

In the previous exercise, you created the Customer Meeting Prep agent. You now need to determine whether it can produce a useful and reliable meeting brief. In this unit, you'll learn how to create effective test prompts, evaluate the agent's responses, and identify changes that can improve its performance.

| **Stage** | **Action** | **Goal** |
| :---: | :---: | :---: |
| Test | Submit a realistic request | Observe how the agent responds |
| Review | Evaluate the response | Identify what worked and what needs improvement |
| Adjust | Update the agent | Improve its instructions or knowledge |
| Repeat | Test the agent again | Confirm that the change improved the response |

## Test with a clear goal

Effective testing begins with knowing what a successful response should include. Without a clear expectation, it can be difficult to determine whether the agent performed its job correctly.

For the Customer Meeting Prep agent, a successful response should provide a structured brief that helps a sales team member prepare for a customer conversation.

The brief should:

- Summarize the customer information provided.
- Identify priorities, needs, or potential discussion topics.
- Connect customer priorities to relevant approved information.
- Suggest useful questions for the meeting.
- Clearly identify missing information.
- Avoid unsupported assumptions about the customer.

The goal isn't to produce the same response every time. The goal is to confirm that each response follows the agent's purpose and provides useful, grounded support.

## Use different types of test prompts

One successful response doesn't confirm that an agent is ready to use. Test prompts should represent different ways a person might interact with the agent.

Begin with a typical request that includes enough information for the agent to complete its task. Then test how the agent responds when information is missing or when a request falls outside its intended purpose.

| **Test type** | **What it evaluates** | **Example** |
| :---: | :---: | :---: |
| Typical request | How the agent performs its primary task | Prepare a meeting brief for a customer using the information provided |
| Incomplete request | Whether the agent identifies missing information | Help me prepare for my customer meeting |
| Follow-up request | Whether the agent can build on the conversation | Add five discovery questions to the brief |
| Out-of-scope request | Whether the agent stays focused on its purpose | Create a complete annual sales strategy |
| Knowledge-based request | Whether the agent uses an added knowledge source | Which approved product information is relevant to this customer? |

A strong agent should complete appropriate requests, ask for clarification when necessary, and avoid presenting unsupported information as fact.

## Review the response

Evaluate each response against the agent's intended purpose instead of judging it only by how polished it sounds. A well-written response might still be incomplete, inaccurate, or unsupported.

Use the following criteria when reviewing a response:

| **Evaluation area** | **Question to ask** |
| :---: | :---: |
| Accuracy | Does the response correctly represent the information provided? |
| Relevance | Does it focus on preparing for the customer meeting? |
| Completeness | Does it include the expected parts of the meeting brief? |
| Clarity | Is the response organized and easy to use? |
| Grounding | Can the response be supported by the provided information or approved knowledge? |
| Boundaries | Does the agent identify missing information instead of making assumptions? |

>[!IMPORTANT]
> Always review an agent's output before using or sharing it. An agent can provide useful support, but the user remains responsible for confirming that the information is accurate and appropriate for the situation.

## Identify what needs to change

When a response doesn't meet your expectations, identify the likely cause before editing the agent. Different problems require different adjustments.

| **If the agent...** | **Consider changing...** |
| :---: | :---: |
| Produces an inconsistent format | The instructions for organizing the response |
| Omits an important part of the brief | The required steps or output sections |
| Provides overly broad responses | The agent's purpose or scope |
| Makes unsupported assumptions | The instructions for handling missing information |
| Misses relevant information | The connected knowledge sources |
| Provides too much detail | The instructions for response length and priorities |
| Doesn't know how to begin | The starter prompts or examples |

Make one focused change at a time when possible. This makes it easier to determine whether the adjustment improved the agent's response.

## Record what you learn

During testing, keep track of:

- The prompt you used.
- What worked well.
- What information was missing.
- Any incorrect assumptions.
- Changes you plan to make.

Documenting your observations makes it easier to compare results after refining the agent.

## Refine the agent

Refinement is the process of updating an agent based on what you learn through testing. You might need to clarify an instruction, narrow the agent's purpose, improve the expected output format, or add relevant knowledge.

You can refine the Customer Meeting Prep agent by updating:

- **Description:** Clarify the agent's purpose and intended use.
- **Instructions:** Add missing steps, boundaries, or formatting requirements.
- **Knowledge:** Add or replace approved information the agent can reference.
- **Starter prompts:** Provide clearer examples of the tasks the agent supports.

For example, if the agent provides a general summary instead of a structured brief, add specific output sections to its instructions:

- Customer overview
- Meeting goal
- Customer priorities
- Relevant products or solutions
- Recommended discussion topics
- Suggested questions
- Missing information

After making a change, repeat the original test. Compare the new response with the previous response to determine whether the adjustment improved the result.

With an evaluation plan in place, you're ready to test the Customer Meeting Prep agent, review its responses, and make focused improvements in the next exercise.
