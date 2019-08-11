<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u01_intro\_u01_m01_intro\x-oli-workbook_page\_u01_m01_4_service_models.xml -->

## Cloud Building Blocks

 Remember, cloud computing offers the use of computing resources as a service over the network. Before we discuss the service models offered on a cloud, we ought to think about the different layers of hardware and software the are required to build cloud services. Of course, not all service requirements are identical; some cloud users may only desire access to raw infrastructure to build applications on. Others may wish to not deal with the infrastructure at all, but rather, simply develop and deploy applications using an easy-to-use platform. To meet these varied requirements, cloud service providers divide their offerings into various abstract layers.

Here, we introduce a stacked abstraction of the cloud through presenting typical building blocks and discuss their association with three service models in cloud computing. We present four main building blocks in cloud computing: application software, development platforms, resource sharing, and infrastructure, as shown in Figure 1.6. The infrastructure includes the physical resources in a data center. The resource sharing layer typically entails software and hardware techniques that allow the sharing of the physical resources while offering a certain level of isolation. The development platforms are utilized to develop cloud applications.

![Figure 1.6: Cloud computing building blocks.](../media/cloud_computing_stack.png)

_Figure 1.6: Cloud computing building blocks._

## Cloud Building Blocks

**Application software:** The top layer in the stack is the application software, which normally is the system component that the end user utilizes.

**Development platforms:** The next layer, development platforms, allows application developers to write application software in terms of a cloud's application programming interface (API). Development platforms typically provide specifications that developers can use for routines, data structures, object classes, libraries and variables.

**Resource sharing:** Resource sharing mechanisms, the third layer, embody some key cloud ideas:

- Provide software, computation, network and storage services.
- Allow a shared environment whereby multiple hardware images (e.g., virtual machines) and system images (e.g., general-purpose OSs) can run side by side on a single infrastructure along with security, resource, and failure isolations. These isolation properties are provided by a combination of hardware and software techniques that are covered in detail in Unit 3.
- Consolidate physical servers into virtual servers that run on fewer physical servers.
- Deliver agility and elasticity to rapidly respond to users' resource and service demands.

These ideas usually are addressed through virtualization, a technology discussed in detail in Unit 3.

**Infrastructure:** Physical resources comprise the bottom layer and, in cloud computing, are primarily deployed on the cloud provider's side. The broad resource classes, detailed in Unit 2, include the following:

- Compute resources, typically servers, which are computers designed for enterprise computing (as opposed to user workstations). They usually are rack mounted to utilize space efficiently.
- Storage resources maintain the cloud's data, and application storage use usually is charged in terms of capacity usage (e.g., per gigabyte or terabyte usage).
- Network resources enable communication between servers as well as servers and clients.
- Software that manages the compute, network and storage infrastructure.

Next we will discuss which of these abstractions can be provided as a leased service over a network. For example the services and resources required by a software developer will be different compared to someone who would like to have access to a WebMail application running on the cloud.

## Cloud Computing Services

In a broad sense, cloud services differ based on the needs of different users. This section reviews three popular types of cloud services:

- Software as a service (SaaS)
- Platform as a service (PaaS)
- Infrastructure as a service (IaaS)

SaaS is any application in which the end user has access to a software application over the network and pays based on a variety of business models some of which are free. PaaS is the offering of software development platforms as a service which are utilized to develop SaaS applications. Finally, IaaS, is the leasing of virtualized infrastructure over the network. In this last model, the end user has the flexibility to install and use any software they please on the leased infrastructure.

The following video (Video 1.2) reviews these services:

> [!VIDEO <https://youtube.com/embed/ltJmJEI0gGA]>

_Video 1.2: Service Models in Cloud Computing._ ([Alternative version](../media/video_1_service_models.pdf))

### The Software-as-a-Service Model

> [!div class="alert is-tip"]
> ### Software as a Service
>
> _(definition)_ Software as a service (SaaS) is a software delivery model in which software and associated data are hosted on a cloud. SaaS applications typically are accessed by users using a thin client via a Web browser.

SaaS is one of the most common cloud service models in which the cloud provider delivers software as an Internet service (as discussed in Video 1.3). SaaS users simply use their browsers to access the software, thus eliminating the need to install, run, and maintain (update, patch, reconfigure etc.) the application on the user's computer. The Web browser loads the SaaS application service dynamically and transparently.

> [!VIDEO <https://youtube.com/embed/bzfdewWofSU]>

_Video 1.3: Software as a Service._ ([Alternative version](../media/video_2_Software_as_a_Service.pdf))

SaaS has become a common software delivery model for many business applications, including accounting, collaboration, customer relationship management (CRM), management information systems (MIS), enterprise resource planning (ERP), invoicing, human resource management (HRM), content management (CM) as well as service desk management.

With SaaS, the provider maintains the software and required infrastructure to run it. The provider routinely develops the software, and enhancements are automatically made available to all users the next time a user logs on to the service. In addition, any application data that results from the use of the service resides on the cloud and is available to the user from any location.

### Characteristics of SaaS

A vast majority of SaaS solutions are based on what is referred to as multitenant architecture. In this architecture, a single version of the application, with a single configuration, is used for every customer (referred to as a tenant). To enable the service to scale well, it might be installed on several servers at the provider's side. Dynamic scaling is utilized to allow more users to use the service as it becomes more popular.

Typical characteristics of SaaS include:

- Web-based access to the software service.
- Software is managed from a central location by the cloud provider.
- Software is delivered in a one-to-many model in which "one" is the cloud provider and "many" are the cloud users.
- The cloud provider handles software upgrades and patches.

### Pricing Models

Unlike traditional software, which is sold under the software licensing model (with an upfront license cost and an optional ongoing support fee), SaaS providers generally price applications using a monthly or annual subscription fee. This model enables SaaS to fulfill one of the main purported advantages of cloud computing - reducing the capital expenditure or the upfront cost of software. SaaS providers typically charge based on usage parameters, such as the number of users using the application.

### Use Cases for SaaS

SaaS is a good model for certain types of applications, such as:

- Applications that are fairly standardized and do not require custom solutions. E-mail is a good example of a fairly standardized application.
- Applications that have a significant need for remote/web/mobile access, such as mobile sales management software.
- Applications that have a short-term need, such as collaborative software for a particular project.
- Applications in which demand spikes significantly, such as tax or billing software that is used once a month.

However, there are situations where SaaS may not be the right choice, such as:

- Applications that require offline access to data.
- Applications that require significant customization.
- Applications in which policies or regulations disallow data from being hosted externally.
- Applications in which existing in-house solutions satisfy all of the organization's needs.

### Examples of SaaS

Web mail is one of the early examples of SaaS. Webmail enabled users with a browser and an Internet connection to access their e-mail anywhere at anytime. Offerings from Hotmail, Yahoo!, and Gmail are extremely popular. These services are based on the "freemium" model, wherein basic services are free, and more advanced features are available with a subscription. Furthermore, providers earn revenue mainly from advertisements that are displayed to the users as they use the service.

Another popular example of SaaS is online office suites, such as Google Drive and Microsoft Office 365, which allow users to create, edit, and share documents online. Google utilizes the freemium model for individual users. Microsoft has a charge model based on the features required and the number of users per month.

### The Platform-as-a-Service Model

> [!div class="alert is-tip"]
> ### Platform as a Service
>
> _(definition)_ Platform as a service (PaaS) is a computing platform that allows for the creation of Web applications in a simplified manner without the complexity of purchasing and maintaining any of the underlying software and infrastructure.

PaaS-based offerings allow users to develop, deploy, and scale applications on platforms that are offered by cloud providers (Video 1.4). PaaS is analogous to SaaS, except that, rather than software delivered over the Web, it is a platform for the creation of software that is delivered over the Web.

> [!VIDEO <https://youtube.com/embed/mxXm5s0hK8A]>

_Video 1.4: Platform-as-a-Service._ ([Alternative version](../media/video_3_Platform_as_a_Service.pdf))

### Characteristics of PaaS

PaaS offerings vary among providers but usually feature some basic functionality, which includes:

- Services to develop, test, deploy, host, and maintain applications in the same integrated development environment (IDE).
- Web-based user interface (UI) creation tools to help create, modify, and test various UI scenarios.
- Multitenant architecture in which multiple concurrent users utilize the same development tools.
- Built-in scaling mechanisms of deployed software that can be handled automatically by the cloud provider by load-balancing and failover mechanisms.

### Pricing Models

Unlike the SaaS pricing model (which is a subscription or advertisement based model), PaaS usually is priced in terms of usage of the platform. For example, Google App Engine's [charge model](https://cloud.google.com/pricing/) accounts for an application's inbound and outbound bandwidth as well as certain API requests. Consequently, the more an application developed using PaaS gets used, the more the PaaS developer gets charged.

### Use Cases for PaaS

PaaS is a good model for certain types of applications, such as:

- Rapid application development scenarios.
- Applications that require Web-based infrastructure to handle varying loads from users.
- Applications that may not need redeployment or migration to other platforms in the future.

There are certain scenarios in which PaaS may not be ideal, such as:

- When the application needs to be highly portable in terms of where it is hosted because PaaS APIs can vary from one PaaS provider to another.
- When proprietary languages or APIs could impact the development process or cause trouble in the future due to vendor lock-in.
- When application performance requires customization of the underlying hardware and software.

### Examples of PaaS

Google App Engine is an example of a PaaS. Using Google's APIs, developers can create Web and mobile applications that run on Google's infrastructure.

## The Infrastructure-as-a-Service Model

> [!div class="alert is-tip"]
> ### Infrastructure as a service
>
> _(definition)_ Infrastructure as a service (IaaS) is a cloud computing model in which cloud providers make computing resources available to clients, usually in the form of instances or virtual machines.

In the IaaS model, providers rent out compute resources in the form of instances or virtual machines, which have some form of configurable CPU, memory, disk, and network bandwidth attached to them (Video 1.5). Once provisioned, IaaS users can remotely connect to these instances and configure their choice of platforms and applications. This model offers the most amount of flexibility to the IaaS users in terms of software development and deployment. Rather than purchasing servers, software, data center space, or network equipment, users rent those resources as a fully outsourced service on demand.

> [!VIDEO <https://youtube.com/embed/sjQSV-5RaLU]>

_Video 1.5: Infrastructure-as-a-Service._ ([Alternative version](../media/video_4_Infrastructure_as_a_Service.pdf))

## Characteristics of IaaS

IaaS has the following characteristics:

- Computing resources are provided to IaaS users as a service.
- IaaS providers provide tools that enable IaaS users to configure the dynamic scaling of resources.
- IaaS providers usually have different resource offerings at different costs and follow a utility pricing model (typically calculated hourly).
- The same physical resources are shared among multiple users.

## Pricing Models

Unlike the SaaS pricing model (which is a subscription- or advertisement-based model) or the PaaS model (which usually is priced in terms of number of transactions or bandwidth or storage used), IaaS usually is priced on an hourly basis, per instance. For example, Amazon Elastic Compute Cloud (EC2) offers a spectrum of compute resources as virtualized OS instances, which vary in compute, memory, storage, and bandwidth. At the time of writing, the Amazon EC2 t2.micro instance costs about 1.3 cents an hour when provisioned at Amazon's Northern Virginia data center.

Cloud providers can also choose to bill on a prorated or non-prorated basis. On a prorated basis, each partial hour is billed partially, while on a non-prorated basis, each partial hour is billed as a full hour. This difference becomes significant when IaaS users need a large number of instances for a short period of time for burst processing. Amazon EC2 instances are billed on a non-prorated basis.

## Use Cases for IaaS

IaaS makes sense in a number of situations:

- When demand for computing resources is volatile. For example, e-commerce sites experience the most demand during holiday seasons.
- For new organizations that do not have the capital to invest in infrastructure on site.
- When organizations need to grow their IT resources rapidly, such as Internet startup companies.
- For temporary projects or temporary infrastructural needs (when organizations require a large amount of compute power for a limited amount of time).

IaaS may not be the best option when:

- Regulatory compliance does not allow data to be offshored or outsourced.
- When applications have strict quality-of-service (QoS) requirements.
- When organizations have existing in-house customized infrastructure to meet their IT needs.

## Examples of IaaS

Amazon Web Services (AWS), Microsoft Azure and Rackspace are cloud service providers that offer IaaS products. Specifically, AWS's Elastic Compute Cloud (EC2) is one of the first commercially successful IaaS products. AWS EC2 rents out instances from various data center locations scattered around the world. Users can choose from various instance types, from a low-memory, single CPU (which costs about several cents an hour), all the way up to multicore, high-performance, GPU-accelerated instances (which can cost up to several US dollars an hour).
