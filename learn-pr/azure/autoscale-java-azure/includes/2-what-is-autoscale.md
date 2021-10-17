In this unit, we look at Azure scaling concepts.

## Why care about scaling

A primary advantage of the cloud is elastic scaling - scale out by adding application instances based on increased demand. You have the ability to use as much capacity as you need, scaling out as load increases, and scaling in when the extra capacity is not needed.

A classic example of the need for elasticity occurs when an organization's web site experiences unusually high loads. If the site can't scale to meet demand, requests take longer to process because they're queued waiting for processor time. To the customer, the site seems slow and unresponsive. In extreme cases, the site might even appear to be down.

Some loads are unpredictable. For example, the COVID-19 lowdowns triggered a massive surge many company’s e-commerce traffic. IT teams where still managing their infrastructure manually, and the scale-outs were time consuming. Now, with scale automation, teams can achieve that same degree of expansion automatically. Other loads are also as unpredictable. They may occur because a tweet went viral or our favorite team won the World Cup, or due to other factors that an organization can't anticipate.

### Manual vs Automatic scale

You can configure scale settings for an application with either two modes manual or automatic. Manual is as you would expect, you set the absolute count of instances. Automatic (AutoScale) however allows you to set rules that govern how and by how much you should scale.

Autoscale allows you to have the right amount of resources running to handle the load on your application. Autoscaling eases management overhead by reducing the need for system operators to constantly make decisions about adding or removing resources or checking the system's performance. Having a minimum makes sure your application is always running even under no load. Having a maximum limits your total possible hourly cost. You automatically scale between these two extremes using rules you create.

:::image type="content" source="../media/computesaving.jpg" alt-text="save on compute":::

## "Up" vs "Out"

Autoscale only scales "Out" (horizontally), which is an increase ("out") or decrease ("in") in the number of application instances. In contrast, "Up" (vertical) scaling is different. It keeps the same number of application instances, but makes the application instances more ("up") or less ("down") powerful.

:::image type="content" source="../media/outvsup.png" alt-text="scaleup vs scale out difference":::

## Real-world example

Raley’s grocery stores needed to modernize the code and infrastructure for their Java-powered e-commerce sites hosted on Azure. The company also needed to optimize and automate its network allocation. Everything had to be robust, always-on, and—most importantly—easy to manage.

The answer was Azure Spring Cloud, a fully managed service for Spring Boot, providing the power of Kubernetes coupled with real-time monitoring and autoscaling. It also enabled Raley’s to adopt a true platform as a service (PaaS) architecture, seizing the benefits of the cloud more fully.

The service manages the infrastructure of Spring Boot microservice applications behind the scenes, so developers can focus on their code. When JARs or code are deployed, Spring Cloud automatically wires the apps with the Spring service runtime.

After they’re deployed, Spring Cloud apps are fully integrated with Azure Monitor tools, like Application Insights and Log Analytics, allowing easy, fully configurable monitoring of performance and errors. When used with Azure Application Gateway, these same monitoring services can also drive autoscaling, helping to ensure that resources are appropriately sized for current loads.

## Autoscale in Azure Spring Cloud

Autoscaling in Azure Spring Cloud monitors the resource metrics of a Spring application as it runs. It detects situations where additional resources are required to handle an increasing workload, and ensures those resources are available before the system becomes overloaded. Autoscale is a built-in feature of Azure Spring Cloud that helps microservice applications perform their best when demand changes.

:::image type="content" source="../media/autoscaleconcept.png" alt-text="autoscale up scaling":::

In the following exercise, you'll clone a Git repository and run a script that sets-up an Azure Spring Cloud microservice application and an Azure Database for MySQL.
The script deploys a well-known PetClinic microservice application and is built around small independent services, communicating over HTTP via a REST API.

Your application is setup with autoscaling to respond to changes in the environment by adding or removing Azure Spring Cloud instances and balancing the load between them. Autoscaling doesn't have any effect on the CPU power, memory, or storage capacity of the application instances powering the app, it only changes the number of application instances.
