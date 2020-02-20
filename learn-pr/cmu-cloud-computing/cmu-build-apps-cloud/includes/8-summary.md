
- Cloud applications must take precautions to ensure that they use resources that help them meet their bandwidth and latency requirements, as well as follow security best practices. 
- Applications deployed on the cloud are often subject to performance variance due to the shared nature of the cloud.
- The cloud makes it easy to maintain several different environments apart from production. Application pipelines are maintained using code repository and version control systems, and they're automated using continuous integration tools.
- Planning for failure is crucial. Redundancy is the key technique used to ensure resilience, often using replicas deployed across availability zones and regions.
- Redundant resources are generally monitored and accessed using a central, highly available load balancer. High availability is ensured by switching over to a backup instance when one fails.
- Companies like Netflix and Facebook inject large random (or planned) failures in their datacenters and cloud operations to test for fault tolerance.
- Load balancing also supports horizontal scaling, whereby more identical resources can be thrown at a problem. The other type of scaling is vertical, where the size or capacity of existing resources is increased.
- Horizontal scaling across too many nodes leads to the problem of tail latency, where the performance of the application is determined by its slowest component. This is because of variability of performance on the cloud, and also because applications with a large fan-out trigger bursts of activity at each stage. 
- Finally, the lack of standardization and high competitiveness of the cloud market lead to interesting opportunities and challenges to minimize costs.

