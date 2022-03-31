After investigating the connection issues, you have found an issue with Session persistence.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

In this exercise, you’ll resolve the issue.

## Update load balancer rules

1. In the Azure portal, search for **Load balancers**, and then under **Services**, click **Load balancers**.

   :::image type="content" source="../media/5-load-balancer-search.png" alt-text="A screenshot showing searching for load balancers.":::


1. Click the **myScaleSetLB** load balancer.

1. Under **Settings**, click **Load balancing rules**.

   :::image type="content" source="../media/5-load-balancer-rules.png" alt-text="A screenshot showing the load balancer rule highlighted.":::


1. From the list of rules, click **myLoadBalancerRuleWeb**.

   :::image type="content" source="../media/5-load-balancer-rule-web.png" alt-text="A screenshot of the load balancer rule, showing the session persistence set to Client IP. This is the error.":::

1. To resolve the backend issue, change the **Session persistence** from **Client IP** to **None**, and then click **Save**.

    > [!NOTE]
    > By setting **Session persistence** to **None**, successive request from clients can be handled by different virtual machines.

1. Wait until the rule has been deployed successfully.

:::image type="content" source="../media/5-rule-deployed.png" alt-text="A screenshot showing the successful deployment of the updated load balancer rule.":::