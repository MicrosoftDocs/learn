Azure Machine Learning's Prompt Flow is a cutting-edge feature currently in public preview that allows developers to create, test, and deploy large language model (LLM)-based applications. This learning unit provides an overview of the core components of Prompt Flow: connections, runtimes, flows, Prompt Flow tools, variants and monitoring metrics.

## Connections

Connections are vital for securely linking your Prompt Flow to external APIs and data sources.

- Key Features
  - Secure storage of credentials in Azure Key Vault.
  - Prebuilt connections for ease of access to common services.
  - Custom connection capabilities for user-specific needs.

- Use Cases
  - Automating credential management for APIs.
  - Enabling secure data transfer from various sources.

## Runtimes

Runtimes provide the necessary computational resources for executing the Prompt Flows.

- Key Features
  - Prebuilt Docker images containing all necessary built-in tools.
  - Options for custom environments to include specific packages or configurations.
  - Use Cases:
  - Running and validating flows in a controlled environment.
  - Customizing computing resources to fit specific application needs.

## Flows

Flows are the backbone of your LLM-based applications, allowing for a streamlined development process.

- Key Features
  - Nodes that represent data processing tasks and algorithmic functions.
  - DAG visualization for clear workflow structure and node interdependencies.
  - Various flow types (Standard, Chat, Evaluation) to suit different application needs.

- Use Cases
  - Building and managing a sequence of operations for data handling.
  - Tailoring the AI application logic through an interactive, notebook-like UI.

## Tools in Prompt Flow (Preview)

Tools are discrete executable units within Prompt Flow, each designed for a particular function.

- Types of Tools
  - LLM Tool: Enables custom prompt creation utilizing large language models.
  - Python Tool: Allows the execution of custom Python scripts.
  - Prompt Tool: Prepares prompts as strings for complex scenarios or integration with other tools.

- Benefits
  - Integration with third-party APIs and Python packages.
  - Facilitates a range of tasks from summarization to API interactions.
  - Consideration: The preview is without an SLA and not recommended for production workloads.

## Variants in Prompt Flow (Preview)

Variants are different versions of a tool node, each with unique settings or prompt content, especially within the LLM tool.

- Benefits
  - Enhance LLM generation quality through experimentation.
  - Simplify historical tracking and management of different prompt configurations.
  - Facilitate side-by-side result comparison to optimize LLM output.
  - Consideration: Limited to the LLM tool and used for tuning prompt efficacy.

## Monitoring Evaluation Metrics

To track and evaluate generative AI models' performance in production.

- **Metrics**
  - ***Groundedness***: Measures alignment of the model’s output with the input source or database.
  - ***Relevance***: Assesses how pertinent the model’s output is to the given input.
  - ***Coherence***: Evaluates the logical flow and readability of the model’s text.
  - ***Fluency***: Assesses the grammatical and linguistic accuracy of the AI’s output.
  - ***Similarity***: Quantifies the contextual and semantic match between the AI’s output and the ground truth.

- Use Cases:
  - Assessing models' real-world utility and user experience.
  - Comparing model predictions to expected or ground truth responses.
  - Consideration: Monitoring is crucial for maintaining model reliability, especially when generative models are involved.

The core of Prompt Flow revolves around tools and variants, instrumental in crafting precise AI outputs. Tools enable task execution, while variants fine-tune prompts for optimal performance. Monitoring metrics like Groundedness, Relevance, Coherence, Fluency, and Similarity are key for quality assurance, ensuring that AI interactions are accurate and effective. These concepts collectively form the backbone of Prompt Flow's functionality.
