Before deploying the Language Detection module to your edge device, you need to configure the Azure AI services API key and endpoint into the container. 

<a name='create-an-azure-ai-services-text-analytics-resource'></a>

## Create an Azure AI Language service resource

Create an Azure AI Language service resource that matches the container.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. Select **Create a resource**, and then go to **AI + Machine Learning** > **Language service**.
1. Enter all the required settings:

   | Setting        | Value                                   |
   | :------------- | :-------------------------------------- |
   | Name           | Enter a name (2-64 characters).         |
   | Subscription   | Select the appropriate subscription.    |
   | Location       | Select a nearby location.               |
   | Pricing tier   | Enter **S**, the standard pricing tier. |
   | Resource group | Select an available resource group.     |

1. Select **Create**, and wait for the resource to be created. Your browser automatically redirects to the newly created resource page.
1. Go to the resource.
1. In the **Keys and Endpoint** page under **Resource Management**, copy **KEY 1** and **Endpoint**.

   ![The illustration shows access keys of the cognitive service.](../media/keys-endpoint.png)

## Deploy the Language Detection module to the edge

To deploy the Language Detection container image as Azure IoT Edge modules from Azure Marketplace, follow these steps:

1. Find the **Azure AI services Text Analytics Language** module in the [Microsoft Artifact Registry](https://mcr.microsoft.com/catalog?cat=IoT%20Edge%20Modules&alphaSort=asc&alphaSortKey=Name) filtered by *IoT Edge Modules*.

1. Select the latest image version of the **Azure AI services Text Analytics Language** module.

1. Copy the URI for the **Azure AI services Text Analytics Language** module. You only need the URI for the module. Don't include the *docker pull* command. For example, `mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest`.

1. 1. In the Azure portal, find your IoT Edge device created in an earlier step.

1. Select **Set modules** from the IoT Edge device details page.

1. In the **IoT Edge modules** section, select **Add** then choose **IoT Edge Module**.

1. Update the following module settings:

    | Setting            | Value                                                                      |
    |--------------------|----------------------------------------------------------------------------|
    | IoT Module name    | `EdgeModuleLanguageDetectionTextAnalytics`                                 |
    | Image URI          | `mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest` |
    | Restart policy     | always                                                                     |
    | Desired status     | running                                                                    |

1. Navigate to **Environment Variables** and provide the following information.

    1. Keep the value **accept** for **Eula**.

    1. Fill out **Billing** with your Azure AI services endpoint.

    1. Fill out **ApiKey** with your Azure AI services API key.

   ![The illustration shows environment variables.](../media/provide-info.png)

1. Navigate to **Container Create Options**, and verify the options to be:

    ```json
    {
        "ExposedPorts": {
            "5000/tcp": {}
        },
        "HostConfig": {
            "PortBindings": {
                "5000/tcp": [
                    {
                        "HostPort": "5000"
                    }
                ]
            }
        }
    }
    ```

    This configuration adds port 5000 to the exposed ports so that the container can be connected to.

1. Select **Apply**.

1. Select **Review + create**. You can preview the JSON file that defines all the modules that get deployed to your IoT Edge device.

1. Select **Create** to start the module deployment.

1. After you complete the module deployment, you'll go back to the **IoT Edge** page of your IoT hub. Select your device from the list of IoT Edge devices to see its details.

1. Scroll down and see the modules listed. Check that the runtime status is running for modules.
