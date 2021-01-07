Recall from earlier, that we're using an App Service to run our WordPress application. Here we'll look at additional information exposed about our application and explore some of the available options to configure our website.

Let's have a look at some of this information.

1. Open the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. From the left-hand navigation menu, select **Dashboard** to access a list of all resources in your subscription. You may have to click the menu icon to show the navigation choices.

    ![Screenshot of Azure portal showing several resources in the all resources widget of a dashboard.](../media/5-dashboard-resources.png)

1. Select the **App Service** with the name you chose in the previous exercise.

1. By default, the app service's overview is displayed, if not select **Overview**.

    [![Screenshot of Azure portal showing the App Service overview pane.](../media/5-overview.png)](../media/5-overview-expanded.png#lightbox)

1. Scroll down in the overview view to where you can see the graphs for your newly created website. These graphs provide statistics about the number of requests received by our website, the amount of data in, data out, and the number of errors encountered on the site.

    [![Screenshot of Azure portal showing App Service graphs: Http 5xx, Data In, Data Out, Requests, and Average Response Time.](../media/5-graphs.png)](../media/5-graphs-expanded.png#lightbox)

    The information displayed here is near real-time data and gives a quick overview of the performance of your website. Problems with the site's performance will manifest in these graphs as early warnings.

## What is scale?

Suppose you deployed your website and it becomes popular. By looking at the graphs in the overview, you realize that your site can't effectively manage all the requests it's receiving. To solve the problem, you'll need to increase the server's hardware capacity.

*Scale* refers to adding network bandwidth, memory, storage, or compute power to achieve better performance.  

You may have heard the terms *scaling up* and *scaling out*.

Scaling up, or vertical scaling means to increase the memory, storage, or compute power on an existing virtual machine. For example, you can add additional memory to a web or database server to make it run faster.

Scaling out, or horizontal scaling means to add extra virtual machines to power your application. For example, you might create many virtual machines configured in exactly the same way and use a load balancer to distribute work across them.

> [!TIP]
> The cloud is elastic. You could *scale down* or *scale in* your deployment if you needed to scale up or scale out only temporarily. Scaling down or scaling in can help you save money.
> **Azure Advisor** and **Azure Cost Management** are two services that help you optimize cloud spend. You can use these services to identify where you're using more than you need, and then scale back to the capacity you're actually using.

When you have more time, feel free to go through each section and explore the various options available.

## How to change the App Service configuration

The App Services has many configurable options available and groups these options in sections of functionality.

The first section displayed is a group of common options you'd access to get a view of the health of your application. However, each following section provides additional functionality and information.

For example, the **Settings** section gives you access to configure various aspects such as application settings, backups, TLS/SSL settings, options to scale up the resources of the application, and so on.

![Screenshot of Azure portal showing App Service settings menu options.](../media/5-settings.png)

## Scale up your App Service

1. In the **Settings** configuration section for your app service, select **Scale up (App service plan)**.

    ![Screenshot of Azure portal showing App Service settings menu with Scale up section highlighted.](../media/5-settings-scale.png)

1. Notice that there are three workload categories to choose from in the configuration pane. These three categories make it easier to decide the type of workload we'll run.

    | Category | Description |
    | --- | --- |
    | **Dev / Test** | This category is ideal for less demanding workloads. This category is predominantly focused on providing shared infrastructure. In this category, you have additional features that become available to the App Service application. For example, Custom domains / SSL and manual scale. |
    | **Production** | This category is ideal for more demanding workloads. In this category, you'll also notice added features such as staging slots, daily backups, and a traffic manager. |
    | **Isolated** | This category is ideal for workloads that require advanced networking and fine-grained scaling. |

    Within each category, there are pricing tiers that will allow us to scale the resources available to our App service. These pricing tiers give us access to the additional features mentioned above.

    We'll leave the configuration on the **F1** tier, but know that this pane is where you can go to make scaling adjustments in your app service if you have changes in load for your application.

    Let's now take a look at how to use the Cloud Shell to configure Azure resources, such as App Service.
