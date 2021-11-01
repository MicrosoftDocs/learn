Middleware is a general term for software that serves to \"glue together\" separate, often complex and already existing, programs. The term middleware is used in many contexts. For example, in the context of a single computer, middleware exists between the operating system kernel and application programs in the form of APIs, which manage access to system resources such as hardware devices. In web applications, middleware frequently sits in the request-processing pipeline and provides services such as authentication and request routing.

Cloud middleware refers to the software platform that controls and coordinates different cloud services and makes it possible for users to issue service requests and cloud providers to manage their infrastructure. Cloud middleware consists of multiple abstraction layers that hide system complexity and that enable communication between various applications, services, and devices that are part of a cloud service (Figure 2.3).

![Figure 2.3: Cloud middleware features.](../media/middleware-features.png)

_Figure 2.3: Cloud middleware features._

# Cloud Middleware Features

There are a number of distinct and important features that cloud middleware provides, each of which has its own benefits. Some of the most important responsibilities of a cloud middleware stack are as follows:

**Interoperability**: Cloud middleware is the proverbial "glue" that enables multiple distinct applications and services to connect to and communicate with each other. Specifically, middleware connects distinct application services with different APIs to one another. For example, to provision a VM, cloud service APIs act as middleware for cloud provisioning services by taking instructions from a program and translating them into service calls that the cloud provisioning service can understand. These instructions are further passed down the middleware stack at the cloud service provider's end to perform actions for example, create virtual machines, allocate disk space, or create a database table.

**Virtualization management**: Cloud middleware is also responsible for the configuration, allocation, creation, management, and destruction of virtualized resources from physical resources. As an example, when a cloud service provider gets a request from a client to provision a virtual machine, it handles that request through multiple middleware layers until it reaches a hypervisor layer, which handles the configuration and allocation of a virtual machine for the client.

**Resource allocation and scheduling**: As discussed above, an important aspect of cloud middleware is the management of resources. As part of this responsibility, middleware must manage the allocation and scheduling of multiple resource types in order to achieve multiple goals such as performance, isolation, utilization, etc.

**Load balancing and fault tolerance**: Cloud service providers must utilize adequate load balancing mechanisms in their middleware in order to optimize the distribution of load on multiple back-end services and physical infrastructure. The middleware should also coordinate with back-end resources to provide end-to-end fault-tolerance so that the availability of services to the client meets required SLOs.

**Resource monitoring**: A crucial responsibility of middleware is the monitoring of resources. Monitoring provides a source of data which is valuable for the internal middleware features such as allocation, scheduling, load balancing, and fault tolerance as discussed above. In addition, data from monitoring systems can be made available to clients, which gives them additional visibility into the state of their applications and provisioned resources.

**User management and security**: Cloud middleware must also provide support for access control and employ standard security practices for the management of various types of credentials that control access to individual resources. The user-management system in the middleware should provide features that allow cloud clients to create and destroy entities such as users and groups, and configure the Access Control Lists (ACLs) that define the resources that individual users and groups have access to.

**User interface and APIs**: Finally, cloud middleware must make available a client-facing set of APIs. It is also typical of cloud middleware to provide user-friendly interfaces (typically in the form of web interfaces), where clients can log in and manage their provisioned resources and make service requests.
