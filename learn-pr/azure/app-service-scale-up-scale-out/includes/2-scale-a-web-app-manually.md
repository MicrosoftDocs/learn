By manually scaling out and back in again, you can respond to expected increases and decreases in traffic. Scaling out has the extra benefit of increasing availability because of the increased number of instances of the web app. A failure of one instance doesn't make the web app unavailable. 

In the hotel reservation system, you can scale out before an anticipated seasonal influx. You can scale back in when the season is over and the number of booking requests is reduced.

In this unit, you learn how to manually scale out a web app and how to scale it back in.

## App Service plans and scalability

A web app that runs in Azure typically uses Azure App Service to provide the hosting environment. App Service can arrange for multiple instances of the web app to run. It load balances incoming requests across these instances. Each instance runs on a virtual machine.

An App Service plan defines the resources available to each instance. The App Service plan specifies the operating system (Windows or Linux), the hardware (memory, CPU processing capacity, disk storage, and so on), and the availability of services like automatic backup and restore.

Azure provides a series of well-defined App Service plan tiers. This list summarizes each of these tiers, in increasing order of capacity and cost:

- The Free tier provides 1 GB of disk space and support for up to 10 apps, but only a single shared instance and no SLA for availability. Each app has a compute quota of 60 minutes per day. The Free service plan is suitable for app development and testing rather than production deployments.
- The Shared tier provides support for more apps (up to 100) also running on a single shared instance. Apps have a compute quota of 240 minutes per day. There's no availability SLA.
- The Basic tier supports an unlimited number of apps and provides more disk space. Apps can be scaled out to three dedicated instances. This tier provides an SLA of 99.95% availability. There are three levels in this tier that offer varying amounts of computing power, memory, and disk storage.
- The Standard tier also supports an unlimited number of apps. This tier can scale to 10 dedicated instances and has an availability SLA of 99.95%. Like the Basic tier, this tier has three levels that offer an increasingly powerful set of computing, memory, and disk options.
- The Premium tier gives you up to 20 dedicated instances, an availability SLA of 99.95%, and multiple levels of hardware.
- The Isolated tier runs in a dedicated Azure virtual network, which gives you a network and computes isolation. This tier can scale out to 100 instances and has an availability SLA of 99.95%.

> [!NOTE]
> Some tiers aren't available for all operating systems. For example, there is currently no Shared tier for Linux.

## Monitor and scale a web app

When you create a web app, you can either create a new App Service plan or use an existing one. If you select an existing plan, any other web apps that use the same plan share resources with your web app. They all scale together, so they need to have the same scaling requirements. If your apps have different requirements, use a separate App Service plan for each one.

You scale out by adding more instances to an App Service plan, up to the limit available for your selected tier. If you're not using the Free tier, you're charged for each instance on an hourly basis. You can perform this task in the Azure portal.

The key to scaling effectively is knowing when to scale, and by how much. You monitor the performance of a web app by using the metrics available for the App Service. The simplest way to do this task is to use the Azure portal.

If you notice a steady increase in resource use, such as CPU utilization, memory occupancy, or disk queue length, you should consider scaling out before these metrics hit a critical point. You should also monitor the average response time of requests and the number of failing requests. If both of these figures are high, the system might be running close to or beyond capacity. You might need to scale out immediately.

If the metrics indicate that your system is lightly loaded and has plenty of spare capacity, you might want to scale back in to reduce costs.

In both cases, you should continue to monitor the statistics for the web app. Allow the system to stabilize. If the metrics indicate that the app is still underpowered or overpowered, add or remove instances as needed.
