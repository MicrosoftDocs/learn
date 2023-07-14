Azure OpenAI on your data allows developers to use supported AI chat models that can reference specific sources of information to ground the response. Adding this information allows the model to reference both the specific data provided and its pretrained knowledge to provide more effective responses.

Azure OpenAI on your data utilizes the search ability of Azure Cognitive Search to add the relevant data chunks to the prompt. Once your data is in a Cognitive Search index, Azure OpenAI on your data goes through the following steps:

1. Receive user prompt.
1. Determine relevant content and intent of the prompt.
1. Query the search index with that content and intent.
1. Insert search result chunk into the Azure OpenAI prompt, along with system message and user prompt.
1. Send entire prompt to Azure OpenAI.
1. Return response and data reference (if any) to the user.

By default, Azure OpenAI on your data encourages, but doesn't require, the model to respond only using your data. This setting can be unselected when connecting your data, which may result in the model choosing to use its pretrained knowledge over your data.

## Fine-tuning vs. using your own data

Fine-tuning is a technique used to create a custom model by training an existing foundational model such as `gpt-35-turbo` with a dataset of additional training data. Fine-tuning can result in higher quality requests that prompt engineering alone, customize the model on examples larger than can fit in a prompt, and allow the user to provide fewer examples to get the same high quality response. However, the process for fine-tuning is both costly and time intensive, and should only be used for use cases where it's necessary.

Azure OpenAI on your data still uses the stateless API to connect to the model, which removes the requirement of training a custom model with your data and simplifies the interaction with the AI model. Cognitive Search first finds the useful information to answer the prompt, and Azure OpenAI forms the response based on that information.
