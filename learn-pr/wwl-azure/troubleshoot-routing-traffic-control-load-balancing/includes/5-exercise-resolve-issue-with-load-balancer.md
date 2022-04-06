After investigating the connection issues, you have found an issue with Session persistence.

In this exercise, you'll resolve the issue.

## Update load balancer rules

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for **Load balancers**, and then under **Services**, select **Load balancers**.

   :::image type="content" source="../media/5-load-balancer-search.png" alt-text="A screenshot showing searching for load balancers.":::


1. Select the **myScaleSetLB** load balancer.

1. Under **Settings**, select **Load balancing rules**.

   :::image type="content" source="../media/5-load-balancer-rules.png" alt-text="A screenshot showing the load balancer rule highlighted.":::


1. From the list of rules, select **myLoadBalancerRuleWeb**.

   :::image type="content" source="../media/5-load-balancer-rule-web.png" alt-text="A screenshot of the load balancer rule, showing the session persistence set to Client IP. This is the error.":::

1. To resolve the backend issue, change the **Session persistence** from **Client IP** to **None**, and then select **Save**.

    > [!NOTE]
    > By setting **Session persistence** to **None**, successive request from clients can be handled by different virtual machines.

1. Wait until the rule has been deployed successfully.

   :::image type="content" source="../media/5-rule-deployed.png" alt-text="A screenshot showing the successful deployment of the updated load balancer rule.":::