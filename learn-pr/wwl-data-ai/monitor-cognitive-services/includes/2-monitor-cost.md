One of the main benefits of using cloud services is that you can gain cost efficiencies by only paying for services as you use them. Some Azure AI Services resources offer a free tier with restrictions on use, which is useful for development and testing; and one or more billed tiers that incur charges based on transactions. The specific billing rate depends on the resource type.

## Plan costs for Azure AI Services

Before deploying a solution that depends on Azure AI Services, you can estimate costs by using the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).

To use the pricing calculator to estimate Azure AI Services costs, create a new estimate and select **Azure AI Services** in the **AI + Machine Learning** category. Then select the specific Azure AI service API you plan to use (for example, *Text Analytics*), the region where you plan to provision it, and the pricing tier of the instance you plan to use; and fill in the expected usage metrics and support option. To create an estimate that includes multiple Azure AI Services APIs, add additional **Azure AI Services** products to the estimate.

![The Azure pricing calculator](../media/azure-calculator.png)

After you've created an estimate, you can save it. You can also export it in Microsoft Excel format.

## View costs for Azure AI Services

In common with other Azure resources, you can view details of accumulated costs for Azure AI Services resources in the Azure portal.

To view costs for Azure AI Services, sign into the Azure portal and select your subscription. You can then view overall costs for the subscription by selecting the **Cost analysis** tab. To view only costs for Azure AI Services, add a filter that restricts the data to reflect resources with a **service name** of **Azure AI services**.

![Cost analysis in the Azure portal](../media/cognitive-services-costs.png)

> [!NOTE]
> For more information, see [Plan and manage costs for Azure AI Services](/azure/ai-services/plan-manage-costs) in the Azure AI Services documentation.