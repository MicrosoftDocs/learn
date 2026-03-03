Prompt engineering helps you guide the model's behavior, and RAG helps you ground responses in factual data. But sometimes the model still doesn't produce responses with the consistent style, tone, or format you need. When you notice that the model ignores or inconsistently follows your instructions—even with detailed system messages and few-shot examples—it might be time to **fine-tune** the model.

**Fine-tuning** is the process of taking a pretrained language model and further training it on a smaller, task-specific dataset. This adjusts the model's internal weights so that it produces responses that are consistent with the patterns in your training data.

## Understand fine-tuning

Foundation models like GPT-4o are trained on vast amounts of general data. Fine-tuning builds on that foundation by training the model with additional examples that reflect your specific requirements. Think of it as specializing a generalist: the model retains its broad language capabilities but learns to respond in the particular way your training data demonstrates.

Fine-tuning uses **LoRA (Low-Rank Adaptation)**, a technique that approximates weight changes with a lower-rank representation. Instead of retraining all of the model's parameters, LoRA updates only a smaller subset of important parameters. This makes training faster and more cost-effective while maintaining model quality.

The key benefit of fine-tuning over training a model from scratch is efficiency. You need less time, fewer computing resources, and significantly less data to customize a model's behavior.

## Know when to fine-tune

Fine-tuning is suited for scenarios where prompt engineering alone doesn't achieve the consistency you need. Common use cases include:

- **Consistent style and tone**: Your organization has a specific brand voice, and the model needs to follow it reliably across all interactions. For example, the travel agency wants every response to use a warm, encouraging tone with short paragraphs.
- **Specific output formats**: You need the model to reliably produce structured output, like JSON responses following a defined schema, and few-shot examples alone aren't sufficient.
- **Reducing prompt length**: Long system messages with many examples consume tokens and increase latency. Fine-tuning embeds those patterns into the model, reducing the prompt size needed for each request.
- **Distillation**: You want to transfer the capabilities of a large, expensive model to a smaller, more efficient one. For example, you can collect outputs from a high-performing model and use them to fine-tune a smaller model that achieves similar quality at lower cost and latency.
- **Enhancing tool usage**: When your application uses tool calling, fine-tuning with tool examples can improve the accuracy of tool selection and parameter generation.

> [!IMPORTANT]
> Fine-tuning is an advanced capability. Always start by evaluating the baseline performance of a standard model against your requirements before considering fine-tuning. Without a baseline, it's hard to detect whether fine-tuning improved or degraded the model's performance.

## Explore types of fine-tuning

<!-- TODO: Screenshot of the fine-tuning creation page in the Microsoft Foundry portal, showing the model selection dropdown and the fine-tuning method options (supervised, reinforcement, DPO). -->

Microsoft Foundry offers several fine-tuning techniques:

- **Supervised fine-tuning (SFT)**: Train the model on a labeled dataset of prompt-and-response pairs. The model learns to produce outputs that match the patterns in your training data. This technique works best when there are clear, well-defined ways to approach a task.
- **Reinforcement fine-tuning (RFT)**: Optimize the model's behavior through iterative feedback, using a grader to reward better responses incrementally. RFT works well for complex or dynamic tasks where there are many possible solutions and you want to improve the model's reasoning quality.
- **Direct Preference Optimization (DPO)**: Align the model based on human preferences by providing preferred and non-preferred response pairs. DPO is computationally lighter than traditional reinforcement learning approaches while being equally effective at alignment.

You can also combine techniques. For example, first use supervised fine-tuning to create a customized model, then use DPO to further align the responses to your specific preferences.

## Prepare training data

<!-- TODO: Screenshot of the training data upload step in the Microsoft Foundry portal fine-tuning wizard, showing the file upload interface and validation status for a JSONL file. -->

Fine-tuning requires a dataset of high-quality examples in JSONL (JSON Lines) format. For chat completion models, each example consists of a conversation with system, user, and assistant messages:

```json
{"messages": [{"role": "system", "content": "You are a friendly travel advisor for Margie's Travel."}, {"role": "user", "content": "What's a good beach destination in Europe?"}, {"role": "assistant", "content": "For a beautiful European beach experience, consider the Algarve in southern Portugal! It offers stunning golden cliffs, warm waters, and charming coastal towns. The best time to visit is from May through September."}]}
{"messages": [{"role": "system", "content": "You are a friendly travel advisor for Margie's Travel."}, {"role": "user", "content": "I need a budget hotel in Tokyo."}, {"role": "assistant", "content": "Here are some great budget-friendly options in Tokyo:\n\n- **Sakura Hotel Jimbocho** - Central location, from $45/night\n- **Khaosan World Asakusa** - Near Senso-ji temple, from $35/night\n- **Imano Tokyo Ginza Hostel** - Modern design, from $40/night\n\nAll three options are close to public transit, making it easy to explore the city."}]}
```

When preparing your training data:

- Include a consistent system message across examples.
- Use high-quality, representative examples that cover the range of scenarios you expect.
- Aim for at least hundreds of examples; more is generally better.
- Ensure the assistant responses reflect exactly the style, format, and tone you want.

> [!NOTE]
> Including a system message in your training data is important. Leaving it blank tends to produce lower-accuracy models. Use the same system message when you deploy your fine-tuned model for inference.

## Consider the challenges

Fine-tuning introduces costs and complexity that you should evaluate before committing:

- **Training costs**: Fine-tuning has upfront costs for training and ongoing hourly costs for hosting the custom model.
- **Data quality requirements**: Poor-quality or unrepresentative training data leads to overfitting, underfitting, or bias.
- **Maintenance**: Fine-tuned models may need to be retrained when data changes or when updated base models are released.
- **Experimentation**: Finding the right combination of hyperparameters (epochs, batch size, learning rate) requires testing and iteration.
- **Model drift**: Specializing too narrowly can make the model less effective at general language tasks outside the fine-tuned domain.

For the travel agency, fine-tuning means every response consistently matches the company's brand voice and formatting guidelines—even without extensive system messages. But the team needs to weigh this benefit against the cost of preparing training data and maintaining the fine-tuned model over time.
