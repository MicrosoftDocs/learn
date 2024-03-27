By using open-source pretrained **foundation** models, you can save resources. Sometimes, you may need to fine-tune a foundation model to cater to your specific needs. 

## Explore foundation models in the model catalog

Foundation models are large machine learning models that are already trained to serve as the base for a wide variety of use cases.

In Azure Machine Learning, you can explore open source foundation models by searching through the **model catalog**. What type of foundation model you need depends on what you want to use the model for.

In general, foundation models are trained on large amounts of data and excel at doing generic tasks like understanding language, generating text, and predicting context. However, they might not be the best choice if you need a model tailored to a specific task or domain. In such cases, fine-tuning the foundation model on task-specific data can help meet your specific requirements and achieve better results.

## Fine-tuning foundation models for specific tasks

Though the foundation models may already satisfy your requirements, it may be necessary for you to fine-tune a foundation model.

Foundation models are pretrained on a diverse range of text from the internet, making them proficient in general language understanding. However, fine-tuning allows you to tailor the model's knowledge to a specific task or domain, optimizing its performance and ensuring it excels in that particular context.

Some common tasks for which you may want to fine-tune a foundation model are:

- **Text classification**: Categorizing a given text into predefined classes or categories based on its content or context.
- **Token classification**: Assigning specific labels or tags to individual tokens or words in a text, often used in tasks like named entity recognition.
- **Question answering**: Providing accurate and relevant answers to questions posed in natural language.
- **Summarization**: Creating concise and coherent summaries of longer texts, capturing the essential information.
- **Translation**: Converting text from one language to another while preserving the meaning and context.

As foundation models are already pretrained, you need a smaller task-specific dataset to fine-tune a foundation model. When you fine-tune a model, you're likely to need less data and compute than when you would train a model from scratch.

You can fine-tune a foundation model from the model catalog in Azure Machine Learning. You only need a small dataset and a GPU cluster to fine-tune a model.
