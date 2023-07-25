To fine-tune a foundation model from the model catalog in Azure Machine Learning, you can use the user interface provided in the studio, the Python SDK, or the Azure CLI.

## Prepare your data and compute

Before you can fine-tune a foundation model to improve model performance, you need to prepare your training data and create a GPU compute cluster.

> [!Tip]
> When you create a GPU compute cluster in Azure Machine Learning, GPU optimized virtual machine will be created for you. Learn more about the [GPU virtual machine sizes available in Azure](https://learn.microsoft.com/azure/virtual-machines/sizes-gpu?azure-portal=true).

The training data can be in JSON Lines (JSONL), CSV, or TSV format. The requirements of your data vary based on the specific task you intend to fine-tune your model for.

| Task | Dataset requirements |
| --- | --- |
| Text classification | Two columns: `Sentence` (string) and `Label` (integer/string) |
| Token classification | Two columns: `Token` (string) and `Tag` (string) |
| Question answering | Five columns: `Question` (string), `Context` (string), `Answers` (string), `Answers_start` (int), and `Answers_text` (string) |
| Summarization | Two columns: `Document` (string) and `Summary` (string) |
| Translation | Two columns: `Source_language` (string) and `Target_language` (string) |

> [!Note]
> Your dataset needs to have the necessary requirements. You can use different column names however, and map the column to the appropriate requirement.

When you have your dataset and compute cluster ready, you can configure a fine-tuning job in Azure Machine Learning.

## Choose a foundation model

When you navigate to the model catalog in the Azure Machine Learning studio, you can explore all foundation models.

:::image type="content" source="../media/model-catalog.png" alt-text="Screenshot of model catalog in Azure Machine Learning.":::

You can filter the available models based on the task you want to fine-tune a model for. Per task, you have several options for foundation models to choose from. When deciding between foundation models for a task, you can examine the description of the model, and the referenced model card.

Some considerations you may take into account when deciding on a foundation model before fine-tuning are:

- **Model capabilities**: Evaluate the capabilities of the foundation model and how well they align with your task. For example, a model like BERT is better at understanding short texts.
- **Pretraining data**: Consider the dataset used for pretraining the foundation model. For example, GPT-2 is trained on unfiltered content from the internet that may result in biases.
- **Limitations and biases**: Be aware of any limitations or biases that might be present in the foundation model.
- **Language support**: Explore which models offer the specific language support or multilingual capabilities that you need for your use case.

> [!Tip]
> Though the Azure Machine Learning studio provides you with descriptions for each foundation model in the model catalog, you can also find more information about each model through the respective model card. The model cards are referenced in the overview of each model and hosted on [the website of Hugging Face](https://huggingface.co/models?azure-portal=true) 

## Configure a fine-tuning job

To configure a fine-tuning job using the Azure Machine Learning studio, you need to do the following steps:

1. Choose a foundation model.
1. Select **Finetune** to open a pop-up that helps you configure the job.
1. Select the task type.
1. Select the training data and map the columns in your training data to the dataset requirements.
1. Either let Azure Machine Learning automatically split the training data to create a validation and test dataset, or provide your own.
1. Select a GPU compute cluster managed by Azure Machine Learning.
1. Select finish to submit the fine-tuning job.

> [!Tip]
> Optionally, you can explore the advanced settings to change settings such as the name of the fine-tuning job and task parameters (for example the learning rate).

:::image type="content" source="../media/overview-fine-tuning-job.png" alt-text="Screenshot of fine-tuning job configuration.":::

After you submit the fine-tuning job, a pipeline job will be created to train your model. You can review all inputs and collect the model from the job outputs.

:::image type="content" source="../media/pipeline-job.png" alt-text="Screenshot of completed pipeline job that fine-tuned a foundation model.":::
