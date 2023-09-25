Previously you created a web service that could consume data and return predictions. There are also many AI software as a service (SaaS) offerings on the web that return predictions or classifications based on data you supply. One family of AI SaaS offerings is Azure AI services.

The advantage of using cloud-based services is that they provide cutting-edge models that you can access without having to train them. You can use the models to help accelerate both your exploration and use of machine learning.

Azure provides Azure AI services APIs that can be consumed by using Python to conduct image recognition, speech recognition, and text recognition, to name a few. For the purposes of this notebook, we're going to look at using the Computer Vision API and the Text Analytics API.

We'll start by obtaining a Azure AI services API key. You can get a free key for seven days, and after that you're required to pay for it.

To learn more about the costs to use Azure AI services, see [Azure AI services pricing](https://azure.microsoft.com/pricing/details/cognitive-services/?azure-portal=true).

Browse to [try Azure AI services](https://azure.microsoft.com/try/cognitive-services/?azure-portal=true).

First, get a Azure AI services API key:

1. Select the **Vision APIs** category tab.

1. In the **Computer Vision** row, select **Get API key**.

1. If you're prompted to enter credentials, you can choose to evaluate Azure AI services for free for seven days:

   - Under **Guest**, select **Get started**.

Follow the same steps to retrieve a Text Analytics API key:

1. Select the **Language APIs** category tab.

1. In the **Text Analytics** row, select **Get API key**.

> [!NOTE]
> You can also obtain keys on the page that shows your API keys. Scroll to find the service you want, and then select **Add**.

After you have your API keys, you're ready to start.

## Learning objectives

In this module, you will:

- Be comfortable accessing cloud-based Azure AI services APIs from a Python environment.
- Access Azure AI Vision APIs to analyze and describe images.
- Use a few Azure AI Language APIs to extract different information from text, such as language, sentiment, key phrases, and entities.

## Prerequisites

- Basic understanding of Python

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
