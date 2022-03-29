You work as a support engineer supporting Azure infrastructure. You’ve been contacted by your web team about an issue with the website not responding. The web team have a pool of webservers behind a load balancer and public IP address.

![A network topology diagram showing a pool of webservers behind a load balancer and public IP address.](../media/6-network-topology-diagram.png)

In this exercise, you’ll use what you’ve learned to go through steps to troubleshoot the connection issues to the virtual machines.

## Create the exercise environment

 Use the cloud shell on the right run these commands to create the example topology.  It will take approximately 3 minutes to build the environment.

1. Clone the setup script from GitHub.

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-troubleshoot-connectivity-issues-virtual-machines/blob/main/setup.sh
    ```

1. Run the setup script.

    ```azurecli
    bash networking/setup.sh
    ```

1. The script will create all the resources. Wait until it completes, you should see a **Webserver Pool Created** message.

    ![Screenshot of the Azure cloud shell showing the Webserver Pool created message.](../media/6-webserver-pool.png)

## Check the Load Balancer settings

1. Navigate to the Azure portal in another browser tab.

1. Search for **Load balancers**.

    ![A screenshot of the Azure portal showing Load balancers being selected.](../media/6-load-balancers.png)

1. Under **Services**, click **Load balancers**.

    ![A screenshot showing the load balancers.](../media/6-list-of-load-balancers.png)

1. Click **myScaleSetLB**.

## Check the load balancer settings

- Select each **Settings** category and look for settings that could cause the routing issue.

    ![A screenshot showing the load balancer settings categories.](../media/6-load-balancer-settings.png)
