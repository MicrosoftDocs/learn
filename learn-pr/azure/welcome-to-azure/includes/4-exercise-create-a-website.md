As a technology professional, you likely have expertise in a specific area. Perhaps you're a storage admin or virtualization expert, or maybe you focus on the latest security practices. If you're a student, you may still be exploring what interests you most.

No matter your role, most people get started with the cloud by creating a website. Here you'll deploy a website hosted in an App Service.

Let's review some basic terms and get your first website up and running.

## What is an App Service?

Azure App Service is an HTTP-based service that enables you to build and host many types of web-based solutions without managing infrastructure. For example, you can host web apps, mobile back ends, and RESTful APIs in several supported programming languages. Applications develop in .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python can run in and scale with ease on both Windows and Linux-based environments.

We aim to create a website in less than the time it takes to eat lunch. Therefore, we're not going to write any code and will instead deploy a predefined application from the Microsoft Azure Marketplace.

## What is the Microsoft Azure Marketplace?

The Microsoft Azure Marketplace is an online store that hosts applications that are certified and optimized to run in Azure. Many types of applications are available, ranging from AI + Machine Learning to Web applications. As you'll see in a couple of minutes, deployments from the store are done via the Azure portal using a wizard-style user interface. This user interface makes evaluating different solutions very easy.

We're going to use one of the WordPress application options from the Azure Marketplace for our website.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Creating resources in Azure

Typically, the first thing we'd do is to create a *resource group* to hold all the things that we need to create. The *resource group* allows us to administer all the services, disks, network interfaces, and other elements that potentially make up our solution as a unit. We can use the Azure portal to create and manage our solution's resource groups. However, keep in mind that you can also manage resources via a command line using the Azure CLI. The Azure CLI is a useful option should you need to automate the process in the future.

In the free Azure sandbox environment you will use the pre-created resource group **<rgn>[Resource Group Name]</rgn>**, and you don't need to do this step.

## Choosing a location

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

## Create a WordPress website

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the top left of the Azure portal, select **Create a resource**. You'll notice how the portal updates it's itself and present additional UI that either provides you with options to refine selection or update configuration variables. We call these panels *blades*. 

1. Notice how we have several application types to choose from, and unfortunately, we'll not discuss each in detail. However,  you're welcome to go through the list and explore each item at a later stage. Since we know that we want to install WordPress, we can do a quick search for it. In the Search box above the listed application options, type in *WordPress*. Select the default *WordPress* option from the list of options available.

> [!NOTE]
> There are several selections available relating WordPress that you would have noticed in this step. Each of these items provides you with different options regarding the operating system and the amount of configuration to customize the application. Be aware that not all of these options are enabled in the sandbox. You'll have to try the different options in your personal Azure subscription where additional costs will apply.

1. In the newly presented blade, you'll typically find additional information about the item you're about to install. Make sure to review this information. Click the **Create** button when ready.

1. Recall from earlier, that we'll use a wizard type interface to create our website. The newly presented blade is our 1st step in this process. Here, we have to set some values for the required options.

 | Option | Value |
 |--- | --- |
 | **App Name** | Choose a unique for the App name. It will form part of a Fully Qualified Domain Name (FQDN).|
 | **Subscription** | Select the appropriate subscription. |
 | **Resource Group** | Select the existing Resource Group ("**<rgn>[sandbox resource group name]</rgn>**") from the drop-down list. |
 | **Database Provider** | You'll notice that you have two provider options. The default provider is an **Azure database for MySQL**. The second option is the **MySQL in App** provider. We're going to use the **MySQL in App** provider for our website. Notice the call out that the MySQL in App provider isn't intended for production environments.|
 | **App Service plan/location** | The App Service plan/location allows you to select the capabilities and limits available to your application. Keep in mind that different locations sometimes also have different resources available. You are welcome to have a look at this option, however, make sure to leave this value set to the default provided. |
 | **Application Insights** | Application Insights allows you to monitor the performance of your application using powerful analytics tools. Leave the value as set by the default configuration. |

Here is a screenshot to give you an idea of the configuration values.

1. Finally, click on the create button to start the deployment of your new site.

## Verify your website is running

The deployment of the new website can take a few minutes to complete, and you are welcome to explore the portal further on your own. We're able to track the progress of the deployment at any time.

1. Click on the notification bell.

1. Click on "Deployment in progress" link in the dialogue.

1. Resources are listed as they're created and the status changes to green checkmarks as each component in the deployment completes.

1. Once the deployment completes the status for this item changes to "Deployment Succeeded" and you're now able to navigate to the resource.

1. Click on "Go to Resource" to access the information for the website.

1. Find the URL in the Overview section. When you click on the URL, it will open a new tab in your browser that takes you to your WordPress site. You can now configure your WordPress website and add content.
