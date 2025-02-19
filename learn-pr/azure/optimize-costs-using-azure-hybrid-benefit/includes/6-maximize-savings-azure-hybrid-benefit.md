The Azure platform provides many solutions, services, and tools that you can use to achieve increased savings in cloud usage. In addition to Azure Hybrid Benefit, you can leverage Azure Savings Plan and Azure Reservations when planning your cloud usage and spending to help you manage your costs. You also can use services such as Cost Management, Azure Monitor, Azure Policy, and Azure Advisor to get detailed insight into what is happening cost-wise in your cloud services.

:::image type="content" source="../media/ahb-with-reservations.png" alt-text="Illustration comparing the savings between using Azure Hybrid Benefit versus using Azure Hybrid Benefit and Azure Reservations." border="false":::

Azure Savings Plan enables you to save on Azure compute costs by committing to a consistent amount of usage over a one- or three-year perio- This commitment provides you with lower prices compared to pay-as-you-go rates. Savings can range from 11 percent to 65 percent, depending on the services and regions you use.

### Combine savings plan with Azure Hybrid Benefit

You can combine Azure Savings Plan with Azure Hybrid Benefit to optimize your cost savings.

#### Simple Exercise - 1

Let's consider an example to understand the savings:

- **Without Azure savings plans and Azure Hybrid Benefit**:

    - You run a D4s_v4 VM (4 vCPUs, 16 GB RAM) in the East US region.

    - Pay-as-you-go rate: \$0.20 per hour

    - Monthly cost: \$0.20 × 730 hours = \$146

- **With Azure Savings Plan**:

    - Assume a 3-year savings plan reduces the rate to \$0.15 per hour.

    - Monthly cost: \$0.15 × 730 hours = \$109.50

    - Savings: \$146 - \$109.50 = \$36.50/month

- **With Azure Hybrid Benefit**:

    - Assume Azure Hybrid Benefit reduces the software cost by 50 percent.

    - New rate: \$0.10 per hour

    - Monthly cost: \$0.10 × 730 hours = \$73

    - Savings: \$146 - \$73 = \$73 per month

- **Combining Both**:

    - Apply both Azure Savings Plan and Azure Hybrid Benefit.

    - New rate: \$0.075 per hour

    - Monthly cost: \$0.075 × 730 hours = \$54.75

    - Total savings: \$146 - \$54.75 = \$91.25 per month

### Azure Reservations and Azure Hybrid Benefit

#### Azure Reservations

Azure Reservations enable you to save on your Azure costs by committing to a one-year or three-year term for a VM. This commitment provides you with a discount of up to 80 percent compared to the standard pay-as-you-go rate.

#### Simple Exercise - 2

Let's consider an example to understand the savings:

- **Without Azure Reservations and Azure Hybrid Benefit**:

    - You run a D8s_v4 VM (8 vCPUs, 32 GB RAM) in the US West 2 region.

    - Pay-as-you-go rate: \$0.75 per hour

    - Monthly cost: \$0.75 × 730 hours = \$547.50

- **With Azure Reservations**:

    - Assume a 3-year reservation reduces the rate to \$0.50 per hour.

    - Monthly cost: \$0.50 × 730 hours = \$365

    - Savings: \$547.50 - \$365 = \$182.50 per month

- **With Azure Hybrid Benefit**:

    - Assume Azure Hybrid Benefit reduces the software cost by 50%.

    - New rate: \$0.375 per hour

    - Monthly cost: \$0.375 × 730 hours = \$273.75

    - Savings: \$547.50 - \$273.75 = \$273.75 per month

- **Combining Both**:

    - Apply both Azure Reservations and Azure Hybrid Benefit.

    - New rate: \$0.25 per hour

    - Monthly cost: \$0.25 × 730 hours = \$182.50

    - Total savings: \$547.50 - \$182.50 = \$365 per month
