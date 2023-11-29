Azure Machine Learning's prompt flow is a cutting-edge feature currently in public preview that allows developers to create, test, and deploy Large Language Model (LLM)-based applications. This learning unit provides an overview of the core components of prompt flow: **connections**, **runtimes**, **flows**, **prompt flow tools**, **variants** and **monitoring metrics**.

## Connections

In Azure Machine Learning's prompt flow, *connections* serve as secure links between your projects and external APIs or data sources, ensuring seamless and safe data communication.

### Connections key features

*Connections* offer three key features. First, there's the secure storage of credentials in Azure Key Vault, which guarantees the safety of sensitive information. Next, users benefit from prebuilt connections, allowing for easy and quick access to commonly used services. Finally, the platform accommodates unique requirements through custom connection capabilities, providing tailored solutions for specific user needs.

### Connections use cases

Prompt flow *connections* play pivotal roles in two scenarios. They automate API credential management, simplifying and securing the handling of sensitive access information. Additionally, they enable secure data transfer from various sources, crucial for maintaining data integrity and privacy across different environments.

## Runtimes

Runtimes provide the necessary computational resources for executing the prompt flows.

### Runtimes key features

Prompt flow *runtimes* has a couple of main features. First, they include prebuilt Docker images loaded with all the essential built-in tools, making setup straightforward and efficient. Second, they offer the ability to create custom environments, where users can add their own packages or configurations, allowing for a more personalized and flexible setup tailored to specific project needs.

### Runtimes use cases

Prompt flow *runtimes* are used primarily for two purposes. First, they create a controlled environment where flows can be run and validated, ensuring that everything works as intended in a stable setting. Creating a control environment is essential for checking the functionality and accuracy of different parts of a flow. Second, *runtimes* offer the flexibility to customize computing resources according to the specific requirements of an application, allowing users to fine-tune their setup to better suit their project's unique needs.

## Flows

Flows are the backbone of your LLM-based applications, allowing for a streamlined development process.

### Flows key features

Prompt flow *flows* are defined by nodes for data processing and algorithmic tasks, Directed Acyclic Graph (DAG) visualization for clear workflow structure, and various flow types to suit different needs. 

The flow types include:

- **Standard flow**: Ideal for general LLM-based application development, offering a range of versatile tools.
- **Chat flow**: Specifically designed for conversational applications, with enhanced support for chat-related functionalities.
- **Evaluation flow**: Focused on performance evaluation, allowing the analysis and improvement of models or applications through feedback on previous runs.

### Flows use cases

Prompt flow 'Flows' have two main use cases. They enable the building and management of operations sequences for efficient data handling, streamlining the process of data manipulation in AI applications. Additionally, Flows offer a notebook-like UI, allowing users to tailor AI application logic interactively and intuitively, enhancing customization and ease of use.

## Tools

Tools are discrete executable units within prompt flow, each designed for a particular function.

### Prompt flow tools benefits

Prompt flow *tools* offer two notable benefits. They stand out for their ability to easily integrate with third-party APIs and Python packages, broadening their usefulness. They're also versatile, handling tasks ranging from summarizing text to managing API interactions, making them adaptable to a variety of needs.

### Types of tools

Prompt flow *tools* are divided into three categories:

- **LLM Tool**: Enables custom prompt creation utilizing Large Language Models.
- **Python Tool**: Allows the execution of custom Python scripts.
- **Prompt Tool**: Prepares prompts as strings for complex scenarios or integration with other tools.

## Variants

Prompt flow *variants* are versions of a tool node with distinct settings, used in the LLM tool for various prompt contents or connection settings. Variants allow users to customize their approach for specific tasks, like, for example, summarizing news articles.

The benefits of using Variants include:

- **Enhance the quality of your LLM generation**: Creating diverse variants of an LLM node helps find the best prompt and settings for high-quality content.
- **Save time and effort**: Variants allow for easy management and comparison of different prompt versions, streamlining historical tracking and reducing the effort in prompt tuning.
- **Boost productivity**: They simplify the optimization of LLM nodes, enabling quicker creation and management of variations, leading to better results in less time.
- **Facilitate easy comparison**: Variants enable side-by-side result comparisons, aiding in choosing the most effective variant based on data-driven decisions.

## Monitor evaluation metrics

In Azure Machine Learning prompt flow, monitoring evaluation metrics is key to understanding AI model performance, ensuring they meet real-world expectations and deliver accurate results.

### Monitor evaluation metrics use cases

Let's explore a couple of Prompt flow monitoring evaluation metrics use cases. One is assessing models' utility in real-world scenarios and their impact on user experience, making sure they meet practical needs. The other is comparing model predictions with expected or ground truth responses to gauge accuracy and relevance. This process is crucial for keeping generative AI models reliable and effective in various applications.

### Metrics

Let's examine the key metrics used for monitoring evaluation in Azure Machine Learning, each offering unique insights into the performance of AI models:

- ***Groundedness***: Measures alignment of the model’s output with the input source or database.
- ***Relevance***: Assesses how pertinent the model’s output is to the given input.
- ***Coherence***: Evaluates the logical flow and readability of the model’s text.
- ***Fluency***: Assesses the grammatical and linguistic accuracy of the AI’s output.
- ***Similarity***: Quantifies the contextual and semantic match between the AI’s output and the ground truth.

The core of prompt flow revolves around *tools* and *variants*, instrumental in crafting precise AI outputs. Tools enable task execution, while variants fine-tune prompts for optimal performance. *Monitoring metrics* like *groundedness*, *relevance*, *coherence*, *fluency*, and *similarity* are key for quality assurance, ensuring that AI interactions are accurate and effective. These concepts collectively form the backbone of prompt flow's functionality.
