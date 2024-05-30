Scaling out enables you to run more instances of a web app. The resources available to each instance are determined by the pricing tier used by the App Service plan that hosts the web service. Each pricing tier specifies the computing power provided, together with the memory and maximum number of instances that can be created.

If you initially deploy a web app using a relatively cheap pricing tier, you might find the resources are sufficient to start with. But the resources might become too limited if demand for your web service grows, or if you add features that require more power. In this case, you can scale up to a more powerful pricing tier.

In the hotel reservation system, you notice a steady increase in the number of visitors, beyond the variations caused by special offers or events. And your company is adding more features to the web app that require more resources. You're nearing the scale-out limits of your current App Service plan pricing tier, so you need to scale up to a tier that provides more instances and more powerful hardware.

In this unit, you learn how to scale up the web app to meet the increasing resource requirements.

## App Service plan pricing tiers and hardware levels

The different pricing tiers available for App Service plans offer various levels or resources. The Basic, Standard, and Premium tiers are based on *A-Series* virtual machines that have different amounts of memory and IO capacity. The PremiumV2 and Isolated tiers are based on *Dv2-Series* virtual machines. Each of these tiers has three hardware levels, roughly corresponding to 1, 2, and 4 CPUs. For detailed information about the pricing tiers and hardware levels, see [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/windows/).

## Scale up a web app

You scale an App Service plan up and down by changing the pricing tier and hardware level that it runs on. You can start with the Free tier and scale up as needed according to your requirements. This process is manual. You can also scale down again if you no longer need the resources associated with a particular tier.

Scaling up can cause an interruption in service to client apps running at the time. They might need to disconnect from the service and reconnect if the scale-up occurs during an active call to the web app. And new connections might be rejected until scaling finishes. Also, scaling up can cause the outgoing IP addresses for the web app to change. If your web app depends on other services that have firewalls restricting incoming traffic, you need to reconfigure these services.

As with scale-out, you should monitor the performance of your system to ensure that scaling up or down has the desired effect. It's also important to understand that scale up and scale out can work cooperatively together. If you scale out to the maximum number of instances available for your pricing tier, you must scale up before you can scale out further.
