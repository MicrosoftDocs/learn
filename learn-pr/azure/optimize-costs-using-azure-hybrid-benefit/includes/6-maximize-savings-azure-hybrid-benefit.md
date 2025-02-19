The Azure platform provides many solutions, services, and tools that you can use to achieve increased savings in cloud usage. In addition to Azure Hybrid Benefit, you can leverage Azure Savings Plan and Azure Reservations when planning your cloud usage and spending to help you manage your costs. You also can use services such as Cost Management, Azure Monitor, Azure Policy, and Azure Advisor to get detailed insight into what is happening cost-wise in your cloud services.

:::image type="content" source="../media/ahb-with-reservations.png" alt-text="Illustration comparing the savings between using Azure Hybrid Benefit versus using Azure Hybrid Benefit and Azure Reservations." border="false":::

Azure Savings Plan enables you to save on Azure compute costs by committing to a consistent amount of usage over a one or three-year period. This commitment provides you with lower prices compared to pay-as-you-go rates. Savings can range from 11 percent to 65 percent, depending on the services and regions you use.

### Combine savings plan with Azure Hybrid Benefit

You can combine Azure Savings Plan with Azure Hybrid Benefit to optimize your cost savings.

#### Simple Exercise - 1

Let's consider an example to understand the savings:

- **Without Azure savings plans and Azure Hybrid Benefit**:

    - You run a D4s_v4 VM (4 vCPUs, 16 GB RAM) in the East US region.

    - Pay-as-you-go rate: 0.20 dollar per hour

    - Monthly cost: 0.20 dollar × 730 hours = 146 dollars

- **With Azure Savings Plan**:

    - Assume a 3-year savings plan reduces the rate to 0.15 dollar per hour.

    - Monthly cost: 0.15 dollar × 730 hours = 109.50 dollars

    - Savings: 146 dollars - 109.50 dollars = 36.50 dollars per month

- **With Azure Hybrid Benefit**:

    - Assume Azure Hybrid Benefit reduces the software cost by 50 percent.

    - New rate: 0.10 dollar per hour

    - Monthly cost: 0.10 dollar × 730 hours = 73 dollars

    - Savings: 146 dollars - 73 dollars = 73 dollars per month

- **Combining Both**:

    - Apply both Azure Savings Plan and Azure Hybrid Benefit.

    - New rate: 0.075 dollar per hour

    - Monthly cost: 0.075 dollar × 730 hours = 54.75 dollars

    - Total savings: 146 dollars - 54.75 dollars = 91.25 dollars per month

### Azure Reservations and Azure Hybrid Benefit

#### Azure Reservations

Azure Reservations enable you to save on your Azure costs by committing to a one-year or three-year term for a VM. This commitment provides you with a discount of up to 80 percent compared to the standard pay-as-you-go rate.

#### Simple Exercise - 2

Let's consider an example to understand the savings:

- **Without Azure Reservations and Azure Hybrid Benefit**:

    - You run a D8s_v4 VM (8 vCPUs, 32 GB RAM) in the US West 2 region.

    - Pay-as-you-go rate: 0.75 dollar per hour

    - Monthly cost: 0.75 dollar × 730 hours = 547.50 dollars

- **With Azure Reservations**:

    - Assume a 3-year reservation reduces the rate to 0.50 dollar per hour.

    - Monthly cost: 0.50 dollar × 730 hours = 365 dollars

    - Savings: 547.50 dollars - 365 dollars = 182.50 dollars per month

- **With Azure Hybrid Benefit**:

    - Assume Azure Hybrid Benefit reduces the software cost by 50%.

    - New rate: 0.375 dollar per hour

    - Monthly cost: 0.375 dollar × 730 hours = 273.75 dollars

    - Savings: 547.50 dollars - 273.75 = 273.75 dollars per month

- **Combining Both**:

    - Apply both Azure Reservations and Azure Hybrid Benefit.

    - New rate: 0.25 dollar per hour

    - Monthly cost: 0.25 dollar × 730 hours = 182.50 dollars

    - Total savings: 547.50 dollars - 182.50 dollars = 365 dollars per month
