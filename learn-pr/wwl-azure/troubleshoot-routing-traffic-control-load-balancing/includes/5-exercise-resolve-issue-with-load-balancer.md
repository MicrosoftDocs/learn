After investigating the connection issues, you have found an issue with Session persistence.

In this exercise, you’ll resolve the issue.

## Update load balancer rules

1. In the Azure portal, search for **Load balancers**, and then under **Services**, click **Load balancers**.

    ![A screenshot showing searching for load balancers.](../media/7-load-balancer-search.png)

1. Click the **myScaleSetLB** load balancer.

1. Under **Settings**, click **Load balancing rules**.

    ![A screenshot showing the load balancer rule highlighted.](../media/7-load-balancer-rules.png)

1. From the list of rules, click **myLoadBalancerRuleWeb**.

    ![A screenshot of the load balancer rule, showing the session persistence set to Client IP. This is the error.](../media/7-load-balancer-rule-web.png)

1. To resolve the backend issue, change the **Session persistence** from **Client IP** to **None**, and then click **Save**.

    > NOTE:
    > By setting **Session persistence** to **None**, successive request from clients can be handled by different virtual machines.

1. Wait until the rule has been deployed successfully.

    ![A screenshot showing the successful deployment of the updated load balancer rule. ](../media/7-rule-deployed.png)
