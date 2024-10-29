When you want to fine-tune a language model, you can use a base or foundation model that is already pretrained on large amounts of data. There are many foundation models available through the model catalog in the Azure AI Studio. You can fine-tune base models on various tasks, like text classification, translation, or chat completion.

When you want to use a fine-tuned model to generate responses in a chat application, you need to use a base model that can be fine-tuned on a chat completion task. The Azure AI Studio model catalog allows you to filter based on fine-tuning tasks to decide which base model to select. You can, for example, select a GPT-4 or Llama-2-7b model to fine-tune on your own training data.

To fine-tune a language model from Azure AI Studio's model catalog, you can use the user interface provided in the studio.

## Select the base model

When you navigate to the model catalog in the Azure AI Studio, you can explore all available language models.

> [!Note]
> Though all available language models will appear in the Azure AI Studio model catalog, you might not be able to fine-tune the model you want depending on the available quota. Ensure the model you want to fine-tune is available in the region you created your AI hub in.

You can filter the available models based on the task you want to fine-tune a model for. Per task, you have several options for foundation models to choose from. When deciding between foundation models for a task, you can examine the description of the model, and the referenced model card.

Some considerations you can take into account when deciding on a foundation model before fine-tuning are:

- **Model capabilities**: Evaluate the capabilities of the foundation model and how well they align with your task. For example, a model like BERT is better at understanding short texts.
- **Pretraining data**: Consider the dataset used for pretraining the foundation model. For example, GPT-2 is trained on unfiltered content from the internet that can result in biases.
- **Limitations and biases**: Be aware of any limitations or biases that might be present in the foundation model.
- **Language support**: Explore which models offer the specific language support or multilingual capabilities that you need for your use case.

> [!Tip]
> Though the Azure AI Studio provides you with descriptions for each foundation model in the model catalog, you can also find more information about each model through the respective model card. The model cards are referenced in the overview of each model and hosted on [the website of Hugging Face](https://huggingface.co/models?azure-portal=true)

## Configure the fine-tuning job

To configure a fine-tuning job using the Azure AI studio, you need to do the following steps:

1. Select a base model.
1. Select your training data.
1. *(Optional)* Select your validation data.
1. Configure the advanced options.

When you submit a model for fine-tuning, the model is further trained on your data. To configure the fine-tuning or training job, you can specify the following advanced options:

|Name|Description|
|---|---|
|batch_size|The batch size to use for training. The batch size is the number of training examples used to train a single forward and backward pass. In general, larger batch sizes tend to work better for larger datasets. The default value and the maximum value for this property are specific to a base model. A larger batch size means that model parameters are updated less frequently, but with lower variance.|
|learning_rate_multiplier|The learning rate multiplier to use for training. The fine-tuning learning rate is the original learning rate used for pretraining multiplied by this value. Larger learning rates tend to perform better with larger batch sizes. We recommend experimenting with values in the range 0.02 to 0.2 to see what produces the best results. A smaller learning rate can be useful to avoid overfitting.|
|n_epochs|The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.|
|seed|The seed controls the reproducibility of the job. Passing in the same seed and job parameters should produce the same results, but can differ in rare cases. If a seed isn't specified, one is generated for you.|

After you submit the fine-tuning job, a job will be created to train your model. You can review the status of the job while it's running. After the job is completed, you can review the input parameters when you want to understand how the fine-tuned model was created.

If you added a validation dataset, you can review the model's performance by exploring how it performed on your validation dataset.

Alternatively, you can always deploy a fine-tuned model. After deploying the model, you can test it to assess its performance. When you're satisfied with your fine-tuned model, you can integrate the deployed model with your chat application.
