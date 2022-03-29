You’ll troubleshoot a site-to-site connection problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> **NOTE**:
> The resource group **sandbox-rg** has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.


## Create the exercise environment

 Use the cloud shell on the right run these commands to create the example topology.

1. Clone the setup script from GitHub.

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-troubleshoot-network-security-issues/blob/main/arm-lab.json networking
    ```

1. Run the setup script.

    ```
    bash networking/setup.sh
    ```

1. You can continue to the next unit as this command runs in the background, you should see a **Webserver Pool Created** message.

    ![Screenshot of the Azure cloud shell showing the Webserver Pool Created message.](../media/6-webserver-pool.png)