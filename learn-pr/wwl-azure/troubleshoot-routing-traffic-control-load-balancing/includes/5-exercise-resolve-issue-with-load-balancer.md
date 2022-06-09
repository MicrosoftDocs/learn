After investigating the performance issues, you've found an issue with the load balancers session persistence settings.

In this exercise, you'll resolve the issue.

## Update load balancer rules

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in a new tab, select **Load balancers**.

    :::image type="content" source="../media/5-load-balancer-search.png" alt-text="A screenshot showing searching for load balancers.":::


1. Select the **webLoadBalancer** load balancer.

    :::image type="content" source="../media/4-list-of-load-balancers.png" alt-text="Screenshot showing webLoadBalancer selected." lightbox="../media/4-list-of-load-balancers.png":::

1. Under **Settings**, select **Load balancing rules**, then select **webLoadBalancerRule**.

    :::image type="content" source="../media/4-load-balancer-rules.png" alt-text="A screenshot showing the load balancer rule highlighted.":::

1. To resolve the backend issue, change the **Session persistence** from **Client IP and protocol** to **None**, and then select **Save**.

    :::image type="content" source="../media/5-load-balancer-fix.png" alt-text="Screenshot showing the rule fixed." lightbox="../media/5-load-balancer-fix.png":::

    > [!NOTE]
    > By setting **Session persistence** to **None**, successive request from clients can be handled by different virtual machines.

1. Wait until the rule has been deployed successfully.

## Test that the issue has been resolved

Switch back to the tab where you pasted the public IP address. If you have closed the tab select the load balancer rule and the public IP address is listed there.

1. Refresh the browser 20 or 30 times, you should see the message switch between **webVirtualMachine1** and **webVirtualMachine2**.
1. The traffic is now being shared correctly between all the machines in the backend pool.

    :::image type="content" source="../media/issue-resolved.gif" alt-text="Animated gif showing the different webservers responding.":::
