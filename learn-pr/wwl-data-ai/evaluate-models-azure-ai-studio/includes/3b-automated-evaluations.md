Automated evaluations in Azure AI Foundry portal enable you to assess the quality and content safety performance of models, datasets, or prompt flows.

## Evaluation data

To evaluate a model, you need a dataset of prompts and responses (and optionally, expected responses as "ground truth"). You can compile this dataset manually or use the output from an existing application; but a useful way to get started is to use an AI model to generate a set of prompts and responses related to a specific subject. You can then edit the generated prompts and responses to reflect your desired output, and use them as ground truth to evaluate the responses from another model.

![Screenshot of AI-generated evaluation data](../media/ai-generated-test-data.png)

## Evaluation metrics

Automated evaluation can produce the following kinds of metric:

- **AI Quality (AI-assisted)**: Metrics that measure the grammatical and linguistic quality of the generated responses based on analysis by an AI model.
- **AI Quality (NLP-based)**: Metrics that measure the alignment between the AI-generated responses and the ground truth expected responses.
- **Risk and safety**: Metrics that evaluate the responses for content safety issues, including violence, hate, sexual content, and content related to self-harm.