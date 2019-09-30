Cloud computing offers the use of computing resources as a service over a network. The "cloud" is simply a large distributed computing infrastructure whose services are available to end users in much the same that electricity is available to customers of power companies. Similar to some other domains, cloud computing came about through the maturity of enabling technologies while attempting to satisfy economic needs. In this course, we will provide an introduction to cloud computing and then cover relevant topics, in varying detail, including hardware and software infrastructure, resource management (virtualization), cloud storage, and programming models.

# What is Cloud Computing?

> [!div class="alert is-tip"]
> ### Cloud Computing
>
> _(definition)_ The delivery of computing as a service over a network, whereby distributed resources are provided to the end user as a utility.

Information Technology (IT) has become an essential requirement for most organizations to function effectively. Typically, and depending on a specific organization's needs, IT has three components as depicted in Figure 1.1: application software, development platforms, and underlying infrastructure.

![Figure 1.1: Typical Components of Information Technology.](../media/IT_components.png)

_Figure 1.1: Typical Components of Information Technology._

Traditionally, an organization that needs to deploy a particular IT solution has to procure, set up, and maintain the infrastructure and the application. Some organizations may decide to develop their own software, in which case they need to manage development platforms as well. The organization hence \"owns\" the solution, which allows full control over the solution, including, for example, access security and customization. However, ownership has some drawbacks:

1. Organizations must pay up-front to buy a particular solution, which commits significant capital for long-lived IT resources.
1. Organizations are solely responsible for managing their IT solutions. Organizations must have hardware-maintenance contracts in place or maintain and upgrade the hardware themselves. System administrators must be hired to monitor hardware and software, both of which have to be updated and maintained. Organizations also have to pay for power and cooling to keep the hardware running. Therefore, in addition to up-front costs, organizations must budget for recurring costs.
1. The IT solution typically has a fixed size -- for example, a specified number of servers -- and must be scaled as demand changes. For example, as the number of employees or customers grows, the organization must purchase additional hardware and/or software to keep up with increasing demand.
1. Typically, on-premises IT systems suffer from low average *utilization*, which refers to the proportion of time (expressed usually as a percentage) that an IT system is being used to capacity. For example, email services in a large organization typically see a spike in traffic each morning, when people sign in and check email. Utilization tapers off towards close of business and is substantially lower after hours. Further, since IT systems consume energy, even at idle, they leave a substantial carbon footprint.

Many of the disadvantages listed above emanate from the ownership of IT. However, with the evolution of computing technology, it is no longer necessary for organizations to own IT systems. Many of the IT needs of organizations can be provided to them as *services*. **Cloud computing is the transformation of owned IT products into services that can be leased from a *cloud service provider* (CSP) such as Amazon, Alibaba, Microsoft, or Google**.

The transformation of a certain technology from a product to a service is not new. A similar transformation evolved for electricity, which initially had to be produced near the device or service requiring it. The development of large power plants, electric transmission systems, and grids has led to the rise of electric power as a utility -- a service that people can obtain and pay for as needed.

In cloud computing, users or organizations use computing resources as a service and pay for them as a utility using a pay-as-you-go model. When a request is made for computing resources, the cloud provider typically provisions these resources and does so relatively quickly. (A virtual machine can be created in minutes, whereas procuring a physical server and deploying it to an on-premises data center can require weeks.) As the demand for these resources changes, users or organizations that utilize the cloud can rapidly scale up or down their resources on demand.

The cloud model offers users and organizations several benefits, including:

- Reduced up-front cost, as IT services can be obtained in a pay-as-you-go model
- The convenience of fast resource provisioning, which significantly reduces the time to market for IT solutions
- Rapid scalability of computing resources, as they can be scaled up and down on demand.

Cloud providers\' resources are shared by multiple users, thereby improving utilization and reducing carbon footprint.

Despite all of its advantages, cloud computing is a rapidly evolving technology that comes with its own challenges that must be understood and assessed before moving to the cloud. For example, deploying complex applications to the cloud invariably requires apps to be adapted to use features and services offered by the host cloud provider. Vendor lock-in becomes a real risk because an application built to run in one vendor's public cloud typically requires modification to run in someone else's cloud. Specific benefits, risks, and challenges are discussed later in this module.
