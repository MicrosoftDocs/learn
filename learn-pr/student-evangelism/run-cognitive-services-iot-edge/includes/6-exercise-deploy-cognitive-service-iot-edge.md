Before deploying the Language Detection module to your edge device, you need to configure the Azure Cognitive Services API key and endpoint into the container. 

## Create a Cognitive Services Text Analytics resource

First, you'll create a Cognitive Services Text Analytics resource that matches the container.

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Select **Create a resource**, and then go to **AI + Machine Learning** > **Text Analytics**. 

3. Enter all the required settings:

   | Setting        | Value                                   |
   | :------------- | :-------------------------------------- |
   | Name           | Enter a name (2-64 characters).         |
   | Subscription   | Select the appropriate subscription.    |
   | Location       | Select a nearby location.               |
   | Pricing tier   | Enter **S**, the standard pricing tier. |
   | Resource group | Select an available resource group.     |

4. Select **Create**, and wait for the resource to be created. Your browser automatically redirects to the newly created resource page.

5. Go to the resource.

6. In the **Keys and Endpoint** page under **Resource Management**, copy the API Key 1 and endpoint.

   ![The illustration shows access keys of the cognitive service.](../media/keys-endpoint.png)

## Deploy the Language Detection module to the edge

To deploy the Language Detection container image as Azure IoT Edge modules from Azure Marketplace, follow these steps:

1. In the Azure portal, enter **Language Detection Container – Azure Cognitive Services** into the search and open the Azure Marketplace result.

2. Select **Get it now** to download the image. 

3. It will take you to the Azure portal's **Target Devices for IoT Edge Module** page. Provide the following required information.

   ​	a. Select your subscription.

   ​	b. Select the IoT hub created in an earlier step.

   ​	c. Select **Find device** and find your IoT Edge device created in an earlier step.

4. Click the **Create** button. It will take you to the **Set modules** page. Keep the page open, because you'll configure Cognitive Services in the next step.

5. Click on the **LanguageDetectionContainerAzureCognitiveServices** IoT Edge module.

   ![The illustration shows the container image in your device.](../media/edge-module.png)

6. Navigate to **Environment Variables** and provide the following information.

   ​	a. Keep the value **accept** for **Eula**.

   ​	b. Fill out **Billing** with your Cognitive Services endpoint.

   ​	c. Fill out **ApiKey** with your Cognitive Services API key.

   ![The illustration shows environment variables.](../media/provide-info.png)

7. Click **Update**.

8. Select **Next: Routes** to  define your route. You define all messages from all modules to go to Azure IoT Hub. 

9. Select **Next: Review + create**. You can preview the JSON file that defines all the modules that get deployed to your IoT Edge device.

10. After you complete module deployment, you'll go back to the **IoT Edge** page of your IoT hub. Select your device from the list of IoT Edge devices to see its details.

11. Scroll down and see the modules listed. Check that the runtime status is running for modules.
