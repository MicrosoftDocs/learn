Congratulations, you have completed the module on Performance and Scalability. Let's recap what we have covered:

## Scaling up and scaling out

- The difference between scaling up/down (the level of resource provisioned on an instance) and scaling in/out (increasing or decreasing the number of available instances). We also discussed examples in Azure of each.
- The considerations to be made when scaling in/out around state management and application startup times.
- Autoscale, and how it can help you scale the number of instances based on a schedule or the demand of an application.
- Discussed alternate technologies that may help with scalability, including serverless and containers.

## Optimize network performance

- Network latency is a measure in delay of data being sent from a sender to a receiver.
- In a cloud environment, chattier applications may see a performance impact compared to on-premises as resources are no longer immediately co-located.
- Co-locating APIs near to a database write endpoint could provide a performance benefit, as we are reducing the network latency between the two resources.
- Azure Traffic Manager could be used to route users to the deployed instance with the lowest network latency.
- Azure Content Delivery Networks (CDN) could be used to offload compute from the main application and speed up application load times by caching content on a CDN edge node near to a user.

## Optimize storage performance

- There are three main types of disks available for IaaS deployments. Standard HDD disks (inconsistent latency and lower levels of throughput), Standard SSD disks (consistent latency and lower levels of throughput), and Premium SSD disks (consistent latency and high levels of throughput).
- Caching could be used in the application layer to improve the load times of an application. Frequently requested information could be stored in a cache in front of the database, which could then optimize for data load times of the most requested information.
- Using the appropriate back-end data store for the job (polyglot persistence) should be considered when building out your solution.

## Identify performance bottlenecks

- Importance of understanding the expectations of the application before architecting or building any operations.
- Understanding how effective DevOps strategies can help build more robust and well-performing applications.
- Summarized the monitoring options available in Azure, including Azure Monitor (pane of glass for monitoring on Azure), Azure Log Analytics (log ingestion and IaaS monitoring), and Application Insights (application performance monitoring including availability, performance, and exception information).
