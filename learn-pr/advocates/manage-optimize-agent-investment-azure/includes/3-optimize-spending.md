As AI workloads scale across organizations, so do the risks of runaway costs and resource inefficiencies. Microsoft's Azure platform offers a strategic arsenal of pricing models and architectural principles designed to help organizations rein in spending while maximizing performance. Leveraging Azure AI Foundry provisioned throughput reservations are a powerful way to optimize spending on AI agents. By accurately estimating needs, managing quotas, and purchasing the right reservations, organizations can ensure high performance while minimizing costs.

## Introduction to PTUs and cost optimization

Provisioned Throughput Units (PTUs) are model-independent units of processing capacity used to size deployments in Azure AI Foundry. They determine how much throughput (measured in tokens per minute) your AI agents can handle. PTUs are granted as quota per region and are essential for high-performance, scalable AI workloads.

### Why PTUs matter for ROI

- PTUs allow predictable performance for AI agents.
- Hourly PTU billing is flexible but expensive for long-term use.
- Azure AI Foundry provisioned throughput reservations offer substantial discounts over hourly billing and are ideal for consistent workloads.

## Estimating PTU needs for AI agents

Before purchasing reservations, you must estimate and deploy the PTUs your AI agents require. This depends on:

- Input and output token volume
- Request frequency
- Model type and latency targets

Use the capacity calculator in **Azure AI Foundry** to simulate workload shapes and determine the optimal PTU count.

## Purchasing PTU reservations

PTU reservations are available for **Global**, **Data Zone**, and **Regional** deployment types. Each type requires a separate reservation.

### Steps to purchase PTU reservations

1. Confirm PTU quota and deploy models in Azure AI Foundry portal.
1. Go to the Azure portal, select **Reservations**, then select **Azure AI Foundry Provisioned Throughput**.
1. Select the relevant scope, region, deployment type, billing frequency, and PTU quantity.
1. Choose billing frequency (monthly or upfront).
1. Complete the purchase.

It's best practice to purchase a reservation after you've created the deployment. This order ensures that the required capacity is available for the desired region or model before your purchase.

> [!NOTE]
> Reservations aren't deployments. Reservations provide a discounted price for the selected term.  They don't reserve capacity on the service or guarantee that it's available when a deployment is created.

## Managing quotas and deployments

Quota management ensures you don't exceed your PTU limits. In the **Azure AI Foundry Management Center**, you can:

- View current quota allocations.
- Request increases for specific regions and models.
- Use charts to monitor usage trends.

### Quota types

- Regional Provisioned
- Global Provisioned
- Data Zone Provisioned

### Agent-specific limits

- Max 128 tools per agent
- Max 10,000 files per thread
- Max 100,000 messages per thread

## Maximizing ROI with PTU reservations

Key strategies for maximizing ROI with PTU reservations include:

- Use reservations for production workloads with steady traffic.
- Avoid hourly billing for long-term deployments.
- Leverage Cost Management to view your reservation utilization.
- Set up utilization alerts with appropriate thresholds to avoid unexpected cost spikes.
- Exchange reservations if your scope changes.
- Use shared quota pools for testing and development.

Benefits of PTU reservations include:

- Achieve cost savings on your predictable stable workloads.
- Improve estimation and forecasting with reservation recommendations based on historical usage and fixed monthly or upfront costs.
- Adhere to budgets by locking in lower prices and setting up alerts.
- Simplified budgeting and forecasting.
