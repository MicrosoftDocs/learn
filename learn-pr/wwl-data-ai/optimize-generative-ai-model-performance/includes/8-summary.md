In this module, you learned how to optimize generative AI model performance using complementary strategies in Microsoft Foundry.

You learned how to:

- Apply prompt engineering techniques including system messages, few-shot learning, and model parameters to optimize model output.
- Understand when and how to ground a language model using Retrieval Augmented Generation (RAG).
- Identify when fine-tuning a model improves behavioral consistency.
- Compare optimization strategies and determine when to combine them.

The key takeaway is that prompt engineering, RAG, and fine-tuning aren't competing approaches—they're complementary strategies that address different dimensions of model performance. Start with prompt engineering to guide the model's behavior, add RAG when factual accuracy requires domain-specific data, and consider fine-tuning when you need consistent style and format that prompt engineering alone can't reliably achieve.

For the travel agency scenario, the most effective solution might combine all three: a fine-tuned model that maintains the brand voice, RAG that grounds responses in the actual hotel catalog, and prompt engineering that adds conversation-specific instructions and safety guardrails.

### Learn more

- [Getting started with customizing a large language model (LLM)](/azure/ai-foundry/openai/concepts/customizing-llms)
- [Prompt engineering techniques](/azure/ai-foundry/openai/concepts/prompt-engineering)
- [System message design](/azure/ai-foundry/openai/concepts/advanced-prompt-engineering)
- [Retrieval Augmented Generation in Microsoft Foundry](/azure/ai-foundry/concepts/retrieval-augmented-generation)
- [Customize a model with fine-tuning](/azure/ai-foundry/openai/how-to/fine-tuning)
- [Microsoft Foundry fine-tuning considerations](/azure/ai-foundry/openai/concepts/fine-tuning-considerations)
- [Augment large language models with RAG or fine-tuning](/azure/developer/ai/augment-llm-rag-fine-tuning)
