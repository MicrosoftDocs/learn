The quality and nature of data play a critical role in determining the efficacy and reliability of evaluation processes. Data serves as the backbone for testing, validating, and refining AI models, ensuring they perform optimally in real-world scenarios. The relationship between data and evaluation quality is symbiotic; high-quality, diverse, and representative data sets help ensure that the evaluation metrics accurately reflect the model's performance in various scenarios. Conversely, poor-quality or biased data can lead to misleading evaluation results, masking the AI system's weaknesses and overestimating its strengths. Therefore, the quality and variety of data directly impacts the reliability and validity of the evaluation process.

## Characteristics of good evaluation data

Data used for evaluating generative AI applications should possess the following characteristics:

- **Diversity**: Good evaluation data encompasses a wide range of scenarios, contexts, and variations, ensuring the application is tested against different types of inputs.
- **Representativeness**: The data should accurately reflect the real-world scenarios in which the AI model is deployed, capturing the nuances and complexities of actual user interactions.
- **Quality**: High-quality data is clean, well-labeled, and free from errors or inconsistencies. High-quality data ensures that the evaluation metrics aren't skewed by noise or inaccuracies.
- **Relevance**: The data should be aligned with the specific goals and requirements of the AI application, focusing on the aspects that are most critical for its performance and user experience.
- **Regularly Updated and Refreshed**: Continuously update and refresh evaluation data to reflect evolving user needs, standards, and contexts.
- **Balanced Data Quality and Quantity**: Ensure that the data is both high-quality and sufficiently large to provide meaningful and accurate evaluation results.

## Importance of handling edge cases

Edge cases, though rare, can have significant implications for the performance and reliability of generative AI applications. By including edge cases in the evaluation data, developers can validate that the model is robust and capable of handling a wide range of inputs, enhancing its overall reliability and user experience. In generative AI, edge cases might include inputs that are different from the typical data using for model training. Edge cases can help identify potential weaknesses or biases in the model.

Consider a generative AI application designed for customer service chatbots. An edge case for this application might involve a user inputting a message that includes a mix of languages, such as English and Mandarin, along with slang and industry-specific jargon. For instance, a user might type, "Hey, can you帮我reset我的密码? Thanks!" This input combines English, Mandarin, and informal language, which could challenge the chatbot's language processing capabilities. Evaluating the AI system's response to such inputs can help developers identify whether the chatbot can accurately understand and respond to multilingual and informal queries, ensuring robustness and reliability in diverse communication scenarios.

## Data requirements

The built-in evaluators used within Azure AI Foundry and the Azure AI Evaluation SDK require specific data in .jsonl format:

**Context** – The context is the source that the response is generated with respect to (that is, grounding documents).

Ex: "Paris is the capital/major city of France."

**Query** – The query is the specific question or prompt given to the AI. It’s what the AI is directly asked to address or respond to.

Ex: "What is the capital/major city of France?"

**Response** – The AI’s generated answer to the query, considering the given context.

Ex: "The capital/major city of France is Paris. It’s a big city with a famous tower called the Eiffel Tower."

**Ground truth** – The ground truth is the response to the query generated by a user/human as the true answer.

Ex: “Paris is the capital/major city and most populous city of France.”

Ensure that your dataset is formatted properly with the proper key-value pair for each entry.

## Types and sources of evaluation data

There are several types and sources of data that can be used for evaluating generative AI applications, each offering unique benefits, and challenges.

### Real-world data

Real-world data is user-generated data that reflects actual interactions and scenarios. It's invaluable for testing the model's performance in realistic conditions. In addition, real-world data embodies the subtle variations and complex patterns found in authentic user interactions.

### Synthetic data

Synthetic data is artificially generated data designed to mimic real-world scenarios. It's used to supplement real-world data, especially when certain types of data are scarce or difficult to obtain. Synthetic data can be generated in large quantities, providing ample data for evaluation. In addition, synthetic data avoids potential privacy issues associated with user-generated data.

The Azure AI Evaluation SDK is equipped with a `Simulator` class which provides end-to-end synthetic data generation capabilities. This capability enables developers to effectively test their application’s responses to typical user queries, even in the absence of production data.

`Simulator` offers the following features

- Create synthetic data based on text or indexes for input
- Define target callbacks for simulation purposes
- Customize how query-response pairs are generated from input text
- Use fixed conversation starters for simulations

### Adversarial data

Adversarial data refers to carefully crafted inputs designed to challenge, confuse, or exploit AI models. Adversarial data is crucial when stress-testing a model because it pushes the model's boundaries, revealing its vulnerabilities and potential failure points. Evaluating the model using adversarial data can reveal possible vulnerabilities or pathways for attacks. Adversarial data is critical for building generative AI applications that are resistant to malicious inputs and protect user data and privacy.

The Azure AI Evaluation SDK is equipped with a `AdversarialSimulator` class which generates an adversarial dataset against your application. We provide adversarial scenarios along with configured access to a service-side Azure OpenAI GPT-4 model with safety behaviors turned off to enable the adversarial simulation.

The adversarial simulator works by setting up a service-hosted GPT large language model to simulate an adversarial user and interact with your application. You can bring any application endpoint to the adversarial simulator. The `AdversarialSimulator` supports a [range of scenarios](/azure/ai-studio/how-to/develop/simulator-interaction-data#supported-simulation-scenarios), hosted in the service, to simulate against your target application or function.
