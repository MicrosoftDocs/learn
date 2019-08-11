<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u01_intro\_u01_m01_intro\x-oli-workbook_page\_u01_m01_1_intro.xml -->

## Cloud Computing

Cloud computing offers the use of computing resources as a service over the network. A cloud computer is simply a large distributed computing infrastructure that users have access to over a network. Similar to some other domains, cloud computing came about through the maturity of enabling technologies while attempting to satisfy economic needs. In this course, we will provide an introduction to cloud computing and then cover relevant topics, in varying detail, including hardware and software infrastructure, resource management (virtualization), cloud storage, and programming models.

In the first unit of this course we will start with a simple overview of cloud computing, its definition, motivations, evolutions, building blocks, service models and use cases. We will also discuss economics, risks, benefits and security.

## What is Cloud Computing?

> [!div class="alert is-tip"]
> ### Cloud Computing
>
> _(definition)_ The delivery of computing as a service over a network, whereby distributed resources are provided to the end user as a utility.

Information technology (IT) has become an essential requirement for most organizations to function effectively. Typically, and depending on a specific organization’s needs, IT has three components associated with it (Figure 1.1) - application software, development platforms and the underlying infrastructure:

![Figure 1.1: Typical Components of Information Technology.](../media/IT_components.png)

_Figure 1.1: Typical Components of Information Technology._

Traditionally, an organization that needs to deploy a particular IT solution has to procure, setup and maintain the infrastructure and the application; certain organizations may decide to develop their own software, in which case they need to manage development platforms as well. The organization hence "owns" the solution, which allows full control over the solution, including, for example, access security and customization, however, it has some drawbacks:

1. Organizations must pay upfront to buy a particular solution, which commits significant capital for long-lived IT resources.
1. Organizations are solely responsible for the management of their IT solutions. Organizations must have hardware maintenance contracts for the acquired IT solutions. System administrators will have to be hired to monitor hardware and software which has to be updated and maintained. Organizations also have to pay for power and cooling to keep the hardware running. Therefore, in addition to upfront costs, organizations have to budget for recurring costs.
1. The IT solution typically has a fixed size and will have to be modified to scale when the needs grow or shrink. (For example, as the number of employees grows, the organization will have to purchase additional hardware and/or software to keep up with increasing demands).
1. Typically IT systems suffer from low average **utilization**. Utilization refers to the proportion of time (expressed usually as a percentage) that an IT system is being used to capacity. For example, email services in a large organization typically see the most amount of traffic at 8 am, when people sign in and check email. Utilization tapers off towards close of business and is practically nil after hours. Further, since IT systems consume energy, even at idle, they leave a prominent carbon footprint.

Many of the disadvantages listed above emanate from the ownership of IT. However, with the evolution of computing technology, it is no longer necessary for organizations to own IT systems. Many of the IT needs of organizations can be provided to them as **services**. Cloud computing is the transformation of owned IT products into services that can be leased from a **cloud service provider**.

The transformation of a certain technology from a product to a service is not new. A similar transformation evolved for electricity, which initially had to be produced near the device or service requiring it. The development of large power plants, electric transmission systems and grids has led to the rise of electric power as a **utility**, (a service that people can obtain and pay for as needed).

The following video (Video 1.1) discusses the transformation of IT from a product to a service:

> [!VIDEO <https://youtube.com/embed/HaVqHgg7zv4>]

_Video 1.1: Introduction to Cloud Computing._ ([Alternative version](../media/video_1_intro.pdf))

In cloud computing, users or organizations use computing resources as a service and pay for them as a utility, in a pay-as-you-go model. When a request is made for computing resources, the cloud provider typically **provisions** these resources, in a rapid manner (minutes or hours). As the need for these resources changes, users or organizations can rapidly scale up or down their resources on demand.

The cloud model offers users and organizations several benefits, including: reduced upfront cost, as IT services can be obtained in a pay-as-you-go model; the convenience of fast resource provisioning, which significantly reduces the time to market for IT solutions; and rapid scalability of computing resources, as they can be scaled up and down on demand. Cloud providers' resources are shared by multiple users, thereby improving utilization and reducing carbon footprint.

In spite of all of its advantages, cloud computing is an emerging technology and comes with many risks and challenges which will be later covered in this unit.
