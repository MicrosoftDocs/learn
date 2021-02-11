Previously you created a web service that could consume data and return predictions. There are also many AI software as a service (SaaS) offerings on the web that return predictions or classifications based on data you supply. One family of AI SaaS offerings is Azure Cognitive Services.

The advantage of using cloud-based services is that they provide cutting-edge models that you can access without having to train them. You can use the models to help accelerate both your exploration and use of machine learning.

Azure provides Cognitive Services APIs that can be consumed by using Python to conduct image recognition, speech recognition, and text recognition, to name a few. For the purposes of this notebook, we're going to look at using the Computer Vision API and the Text Analytics API.

We'll start by obtaining a Cognitive Services API key. You can get a free key for seven days, and after that you're required to pay for it.

To learn more about the costs to use Cognitive Services, see [Cognitive Services pricing](https://azure.microsoft.com/pricing/details/cognitive-services/?azure-portal=true).

Browse to [try Azure Cognitive Services](https://azure.microsoft.com/try/cognitive-services/?azure-portal=true).

First, get a Cognitive Services API key:

1. Select the **Vision APIs** category tab.

1. In the **Computer Vision** row, select **Get API key**.

1. If you're prompted to enter credentials, you can choose to evaluate Cognitive Services for free for seven days:

   - Under **Guest**, select **Get started**.

Follow the same steps to retrieve a Text Analytics API key:

1. Select the **Language APIs** category tab.

1. In the **Text Analytics** row, select **Get API key**.

> [!NOTE]
> You can also obtain keys on the page that shows your API keys. Scroll to find the service you want, and then select **Add**.

After you have your API keys, you're ready to start.

## Learning objectives

In this module, you will:

- Be comfortable accessing cloud-based Cognitive Services APIs from a Python environment.
- Access Cognitive Services Computer Vision APIs to analyze and describe images.
- Use a few Cognitive Services APIs to extract different information from text, such as language, sentiment, key phrases, and entities.

## Prerequisites

- Basic understanding of Python

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
