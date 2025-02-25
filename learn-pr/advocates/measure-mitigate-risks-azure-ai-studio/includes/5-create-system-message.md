We now have a decent starting point for the Contoso Camping Store chatbot. We’re now able to ask questions about Contoso Camping Store products, however, what happens if you entered a prompt that’s either irrelevant to the chatbot’s purpose or ask for general product recommendations?

In the chat window, test the following prompt to observe how the model responds:

| **Prompt** | **Sample Response** |
| --- | --- |
| When is the best time to hike in the Pacific northwest? | The requested information is not available in the retrieved data. Please try another query or topic. |

Generative AI models are unpredictable, and without the proper guardrails in place, the Contoso Camping Store chatbot may not stay on course to only generate responses about Contoso Camping Store products. Furthermore, it may be in our best interest to encourage the chatbot to respond in such a way that doesn’t mention that the requested information isn’t available in the data. Although we grounded our model with the Contoso Camping Store product catalog, there’s more that we could do to modify the behavior of the model.

Let’s start by defining the system message. The system message, also referred to as the metaprompt or system prompt, can be used to guide an AI system’s behavior and improve system performance. The system message should:

- Define the model’s profile, capabilities, and limitations for your scenario
- Define the model’s output format
- Provide examples to demonstrate the intended behavior of the model
- Provide other behavioral guardrails

> [!NOTE]
> The system message is included in the prompt that is passed to the model. Therefore, the system message will impact your token-usage.

## Create a system message

Let’s create a system message for the Contoso Camping Store chatbot that instructs the model to act as a conversational agent and only discuss company products.

:::image type="content" source="../media/system-message.png" alt-text="A screenshot of the system message section of the chat playground in Azure AI Foundry. The system message section is highlighted." lightbox="../media/system-message.png":::

1. On the **Chat playground** page, within the **System message** box, enter:

    *You are the Contoso Camping Store chatbot. Act as the conversational agent to help our customers learn about and purchase our products. Your responses should be informative, polite, relevant, and engaging.*

    *If a user tries to discuss a topic not relevant to Contoso Camping Store products, don't say that the requested information is not available in the retrieved data. Instead, politely refuse and suggest they ask about our products.*

    *Your responses should be in the language initially used by the user. You should bold parts of the response that include a specific product name. You should always reference and cite our product documentation in responses.*

1. Select **Apply changes**.

> [!NOTE]
> If a notification appears warning that updating the system message will start a new chat session, select **Continue**.

## Add a safety system message

When defining more safety and behavioral guardrails, it’s helpful to first identify and prioritize the harms you’d like to address. Depending on the application, the sensitivity and severity of certain harms could be more important than others. Azure AI Foundry provides pre-made **Safety system messages** that can be appended to your system message.

:::image type="content" source="../media/safety-system-message.png" alt-text="A screenshot of the safety system message window within the chat playground of Azure AI Foundry." lightbox="../media/safety-system-message.png":::

1. Select the **+ Add section** drop-down and select **Safety system messages**.
1. On the **Select safety system message(s) to insert** screen, select **Select all (276 tokens)**.
1. Select **Insert**.
1. Within the **To Avoid Fabrication or Ungrounded Content** of the **Safety system message**, replace the final bullet point (it starts with ‘You must always perform searches…’) within the with the following:

    *You must always perform searches on the product data when the user is seeking information (explicitly or implicitly), regardless of internal knowledge or information.*

1. Select **Apply changes**.

## Test the model with the new system message

Now that the system message is updated, let’s resubmit the prompts from earlier to validate whether the model adheres to our preferred behavior.

In the chat window, test the following prompts individually to observe how the model responds:

| **Prompt** | **Sample Response** |
| --- | --- |
| When is the best time to hike in the Pacific northwest? | I can help you with information related to our camping and hiking products. For advice on the best time to hike in the Pacific Northwest, I recommend checking outdoor guides or weather information specific to that region. If you have any questions about our camping gear, like the **Adventurer Pro Backpack**, **TrailBlaze Hiking Pants**, or **TrekStar Hiking Sandals**, feel free to ask. |

Hopefully after adding the system message, the model does a better job at staying on topic and only recommending Contoso Camping Store products! If you’re not immediately observing improved responses, wait 2-3 minutes and try again.

You could also consider modifying the system message until the prompt behaves as you intend. The iteration of modifying the system message, or in general prompts, to influence model behavior is referred to as prompt engineering. Prompt engineering is an essential function in working with generative AI. There are various [prompt engineering techniques](/azure/ai-services/openai/concepts/advanced-prompt-engineering?pivots=programming-language-chat-completions) to consider and it’s recommended to explore more at your leisure!

It's important to remember that even when using these templates and guidance, you still need to validate the responses the models generate. Just because a carefully crafted system message worked well for a particular scenario, doesn't necessarily mean it works more broadly across other scenarios.