To use the Custom Vision service to create an object detection solution, you need *two* Custom Vision resources in your Azure subscription:

- An **Azure AI Custom Vision *training*** resource - used to train a custom model based on your own training images.
- An **Azure AI Custom Vision *prediction*** resource - used to generate predictions from new images based on your trained model.

When you provision the Azure AI Custom Vision service in an Azure subscription, you can choose to create one or both of these resources. This separation of training and prediction provides flexibility. For example, you can use a *training* resource in one region to train your model using your own image data; and then deploy one or more prediction resources in other regions to support computer vision applications that need to use your model.

Each resource has its own unique *endpoint* and authentication *keys*; which are used by client applications to connect and authenticate to the service.

## The Custom Vision portal

Azure AI Custom Vision provides a web-based portal, in which you can train, publish, and test custom vision models.

![Screenshot of the Azure AI Custom Vision portal.](../media/custom-vision-portal.png)

You can sign into the Custom Vision portal at [https://www.customvision.ai/](https://www.customvision.ai?azure-portal=true) using your Azure credentials and use it to create image classification or object detection projects that use Azure AI Custom Vision resources in your Azure subscription.

Each project has a unique *project ID*; which is used by client applications to perform training or prediction tasks using code.

## Custom Vision SDKs

You can write code to train and consume custom models by using the Azure AI Custom Vision language-specific SDKs.

For example, Microsoft C# developers can use the [Microsoft.Azure.CognitiveServices.Vision.CustomVision.Training](https://www.nuget.org/packages/Microsoft.Azure.CognitiveServices.Vision.CustomVision.Training?azure-portal=true) and [Microsoft.Azure.CognitiveServices.Vision.CustomVision.Prediction](https://www.nuget.org/packages/Microsoft.Azure.CognitiveServices.Vision.CustomVision.Prediction?azure-portal=true) Microsoft .NET packages for training and prediction respectively.

Python developers can perform both training and prediction tasks by using the [azure-cognitiveservices-vision-customvision](https://pypi.org/project/azure-cognitiveservices-vision-customvision?azure-portal=true) package.
