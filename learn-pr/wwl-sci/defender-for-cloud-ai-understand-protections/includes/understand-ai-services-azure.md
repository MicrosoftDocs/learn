AI workloads are becoming a standard part of many Azure solutions. They are built from five layers of services: model endpoints, retrieval, application logic, data storage, and orchestration. Knowing how these layers work together and where sensitive data flows through them creates the foundation for identifying security responsibilities.

## The five layers of AI workloads in Azure

AI applications in Azure typically combine five layers of services:

- **Model endpoints**: Services such as Azure OpenAI provide access to large language models and other generative AI capabilities.
- **Retrieval services**: Azure AI Search or vector indexes are used to supply context and keep responses grounded in organizational data.
- **Application layer**: Web apps, APIs, or copilots connect user input to models and return results.
- **Data layer**: Storage accounts and databases hold prompts, cached responses, logs, and training or evaluation datasets.
- **Orchestration and management**: Azure AI Foundry provides tools for building, testing, and operationalizing AI solutions.

These components resemble other workloads in Azure. What changes is how sensitive data flows through them and how users interact with the system.

## Three reasons AI workloads require security attention

Several characteristics bring AI workloads into scope for security:

- **Data handling**: Prompts and outputs can contain sensitive information that might be logged, cached, or stored.
- **User interaction**: Natural language inputs are less predictable than structured forms, increasing the risk of manipulation.
- **Expanded attack surface**: Model endpoints, retrieval indexes, and orchestration pipelines become additional entry points that require protection.

If you've secured storage, databases, and APIs before, many of the same principles apply here. The difference is where the sensitive information appears and how attackers can influence model behavior.

Many organizations deploy support assistants that use **Azure OpenAI** and **Azure AI Search** to retrieve knowledge base articles and return answers through a web app. From a developer perspective, the focus is accuracy and usability. From a security perspective, the workload processes customer data, stores sensitive information, and relies on multiple Azure services that must be secured. Security responsibilities often include:

- **Identity and access**
- **Secrets management**
- **Network isolation**
- **Workload posture**
- **AI-specific guardrails** layered in where prompts and outputs present new risks

Understanding how these services combine and why they introduce new risks creates the baseline needed to evaluate the unique risks of AI workloads.
