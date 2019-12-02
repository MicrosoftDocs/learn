---
title: Summary
---

Here are some of the key points presented in this module regarding elasticity:

-   VMs and other cloud resources rarely experience constant loads. Instead, they experience variable loads -- sometimes loads that vary by an order of magnitude or more over time.

-   Sizing compute capacity to fit peak loads ensures quality of service (QoS) but results in increased costs and energy usage.

-   Elasticity refers to the ability to add resources to handle higher loads and remove resources when the load decreases.

-   Elasticity is achieved in the cloud by scaling resources such as VMs and databases.

-   Scaling in and out (horizontal scaling) refers to increasing and decreasing the number of resources devoted to a task -- for example, increasing the number of VMs serving web-site users from 10 to 15.

-   Scaling up and down (vertical scaling) refers to replacing existing resources with more or less powerful ones -- for example, replacing a web-server VM containing two cores and 4 GB of RAM with one containing four cores and 8 GB of RAM.

-   Scaling resources to match demand keeps resource utilization relatively constant, decreases costs, and decreases energy usage.

-   Auto-scaling allows scaling to occur based on rules or policies established by a cloud administrator. The rules or policies can be time-based, metrics-based, or both. An example of metrics-based auto-scaling is bringing additional instances online when average CPU utilization reaches a predetermined threshold such as 70%.

-   Time-based auto-scaling, also known as scheduled auto-scaling, is most appropriate when loads are cyclical and predictable.

-   Metrics-based auto-scaling can handle predictable as well as unpredictable loads.

-   Effective load balancing is crucial to implementing scalable cloud services.

-   Load balancers use a variety of different algorithms to distribute load, including round-robin and hashed-based algorithms.

-   Some load balancers attempt to dispatch requests more intelligently by using metrics such as request-execution time and CPU utilization at each node.

-   Load balancers also increase availability by monitoring the health of back-end resources and recognizing when those resources are not available.

-   Because a single load balancer represents a single point of failure, load balancers are often deployed in pairs.

-   Serverless computing offers benefits that include consumption-based pricing, automatic scalability, and reduced administrative costs

-   One example of serverless computing is serverless functions, which let you upload code to the cloud and define when it executes.

-   Another example is serverless workflows, which let you define business workflows (typically using graphical designers and without writing code) and specify when they execute.

-   Serverless computing also extends to databases, which scale to meet the demand placed on them.
