After uploading data to the Azure AI Studio and creating an index on your data using the integration with Azure AI Search, you can implement the RAG pattern with *Prompt Flow* to build a copilot application.

## Understand the prompt flow components

**Prompt Flow** is a development framework for defining flows that orchestrate interactions with an LLM.

![Diagram of a prompt flow.](../media/prompt-flow.png)

A flow begins with one or more *inputs*, usually a question or prompt entered by a user, and in the case of iterative conversations the chat history to this point.

The flow is then defined as a series of connected *tools*, each of which performs a specific operation on the inputs and other environmental variables. There are multiple types of tool that you can include in a prompt flow to perform tasks such as:

- Running custom Python code
- Looking up data values in an index
- Creating prompt variants - enabling you to define multiple versions of a prompt for a large language model (LLM), varying system messages or prompt wording, and compare and evaluate the results from each variant.
- Submitting a prompt to an LLM to generate results.

Finally, the flow has one or more *outputs*, typically to return the generated results from an LLM.

## Create an evaluation flow

To evaluate chat applications you built with prompt flow:

- Create a test dataset.
- Create a new automated evaluation.
- Select a flow or a dataset with model generated outputs.
- Select the metrics you want to evaluate on.
- Run the evaluation flow.
- Review the results.
