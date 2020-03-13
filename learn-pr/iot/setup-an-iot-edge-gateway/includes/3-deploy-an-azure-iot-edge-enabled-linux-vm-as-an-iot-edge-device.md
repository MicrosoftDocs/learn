In this module, you will deploy an Ubuntu Server VM with Azure IoT Edge runtime support from the Azure Marketplace.

## Deploy an Azure IoT Edge enabled Linux VM

If necessary, log in to your Azure portal using your Azure account credentials.

1. Make sure that you have activated the sandbox, using the button above. The sandbox will allow us to create the necessary resources without incurring any charges.

1. We will deploy an Azure IoT Edge enabled Linux VM using the iotedge-vm-deploy ARM Template.  To begin, click the button below:

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazure%2Fiotedge-vm-deploy%2Fms-learn%2FedgeDeploy.json" target="_blank">
        <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" />
    </a>

1. Ensure that you are logged in with the account used to create the sandbox and make absolutely sure that you are using the "Microsoft Learn Sandbox" subscription.

1. We will now fill in the available form fields:

    **Subscription**: Ensure "Concierge Subscription" is selected.

    **DNS Label Prefix**: Enter a name in the following format `az-220-vm-edgegw-{YOUR-ID}`.

    **Resource group**: Choose the pre-created entry that looks similar to  `learn-00000000-0000-0000-0000-000000000000`.

    **Admin Username**: Enter a username of you choice.

    **Device Connection String**: Enter the Device Connection string for the device that was created within your IoT Hub in the previous module.

    **VM Size**, **Ubuntu OS Version**, and **Location**, should be left at their default values.

    **Authentication Type**: Select "password" from the dropdown.

    **Admin Password or Key**: Enter a password of your choice.

    When all fields have been filled in, select the checkbox at the bottom of the page to accept the terms and select "Purchase" to begin the deployment.

1. Verify that the deployment has completed successfully.  A Virtual machine resource should have been deployed into the selected resource group.  Take note of the machine name which should be in the following format `vm-0000000000000`.

Congratulations, that's the end of the module! In the next module, we will generate and configure IoT Edge Device CA Certificates to allow devices to securely connect to our IoT Edge Gateway.