Azure App Service supports manual scaling, and two options for scaling out your web apps automatically:

* Autoscaling with Azure *autoscale*. Autoscaling makes scaling decisions based on rules that you define.
* Azure App Service *automatic scaling*. Automatic scaling makes scaling decisions for you based on the parameters that you select.

The following table highlights the differences between the two automatic scaling options:

| **Factor** | **Autoscale** | **Automatic scaling** |
|--|--|--|
| Available pricing tiers | Standard and Up | Premium V2 (P1V2, P2V2, P3V2) and Premium V3 (P0V3, P1V3, P2V3, P3V3, P1MV3, P2MV3, P3MV3, P4MV3, P5MV3) pricing tiers |
| Rule-based scaling | Yes | No, the platform manages the scale-out and in based on HTTP traffic. |
| Schedule-based scaling | Yes | No |
| Always ready instances | No, your web app runs on other instances available during the scale-out operation, based on threshold defined for autoscale rules. | Yes (minimum 1) |
| Prewarmed instances | No | Yes (default 1) |
| Per-app maximum | No | Yes |

## What is autoscaling?

Autoscaling is a cloud system or process that adjusts available resources based on the current demand. Autoscaling performs scaling *in and out*, as opposed to scaling *up and down*.

Autoscaling can be triggered according to a schedule, or by assessing whether the system is running short on resources. For example, autoscaling could be triggered if CPU utilization grows, memory occupancy increases, the number of incoming requests to a service appears to be surging, or some combination of factors.

## Azure App Service autoscaling

Autoscaling in Azure App Service monitors the resource metrics of a web app as it runs. It detects situations where other resources are required to handle an increasing workload, and ensures those resources are available before the system becomes overloaded.

Autoscaling responds to changes in the environment by adding or removing web servers and balancing the load between them. Autoscaling doesn't have any effect on the CPU power, memory, or storage capacity of the web servers powering the app, it only changes the number of web servers.

### Autoscaling rules

Autoscaling makes its decisions based on rules that you define. A rule specifies the threshold for a metric, and triggers an autoscale event when this threshold is crossed. Autoscaling can also deallocate resources when the workload lessens.

Define your autoscaling rules carefully. For example, a Denial of Service attack can result in a large-scale influx of incoming traffic. Trying to handle a surge in requests caused by a DoS attack would be fruitless and expensive. These requests aren't genuine, and should be discarded rather than processed. A better solution is to implement detection and filtering of requests that occur during such an attack before they reach your service.

### When should you consider autoscaling?

Autoscaling provides elasticity for your services. For example, you might expect increased/reduced activity for a business app during holidays.

Autoscaling improves availability and fault tolerance. It can help ensure that client requests to a service aren't denied because an instance is either: not able to acknowledge the request in a timely manner; or because an instance has crashed.

Autoscaling works by adding or removing web servers. If your web apps perform  resource-intensive processing as part of each request, then autoscaling might not be an effective approach. In these situations, manually scaling up may be necessary. For example, if a request sent to a web app involves performing complex processing over a large dataset, depending on the instance size, this single request could exhaust the processing and memory capacity of the instance.

Autoscaling isn't the best approach to handling long-term growth. You might have a web app that starts with a few users, but increases in popularity over time. Autoscaling has an overhead associated with monitoring resources and determining whether to trigger a scaling event. In this scenario, if you can anticipate the rate of growth, manually scaling the system over time may be a more cost effective approach.

The number of instances of a service is also a factor. You might expect to run only a few instances of a service most of the time. However, in this situation, your service is susceptible to downtime or lack of availability whether autoscaling is enabled or not. The fewer the number of instances initially, the less capacity you have to handle an increasing workload while autoscaling spins up more instances.

## Azure App Service automatic scaling

You enable automatic scaling for an App Service Plan and configure a range of instances for each of the web apps. As your web app starts receiving HTTP traffic, App Service monitors the load and adds instances. Resources may be shared when multiple web apps within an App Service Plan are required to scale out simultaneously.

Here are a few scenarios where you should scale out automatically:

- You don't want to set up autoscale rules based on resource metrics.
- You want your web apps within the same App Service Plan to scale differently and independently of each other.
- Your web app is connected to a database or legacy system, which may not scale as fast as the web app. Scaling automatically allows you to set the maximum number of instances your App Service Plan can scale to. This setting helps the web app to not overwhelm the backend.
