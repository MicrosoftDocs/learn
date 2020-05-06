> [!Note]
> **Sarah: Conversion feedback**
> 
> I formatted the Learning goal as the first item under Learning objectives.
> I updated the steps to get the API keys based on the current UI.
>

> [!Note]
> **Sarah: Action items**
> 
> - Add Learning objectives
> - Add Prerequisites
>

Just as you created a web service that could consume data and return predictions, so there are many AI software-as-a-service (SaaS) offerings on the web that return predictions or classifications based on data you supply. One family of AI SaaS offerings is Microsoft Azure Cognitive Services.

The advantage of using cloud-based services is that they provide cutting-edge models that you can access without having to train them. This can help accelerate both your exploration and use of ML.

Azure provides Cognitive Services APIs that can be consumed using Python to conduct image recognition, speech recognition, and text recognition, just to name a few. For the purposes of this notebook, we're going to look at using the Computer Vision API and the Text Analytics API.

We'll start by obtaining a Cognitive Services API key. Note that you can get a free key for seven days, and then you'll be required to pay.

To learn more about the costs to use Cognitive Services, see [Cognitive Services pricing](https://azure.microsoft.com/pricing/details/cognitive-services/?azure-portal=true).

Browse to [try Azure Cognitive Services](https://azure.microsoft.com/try/cognitive-services/?azure-portal=true).

First, get a Cognitive Services API key:

1. Select the **Vision APIs** category tab.

1. On the **Computer Vision** row, select the **Get API key** button.

1. If you're prompted to enter credentials, you can choose to evaluate Cognitive Services for free for seven days:

   - Under **Guest**, select **Get started**.

Next, complete the same steps to retrieve a Text Analytics API key:

1. Select the **Language APIs** category tab.

1. On the **Text Analytics** row, select the **Get API key** button.

> [!Note]
> You can also obtain keys on the page that shows your API keys.
> Scroll to find the service that you want, and then select **Add**.

After you have your API keys, you're ready to start.

## Learning objectives

In this module, you will:

- By the end of this part, you should have a basic comfort with accessing cloud-based cognitive services by API from a Python environment.
- TBD

## Prerequisites

- None.
