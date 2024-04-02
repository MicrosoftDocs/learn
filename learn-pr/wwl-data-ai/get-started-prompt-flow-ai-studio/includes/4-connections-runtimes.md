When you create a Large Language Model (LLM) application with prompt flow, you first need to configure any necessary **connections** and **runtimes**.

## Explore connections

Whenever you want your flow to connect to external data source, service, or API, you need your flow to be authorized to communicate with that external service. When you create a **connection**, you configure a secure link between prompt flow and external services, ensuring seamless and safe data communication.

:::image type="content" source="../media/connections.png" alt-text="Diagram showing a flow with two nodes, connecting to Cognitive Search and Azure Open AI.":::

Depending on the type of connection you create, the connection securely stores the endpoint, API key, or credentials necessary for prompt flow to communicate with the external service. Any necessary secrets aren't exposed to users, but instead are stored in an Azure Key Vault.

By setting up connections, users can easily reuse external services necessary for tools in their flows.

Certain built-in tools require you to have a connection configured:

|Connection type|Built-in tools|
|---|---|
|Azure Open AI|LLM or Python|
|Open AI|LLM or Python|
|Cognitive Search|Vector DB Lookup or Python|
|Serp|Serp API or Python|
|Custom|Python|

Prompt flow connections play pivotal roles in two scenarios. They automate API credential management, simplifying and securing the handling of sensitive access information. Additionally, they enable secure data transfer from various sources, crucial for maintaining data integrity and privacy across different environments.

## Explore runtimes

After creating your flow, and configuring the necessary connections your tools use, you want to run your flow. To run the flow, you need compute, which is offered through prompt flow **runtimes**.

:::image type="content" source="../media/runtimes.png" alt-text="Diagram runtimes, compute, and environments in relation to flows.":::

Runtimes (1) are a combination of a **compute instance** (2) providing the necessary compute resources, and an **environment** (3) specifying the necessary packages and libraries that need to be installed before being able to run the flow.

When you use runtimes, you have a controlled environment where flows can be run and validated, ensuring that everything works as intended in a stable setting. A default environment is available for quick development and testing. When you require other packages to be installed, you can [create a custom environment](/azure/machine-learning/prompt-flow/how-to-customize-environment-runtime?azure-portal=true).
