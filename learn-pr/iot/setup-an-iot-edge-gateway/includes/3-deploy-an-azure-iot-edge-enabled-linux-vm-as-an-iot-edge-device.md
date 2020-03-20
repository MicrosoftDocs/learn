In this module, you will deploy an Ubuntu Server VM with Azure IoT Edge runtime support from the Azure Marketplace.

## Deploy an Azure IoT Edge enabled Linux VM

If necessary, log in to your Azure portal using your Azure account credentials.

1. Make sure that you have activated the sandbox, using the button above. The sandbox will allow us to create the necessary resources without incurring any charges.

1. We will deploy an Azure IoT Edge enabled Linux VM using the iotedge-vm-deploy ARM Template.  To begin, click the button below:

    [![Deploy to Azure Button for iotedge-vm-deploy](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazure%2Fiotedge-vm-deploy%2Fms-learn%2FedgeDeploy.json)

1. Ensure that you are logged in with the account used to create the sandbox and make absolutely sure that you are using the "Microsoft Learn Sandbox" subscription.

1. We will now fill in the available form fields:

    [![Screenshot showing the iotedge-vm-deploy template](../media/iotedge-vm-deploy.png)](../media/iotedge-vm-deploy.png#lightbox)

    **Subscription**: Ensure "Concierge Subscription" is selected.

    **DNS Label Prefix**: Enter a name in the following format `az-220-vm-edgegw-{YOUR-ID}`.

    **Resource group**: Choose the pre-created entry that looks similar to  `learn-00000000-0000-0000-0000-000000000000`.

    **Admin Username**: Enter a username of you choice.

    **Device Connection String**: Enter the Device Connection string for the device that was created within your IoT Hub in the previous module.

    **VM Size**, **Ubuntu OS Version**, and **Location**, should be left at their default values.

    **Authentication Type**: Select "password" from the dropdown.

    **Admin Password or Key**: Enter a password of your choice.

    When all fields have been filled in, select the checkbox at the bottom of the page to accept the terms and select "Purchase" to begin the deployment.

1. Verify that the deployment has completed successfully.  A virtual machine resource should have been deployed into the selected resource group.  Take note of the machine name, this should be in the format `vm-0000000000000`. Also, take note of the associated **DNS Name**, which should be in the format `<dnsLabelPrefix>`.`<location>`.cloudapp.azure.com.

    The **DNS Name** can be obtained from the **Overview** section of the newly deployed virtual machine within the Azure Portal.

    > [!div class="mx-imgBorder"]
    > [![Screenshot showing the dns name of the iotedge vm](../media/iotedge-vm-dns-name.png)](../media/iotedge-vm-dns-name.png)

Congratulations, that's the end of the module! In the next module, we will generate and configure IoT Edge Device CA Certificates to allow devices to securely connect to our IoT Edge Gateway.