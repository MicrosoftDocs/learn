<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u02_data_centers\_u02_m04_programming_the_cloud\x-oli-workbook_page\_u02_m04_8_summary.xml -->
##  Programming the Cloud Summary

- Cloud applications must take precautions to ensure that they use resources that help them meet their bandwidth and latency requirements, as well as follow security best practices. 
- Applications deployed on the cloud are often subject to performance variance due to the shared nature of the cloud.
- The cloud makes it easy to maintain several different environments apart from production. Applicaton pipelines are maintained using code repository and version control systems and automated using Continuous Integration tools.
- Planning for failure is crucial. Redundancy is the key technique used to ensure resilience- often ensure using replicas deployed across availability zones and regions.
- Redundant resources are generally monitored and accessed using a central Highly Available load balancer. High Availability is ensure by switching over to a backup instance when one fails.
- Companies like Netflix and Facebook inject large random (or planned) failures in their data centers and cloud operations to test for fault tolerance.
- Load Balancing also supports horizontal scaling, whereby more identical resources can be thrown at a problem. The other type of scaling is vertical- where the size or capacity of existing resources is increased.
- Horizontal scaling across too many nodes leads to the problem of Tail Latency, where the performance of the application is determined by it's slowest component. This is both due to variability of performance on the cloud and also because applications with a large fan-out trigger bursts of activity at each stage. 
- Finally, the lack of standardization and high competitiveness of the cloud market leads to interesting opportunties and challenges to minimize costs.