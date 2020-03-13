In this module, you will deploy an Ubuntu Server VM with Azure IoT Edge runtime support from the Azure Marketplace.

## Deploy an Azure IoT Edge enabled Linux VM

If necessary, log in to your Azure portal using your Azure account credentials.

1. Make sure you've activated the sandbox, using the button above. The sandbox creates a free temporary resource.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. In the Azure Portal, click **Create a resource** open the Azure Marketplace.

1. On the **New** blade, in the **Search the Marketplace box**, type in and search for **Azure IoT Edge on Ubuntu**.

1. In the search results, select the **Azure IoT Edge on Ubuntu** item.

1. On the Azure IoT Edge on Ubuntu item, click **Create**.

1. On the **Create a virtual machine** blade, select your Azure Subscription and use the **Create new** Resource group option to create a new Resource Group for the VM named `AZ-220-GWVM-RG`.

1. In the **Virtual machine name** box, enter `az-220-vm-edgegw-{YOUR-ID}` for the name of the Virtual Machine.

1. In the **Region** dropdown, select the Azure Region closest to you, or the region where your Azure IoT Hub is provisioned.

1. Notice the **Image** dropdown has the **Ubuntu Server 16.04 LTS + Azure IoT Edge runtime** image selected.

1. Under **Size**, click **Change size**. In the displayed list of sizes, select **DS1_v2** and click **Select**.

    >[!NOTE]
    >Not all VM sizes are available in all regions. If, in a later step, you are unable to select the VM size, try a different region. For example, if West US doesn’t have the sizes available, try West US 2.

1. Under **Administrator account**, select the **Password** option for **Authentication type**.

1. Enter an Administrator **Username** and **Password** for the VM.

1. Notice the **Inbound port rules** is configured to enable inbound **SSH** access to the VM. This will be used to remote into the VM to configure/manage it.

1. Click **Review + create** to create the IoT Edge on Ubuntu virtual machine.

1. Once validation passes, click **Create** to begin deploying the virtual machine.

    >[!NOTE]
    >Note: Deployment will take approximately 5 minutes to complete. You can continue on to the next unit while it is deploying.

Congratulations, that's the end of the module! In the next module, we will generate and configure IoT Edge Device CA Certificates to allow devices to securely connect to our IoT Edge Gateway.