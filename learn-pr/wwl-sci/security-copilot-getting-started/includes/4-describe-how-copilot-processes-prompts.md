
So now that there's a basic understanding of plugins, capabilities, and how the user interacts with Microsoft Copilot for Security through prompts, it’s worth taking a look under the hood to see how these components come together to process a prompt request and help security analysts.

### Process flow

When a user submits a prompt, Copilot processes that prompt to generate the best possible response. The diagram that follows illustrates those process steps to provide a general understanding of what is happening and how the response comes to be.

:::image type="content" source="../media/process-prompts-figma-updated-logo-numbered.png" lightbox="../media/process-prompts-figma-updated-logo-numbered.png" alt-text="Diagram illustrating how Microsoft Copilot for Security processes a prompt request.":::

1. The process starts when a user submits a prompt in the prompt bar. Once the user submits their prompt, it's sent to the Copilot backend referred to as the orchestrator.  The orchestrator is Copilot’s system for composing capabilities together to answer a user’s prompt.

1. Copilot bundles the user prompt and a full list of Copilot capabilities for the enabled sources (plugins and knowledge bases) and then sends it to Azure OpenAI with the request to make a plan for fulfilling the user’s request

1. Azure OpenAI, runs advanced LLMs to match the prompt with the available capabilities and creates a plan (set of steps) for fulfilling the user’s request.  That plan is sent back to the orchestrator.
    1. If no capability is matched, the response to the user’s prompt is generated using the general knowledge LLM, and the process jumps to step 7.
    1. The general knowledge LLM is good at general knowledge and problem solving but isn't uniquely focused on security so there's a greater chance that the response provided isn't accurate.  For this reason, it's beneficial to enable plugins and connect to knowledge bases to bring a collection of resource specific capabilities to Copilot.  

1. Copilot's orchestrator executes the plan by running the code for the selected plugins/capabilities and calling the appropriate application programming interfaces (API) to gather information and to take action.

1. The first- and third-party integration partner apps gather information and execute actions based on the API call and sends the response back to Copilot.

1. The orchestrator receives the response from the API calls, but it’s still not ready to be sent to the user.  Copilot iterates on the process to ensure best response. Before a final response can be sent to the user, the orchestrator bundles that response with the original prompt, and sends it back to Azure OpenAI.

1. Azure OpenAI uses the power of its advanced LLM to compose a response using language that makes sense to a human being.

1. That response is sent back to Copilot for review by Microsoft’s responsible AI models that look for anything malicious, hate speech, etc.
    1. If everything looks good, then the response is sent to the user.
    1. If something malicious or inappropriate is detected, then an error message is generated instead of sending the information to the user.

1. The user receives the response from the Copilot.

#### Process log

During this process, Copilot generates a process log that is visible to the user. The user can see what capability is used to generate the response. This is important because it enables the user to determine whether the response was generated from a trusted source. In the screenshot that follows, the process log shows that Copilot chose the Microsoft Sentinel plugin and lists the selected capability. The process log also shows that the final output went through safety checks, which is part of Microsoft’s commitment to responsible AI.

:::image type="content" source="../media/process-log-new.png" lightbox="../media/process-log-new.png"alt-text="Screen capture of the process log that highlights the capability selected and the text indicating that Copilot ran safety checks as part of the process to compose the response message.":::
