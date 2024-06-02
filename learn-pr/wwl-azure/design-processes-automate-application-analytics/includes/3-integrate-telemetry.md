A key factor to automating feedback is telemetry. By inserting telemetric data into your production application and environment, the DevOps team can automate feedback mechanisms while monitoring applications in real time.

DevOps teams use telemetry to see and solve problems as they occur, but this data can be helpful to both technical and business users.

When properly instrumented, telemetry can also be used to see and understand how customers are engaging with the application in real time.

It could be critical information for product managers, marketing teams, and customer support. So, feedback mechanisms must share continuous intelligence with all stakeholders.

## What is telemetry, and why should I care?

In the software development world, telemetry can offer insights on which features end users use most, detect bugs and issues, and provide better visibility into the performance without asking for feedback directly from users.

In DevOps and the world of modern cloud apps, we're tracking the health and performance of an application.

That telemetry data comes from application logs, infrastructure logs, metrics, and events.

The measurements are things like memory consumption, CPU performance, and database response time.

Events can be used to measure everything else, such as when a user logged in, when an item is added to a basket, when a sale is made, and so on.

The concept of telemetry is often confused with just logging. But logging is a tool used in the development process to diagnose errors and code flows. It's focused on the internal structure of a website, app, or another development project. Logging only gives you a single dimension view. With insights into infrastructure logs, metrics, and events, you have a 360-degree view of understanding user intent and behavior.

Once a project is released, telemetry is what you are looking for to enable data collection from real-world use.

Telemetry is what makes it possible to collect all that raw data that becomes valuable, actionable analytics.

## Common sources of telemetry

When it comes to gathering telemetry, there are various sources to tap into for valuable insights. Azure offers a rich ecosystem of services that provide telemetry data from different aspects of your application and infrastructure. For instance, telemetry can be collected from Windows and Linux servers running in Azure, other cloud environments, or on-premises, containerized workloads, storage accounts, network services, and more. These sources offer a wealth of information about the health, performance, and usage of your resources.

To harness the power of this telemetry data, Azure provides specialized insight services tailored to these different sources. One such service is Application Insights, which focuses on collecting telemetry from web applications hosted on App Services, physical and virtual servers, containers, and other types of compute resources. It offers detailed monitoring and diagnostics capabilities, allowing you to track performance metrics, detect issues, and analyze user interactions.

If you want to monitor physical and virtual servers running Windows or Linux, VM Insights provides deep visibility into their performance and health metrics, enabling proactive management and troubleshooting. It offers features like performance trend analysis, anomaly detection, and recommendations for performance optimization.

Container Insights is designed to gather telemetry from containerized applications running on Azure Kubernetes Service (AKS) or Arc-enabled Kubernetes clusters. It provides insights into container performance, resource utilization, and application dependencies, helping you optimize containerized workloads and ensure their reliability and scalability.

Storage Insights focuses on telemetry data related to Azure storage accounts, providing visibility into storage performance, usage patterns, and access trends. It enables you to monitor storage latency, throughput, and capacity utilization, helping you optimize storage configurations and identify potential bottlenecks.

Lastly, Network Insights collects telemetry from Azure network services, such as Azure virtual networks, load balancers, and firewalls, to monitor network performance, connectivity, and security. It offers visibility into network traffic patterns, latency metrics, and security events, allowing you to troubleshoot network issues and optimize network configurations for better performance and reliability.

## Benefits of telemetry

The primary benefit of telemetry is the ability of an end user to monitor the state of an object or environment while physically far removed from it.

Once you've shipped a product, you can't be physically present, peering over the shoulders of thousands (or millions) of users as they engage with your product to find out what works, what is easy, and what is cumbersome.

Thanks to telemetry, those insights can be delivered directly into a dashboard for you to analyze and act.

Because telemetry provides insights into how well your product is working for your end users – as they use it – it's a unique tool for ongoing performance monitoring and management.

Plus, you can use the data you've gathered from version 1.0-to-drive improvements and prioritize updates for your release of version 2.0.

Telemetry enables you to answer questions such as:

 -  Are your customers using the features you expect? How are they engaging with your product?
 -  How frequently are users engaging with your app, and for what duration?
 -  What settings options do users select most? Do they prefer certain display types, input modalities, screen orientation, or other device configurations?
 -  What happens when crashes occur? Are crashes happening more frequently when certain features or functions are used? What is the context surrounding a crash?

The answers to these and the many other questions that can be answered with telemetry are invaluable to the development process.

It will enable you to make continuous improvements and introduce new features that, to your end users, may seem as though you have been reading their minds – which you've been, thanks to telemetry.

## Challenges of telemetry

Telemetry is a fantastic technology, but it isn't without its challenges.

The most prominent challenge – and a commonly occurring issue – isn't with telemetry itself but with your end users and their willingness to allow what some see as Big Brother-Esque spying.

In short, some users immediately turn it off when they notice it, meaning any data generated from their use of your product won't be gathered or reported.

That means the experience of those users won't be accounted for when it comes to planning your future roadmap, fixing bugs, or addressing other issues in your app.

Although it isn't necessarily a problem by itself, the issue is that users who tend to disallow these types of technologies can tend to fall into the more tech-savvy portion of your user base.

It can result in the dumbing-down of software. On the other hand, other users take no notice of telemetry happening behind the scenes or ignore it if they do.

It's a problem without a clear solution—and it doesn't negate the overall power of telemetry for driving development—but one to keep in mind as you analyze your data.

So, when designing a strategy for how you consider the feedback from application telemetry, it's necessary to account for users who don't participate in providing the telemetry.
