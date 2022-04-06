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

1. Hit refresh in your browser, or on Windows press the <kbd>F5</kbd> multiple times. Notice that you are getting a response from the same webserver every time.

1. Leave this tab open to check you resolve the issue in the next exercise.

## Check all the virtual machines are responding on port 80

1. Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in another browser tab.

1. Select **Virtual machines**.

    :::image type="content" source="../media/4-portal-selectr-virtual-machines.png" alt-text="":::

##

## Check the Load Balancer settings

1. Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in another browser tab.

1. Search for **Load balancers**.

    :::image type="content" source="../media/4-load-balancers.png" alt-text="A screenshot of the Azure portal showing Load balancers being selected." lightbox="../media/4-load-balancers.png":::

1. Under **Services**, select **Load balancers**.

    :::image type="content" source="../media/4-list-of-load-balancers.png" alt-text="A screenshot showing the load balancers." lightbox="../media/4-list-of-load-balancers.png":::

1. Select **webLoadBalancer**.

1. Select each **Settings** category and look for settings that could cause the routing issue.

    :::image type="content" source="../media/4-load-balancer-settings.png" alt-text="A screenshot showing the load balancer settings categories." lightbox="../media/4-load-balancer-settings.png":::

