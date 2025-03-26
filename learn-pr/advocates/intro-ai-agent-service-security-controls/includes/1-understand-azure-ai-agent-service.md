Azure AI Agent Service is a fully managed service designed to empower developers to securely build, deploy, and scale high-quality, and extensible AI agents without needing to manage the underlying compute and storage resources. Tasks that can take hundreds of lines of code to support client side function calling may now be achieved with just a few lines of code with Azure AI Agent Service.

An AI Agent acts as a "smart" microservice that can be used to answer questions (Retrieval Augmented Generation), perform actions, or completely automate workflows. AI agents achieve this by combining the power of generative AI models to understand information resources with tools that allow that model to access and interact with real-world data sources.

Because Azure AI Agent Service is a service fully managed by Microsoft, you can focus on building workflows and the agents that power them without needing to worry about scaling, security, or management of the underlying infrastructure for individual agents.

As Azure AI Agent Service is a service managed by Microsoft and you don't need to worry about the underlying security of its moving parts, you should still apply standard security principals when you use the AI agent service. These principles include:

- Restrict access to the service using role based access control. Ensure that only appropriate security principals can interact with the AI agent service.
- Restrict the access of the AI Agent service. The AI Agent service is interacting with sensitive resources, such as organizational data. Ensure that the scope of this access is limited and that the AI Agent service and its tools only have necessary visibility of resources such as data stores.
- Restrict network access to the AI Agent service and the network access of the AI agent service. Limit which network hosts can interact with the AI Agent service and control which network hosts the AI Agent service and it's associated tools are able to reach.
