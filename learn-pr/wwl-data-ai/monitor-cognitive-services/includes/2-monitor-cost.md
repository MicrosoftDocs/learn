One of the main benefits of using cloud services is that you can gain cost efficiencies by only paying for services as you use them. Some Cognitive Services resources offer a free tier with restrictions on use, which is useful for development and testing; and one or more billed tiers that incur charges based on transactions. The specific billing rate depends on the resource type.

## Plan costs for Cognitive Services

Before deploying a solution that depends on Cognitive Services, you can estimate costs by using the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).

To use the pricing calculator to estimate Cognitive Services costs, create a new estimate and select **Azure Cognitive Services** in the **AI + Machine Learning** category. Then select the specific cognitive service API you plan to use (for example, *Text Analytics*), the region where you plan to provision it, and the pricing tier of the instance you plan to use; and fill in the expected usage metrics and support option. To create an estimate that includes multiple Cognitive Services APIs, add additional **Azure Cognitive Services** products to the estimate.

![The Azure pricing calculator](../media/azure-calculator.png)

After you've created an estimate, you can save it. You can also export it in Microsoft Excel format.

## View costs for Cognitive Services

In common with other Azure resources, you can view details of accumulated costs for Cognitive Services resources in the Azure portal.

To view costs for Cognitive Services, sign into the Azure portal and select your subscription. You can then view overall costs for the subscription by selecting the **Cost analysis** tab. To view only costs for Cognitive Services, add a filter that restricts the data to reflect resources with a **service name** of **azure cognitive services**.

![Cost analysis in the Azure portal](../media/cognitive-services-costs.png)

> [!NOTE]
> For more information, see [Plan and manage costs for Azure Cognitive Services](/azure/cognitive-services/plan-manage-costs) in the Cognitive Services documentation.