In the shipping company scenario, you installed a web application when you created the virtual machine scale set. You now need to update the web app and install a new version across all virtual machines in the scale set.

In this exercise, you'll use a custom script extension to roll out a new version of the web app. In this case, you'll simply amend the message output by the **nginx** server, but you can use the same approach to perform more substantial updates.

## Create a custom script to update the web application

1. In the Cloud Shell, start the Code editor and create a file named **appv2.json**.

    ```bash
    code appv2.json
    ```

2. Add the following text to the file.

    ```json
    {
        "commandToExecute": "echo This is the updated app installed on the Virtual Machine Scale Set ! > /var/www/html/index.html"
    }
    ```

    The `commandToExecute` field contains the script that will be run to update the web application.

3. Press Ctrl-S to save the file, and then press Ctrl-Q to close the Code editor.

## Deploy the update using a custom script extension

1. Run the following command to view the current upgrade policy for the scale set.

    ```azurecli
    az vmss show \
        --name webServerScaleSet \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --query upgradePolicy.mode
    ```

    Verify that the upgrade policy is currently set to `Automatic`. This is the policy you specified when you created the scale set in the first lab. If the policy was `Manual`, you would have to apply any changes to the virtual machines by hand. As the policy is `Automatic`, you can use the custom script extension and allow the scale set to perform the update.

1. Run the following command to apply the update script.

    ```azurecli
    az vmss extension set \
        --publisher Microsoft.Azure.Extensions \
        --version 2.0 \
        --name CustomScript \
        --vmss-name webServerScaleSet \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --settings @appV2.json
    ```

## Test the updated web application

1. Run the following command to retrieve the IP address of the load balancer for the scale set.

    ```azurecli
    az network public-ip show \
        --name webServerScaleSetLBPublicIP \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --output tsv \
        --query ipAddress
    ```

2. Using your web browser, navigate to the public address of the scale set load balancer in the web browser. Verify that the message **This is the updated app installed on the Virtual Machine Scale Set !** appears.

    ![Screenshot of the updated web app](../media/7-web-app.png)
