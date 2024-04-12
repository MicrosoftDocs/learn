
So now that there's a basic understanding of plugins, capabilities, and how the user interacts with Microsoft Copilot for Security through prompts, it’s worth taking a look under the hood to see how these components come together to process a prompt request and help security analysts.

### Process flow

When a user submits a prompt, Copilot processes that prompt to generate the best possible response. The diagram that follows illustrates, at a high level, steps that Copilot takes to process the prompt and generate a response.

:::image type="content" source="../media/copilot-how-it-works.png" lightbox="../media/copilot-how-it-works.png" alt-text="Diagram illustrating how Microsoft Copilot for Security processes a prompt request.":::

1. Submit a prompt: The process starts when a user submits a prompt in the prompt bar.

1. Orchestrator: Copilot for Security sends the information to the Copilot backend referred to as the orchestrator. The orchestrator is Copilot’s system for composing capabilities together to answer a user’s prompt. It determines the initial context and builds a plan using all the available capabilities (skills).

1. Build context: Once a plan is defined and built, Copilot executes that plan to get the required data context to answer the prompt.

1. Plugins: In the course of executing the plan, Copilot analyzes all data and patterns to provide intelligent insights. This includes reasoning over all the plugins and sources of data, enabled and available to Copilot.

1. Responding: Copilot combines all the data and context and uses the power of its advanced LLM to compose a response using language that makes sense to a human being.

1. Response: Before the response can be sent back to the user, Copilot formats and reviews the response as part of Microsoft's commitment to responsible AI.

1. Receives response: The process culminates with the user receiving the response from the Copilot.

#### Process log

During this process, Copilot generates a process log that is visible to the user. The user can see what capability is used to generate the response. This is important because it enables the user to determine whether the response was generated from a trusted source. In the screenshot that follows, the process log shows that Copilot chose the Incident Analysis capability. The process log also shows that the final output went through safety checks, which is part of Microsoft’s commitment to responsible AI.

:::image type="content" source="../media/process-log-new.png" lightbox="../media/process-log-new.png"alt-text="Screen capture of the process log that highlights the capability selected and the text indicating that Copilot ran safety checks as part of the process to compose the response message.":::
