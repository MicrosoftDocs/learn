The quality and nature of data play a critical role in determining the effectiveness and reliability of evaluation processes. Data is the backbone for testing, validating, and refining AI systems so that the results reflect what users are likely to experience in production. High-quality, diverse, and representative datasets help ensure that evaluator results reflect the model's real strengths and weaknesses instead of just the easiest cases.

## Characteristics of good evaluation data

Data used for evaluating generative AI applications should possess the following characteristics:

- **Diversity**: Good evaluation data encompasses a wide range of scenarios, contexts, and variations, ensuring the application is tested against different types of inputs.
- **Representativeness**: The data should accurately reflect the real-world scenarios in which the AI model is deployed, capturing the nuances and complexities of actual user interactions.
- **Quality**: High-quality data is clean, well-labeled, and free from errors or inconsistencies. High-quality data ensures that the evaluation metrics aren't skewed by noise or inaccuracies.
- **Relevance**: The data should be aligned with the specific goals and requirements of the AI application, focusing on the aspects that are most critical for its performance and user experience.
- **Regularly updated**: Continuously refresh evaluation data to reflect evolving user needs, policies, and scenarios.
- **Balanced data quality and quantity**: Ensure that the data is both high-quality and sufficiently large to provide meaningful and accurate evaluation results.

Match the dataset not just to the user task, but also to the evaluator constraints you plan to use. Some judge-based evaluators document language limitations, and some agent evaluators document limited support for specific tool types. A representative dataset is only useful if the evaluator can interpret it correctly.

## Importance of handling edge cases

Edge cases, though rare, can have significant implications for the performance and reliability of generative AI applications. By including edge cases in the evaluation data, developers can validate that the system is robust and capable of handling a wide range of inputs. In generative AI, edge cases might include inputs that differ from the data typically seen during development or early testing. These cases often reveal weaknesses, unsafe behavior, or unhelpful assumptions that average scores can hide.

Consider a generative AI application designed for customer service chatbots. An edge case for this application might involve a user inputting a message that includes a mix of languages, such as English and Mandarin, along with slang and industry-specific jargon. For instance, a user might type, "Hey, can you帮我reset我的密码? Thanks!" This input combines English, Mandarin, and informal language, which could challenge the chatbot's language processing capabilities. Evaluating the AI system's response to such inputs can help developers identify whether the chatbot can accurately understand and respond to multilingual and informal queries, ensuring robustness and reliability in diverse communication scenarios.

## Data requirements

Evaluation workflows don't all start from the same kind of input. In the portal, you can evaluate an **Agent**, **Model**, or **Dataset**. When you use a dataset in the portal, the uploaded file must be CSV or JSONL. In cloud and SDK workflows, you can reuse an uploaded dataset by ID or provide inline `file_content`; model and agent target evaluations then generate responses at runtime from your input queries.

Common evaluation fields include:

**Query** - The specific question or prompt given to the AI.

Ex: "What is the capital/major city of France?"

**Response** - The AI-generated answer to the query.

Ex: "The capital/major city of France is Paris. It's a big city with a famous tower called the Eiffel Tower."

**Context** - The grounding material used to produce the response, such as retrieved text for a RAG system.

Ex: "Paris is the capital/major city of France."

**Ground truth** - The trusted reference answer created by a human or other approved source.

Ex: "Paris is the capital/major city and most populous city of France."

**Tool calls** - Structured tool invocation data used by agent evaluators and some agent-specific safety evaluators.

**Tool definitions** - Structured descriptions of the tools available to an agent. Several agent evaluators use them to judge tool choice and parameter quality.

Those aren't the only valid schemas. `Document Retrieval` uses `retrieval_ground_truth` and `retrieved_documents`. `Task Navigation Efficiency` uses `actions` and `expected_actions`. Agent evaluations can also use conversation-array formats instead of plain strings so evaluators can inspect system messages, tool calls, tool results, and final answers.

Some evaluators need only `query` and `response`. Others need `context`, `ground_truth`, retrieval-label fields, `tool_calls`, or `tool_definitions`. Don't assume one schema works for every run. Plan the dataset around the evaluator set you're using, and verify the field mapping before you submit the evaluation.

Whichever schema you choose, make sure each row is internally consistent and that the field mapping matches the evaluator requirements.

## Types and sources of evaluation data

There are several types and sources of data that can be used for evaluating generative AI applications, each offering unique benefits and challenges.

### Real-world data

Real-world data is user-generated or production-like data that reflects actual interactions and scenarios. It's invaluable for testing performance in realistic conditions because it contains the subtle variations, ambiguity, and messy phrasing that synthetic examples often miss. When you use real-world data, make sure it is handled appropriately for privacy, compliance, and security.

### Synthetic data

Synthetic data is artificially generated data designed to mimic real-world scenarios. It's useful when production data is scarce, sensitive, or not yet available. Synthetic data can expand coverage quickly, especially in early development, but it should supplement rather than replace representative real-world examples.

Current Foundry portal guidance lets you generate a synthetic dataset during evaluation setup when you don't yet have test data. That current portal workflow requires a model with Responses API capability.

Microsoft Learn also documents a `Simulator` class in the Azure AI Evaluation SDK for classic workflows that generate non-adversarial queries and conversations from source text or indexes. Use that guidance only if you're intentionally working in a Foundry classic or hub-based project. The classic article explicitly says it doesn't apply to current Foundry projects.

That simulator guidance includes capabilities such as:

- Create synthetic data based on text or indexes for input
- Define target callbacks for simulation purposes
- Customize how query-response pairs are generated from input text
- Use fixed conversation starters for simulations

Synthetic data is valuable for coverage, but it should complement rather than replace representative real-world examples.

### Adversarial data

Adversarial data refers to carefully crafted inputs designed to challenge, confuse, or exploit AI systems. It is crucial for stress-testing a model because it pushes the system's boundaries and reveals potential failure points. Adversarial evaluation is especially important for jailbreaks, prompt injection, harmful-content exposure, and other safety or security risks.

Current Foundry guidance emphasizes AI red teaming in the cloud for adversarial testing before deployment. The AI Red Teaming Agent can generate attack-style prompts and use safety evaluators to measure whether a model or agent fails those tests at scale. Microsoft Learn also documents an `AdversarialSimulator` for classic workflows, but treat that as legacy or classic guidance rather than the default workflow for new Foundry projects.

> [!NOTE]
> If you don't yet have a production dataset, use the guidance that matches your scenario:
>
> - [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app)
> - [Run evaluations in the cloud by using the Microsoft Foundry SDK](/azure/foundry/how-to/develop/cloud-evaluation)
> - [Agent evaluators](/azure/foundry/concepts/evaluation-evaluators/agent-evaluators)
> - [Run AI Red Teaming Agent in the cloud](/azure/foundry/how-to/develop/run-ai-red-teaming-cloud)
> - [Generate synthetic and simulated data for evaluation (Foundry classic)](/azure/foundry-classic/how-to/develop/simulator-interaction-data) - classic or hub-based projects only
