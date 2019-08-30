In the shipping company scenario, you installed a web application by creating the virtual machine scale set. You now need to update the web app and install a new version across all virtual machines in the scale set. You must ensure that the system remains available while the roll-out occurs. A good way to do this is to use a custom script extension to perform the update, and apply this script across the virtual machine scale set. The scale set will apply the update to one virtual machine at a time, leaving the others up and running.

In this exercise, you'll use a custom script extension to roll out a new version of the web app. You'll amend the message output by the **Nginx** server – but you can use the same approach to do more substantial updates.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the instructions to understand how to use the REST API to retrieve metrics.
> If you want to complete this exercise, but you don't have an Azure subscription or prefer not to use your own account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Deploy the web application's update using a custom script extension

1. Return to the [Azure portal](https://portal.azure.com).

1. Run the following command to view the current upgrade policy for the scale set:

    ```bash
        az vmss show \
            --name webServerScaleSet \
            --resource-group scalesetrg \
            --query upgradePolicy.mode
    ```

    Verify that the upgrade policy is currently set to `Automatic`. You specified this policy when you created the scale set in the first lab. If the policy was `Manual`, you would apply any changes to the virtual machines by hand. As the policy is `Automatic`, you'll use the custom script extension and allow the scale set to do the update.

1. Run the following command to apply the update script:

    ```bash
        az vmss extension set \
            --publisher Microsoft.Azure.Extensions \
            --version 2.0 \
            --name CustomScript \
            --vmss-name webServerScaleSet \
            --resource-group scalesetrg \
            --settings "{\"commandToExecute\": \"echo This is the updated app installed on the Virtual Machine Scale Set ! > /var/www/html/index.html\"}"
    ```

## Test the updated web application

1. Run the following command to retrieve the IP address of the load balancer for the scale set:

    ```bash
        az network public-ip show \
            --name webServerScaleSetLBPublicIP \
            --resource-group scalesetrg \
            --output tsv \
            --query ipAddress
    ```

1. Using your web browser, go to the public address of the scale set load balancer in the web browser. Verify that the message **This is the updated app installed on the Virtual Machine Scale Set** appears.

    ![Screenshot of the updated web app](../media/7-web-app.png)
