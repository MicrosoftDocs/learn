Azure IoT Central applications can be customized for each case.

In the IoT enabled coffee machines example, there will be one application to monitor and manage your devices spread around the world.

You'll begin by creating an Azure IoT Central application that defines the data and commands to be exchanged with the IoT device.

## Create the Coffee Maker application

In this unit, you sign in to Azure IoT Central and create a new custom application. An application created using a standard pricing plan.

1. Start by **activating the Azure sandbox above**.

1. Once it's activated, sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account with which you activated the sandbox.

1. Type `IOT` into the search box and select <kbd>Enter</kbd>.

1. Select **IoT Central Applications**, then select **+ Create**.

1. On the **Basics** tab, enter the following information:

    - Enter the following values for each setting in the **Project details** section:

        | Setting  | Value  |
        |---|---|
        | Subscription | Concierge Subscription (the sandbox subscription should be selected by default). |
        | Resource group | <rgn>[sandbox resource group name]</rgn>. |

    - Enter the following values for each setting in the **Instance details** section:

        | Setting  | Value  |
        |---|---|
        | Resource name | Enter a friendly application name that is unique for your application, such as `coffee-maker-1234`. |
        | Application URL | Optionally edit the URL, which is required if the name you selected is already in use. |
        | Template | Select **Custom application** as the application template.
        | Region | Select a location that is close to you; see the information below this table for available regions. |
        | Pricing plan | Select **Standard 0** (To learn about pricing, see [Azure IoT Central pricing](https://azure.microsoft.com/pricing/details/iot-central/)). |

        <!-- Resource selection -->  
        [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Choose **Review + Create**.

1. If validation passes, click **Create** to create your application.

1. When your application has been created, click **Go to resource**.

1. Click the link for your **IoT Central Application URL**, such as https://coffee-maker-1234.azureiotcentral.com.

### Check your work

Your IoT Central custom application is now live and ready to connect to IoT Devices.