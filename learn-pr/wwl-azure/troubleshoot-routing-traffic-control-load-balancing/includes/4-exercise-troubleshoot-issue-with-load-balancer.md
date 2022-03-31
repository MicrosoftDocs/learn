You work as a support engineer supporting Azure infrastructure. You’ve been contacted by your web team about an issue with the website not responding. The web team has a pool of webservers behind a load balancer and public IP address.

:::image type="content" source="../media/4-network-topology-diagram.png" alt-text="Screenshot of a network topology diagram showing a pool of webservers behind a load balancer and public IP address.":::

In this exercise, you’ll use what you’ve learned to go through steps to troubleshoot the connection issues to the virtual machines.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the exercise environment

 Use the Cloud Shell on the right run these commands to create the example topology.  It will take approximately 3 minutes to build the environment.

1. Clone the setup script from GitHub.

     ```
     git clone https://github.com/MicrosoftDocs/mslearn-troubleshoot-connectivity-issues-virtual-machines/blob/main networking
     ```

1. Run the setup script.

     ```azurecli
     bash networking/setup.sh
     ```

1. The script will create all the resources. Wait until it completes, you should see a **Webserver Pool Created** message.

     :::image type="content" source="../media/4-webserver-pool.png" alt-text="Screenshot of the Azure cloud shell showing the Webserver Pool created message.":::

## Check the Load Balancer settings

1. Navigate to the Azure portal in another browser tab.

1. Search for **Load balancers**.

    :::image type="content" source="../media/4-load-balancers.png" alt-text="A screenshot of the Azure portal showing Load balancers being selected.":::

1. Under **Services**, click **Load balancers**.

    :::image type="content" source="../media/4-list-of-load-balancers.png" alt-text="A screenshot showing the load balancers.":::

1. Click **myScaleSetLB**.

## Check the load balancer settings

- Select each **Settings** category and look for settings that could cause the routing issue.

    :::image type="content" source="../media/4-load-balancer-settings.png" alt-text="A screenshot showing the load balancer settings categories.":::