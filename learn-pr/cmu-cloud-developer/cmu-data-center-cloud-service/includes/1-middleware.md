Middleware is software that serves to "glue together" separate, often complex and already existing, programs. The term "middleware" is used in many contexts. For example, in the context of a single computer, middleware exists between the operating system kernel and application programs in the form of APIs, which manage access to system resources such as hardware devices. 

![Cloud middleware features](../media/middleware.png)

_Figure 1: Cloud middleware features_

Cloud middleware is a software platform that controls and coordinates different cloud services and makes it possible for users to issue service requests, and cloud providers to manage their infrastructure. Cloud middleware consists of multiple abstraction layers that hide system complexity and enable communication between various applications, services, and devices that are part of a cloud service. 

## Cloud middleware features

Cloud middleware provides a number of distinct and important features that come with several benefits.<sup>[1][^1]</sup> Some of the most important responsibilities of a cloud middleware stack are as follows: 

**Interoperability**: Middleware is designed to connect distinct application services with different APIs to one another. Cloud service APIs act as middleware for cloud services by taking instructions from a program (written in a language such as Java or Python), and translating them into service calls that the cloud service can understand. These instructions are further passed down the middleware stack at the cloud service provider's end to perform actions (create virtual machines, allocate disk space, create a database table, etc.). Thus, cloud middleware is the proverbial "glue" that enables multiple distinct applications and services to connect to and communicate with each other. 

**Virtualization management**: Cloud middleware is also responsible for the configuration, allocation, creation, management, and destruction of virtualized resources from physical resources. As an example, when a cloud service provider gets a request from a client to provision a virtual machine, it handles that request through multiple middleware layers until it reaches a hypervisor layer, which handles the configuration and allocation of a virtual machine for the client. 

**Resource allocation and scheduling**: As discussed above, an important aspect of cloud middleware is the management of resources. As part of this responsibility, middleware must manage the allocation and scheduling of multiple resource types in order to achieve multiple goals such as performance, isolation, and utilization. 

**Load balancing and fault tolerance**: Cloud service providers must utilize adequate load-balancing mechanisms in their middleware in order to optimize the distribution of load on multiple back-end services and physical infrastructure. The middleware should also coordinate with back-end resources in order to provide end-to-end fault tolerance so that the availability of services to the client meets required SLOs. 

**Resource monitoring**: A crucial responsibility of middleware is the monitoring of resources. Monitoring provides a source of data that is valuable for the internal middleware features such as allocation, scheduling, load balancing, and fault tolerance, as discussed above. In addition, data from monitoring systems can be made available to clients, which gives them additional visibility into the state of their applications and provisioned resources. 

**User management and security**: Cloud middleware also must provide support for access control of users, and use standard security practices for the management of various types of credentials to control access to individual resources. The user management system in the middleware should provide features that allow cloud clients to create and destroy entities such as users and groups, and configure the access control lists (ACLs) that define the resources that individual users and groups have access to. 

**User interface and APIs**: Finally, cloud middleware must make available a client-facing set of APIs. It is also typical of cloud middleware to provide user-friendly interfaces (typically in the form of web interfaces), where clients can log in and manage their provisioned resources and make service requests. 
<br>
***
### References

1. _Amrani C., Filali K., Ahmed K., Diallo A., Telolahy S. (2012). [A Comparative Study of Cloud Computing Middleware](https://dl.acm.org/citation.cfm?id=2310096.2310135), 12th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing_

***

[^1]: <https://dl.acm.org/citation.cfm?id=2310096.2310135> "Amrani C., Filali K., Ahmed K., Diallo A., Telolahy S. (2012). *A Comparative Study of Cloud Computing Middleware*, 12th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing"