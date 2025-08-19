Before you deploy the Language Detection module to your edge device, set up the Azure AI services API key and endpoint in the container.

<a name='create-an-azure-ai-services-text-analytics-resource'></a>

## Create an Azure AI Language service resource

Create an Azure AI Language service resource that matches your container.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. Select **Create a resource**, and then go to **AI + Machine Learning** > **Language service**.
1. Enter the required settings:

   | Setting        | Value                                   |
   | :------------- | :-------------------------------------- |
   | Name           | Enter a name (2-64 characters).         |
   | Subscription   | Select the appropriate subscription.    |
   | Location       | Select a nearby location.               |
   | Pricing tier   | Enter **S**, the standard pricing tier. |
   | Resource group | Select an available resource group.     |ource group.     |

1. Select **Create**, then wait for the resource to be created. Your browser automatically redirects to the new resource page.
1. Go to the resource.
1. On the **Keys and Endpoint** page under **Resource Management**, copy **KEY 1** and **Endpoint**.

   ![The illustration shows access keys of the cognitive service.](../media/keys-endpoint.png)

## Deploy the Language Detection module to the edge

Deploy the Language Detection container image as Azure IoT Edge modules from Azure Marketplace:

1. Find the **Azure AI services Text Analytics Language** module in the [Microsoft Artifact Registry](https://mcr.microsoft.com/catalog?cat=IoT%20Edge%20Modules&alphaSort=asc&alphaSortKey=Name) filtered by *IoT Edge Modules*.

1. Select the latest image version of the **Azure AI services Text Analytics Language** module.

1. Copy the URI for the **Azure AI services Text Analytics Language** module. Only copy the URI for the module. Don't include the *docker pull* command. For example, `mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest`.

1. In the Azure portal, find your IoT Edge device created in an earlier step.

1. Select **Set modules** from the IoT Edge device details page.

1. In the **IoT Edge modules** section, select **Add** then choose **IoT Edge Module**.

1. Update the following module settings:

    | Setting            | Value                                                                      |
    |--------------------|----------------------------------------------------------------------------|
    | IoT Module name    | `EdgeModuleLanguageDetectionTextAnalytics`                                 |
    | Image URI          | `mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest` |
    | Restart policy     | always                                                                     |
    | Desired status     | running                                                                    |

1. Go to **Environment Variables** and provide the following information.

    1. Keep the value **accept** for **Eula**.

    1. Enter your Azure AI services endpoint in **Billing**.

    1. Enter your Azure AI services API key in **ApiKey**.

   ![The illustration shows environment variables.](../media/provide-info.png)

1. Go to **Container Create Options**, and verify the options are:

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

    This configuration adds port 5000 to the exposed ports so you can connect to the container.

1. Select **Apply**.

1. Select **Review + create**. Preview the JSON file that defines all the modules that are deployed to your IoT Edge device.

1. Select **Create** to start the module deployment.

1. After you complete the module deployment, go back to the **IoT Edge** page of your IoT hub. Select your device from the list of IoT Edge devices to see its details.

1. Scroll down to see the modules listed. Check that the runtime status is running for each module.
