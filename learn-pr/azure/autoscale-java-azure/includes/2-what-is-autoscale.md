In this unit, we look at Azure autoscaling concepts.

## Why care about scaling

A primary advantage of the cloud is elastic scaling - scale out by adding application instances based on increased demand. You have the ability to use as much capacity as you need, scaling out as load increases, and scaling in when the extra capacity is not needed.

A classic example of the need for elasticity occurs when an organization's web site experiences unusually high loads. If the site can't scale to meet demand, requests take longer to process because they're queued waiting for processor time. To the customer, the site seems slow and unresponsive. In extreme cases, the site might even appear to be down.

Some loads are predictable. For example, Domino's pizza sees peak demand for its web site on holidays such as Thanksgiving and New Year's Eve, and during major events such as the Super Bowl1. Other loads are not as predictable. They may occur because a tweet went viral or our favorite team won the World Cup, or due to other factors that an organization can't anticipate.

### Autoscale

You can configure scale settings for an application with either two modes manual or automatic. Manual is as you would expect, you set the absolute count of instances. Automatic (AutoScale) however allows you to set rules that govern how and by how much you should scale.

Autoscale allows you to have the right amount of resources running to handle the load on your application. Having a minimum makes sure your application is always running even under no load. Having a maximum limits your total possible hourly cost. You automatically scale between these two extremes using rules you create.

Autoscaling eases management overhead by reducing the need for system operators to constantly make decisions about adding or removing resources or checking the system's performance.

//TODO https://azure.microsoft.com/mediahandler/files/resourcefiles/azure-sql-database-serverless-infographic/SQL%20DB%20serverless%20infographic_Mar%202020.pdf

//TODO https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-choose-offer 

## Horizontal vs vertical scaling

Autoscale only scales horizontally, which is an increase ("out") or decrease ("in") in the number of application instances. In contrast, vertical scaling is different. It keeps the same number of application instances, but makes the application instances more ("up") or less ("down") powerful.

:::image type="content" source="../media/autoscaleconcept.png" alt-text="autoscale horizontal scaling":::

# How does Autoscale work?

An autoscaling typically involves the following pieces:

* Instrumentation and monitoring systems at the application, service, and infrastructure levels. These systems capture key metrics, such as response times, queue lengths, CPU utilization, and memory usage.
* Decision-making logic that evaluates these metrics against predefined thresholds or schedules, and decides whether to scale.
* Components that scale the system.
* Testing, monitoring, and tuning of the autoscaling strategy to ensure that it functions as expected.

::image:::image type="content" source="../media/autoscale_overview_v4.png" alt-text="autoscale pieces":::

## Autoscale in Azure Spring Cloud

Autoscaling in Azure Spring Cloud monitors the resource metrics of a Spring application as it runs. It detects situations where additional resources are required to handle an increasing workload, and ensures those resources are available before the system becomes overloaded.

In the following exercise, you'll clone a Git repository and run a script that sets-up an Azure Spring Cloud microservice application and an Azure Database for MySQL.
The script deploys a well-known PetClinic microservice application and is built around small independent services, communicating over HTTP via a REST API.

Your application is setup with autoscaling to respond to changes in the environment by adding or removing Azure Spring Cloud instances and balancing the load between them. Autoscaling doesn't have any effect on the CPU power, memory, or storage capacity of the application instances powering the app, it only changes the number of application instances.
