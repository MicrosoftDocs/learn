The Transformer architecture has allowed us to train models for **Natural Language Processing** (**NLP**) in a more efficient way. Instead of processing each token in a sentence or sequence, attention allows a model to process tokens in parallel in various ways.

To train a model using the Transformer architecture, you need to use a large amount of text data as input. Different models have been trained, which mostly differ by the data they've been trained on, or by how they implement attention within their architectures. Since the models are trained on large datasets, and the models themselves are large in size, they're often referred to as **Large Language Models** (**LLMs**).

Many LLMs are open-source and publicly available through communities like Hugging Face. Azure also offers the most commonly used LLMs as **foundation models** in the Azure Machine Learning **model catalog**. Foundation models are pre-trained on large texts and can be fine-tuned for specific tasks with a relatively small dataset.

## Explore the model catalog

In the Azure Machine Learning studio, you can navigate to the model catalog to explore all available foundation models. Additionally, you can import any model from the Hugging Face open-source library into the model catalog.

When you select a model, you can already experiment with it to explore whether it meets your requirements. You can deploy a foundation model as is, or choose to fine-tune it when you need it to perform a specific task well, or when you want it to perform better on domain-specific knowledge.

Foundation models can be used for a variety of tasks:

- Text classification
- Token classification
- Question answering
- Summarization
- Translation

To choose the foundation model that best fits your needs, you can easily test out different models in the model catalog. You can also review the data the models are trained on and possible biases and risks a model may have.

Some foundation models that are commonly used are:

- **BERT** (Bidirectional Encoder Representations from Transformers) is a family of models commonly used when you want to fine-tune a model to perform a specific task like *text classification* and *question answering*.
- **GPT** (Generative Pre-trained Transformer) is trained to create coherent and contextually relevant text, and is most commonly used for tasks like *text generation* and *chat completions*.
- **LLaMA** (Large Language Model Meta AI) is a family of models created by Meta. When training LLaMA models, the focus has been on providing more training data than increasing the complexity of the models. You can use LLaMA models for *text generation* and *chat completions*.
