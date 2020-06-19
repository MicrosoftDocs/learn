Before deploying Language Detection module to your edge device, you need to configure Cognitive Service API key and endpoint into the container. 

## Create a Cognitive Services Text Analytics resource

First, you'll create a Cognitive Service Text Analytics that matches the container.

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

6. In Keys and Endpoint page under Resource Management, copy the API Key 1 and endpoint.

## Deploy Language Detection module to the edge

To deploy the Language Detection container image as IoT Edge modules from the Azure Marketplace, follow the steps:

1. In the Azure portal, enter **Language Detection Container – Azure Cognitive Services** into the search and open the Marketplace result.

2. Select "Get it now" to download the image. 

3. It will take you to the Azure portal "Target Devices for IoT Edge Module" page. Provide the following information required.

   ​	a. Select your subscription.

   ​	b. Select IoT Hub created earlier step.

   ​	c. Select "Find device" and find your IoT Edge device created earlier step.

4. Click Create button to submit. It will take you "Set modules" page. Keep the page open, you'll configure Cognitive Service in the next step.

5. Click on "LanguageDetectionContainerAzureCognitiveServices" IoT Edge module.

6. Navigate the **Environment Variables** and provide the following information.

   ​	a. Keep the value- accept for "Eula".

   ​	b. Fill out Billing with your Cognitive Service endpoint.

   ​	c. Fill out Apikey with your Cognitive Service API key.

7. Click **Update**.
8. Select **Next: Routes** to  define your route. You define all messages from all modules to go to IoT Hub 
9. Select **Next: Review + create**. You can preview the JSON file that defines all the modules that get deployed to your IoT Edge device.
10. After you complete module deployment, you'll go back to the **IoT Edge** page of your IoT hub. Select your device from the list of IoT Edge devices to see its details.
11. Scroll down and see the modules listed. Check runtime status is running for modules.
