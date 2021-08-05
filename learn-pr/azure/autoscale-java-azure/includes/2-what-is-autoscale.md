In this unit, we look at Azure autoscaling concepts.

## What is autoscale?

Autoscale allows you to have the right amount of resources running to handle the load on your application. It allows you to add resources to handle increases in load and also save money by removing resources that are sitting idle. You specify a minimum and maximum number of instances to run and add or remove VMs automatically based on a set of rules. Having a minimum makes sure your application is always running even under no load. Having a maximum limits your total possible hourly cost. You automatically scale between these two extremes using rules you create.

 ![Autoscale explained. Add and remove VMs](../media/AutoscaleConcept.png)

## Horizontal vs vertical scaling

Autoscale only scales horizontally, which is an increase ("out") or decrease ("in") in the number of VM instances.  Horizontal is more flexible in a cloud situation as it allows you to run potentially thousands of VMs to handle load.

In contrast, vertical scaling is different. It keeps the same number of VMs, but makes the VMs more ("up") or less ("down") powerful. Power is measured in memory, CPU speed, disk space, etc.  Vertical scaling has more limitations. It's dependent on the availability of larger hardware, which quickly hits an upper limit and can vary by region. Vertical scaling also usually requires a VM to stop and restart.
When rule conditions are met, one or more autoscale actions are triggered. You can add and remove VMs, or perform other actions. The following conceptual diagram shows this process.

## How does Autoscale work?

 ![Autoscale Flow Diagram](../media/Autoscale_Overview_v4.png)

## Resource Metrics

Resources emit metrics, these metrics are later processed by rules. Metrics come via different methods.
Virtual machine scale sets use telemetry data from Azure diagnostics agents whereas telemetry for Web apps and Cloud services comes directly from the Azure Infrastructure. Some commonly used statistics include CPU Usage, memory usage, thread counts, queue length, and disk usage. For a list of what telemetry data you can use, see the summary section.

## Custom Metrics

You can also leverage your own custom metrics that your application(s) may be emitting. If you have configured your application(s) to send metrics to Application Insights you can leverage those metrics to make decisions on whether to scale or not.

## Time

Schedule-based rules are based on UTC. You must set your time zone properly when setting up your rules.  

## Rules

The diagram shows only one autoscale rule, but you can have many of them. You can create complex overlapping rules as needed for your situation.  Rule types include  

* **Metric-based** - For example, do this action when CPU usage is above 50%.
* **Time-based** - For example, trigger a webhook every 8am on Saturday in a given time zone.

Metric-based rules measure application load and add or remove VMs based on that load. Schedule-based rules allow you to scale when you see time patterns in your load and want to scale before a possible load increase or decrease occurs.  

## Actions and automation

Rules can trigger one or more types of actions.

* **Scale** - Scale VMs in or out
* **Email** - Send email to subscription admins, co-admins, and/or additional email address you specify
* **Automate via webhooks** - Call webhooks, which can trigger multiple complex actions inside or outside Azure. Inside Azure, you can start an Azure Automation runbook, Azure Function, or Azure Logic App. Example third-party URL outside Azure include services like Slack and Twilio.

## Autoscale Settings

Autoscale use the following terminology and structure.

* An autoscale setting is read by the autoscale engine to determine whether to scale up or down. It contains one or more profiles, information about the target resource, and notification settings.

  * An autoscale profile is a combination of a:

    * capacity setting, which indicates the minimum, maximum, and default values for number of instances.

    * set of rules, each of which includes a trigger (time or metric) and a scale action (up or down).

    * recurrence, which indicates when autoscale should put this profile into effect.
      You can have multiple profiles, which allow you to take care of different overlapping requirements. You can have different autoscale profiles for different times of day or days of the week, for example.

    * A notification setting defines what notifications should occur when an autoscale event occurs based on satisfying the criteria of one of the autoscale setting’s profiles. Autoscale can notify one or more email addresses or make calls to one or more webhooks.

![Azure autoscale setting, profile, and rule structure](../media/AzureResourceManagerRuleStructure3.png)

# Benefits of autoscale

Azure Cosmos databases and containers that are configured with autoscale provisioned throughput have the following benefits:

* **Simple:** Autoscale removes the complexity of managing RU/s with custom scripting or manually scaling capacity.

* **Scalable:** Databases and containers automatically scale the provisioned throughput as needed. There is no disruption to client connections, applications, or impact to Azure Cosmos DB SLAs.

* **Cost-effective:** Autoscale helps optimize your RU/s usage and cost usage by scaling down when not in use. You only pay for the resources that your workloads need on a per-hour basis. Of all hours in a month, if you set autoscale max RU/s(Tmax) and use the full amount Tmax for 66% of the hours or less, you'll save with autoscale.

* **Highly available:** Databases and containers using autoscale use the same globally distributed, fault-tolerant, highly available Azure Cosmos DB backend to ensure data durability and high availability.

## Use cases of autoscale

The use cases of autoscale include:

* **Variable or unpredictable workloads:** When your workloads have variable or unpredictable spikes in usage, autoscale helps by automatically scaling up and down based on usage. Examples include retail websites that have different traffic patterns depending on seasonality; IOT workloads that have spikes at various times during the day; line of business applications that see peak usage a few times a month or year, and more. With autoscale, you no longer need to manually provision for peak or average capacity.

* **New applications:** If you're developing a new application and not sure about the throughput (RU/s) you need, autoscale makes it easy to get started. You can start with the autoscale entry point of 400 - 4000 RU/s, monitor your usage, and determine the right RU/s over time.

* **Infrequently used applications:** If you have an application that's only used for a few hours several times a day, week, or month — such as a low-volume application/web/blog site — autoscale adjusts the capacity to handle peak usage and scales down when it's over.

* **Development and test workloads:** If you or your team use Azure Cosmos databases and containers during work hours, but don't need them on nights or weekends, autoscale helps save cost by scaling down to a minimum when not in use.

* **Scheduled production workloads/queries:** If you have a series of scheduled requests, operations, or queries that you want to run during idle periods, you can do that easily with autoscale. When you need to run the workload, the throughput will automatically scale to what's needed and scale down afterward.
