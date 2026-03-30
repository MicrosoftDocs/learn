Fine-tuning involves combining a suitable *foundation* model to use as a base, and with a set of *training data* that includes example prompts and responses that the model can learn from. This unit covers understanding the training data format, preparing datasets from real data, and generating synthetic data for fine-tuning.

![Diagram of a base model plus training data resulting in a fine-tuned model.](../media/fine-tuning.png)

## Understand the training data format

When you decide you want to fine-tune a language model, you need to identify the dataset you can use to fine-tune your language model.

Similar to any machine learning model, the quality of the dataset has a large effect on the quality of your model. Though you need less data than when you would train a language model from scratch, you still might need enough data to maximize the consistency of your desired model's behavior. How much data you need depends on your use case.

When you fine-tune a language model for chat completion, the data you use to fine-tune a model is a collection of sample conversations. More specifically, the data should contain three components:

- The system message
- The user message
- The assistant's response

The three variables come together in a JSON Lines or JSONL file. For example, one line in such a dataset might look like:

```json
{"messages": [{"role": "system", "content": "You are an Xbox customer support agent whose primary goal is to help users with issues they are experiencing with their Xbox devices. You are friendly and concise. You only provide factual answers to queries, and do not provide answers that are not related to Xbox."}, {"role": "user", "content": "Is Xbox better than PlayStation?"}, {"role": "assistant", "content": "I apologize, but I cannot provide personal opinions. My primary job is to assist you with any issues related to your Xbox device. Do you have any Xbox-related issues that need addressing?"}]}
```

## Prepare datasets from real data

The dataset should show the model's ideal behavior. You can create this dataset based on the chat history of a chat application you have. A few things to keep in mind when you use real data is to:

- Remove any personal or sensitive information.
- Not only focus on creating a large training dataset, but also ensure your dataset includes a diverse set of examples.

You can include multiple turns of a conversation on a single line in the dataset. If you want to fine-tune only on specific assistant messages, you can optionally use the `weight` key-value pair. When the weight is set to 0, the message is ignored, when you set to 1, the message is included for training.

An example of a multi-turn chat file format with weights:

```json
{"messages": [{"role": "system", "content": "Marv is a factual chatbot that is also sarcastic."}, {"role": "user", "content": "What's the capital of France?"}, {"role": "assistant", "content": "Paris", "weight": 0}, {"role": "user", "content": "Can you be more sarcastic?"}, {"role": "assistant", "content": "Paris, as if everyone doesn't know that already.", "weight": 1}]}
```

## Generate synthetic data for fine-tuning

Creating high-quality training datasets manually can be time-consuming and expensive. Microsoft Foundry provides **synthetic data generation** capabilities that can help you create training data from reference documents or API specifications.

Synthetic data generation is especially useful when:

- Real data is scarce or difficult to collect
- You need to preserve privacy while retaining useful structure
- You want to generate domain-specific data from existing documents or code
- You want to reduce the cost compared to manual data collection

### Choose synthetic data generators

Microsoft Foundry offers two types of synthetic data generators:

**Simple Q&A Generator**: Converts domain documents (PDF, Markdown, or plain text up to 20 MB) into fine-tuning question-answer pairs. You can configure the question type:

- **Long answer**: Generates questions that require analytical reasoning in the model response
- **Short answer**: Generates questions focused on factual brevity

**Tool use Generator**: Creates multi-turn conversations with tool calls based on your API surface. Requires a valid OpenAPI 3.0.x or 3.1.x specification (JSON format, up to 20MB) that describes the APIs you want the model to learn to call as tools.

### Generate synthetic data in the portal

To generate synthetic data in Microsoft Foundry:

1. Navigate to **Data > Synthetic Data Generation** in the portal
1. Select **Generate data**
1. Choose a task type (Simple Q&A or Tool use)
1. Configure generation parameters if applicable  
1. Upload your reference file
1. Specify the number of samples to generate (between 50 and 1,000)
1. Select the model to use for data generation
1. Optionally enable an 80/20 train-validation split
1. Submit the job

The generated dataset is automatically formatted as JSONL files compatible with Microsoft Foundry fine-tuning workflows. You can download the dataset for review or use it directly in fine-tuning.

### Apply best practices for synthetic data

To get the best results when using synthetic data:

- **Use high-quality reference files**: The quality of your reference file directly impacts the generated data. Use relevant, well-structured documents with clear formatting and avoid excessive noise or irrelevant information.
- **Start small and iterate**: Begin with a smaller sample size to evaluate quality, then scale up after reviewing and refining your approach.
- **Combine with real data**: When possible, mix synthetic data with real-world examples to improve model performance and generalization.
- **Experiment with hyperparameters**: When fine-tuning on synthetic data, you need to adjust learning rates and other parameters differently than with real data to avoid overfitting.
- **Monitor performance**: Regularly evaluate your fine-tuned model on real-world tasks to ensure it meets your requirements.

When preparing your dataset to fine-tune a language model, you should understand your desired model behaviors, create a dataset in JSONL format (manually or through synthetic generation), and ensure the examples you include are high quality and diverse. By preparing your dataset carefully, you have a higher chance that the fine-tuned model improves your chat application's performance.
