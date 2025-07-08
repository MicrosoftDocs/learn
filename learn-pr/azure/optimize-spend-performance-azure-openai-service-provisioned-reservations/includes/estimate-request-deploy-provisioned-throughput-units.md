When you start with Azure OpenAI, we recommend that you use the Standard deployment type during the initial and testing phases. However, you should consider switching from pay-per-token to provisioned throughput when you have well-defined, predictable throughput requirements. Typically, you would know your requirements when the application is ready for production or has already been deployed in production and you understand the expected traffic. This allows you to accurately forecast the required capacity and avoid unexpected billing.

In general, prompt tokens are less expensive to process than an equal number of generated tokens. This also means that the distribution of these call shapes is important in overall throughput. Traffic patterns with a wide distribution that include some very large calls might experience lower throughput per PTU than a narrower distribution with the same average prompt and completion token sizes.

## Using the Capacity Calculator in Azure OpenAI Foundry

Determining the right number of PTUs you require for your workload is an essential step to optimizing performance and cost. You can use the Azure OpenAI capacity calculator to help estimate the required number of PTUs to meet the needs of your workload.

:::image type="content" source="../media/4-azure-openai-capacity-calculator-small.png" alt-text="A screenshot of the Azure OpenAI Capacity calculator." border="true" lightbox="../media/4-azure-openai-capacity-calculator.png":::

When using the Azure OpenAI capacity calculator, it's important that you understand the data you need to provide. In addition to selecting the Azure OpenAI model and its version, you need to provide the following data:

- **Peak calls per min**: The maximum number of calls per minute that you expect to be sent to the model.

- **Tokens in a prompt call**: The number of tokens in the prompt for each call to the model. Calls with larger prompts utilize more of the PTU deployment. Currently this calculator assumes a single prompt value. Therefore, for workloads with wide variance, we recommend benchmarking your deployment on your traffic to determine the most accurate estimate of PTU needed for your deployment.

- **Tokens in model response**: The number of tokens generated from each call to the model. Calls with larger generation sizes utilize more of the PTU deployment. Currently this calculator assumes a single prompt value. Therefore, for workloads with wide variance, we recommend benchmarking your deployment on your traffic to determine the most accurate estimate of PTU needed for your deployment.

After you fill in the required details, select **Calculate** in the output column.

The values in the output column are the estimated values of PTU units required for the provided workload inputs. The first output value represents the estimated PTU units required for the workload, rounded to the nearest PTU scale increment. The second output value represents the raw estimated PTU units required for the workload. The token totals are calculated using the following equation:

Total = Peak calls per minute × (Tokens in prompt call + Tokens in model response)

## Azure OpenAI Provisioned purchase options

Provisioned deployments by default are billed on an hourly basis. Customers can get additional savings by purchasing provisioned reservations.

The hourly model is useful for short-term deployment needs, such as validating new models or acquiring capacity for a hackathon.  However, the discounts provided by the Azure OpenAI Service provisioned reservations are considerable and most customers with consistent long-term usage will find a reserved model to be a better value proposition.

Provisioned throughput deployments are charged an hourly rate (\\$/PTU/hour), based on the number of PTUs that have been deployed.  For example, a 300 PTU deployment will be charged the hourly rate multiplied by 300.  All Azure OpenAI pricing is available in the Azure Pricing Calculator.

## Azure OpenAI Service Quota

Azure OpenAI's quota enables the assignment of rate limits to your deployments, up to a global limit called your *quota*.

For standard deployments, a quota is assigned to your subscription on a per-region, per-model basis, in units of Tokens per Minute (TPM). When you onboard a subscription to Azure OpenAI, you'll receive the default quota for most available models. Then, you'll assign TPM to each deployment as it is created, and the available quota for that model will be reduced by that amount. You can continue to create deployments and assign them TPM until you reach your quota limit. Once that happens, you can only create new deployments of that model by reducing the TPM assigned to other deployments of the same model (thus freeing TPM for use), or by requesting and being approved for a model quota increase in the desired region.

For provisioned deployments, Azure OpenAI grants quota to a subscription regionally and limits the total number of PTUs that can be deployed in that region across all models and versions.

Creating a new deployment requires an available (unused) quota to cover the desired size of the deployment. For example, a subscription has the following quota in South Central US:

- Total PTU Quota = 500 PTUs

- Deployments:

  - 100 PTUs: GPT-4o, 2024-05-13

  - 100 PTUs: GPT-4, 0613

In this scenario, 200 PTUs of quota are considered used, and 300 PTUs are available for use to create new deployments.

A default number of provisioned and global provisioned quota is assigned to all subscriptions in several regions. You can review the quota available to you in a region by visiting the Quotas blade in Azure OpenAI Foundry and selecting the desired subscription and region.

For example, the following screenshot displays a quota limit of 500 PTUs in West US for the selected subscription. Note that you might observe lower values of available default quotas.

:::image type="content" source="../media/4-quota-limit-small.png" alt-text="A screenshot of the available quotas in Azure OpenAI Foundry." border="true" lightbox="../media/4-quota-limit.png":::

By default, PTU quota is available in many regions. If an additional quota is required, customers can request it by using the **Request Quota** link next to the **Provisioned Managed Throughput Unit** quota item in Azure OpenAI Foundry. The form allows customers to request an increase in the PTU quota for a specified region. After the request is approved, customers will receive an email at the included address, typically within two business days.

> [!NOTE]
> You must specify quota for the deployment (Global PTU, Data Zone PTU, and Regional PTU have separate quota).

## Creating a provisioned deployment - capacity is available

You can create PTUs by using Azure OpenAI resource objects within Azure. You must have an Azure OpenAI resource in each region where you intend to create a deployment. Use the Azure portal to create a resource in a region with an available quota, if required. Note that Azure OpenAI resources can support multiple types of Azure OpenAI deployments at the same time. It isn't necessary to dedicate new resources for your provisioned deployments.

To create a provisioned deployment, follow the instructions in the **Deploy model** dialog box, entering the required information as depicted in the following example.

:::image type="content" source="../media/4-deploy-model-dialog-box.png" alt-text="A screenshot of the Azure OpenAI Foundry deployment page for a provisioned deployment." border="true":::

Important things to note when creating a provisioned deployment:

- The deployment dialog box contains a reminder that you can purchase an Azure reservation for Azure OpenAI Provisioned to obtain a significant discount for a term commitment.

- A message displays the listed hourly price of the deployment that would be charged if the deployment isn't covered by a reservation. This is a list price that doesn't include any negotiated discounts for your company.

- If you're unsure of the costs, cancel the deployment and proceed once you understand the payment model and underlying costs for provisioned deployment. This step may prevent unexpected, high charges on your payment invoice.

The following image displays an example of the pricing confirmation that you can review.

:::image type="content" source="../media/4-confirm-pricing.png" alt-text="A screenshot displaying the pricing confirmation for your deployment." border="true":::

## Creating a provisioned deployment - capacity isn't available

Due to the dynamic nature of capacity availability, it is possible that the region of your selected resource might not have the service capacity to create the deployment of the specified model, version, and number of PTUs.

In this event, Azure OpenAI Foundry will direct you to other regions with available quota and capacity to create a deployment of the desired model. If this happens, the **Deploy model** dialog box might display information as depicted in the following screenshot.

:::image type="content" source="../media/4-deploy-model-capacity-not-available.png" alt-text="A screenshot of the Azure OpenAI Foundry deployment page for a provisioned deployment with no capacity available." border="true":::

Important things to note:

- A message displays, indicating the number of PTUs you have in available quota and how many you can currently deploy at this time.

- If you select a PTU number greater than the service capacity, a message will display that provides options for you to obtain more capacity, and an option to select an alternate region. Selecting **See other regions** will open a dialog box that lists the Azure OpenAI resources where you can create a deployment, along with the maximum-sized deployment based on the available quota and service capacity in each region.

When you select a resource and then select **Switch resource**, the **Deploy model** dialog box will redisplay information using the selected resource. You can then proceed to create your deployment in the new region.

## Measuring your deployment utilization

When you deploy a specified number of PTUs, Azure OpenAI makes a set number of inference throughput available to that endpoint. Utilization of this throughput is a complex formula based on the model, model-version call rate, prompt size, and generation size. To simplify this calculation, Azure Monitor provides a utilization metric. After the utilization rises above 100 percent, your deployment returns a **Request rate too large** exception error (code 429) on any new calls.

The Provisioned utilization is defined as follows:

PTU deployment utilization = (PTUs consumed in the time period) ÷ (PTUs deployed in the time period)

You can find the utilization measure in the Azure Monitor section of your resource. To access the monitoring dashboards:

1. Sign in to the Azure portal.

2. Go to your Azure OpenAI resource, and from the navigation pane, select **Metrics**.

3. On the **Metrics** page, select the **Provisioned-managed utilization V2** metric.

If you have more than one deployment in the resource, you should also split the values per deployment by selecting **Apply Splitting**.

:::image type="content" source="../media/4-apply-splitting-small.png" alt-text="A screenshot of the provisioned managed utilization on the resource's metrics page in the Azure portal." border="true" lightbox="../media/4-apply-splitting.png":::

You can also use out-of-the-box dashboards for each of your Azure OpenAI resources. To access the monitoring dashboards, sign in to the Azure portal and select the overview pane for one of your Azure OpenAI resources.

The dashboards are grouped into four categories:

- HTTP Requests
- Tokens-Based Usage
- PTU Utilization
- Fine-tuning

:::image type="content" source="../media/4-azure-openai-dashboards-small.png" alt-text="A screenshot that displays out-of-box dashboards for an Azure OpenAI resource in the Azure portal." border="true" lightbox="../media/4-azure-openai-dashboards.png":::

Azure OpenAI collects the same types of monitoring data as other Azure resources. You can configure Azure Monitor to generate data in activity logs, resource logs, virtual machine logs, and platform metrics.

Platform metrics and the Azure Monitor activity log are collected and stored automatically. You can route this data to other locations by using a diagnostic setting. Azure Monitor resource logs aren't collected and stored until you create a diagnostic setting that routes the logs to one or more locations. When you create a diagnostic setting, you specify which categories of logs to collect.

> [!NOTE]
> Remember that using diagnostic settings and sending data to Azure Monitor Logs has other costs associated with it.

## Summary

In this unit, you gained an understanding of how to estimate, request, and deploy PTU in Azure OpenAI Service. You learned how to use the capacity calculator to estimate PTU usage, how to request quota and how to create provisioned deployments in the Azure portal. At the end, you learned how to measure and monitor your deployment utilization.
