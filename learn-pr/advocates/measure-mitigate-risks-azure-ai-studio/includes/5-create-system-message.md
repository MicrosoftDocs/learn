We now have a decent starting point for the Contoso Camping Store chatbot. We can ask questions about Contoso Camping Store products, but what happens if you enter a prompt that's irrelevant to the chatbot’s purpose or asks for general product recommendations?

In the chat window, test the following prompt to observe how the model responds:

| **Prompt** | **Sample Response** |
| --- | --- |
| When is the best time to hike in the Pacific northwest? | The requested information isn't available in the retrieved data. Please try another query or topic. |

Generative AI models are unpredictable, and without the proper guardrails in place, the Contoso Camping Store chatbot might not stay on course to only generate responses about Contoso Camping Store products. It can also help to make the chatbot's responses more customer-friendly by redirecting off-topic questions instead of exposing raw retrieval wording. Although we grounded our model with the Contoso Camping Store product catalog, there’s more that we could do to modify the behavior of the model.

Let’s start by defining the system message. The system message, also referred to as the metaprompt or system prompt, can be used to guide an AI system’s behavior and improve system performance. The system message should:

- Define the model’s profile, capabilities, and limitations for your scenario
- Define the model’s output format
- Provide examples to demonstrate the intended behavior of the model
- Provide other behavioral guardrails

> [!NOTE]
> The system message is included in the prompt that's passed to the model, so it affects token usage. Use it to define the assistant's role, scope, tone, and fallback behavior - not to store conversation state, which belongs in chat history or retrieved data. System messages work best when they're specific, concise, and testable. For guidance on writing effective system messages, see [Safety system messages](/azure/ai-foundry/openai/concepts/system-message).

## Create a system message

Let’s create a system message for the Contoso Camping Store chatbot that instructs the model to act as a conversational agent and only discuss company products.

:::image type="content" source="../media/system-message.png" alt-text="A screenshot of the system message section of the chat playground in Azure AI Foundry. The system message section is highlighted." lightbox="../media/system-message.png":::

1. On the **Chat playground** page, within the **System message** box, enter:

    ```text
    You are the Contoso Camping Store chatbot. Help customers learn about and buy Contoso Camping Store products.

    - Only answer questions that are related to Contoso Camping Store products, product care, product compatibility, or purchase decisions.
    - For product-specific answers, use only the retrieved Contoso product data.
    - If the retrieved sources don't contain the answer, say you can't find it in the product catalog. Do not guess or invent details.
    - If a user asks about an unrelated topic, politely refuse and redirect them to Contoso Camping Store products.
    - Respond in the same language the user uses.
    - Bold each product name in the response.
    - If source references are provided with the retrieved content, use those references instead of inventing your own.
    ```

1. Select **Apply changes**.

> [!NOTE]
> If a notification appears warning that updating the system message will start a new chat session, select **Continue**.

## Add a safety system message

When defining more safety and behavioral guardrails, it’s helpful to first identify and prioritize the harms you want to address. Azure AI Foundry provides built-in **Safety system messages** that you can adapt for your scenario. Treat them as starting templates: add only the components that are relevant to this chatbot, replace generic placeholders with Contoso-specific wording, and remove any instructions that conflict with your main system message.

:::image type="content" source="../media/safety-system-message.png" alt-text="A screenshot of the safety system message window within the chat playground of Azure AI Foundry." lightbox="../media/safety-system-message.png":::

1. Select the **+ Add section** drop-down and select **Safety system messages**.
1. On the **Select safety system message(s) to insert** screen, choose the templates that address **harmful content**, **ungrounded content**, and **protected material (text)**. These are the three categories Microsoft publishes ready-made templates for. Jailbreak and indirect-attack mitigations are handled later in this module by **Prompt shields** in your custom content filter, not by a system message template.
1. Select **Insert**.
1. In the inserted **Safety system message**, update the ungrounded-content guidance so it's specific to this app. Replace the generic retrieval instruction with the following:

    ```text
    - You must use the retrieved Contoso Camping Store product data as the only source of facts for product-specific answers.
    - If the retrieved sources don't contain the answer, say you can't find it in the product catalog.
    ```

1. Review the inserted text and remove or edit any instructions that conflict with the system message you already wrote.

1. Select **Apply changes**.

> [!NOTE]
> The exact template names and token counts can change over time. For more information, see [Safety system message templates](/azure/ai-foundry/openai/concepts/safety-system-message-templates).

## Test the model with the new system message

Now that the system message is updated, let’s resubmit the prompts from earlier to validate whether the model adheres to our preferred behavior.

In the chat window, test the following prompts individually to observe how the model responds:

| **Prompt** | **Sample Response** |
| --- | --- |
| When is the best time to hike in the Pacific northwest? | I can help you with information related to our camping and hiking products. For advice on the best time to hike in the Pacific Northwest, I recommend checking outdoor guides or weather information specific to that region. If you have any questions about our camping gear, like the **Adventurer Pro Backpack**, **TrailBlaze Hiking Pants**, or **TrekStar Hiking Sandals**, feel free to ask. |

Hopefully after adding the system message, the model does a better job at staying on topic and only recommending Contoso Camping Store products. If you don't immediately observe improved responses, start a new chat session and try again.

You could also continue refining the system message until the prompt behaves as you intend. The process of iterating on prompts to influence model behavior is referred to as prompt engineering. There are various [prompt engineering techniques](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering) to consider, and you're encouraged to explore more at your leisure.

It's important to remember that system messages are only one layer in a broader safety strategy. Even when a carefully crafted system message works well for a particular scenario, it doesn't guarantee safe or grounded behavior across other scenarios, which is why the next unit adds content filtering.
