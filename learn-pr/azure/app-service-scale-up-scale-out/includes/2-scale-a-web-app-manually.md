Manual scaling out and back in again gives you the ability to respond to expected increases and decreases in traffic. Scaling out has the additional benefit of increasing availability because of the increased number of instances of the web app. A failure of one instance does not render the web app unavailable. 

In the hotel reservation system, you can scale out before an anticipated seasonal influx. You can scale back in when the season is over and the number of booking requests diminish.

In this unit, you'll learn how to manually scale out a web app, and scale it back in.

## App Service Plans and Scalability

A web app running in Azure typically uses Azure App Service to provide the hosting environment. App Service can arrange for multiple instances of the web app to run, and will load-balance incoming requests across these instances. Each instance runs on a virtual machine.

The resources available to each instance are defined by an App Service Plan. The App Service Plan specifies the operating system (Windows or Linux), together with the hardware (memory, CPU processing capacity, disk storage, and so on), and also the availability of services such as automatic backup and restore.

Azure provides a series of well-defined App Service Plan tiers. The list below summarizes each of these tiers, in increasing order of capacity (and cost):

- The Free tier provides 1 GB of disk space and support for up to 10 apps, but only a single shared instance and no SLA for availability. Each app has a compute quota of 60 minutes per day. The Free service plan is primarily suitable for app development and testing rather than production deployments.
- The Shared tier provides support for more apps (up to 100) also running on a single shared instance. Apps have a compute quota of 240 minutes per day. There is no availability SLA.
- The Basic tier supports an unlimited number of apps and provides more disk space. Apps can be scaled out to three dedicated instances. This tier also provides an SLA of 99.95% availability. There are three levels in this tier, offering varying amounts of compute power, memory, and disk storage.
- The Standard tier also supports an unlimited number of apps. This tier can scale to 10 dedicated instances with an availability SLA of 99.95%. As with the Basic tier this tier has three levels offering an increasingly powerful set of compute, memory, and disk options.
- The Premium tier gives you up to 20 dedicated instances, an availability SLA of 99.95%, and multiple levels of hardware.
- The Isolated tier runs in a dedicated Azure virtual network, giving you network isolation as well as compute isolation. This tier can scale out to 100 instances, with an availability SLA of 99.95%.

> [!NOTE]
> Not all tiers are available across all operating systems. For example, there is currently no Free tier for Linux.

## Monitor and scale a web app

When you create a new web app, you can either create a new App Service Plan or use an existing one. If you select an existing plan, then any other web apps that use the same plan will share resources with your web app. They'll all scale together, so it's important that they all have the same scaling requirements. If apps have different requirements, then use a separate App Service Plan for each of them.

You scale out by adding more instances to an App Service Plan, up to the limit available for your selected tier. Apart from the Free tier, you're charged for each instance by the hour. You can perform this task using the Azure portal.

The key to scaling effectively is knowing when to scale, and by how much. You monitor the performance of a web app using the metrics available for the App Service. The simplest way to do this is to use the Azure portal. If you notice a steady increase in resource use, such as CPU utilization, memory occupancy, or disk queue length, then you should consider scaling out, before these metric hit a critical point. Other items to look out for include the average response time of requests, and the number of failing requests. If both of these figures are high, the system may be running close to (or beyond) capacity. You may need to scale out immediately.

Similarly, if the metrics indicate that your system is lightly loaded and has plenty of spare capacity, you might want to scale back in to reduce costs.

In both cases, you should continue to monitor the statics for the web app. Allow the system to stabilize, and if the metrics indicate that the app is still underpowered (or overpowered), add or remove instances as necessary.