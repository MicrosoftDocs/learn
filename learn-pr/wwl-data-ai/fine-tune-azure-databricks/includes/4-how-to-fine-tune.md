After you identify the need for fine-tuning and have your dataset prepared, you're ready to fine-tune a Large Language Model (LLM) using Azure Databricks.

The fine-tuning process varies depending on which approach you choose. This unit focuses on fine-tuning Azure OpenAI models. If you're working with Hugging Face models instead, you can learn more about [fine-tuning Hugging Face models](/azure/databricks/machine-learning/train-model/huggingface/fine-tune-model?azure-portal=true).

## Configure your environment

First, configure your environment for fine-tuning. Your environment setup includes configuring a Databricks cluster and installing the required libraries:

- **Set up a Databricks cluster**: Within your Databricks workspace, configure a cluster with the necessary specifications. Ensure that the cluster has access to GPUs, as fine-tuning LLMs can be computationally intensive.

- **Install required libraries**: Install the necessary libraries for fine-tuning LLMs. When working with Azure OpenAI, you can use the [OpenAI Python API library](https://github.com/openai/openai-python?azure-portal=true).

## Prepare and validate your dataset

Next, load your dataset and validate it meets the requirements for fine-tuning. For Azure OpenAI fine-tuning, your data must be in JSONL format with conversation-style entries.

Each line in your training file should contain a conversation with system, user, and assistant messages. Before proceeding, validate that your dataset meets Azure OpenAI's requirements for format and token counts. Check that individual examples remain within the input token limit of the model you're using.

## Submit and monitor your fine-tuning job

Once your environment is ready and your data is validated, you can begin the fine-tuning process. Start by uploading your training and validation files to Azure OpenAI. Initialize an OpenAI client and add the files to its environment. The client generates file IDs for these files, which you'll use to create the fine-tuning job.

With your files uploaded, submit the fine-tuning job by specifying the training and validation file IDs, the base model to fine-tune, and any additional parameters like the number of training epochs. The fine-tuning job trains the model using your provided datasets.

After submitting the job, monitor its progress by checking the job ID and status to ensure that the training process is progressing as expected. Fine-tuning can take several hours to complete, so it's important to track the job status throughout the process.

## Deploy and test your fine-tuned model

Once the fine-tuning job completes successfully, you're ready to deploy your fine-tuned model. Create a new deployment and specify the model details. Once deployed, you can use the fine-tuned model like any other deployed model in Azure AI Studio or via the chat completion API.

Finally, test your fine-tuned model by sending requests to it. Use the model in chat completion calls to see how it performs with your specific use case. Compare the responses to the base model to evaluate the improvement from fine-tuning and determine if the model meets your requirements.
