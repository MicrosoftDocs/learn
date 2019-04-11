Scaling out enables you to run more instances of a web app, but the resources available to each instance are determined by the pricing tier used by the App Service Plan that hosts the web service. Each pricing tier specifies the computing power provided, together with the memory and maximum number of instances that can be created. If you initially deploy a web app using a relatively cheap pricing tier, you might find the resources are sufficient to start with, but the resources might become too limited if demand for your web service grows, or if you add features that require more power. In this eventuality, you can scale up to a more potent pricing tier.

In the hotel reservation system, you've noticed a steady increase in the number of visitors, beyond the variations that occur due to special offers or events. Additionally, your company is adding more features to the web app that require additional resources. You're currently nearing the scale-out limits of the current App Service Plan pricing tier, so you need to scale up to a tier that provides more instances and more powerful hardware.

In this unit, you'll learn how to scale up the web app to meet the increasing resource requirements.

## App Service Plan pricing tiers and hardware levels

The different pricing tiers available for App Service Plans offer varying levels or resources. The Basic, Standard, and Premium tiers are based on *A-Series* VMs with different amounts of memory and IO capacity. The PremiumV2 and Isolated tiers are based on *Dv2-Series* VMs. Each of these tiers has three hardware levels, roughly corresponding to 1, 2, and 4 CPUs. You can find detailed information about the pricing tiers and hardware levels at [App Service Pricing](https://azure.microsoft.com/pricing/details/app-service/windows/)

## Scale up a web app

You scale an App Service Plan up and down by changing the pricing tier and hardware level it runs on. You can start with the Free tier, and scale up as necessary according to your requirements. This is a manual process. You can also scale down again if you no longer need the resources associated with a particular tier.

Scaling up can cause an interruption in service to client apps running at the time; they may need to disconnect from the service and reconnect if the scale up occurs during an active call to the web app. Additionally, new connections may be rejected until scaling has completed. Furthermore, scaling up can cause the outgoing IP addresses for the web app to change. If your web app depends on other services that have firewalls restricting incoming traffic, you will need to reconfigure these services.

As with scale-out, you should monitor the performance of your system to ensure that scaling up (or down) has the desired effect. It's also important to understand that scale up and scale out can work cooperatively together. If you have scaled out to the maximum number of instances available for your pricing tier, you must scale up before you can scale out further.