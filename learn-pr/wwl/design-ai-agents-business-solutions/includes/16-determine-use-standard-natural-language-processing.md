## Learning objectives

By the end of this unit, learners will be able to:
- Describe the differences between **standard NLU**, **Azure Conversational Language Understanding (CLU)**, and **Generative AI orchestration** in Copilot Studio
- Determine which capability aligns best with a business requirement or conversational scenario
- Apply decision criteria for selecting the appropriate language model pathway in Copilot Studio

## Three approaches to language understanding in Copilot Studio

Copilot Studio offers three primary patterns for interpreting user input.

### Standard natural language processing (NLU)

Traditional NLU uses intent and entity models based on rules, patterns, and structured training datasets. It's best suited for predictable tasks that require **high precision** and **low variability**.

Use standard NLU when:

- You need strict intent matching for regulated processes

- User queries and commands are consistent and structured

- You want deterministic responses with limited generative behavior

### Azure Conversational Language Understanding (CLU)

Azure CLU enhances NLU with improved accuracy, intent recognition, and entity extraction through AI-driven classification models. CLU is ideal when natural language varies but remains within well-defined topic boundaries.

Use CLU when:

- You want scalable, trainable models that understand varied phrasing

- Your solution needs high-quality intent recognition across many utterances

- You need integration with Azure AI services for multilingual models and continuous model updates

### Generative AI orchestration in Copilot Studio

Generative orchestration uses large language models (LLMs) to interpret prompts, maintain conversation flow, retrieve knowledge, and call actions dynamically. This mode is ideal for **complex**, **open-ended**, or **knowledge-driven** tasks.

Use generative orchestration when:

- User messages are unstructured or unpredictable

- You need summarization, rewriting, content generation, reasoning, or multi-turn dialog

- The agent must ground responses in enterprise data and follow action-routing logic

## Decision framework for choosing the right approach

**Chart: When to use NLU, CLU, or generative orchestration**

| **Requirement Type** | **Standard NLU** | **Azure CLU** | **Generative AI Orchestration** |
|---|---|---|---|
| **Structured commands** | ✔ Best choice | ✔ Good | — |
| **Regulatory accuracy, predictable outcomes** | ✔ Best | ✔ Good | — |
| **Moderate linguistic variability** | — | ✔ Best choice | ✔ Possible |
| **Highly variable or ambiguous language** | — | ✔ Good | ✔ Best choice |
| **Requires enterprise grounding knowledge** | — | — | ✔ Best |
| **Needs reasoning, summarization, content creation** | — | — | ✔ Best |
| **Needs explicit intent routing** | ✔ Good | ✔ Best | ✔ Can augment |
| **Multi-step conversations** | — | ✔ Good | ✔ Best |

## Applying the right technology for business scenarios

### Use standard NLU when:

- A call center bot recognizes fixed phrases ("Reset password," "Check balance")

- You need safe, consistent routing based on exact intents

- You support languages or patterns already modeled in Copilot Studio's NLU

### Use Azure CLU when:

- A field service bot must understand dozens of ways to report the same problem

- AI must extract structured entities (device type, model number, location)

- You expect continuous retraining and monitoring of accuracy metrics

### Use generative AI orchestration when:

- A sales assistant summarizes CRM records and generates emails

- A service agent bot retrieves knowledge articles and answers long-form questions

- You need conditional LLM behavior triggered by topic boundaries

- You want advanced capabilities like content generation, rewriting, or multiturn reasoning

## Best practices

- Start with NLU or CLU where tasks are structured; use generative only when needed

- Always enable grounding when using generative orchestration for enterprise answers

- Use guardrails (instructions, actions, topic triggers) to keep LLM output safe and predictable

- Evaluate cost and performance: generative orchestration is more powerful but more compute intensive

## References

- NLU fine-tuned language intelligence for smarter conversations <https://www.microsoft.com/dynamics-365/blog/it-professional/2025/07/14/nlu-fine-tuned-language-intelligence-for-smarter-conversations>.

- Generative orchestration topic triggers in Copilot Studio <https://www.digitalbricks.ai/blog-posts/understanding-generative-orchestration-topic-triggers-in-copilot-studio>.
