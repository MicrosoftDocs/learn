As AI workloads scale across organizations, so do the risks of runaway costs and resource inefficiencies. Microsoft's Azure platform offers a strategic arsenal of pricing models and architectural principles designed to help organizations rein in spending while maximizing performance. Microsoft Foundry provisioned throughput reservations are a powerful way to optimize spending on AI agents. By accurately estimating needs, managing quotas, and purchasing the right reservations, organizations can ensure high performance while minimizing costs.

## Introduction to PTUs and cost optimization

Provisioned throughput units (PTUs) are generic units of model processing capacity used to size provisioned deployments in Microsoft Foundry. PTU quota is model-independent, so the same quota pool can be used for any supported model within its subscription, region, and provisioned deployment type. However, a PTU isn't a fixed tokens-per-minute (TPM) conversion. The throughput delivered by a PTU count varies by model and request shape, including the input/output token mix, the model's output-to-input ratio, and prompt-cache rate. See [provisioned throughput concepts](/azure/foundry/openai/concepts/provisioned-throughput) and [per-model throughput values](/azure/foundry/openai/how-to/provisioned-throughput-sizing#deployment-parameters-and-throughput-values-by-model).

> [!IMPORTANT]
> PTU quota is a no-cost policy limit; capacity is the model-version-specific processing capacity actually available at deployment time. Having quota doesn't guarantee capacity. Verify capacity in the deployment experience before planning a deployment or purchasing a reservation.

### Why PTUs matter for ROI

- PTUs allow predictable performance for AI agents.
- Hourly PTU billing is flexible but expensive for long-term use.
- Microsoft Foundry provisioned throughput reservations offer substantial discounts over hourly billing and are ideal for consistent workloads.

## Estimating PTU needs for AI agents

Before purchasing a reservation, estimate the PTUs required for the model version and workload, and then validate the estimate with representative traffic:

1. In Microsoft Foundry, select **Manage** > **Quota** > **Provisioned throughput unit**, and open the capacity calculator.
1. Select the **Model** and **Version**.
1. Enter **Peak calls per min**, **Tokens in prompt call**, **Tokens in model response**, and **Cache rate**.
1. Select **Calculate** and treat the raw and rounded PTU results as guided estimates, not guaranteed or optimal capacity.
1. Review the minimum deployment size and scale increment for the intended Global, Data Zone, or Regional deployment type.
1. Create an hourly-billed deployment and benchmark the same model version with representative peak traffic, prompt and response sizes, cache behavior, and request-shape variation before purchasing a reservation.

The calculator doesn't take a latency target as an input. Validate latency and throughput during the benchmark. For calculation details and current model-specific values, see [Determine PTU sizing for a workload](/azure/foundry/openai/how-to/provisioned-throughput-sizing).

## Purchasing PTU reservations

Purchase separate reservations for **Global**, **Data Zone**, and **Regional** provisioned deployment types. The reservation's deployment type and benefit scope must match the deployment. For Data Zone and Regional deployments, the reservation region must also match the deployment region.

> [!IMPORTANT]
> A PTU reservation is a financial commitment for either one month or one year. It discounts matching PTU usage; it doesn't create a deployment or reserve model capacity. Because model-version capacity changes dynamically, create and verify the provisioned deployments first, and then purchase only enough reservation units to cover the deployed PTUs.

A Global reservation isn't region-specific. During purchase, you can select any public commercial cloud region, and one Global reservation can cover matching Global PTUs across multiple regions within its benefit scope. Size its quantity for the total matching Global PTUs. Data Zone and Regional reservations remain region-matched.

### Steps to purchase PTU reservations

1. Confirm that the provisioned deployments exist and record the deployed PTU total to cover for each deployment type.
1. Verify that the purchaser has the built-in **Owner** or **Reservation Purchaser** role on an eligible subscription and that organizational reservation-purchase policies permit the transaction.
1. In the Azure portal, select **All services** > **Reservations** > **Microsoft Foundry Provisioned Throughput**.
1. Select the subscription whose payment method will pay for the reservation.
1. Select the benefit scope: a single resource group, single subscription, management group, or shared billing scope, as appropriate.
1. Select the region. Match the deployment region for Data Zone or Regional coverage; for consolidated Global coverage, select any public commercial cloud region.
1. Select the product that matches the deployment type: Global, Data Zone, or Regional. Then select **Add to cart**.
1. In the cart, set the PTU **Quantity** to the deployed PTUs that the reservation should cover.
1. Select the commitment **Term**: **One month** or **One year**.
1. Separately select the **Payment option**: **Upfront** or **Monthly**. Monthly payment changes when the committed amount is paid; it doesn't shorten the reservation term.
1. Select **Next: Review + Buy**. Verify the subscription, scope, product, region, quantity, term, payment option, and price, and then select **Buy now**.
1. After purchase, select **View this Reservation** and verify that it becomes active and applies to the intended deployments.

## Managing quotas and deployments

Quota is a policy limit on what a subscription can deploy; it isn't a guarantee that model capacity is currently available. To manage quota in Foundry (new), select **Manage** in the upper-right navigation, and then select **Quota**.

The **Quota** pane has two tabs:

- **Token per minute** shows model-specific TPM quota for standard deployments.
- **Provisioned throughput unit** shows PTU quota allocations and provisioned-capacity estimation tools. PTU quota is model-independent and is scoped by subscription, region, and provisioned deployment type.

PTU quota pools are separate for **Global Provisioned**, **Data Zone Provisioned**, and **Regional Provisioned**. Use the quota-request option available from the **Quota** page when an increase is needed.

Actual deployable capacity is specific to a model version and changes dynamically. Check it when creating or resizing the deployment in the Foundry deployment experience, or query the [model capacities API](/rest/api/aiservices/accountmanagement/model-capacities/list). For more information, see [Manage quota in Microsoft Foundry](/azure/foundry/how-to/quota) and [PTU quota and capacity](/azure/foundry/openai/concepts/provisioned-throughput#quota-and-capacity).

### Agent-specific limits

- Max 128 tools per agent
- Max 10,000 files per thread
- Max 100,000 messages per thread

## Maximizing ROI with PTU reservations

Key strategies for maximizing ROI with PTU reservations include:

- Use hourly-billed provisioned deployments for short-term benchmarking, then use reservations for sustained workloads only after deployment capacity and steady demand are confirmed.
- Size each reservation to the matching deployed PTUs and monitor reservation coverage and utilization in Cost Management.
- Configure [reservation utilization alerts](/azure/cost-management-billing/costs/reservation-utilization-alerts) to notify you when average utilization is below a selected threshold over the last 7 or 30 days. Use these alerts to find underused commitments; the reservation commitment continues when reserved PTUs aren't matched to deployments. Use [budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) or [Cost Management anomaly alerts](/azure/cost-management-billing/understand/analyze-unexpected-charges) for unexpected spend.
- When the reservation's benefit scope changes, open the reservation in the Azure portal, select **Configuration**, and rescope it. Rescoping isn't a commercial transaction and doesn't change the reservation term.
- Don't use **Exchange** only to change benefit scope. An exchange cancels and refunds the existing reservation, purchases a replacement, and starts a new term. Use it only for an eligible change to attributes such as region, deployment type, term, or payment option after reviewing current commercial requirements. Use **Return** only for an eligible cancellation or refund; canceled commitments are subject to the current USD 50,000 limit per billing scope in a rolling 12-month window.

> [!IMPORTANT]
> [Foundry shared quota](/azure/foundry/how-to/quota#foundry-shared-quota) is an availability-dependent, temporary pool for limited-duration inference testing. Access isn't guaranteed, and billing is usage-based. Use shared quota only for temporary test endpoints when it's available; don't use it for production endpoints. Shared quota doesn't provide dedicated PTU quota or model capacity and isn't a way to size, cover, or optimize a PTU reservation. Request dedicated quota for production endpoints.

Benefits of PTU reservations include:

- Achieve cost savings on your predictable stable workloads.
- Improve estimation and forecasting with reservation recommendations based on historical usage and fixed monthly or upfront costs.
- Adhere to budgets by locking in lower prices and setting up alerts.
- Simplified budgeting and forecasting.
