After investigating the connection issues to your website, you've found an issue with the load balancer rule user by the virtual machine scale set.

In this exercise, you'll resolve the issue and check that the website can now be accessed.

## Validate load balancer rules

1. In the Azure portal, search for **load balancers**, and then under **Services**, click **Load balancers**.

   :::image type="content" source="../media/7-load-balancers.png" alt-text="A screenshot showing searching for load balancers." lightbox="../media/7-load-balancers.png":::

1. Click the **myScaleSetLB** load balancer.

1. Under **Settings**, click **Load balancing rules**.

   :::image type="content" source="../media/7-load-balancer-rules.png" alt-text="A screenshot showing the load balancer rule highlighted." lightbox="../media/7-load-balancer-rules.png":::

1. From the list of rules, click **myLoadBalancerRuleWeb**.

   :::image type="content" source="../media/7-my-load-balancer-rule-web.png" alt-text="A screenshot of the load balancer rule, showing the port set to 80 and backend port set to 443. This is the error.":::

1. To resolve the backend issue, change the **Backend port** from **443** to **80**, and then click **Save**.

    > [!NOTE]
    > The front and backend in this environment need to be the same to get a response from the webserver to http requests.

1. Wait until the rule has been deployed successfully.

:::image type="content" source="../media/7-successful-rule.png" alt-text="A screenshot showing the successful deployment of the updated load balancer rule." lightbox="../media/7-successful-rule.png":::

## Verify that the website can now be reached

1. Refresh the tab you opened to test the public IP address.

    > [!NOTE]
    > If you have closed the previous browser tab, run this command to get the public IP address:
    > ```
    > az network public-ip show \
    > --resource-group cloud-shell-storage-westeurope \
    > --name myScaleSetLBPublicIP \
    > --query '[ipAddress]' \
    > --output tsv
    > ```

    If the website is online, you'll see a page with a **Hello World** message from the backend instance.

:::image type="content" source="../media/7-hello-world.png" alt-text="A screenshot of the website showing it's online.":::
