In this unit, we look at Azure autoscaling concepts.

## Why care about scaling

A fundamental design principle in Azure is to scale out by adding application instances based on increased demand. Scaling out can be a better alternative to purchasing more hardware, as you don't pay for idle application instances or need to reserve capacity in advance. A pay-as-you-go plan is ideal for applications that need to meet planned spikes in traffic.

You can configure scale settings for a role with either two modes manual or automatic. Manual is as you would expect, you set the absolute count of instances. Automatic (AutoScale) however allows you to set rules that govern how and by how much you should scale.

Autoscale allows you to have the right amount of resources running to handle the load on your application. Having a minimum makes sure your application is always running even under no load. Having a maximum limits your total possible hourly cost. You automatically scale between these two extremes using rules you create.

## Horizontal vs vertical scaling

Autoscale only scales horizontally, which is an increase ("out") or decrease ("in") in the number of application instances. In contrast, vertical scaling is different. It keeps the same number of application instances, but makes the application instances more ("up") or less ("down") powerful. Power is measured in memory, CPU speed, disk space, and so on.  Vertical scaling has more limitations. It's dependent on the availability of larger hardware, which quickly hits an upper limit and can vary by region. Vertical scaling also usually requires an application instance to stop and restart.

# How does Autoscale work?

An autoscaling typically involves the following pieces:

* Instrumentation and monitoring systems at the application, service, and infrastructure levels. These systems capture key metrics, such as response times, queue lengths, CPU utilization, and memory usage.
* Decision-making logic that evaluates these metrics against predefined thresholds or schedules, and decides whether to scale.
* Components that scale the system.
* Testing, monitoring, and tuning of the autoscaling strategy to ensure that it functions as expected.

## Autoscale in Azure Spring Cloud

Azure Spring Cloud is built using components that scale so that it can meet demand and optimize cost
Autoscale helps Azure Spring Cloud microservice applications perform their best when demand changes. This includes modifying the number of virtual CPUs, memory, and app instances.
