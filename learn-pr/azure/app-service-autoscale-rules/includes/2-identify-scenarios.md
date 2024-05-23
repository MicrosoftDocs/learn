Autoscaling can be triggered according to a schedule, or by dynamically assessing whether the system is running short on resources. For example, autoscaling could be triggered if CPU utilization grows, memory occupancy increases, the number of incoming requests to a service appears to be surging, or some combination of factors.

In the hotel reservation system, autoscaling is useful for handling short-term spikes in the number of booking requests. You can also use scheduled autoscaling to provide more resources at predictable peak times.

## What is autoscaling?

Autoscaling is a cloud system or process that adjusts available resources based on the current demand. Autoscaling performs scaling *in and out*, as opposed to scaling *up and down*.

## Azure App Service autoscaling

Autoscaling in Azure App Service monitors the resource metrics of a web app as the web app runs. App Service detects when more resources are required to handle an increasing workload, and ensures those resources are available before the system becomes overloaded.

Autoscaling responds to changes in the environment by adding or removing web servers and balancing the load among them. Autoscaling doesn't affect the CPU power, memory, or storage capacity of the web servers powering the web app, it only changes the number of web servers.

### Autoscaling rules

Autoscaling makes its decisions based on rules that you define. A rule specifies the threshold for a metric, and triggers an autoscale event when this threshold is crossed. Autoscaling can also de-allocate resources when the workload diminishes.

Define your autoscaling rules carefully. For example, a denial-of-service (DoS) attack will likely result in a large-scale influx of incoming traffic. Trying to handle a surge in requests caused by a DoS attack would be fruitless and expensive. These requests aren't genuine and should be discarded rather than processed. A better solution is to implement detection and filtering of requests that occur during such an attack before they reach your service.

## When should you consider autoscaling?

Autoscaling provides elasticity for your web services. It's a suitable solution when hosting any application for which you can't easily predict the workload, or for which the workload is likely to significantly vary by date or time of day. For example, you might expect increased or reduced activity for a business app during holidays.

Autoscaling improves availability and fault tolerance. It can help ensure that client requests to a web service won't be denied either because an instance is unable to acknowledge requests in a timely manner or because an overloaded instance crashes.

Autoscaling works by adding or removing web servers. If your web apps perform resource-intensive processing as part of each request, then autoscaling might be an ineffective approach. In these situations, manually scaling up might be necessary. For example, if a request sent to a web app involves performing complex processing over a large dataset, depending on the instance size, this single request could exhaust the processing and memory capacity of the instance.

Autoscaling isn't the best approach for handling long-term growth. You might have a web app that starts with a few users but becomes more popular over time. Autoscaling has an overhead associated with monitoring resources and determining whether to trigger a scaling event. In this scenario, if you can anticipate the rate of growth, manually scaling the system over time might be more cost-effective.

The number of instances of a web service is also a factor when considering autoscaling. You might expect to run only a few instances of a service most of the time. However, in this situation, your service will always be susceptible to downtime or lack of availability whether autoscaling is enabled or not. The fewer the number of instances initially, the less capacity you have to handle an increasing workload while autoscaling spins up more instances.
