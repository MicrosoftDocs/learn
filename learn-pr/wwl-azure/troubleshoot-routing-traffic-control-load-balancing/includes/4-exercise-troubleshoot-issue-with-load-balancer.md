You work as a support engineer supporting Azure infrastructure. You've been contacted by your web team about an issue with website performance. The web team has a pool of webservers behind a load balancer and public IP address.

:::image type="content" source="../media/4-network-topology-diagram.png" alt-text="Screenshot of a network topology diagram showing a pool of webservers behind a load balancer and public IP address." lightbox="../media/4-network-topology-diagram.png" border="false":::

The web team thinks that the internet traffic isn't being distributed equally between all the webservers.

In this exercise, you'll use what you've learned to go through steps to troubleshoot the performance issues with your organizations website.

## Check that the issue still exists

1. Using the Cloud Shell to the right, run this command.

    ```azurecli
    az network public-ip show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name webPublicIP \
    --query '[ipAddress]' \
    --output tsv
    ```

1. Paste the IP address returned into a new browser tab.

    :::image type="content" source="../media/4-web-working.png" alt-text="Screenshot of the web responding.":::

    > [!NOTE]
    > Your IP address will be different to the one shown in the screenshot.

1. Hit refresh in your browser, or on Windows press the <kbd>F5</kbd> ten or twenty times. Notice that you are getting a response from the same webserver every single time.

1. Leave this tab open to check you resolve the issue in the next exercise.

## Check all the virtual machines are responding on port 80

1. Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in another browser tab.

1. Select **Virtual machines**.

    :::image type="content" source="../media/4-portal-select-virtual-machines.png" alt-text="Screenshot of the virtual machines." lightbox="../media/4-portal-select-virtual-machines.png":::

1. Select **webVirtualMachine1**.

1. Under **Settings**, select **Networking**.

    :::image type="content" source="../media/4-virtual-machine-network-settings.png" alt-text="Screenshot of the networking settings for the virtual machine." lightbox="../media/4-virtual-machine-network-settings.png":::
  
1. Check that inbound traffic is allowed on port **80**.

1. Repeat the above for **webVirtualMachine2**.

The current settings appear to be correct.

## Check the Load Balancer settings

1. Select **Home**.

1. Search for **Load balancers**.

    :::image type="content" source="../media/4-load-balancers.png" alt-text="A screenshot of the Azure portal showing Load balancers being selected." lightbox="../media/4-load-balancers.png":::

1. Under **Services**, select **Load balancers**.

    :::image type="content" source="../media/4-list-of-load-balancers.png" alt-text="A screenshot showing the load balancers." lightbox="../media/4-list-of-load-balancers.png":::

1. Select **webLoadBalancer**.

1. Under **Settings**, Select the **Frontend IP configuration**.

    :::image type="content" source="../media/4-load-balancer-frontend.png" alt-text="Screenshot of the frontend IP settings of the load balancer." lightbox="../media/4-load-balancer-frontend.png":::

    > [!NOTE]
    > There is a correctly configured frontend IP address. Check that it matches the IP address you have in your other tab.

1. Under **Settings**, select **Backend pools**.

    :::image type="content" source="../media/4-load-balancer-backend-pools.png" alt-text="Screenshot of the load balancer backend pool." lightbox="../media/4-load-balancer-backend-pools.png":::

    > [!NOTE]
    > The virtual machines are both running.

1. Under **Settings**, select **Load balancing rules**, then select **webLoadBalancerRule**.

    :::image type="content" source="../media/4-load-balancer-rules.png" alt-text="Screenshot showing the webLoadBalancerRule to select.":::

1. Check all the settings for the load balancer rule.

    :::image type="content" source="../media/4-webLoadBalancerRule-settings.png" alt-text="Screenshot of the webLoadBalancerRule settings." lightbox="../media/4-webLoadBalancerRule-settings.png":::

You think you have identified the issue. At the moment once a user visits the website they are routed to one virtual machine. This will persist because of the **Session persistence** setting.

You'll resolve the issue in the next exercise.
