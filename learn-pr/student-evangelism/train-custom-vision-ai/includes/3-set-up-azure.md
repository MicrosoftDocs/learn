In this module, you are going to use [Custom Vision](https://azure.microsoft.com/products/ai-services/ai-custom-vision), part of the Azure Cognitive Services suite, to detect your favorite animal in an image. Before we jump into training AI, we need to set up our work environment. In this case, your work environment will be all in the browser on Azure.

## Sign up for Azure

To use Custom Vision, you will need an Azure account. But don't worry! This is a quick process, and there are free trials you can use to try it out. If you get stuck at any point, be sure to check out the [Create an Azure account](/training/modules/create-an-azure-account/?azure-portal=true) Learn module. This module also gives an overview of Azure pricing.

If you haven't used Azure before, you can sign up for a [free trial](https://azure.microsoft.com/free/?azure-portal=true). The free trial gives you free services, which includes Custom Vision. You also get a free credit to use some paid services in the first month.

If you are a student, you can sign up for a [student free trial of Azure](https://azure.microsoft.com/free/students/?azure-portal=true) *without* having to put in a credit card. Similar to the regular free trial, this option gives you free services and a free credit to use in the first *year*.

## Create your resource group

The best way to experiment with Azure is to create a resource group that will be easy to keep track of. Resource groups are ways of connecting services that you are using together. If you create a resource group for this module, when you are done you can delete the entire resource group and ensure you don't accidentally leave any AI running and get charged.

To get started creating a resource group, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Sign in to Azure if you're not signed in already.
1. In the top search bar, search for **Resource Group**.
1. Select **Add**.
1. Select your subscription, give the resource group a name, and choose the region closest to you.
1. Select **Review + create**.
1. Select **Create**.

:::image type="content" source="../media/create-resource-group.png" alt-text="Screenshot that shows creating a new resource group on Azure.":::

You can go to your resource group now. If you ever lose your resource group, you can find it by entering **Resource Group** in the top search bar again and then selecting the resource group.

## Create your Custom Vision resource

The only resource you will need for this module is a Custom Vision resource. Azure has made it easy to get everything you need to use Custom Vision AI. By creating this one resource, you will be able to upload images, train your image classification model, and test the model without having to write a single line of code. And don't worry, if you don't know what training and testing a model means, we will get into that in the next unit.

To create a Custom Vision resource, follow these steps:

1. From your **over-the-moon** resource group, select **Add**.
1. Search for **Custom Vision**.
1. Select **Create**.
1. Select your subscription, give your resource a name, select the region closest to you for both training and predicting, and select the free tier for both training and predicting.
1. Select **Review + create**.
1. Select **Create**.

:::image type="content" source="../media/create-custom-vision.png" alt-text="Screenshot that shows creating a new Custom Vision resource on Azure.":::

When deployment is done, select **Go to resource**.

If you ever lose your Custom Vision resource, you can find it by entering **Resource Group** in the top search bar, selecting the resource group, and selecting the Custom Vision resource.

## Create a project on the Custom Vision portal

Now that you have the Azure resources to run the AI, we can create a project on the Custom Vision portal. Go to [Custom Vision](https://www.customvision.ai/?azure-portal=true), and sign in with your same Azure credentials. If this is your first time visiting, you might need to accept the Terms of Service.

To get started with your project, follow these steps:

1. Select **New Project**.
1. Give your project a name and description.
1. Ensure the Custom Vision resource that you made earlier is selected.
1. Select **Object Detection** for the **Project Type**.
1. Select **General** for the **Domain**.
1. Select **Create project**.

:::image type="content" source="../media/create-vision-project.png" alt-text="Screenshot that shows creating a new Custom Vision project in the Custom Vision portal.":::

## Review setup

Let's review everything we just did. While it only felt like a few clicks to us, we have a lot of powerful computers working for us right now.

Here's everything we have encountered.

### The Azure portal

Azure is a cloud service that gives you the compute power to run code in a secure place *not* on your computer.

:::image type="content" source="../media/azure-portal.png" alt-text="Screenshot of the Azure portal with our resource group and Custom Vision resource.":::

What we are doing for this module is a tiny portion of what Azure can do for you. If you are interested in learning more about what Azure can do for you, check out Azure on Microsoft Learn. There are a lot of [modules on Cognitive Services](/training/browse/?azure-portal=true&expanded=azure&terms=cognitive+services) available.

### Custom Vision resource

[Custom Vision on Azure](/azure/cognitive-services/custom-vision-service/?azure-portal=true) is even more powerful than the bit we are going to explore in this module. Open the resource in Azure.

:::image type="content" source="../media/custom-vision-resource.png" alt-text="Screenshot that shows a Custom Vision resource on Azure.":::

You can see there are a number of resources in the menu on the left that start to hint at the complexity of the service that will be working for you as you train your AI. In this module, we will stay in the Custom Vision portal, which is like a front page to this resource.

Everything that you do in the Custom Vision portal will be using the compute resources that you provisioned here in the Custom Vision resource in Azure. Custom Vision also has an SDK. Like the portal, the calls to the SDK would be using what was provisioned on Azure as part of this resource.

If you get inspired by this module, we encourage you to check out the other [Microsoft Learn modules on Custom Vision](/training/browse/?azure-portal=true&expanded=azure&terms=custom+vision).

### Custom Vision portal

The Custom Vision portal is a user interface that allows us to interact with the Custom Vision resource without having to write code. Everything we do here gets broken down into lines of code that you could do without this interface.

:::image type="content" source="../media/custom-vision-project.png" alt-text="Screenshot that shows the Custom Vision portal with a project open.":::

When we created the project in the Custom Vision portal, we were able to choose one of two classification types: Classification and Object Detection. The biggest difference is that Classification classifies an entire image. Object Detection identifies the location of a particular object from within images. For this project, we wanted Object Detection because we want to identify Bungee in images from the film.
