Cloud computing resources are delivered using three different service models.

- **Infrastructure-as-a-service (IaaS)** provides instant computing infrastructure that you can provision and managed over the Internet.
- **Platform as a service (PaaS)** provides ready-made development and deployment environments that you can use to deliver your own cloud services.
- **Software as a service (SaaS)** delivers applications over the Internet as a web-based service.

When choosing a service model, consider which party should be responsible for the computing resource. Based on your scenario, you can decide how much shared management responsibility you want.

![Shared responsibility model](../media/3-shared-responsibility.png)

## IaaS

Infrastructure as a service is an instant computing infrastructure, provisioned and managed over the Internet. IaaS enables you to quickly scale resources to meet demand and only pay for what you use. IaaS avoids the expense and complexity of buying and managing your own physical servers and other datacenter infrastructure. Each resource is offered as a separate service component, and you *rent* the resource as long as you need it. As a result, IaaS is very flexible. You can provision common infrastructure such as VMs, storage, virtual subnets, firewalls, and VPN's to build a solution. You don't need to manage physical servers and appliances. However, you are responsible for direct management configuring and managing the components. For example, configuring firewalls, updating VM OS's, updating DBMS's, and runtimes.

### Common scenarios 

Let's imagine your healthcare company has a need to run a special version of desktop software. The software is only supported on a specific version of an operating system and only one user and license is required. You can create a virtual machine with the required software. The user can use remote deskop to connect to the virtual machine to use the software.

Let's imagine another scenario. Your development teams need several unique development environments. Through the development cycle, they need to test various versions of the product. The developers can provision environments when needed. When an environment is no longer needed, it can be easily deleted.

Some other common scenarios include:

**Website hosting:** If you want more control of hosting a website, running websites using IaaS may be a better option than traditional web hosting.

**Web apps:** IaaS provides all the infrastructure to support web apps, including storage, web and application servers, and networking resources. Organizations can quickly deploy web apps on IaaS and easily scale infrastructure up and down when demand for the apps is unpredictable.

**Storage, backup, and recovery:** Storage management can be complex requiring a large capital investment and skilled staff to manage data and meet legal and compliance requirements. IaaS can help simplify planning, managment, unpredictable demand, and steadily growing storage needs.

**High-performance computing:** If you have a workload that requires high-performance computing, you can run the workload in the cloud avoiding the up-front cost of the hardware and only pay for the usage when needed. 

**Big data analysis:** If you have large data sets that contain potentially valuable patterns, trends, and associations, IaaS can provide the processing power to mine data sets to locate patterns.

### Advantages

**Eliminates capital expense and reduces ongoing cost:** IaaS sidesteps the upfront expense of setting up and managing an on-site datacenter, making it an economical option for start-ups and businesses testing new ideas. As soon as you’ve decided to launch a new product or initiative, the necessary computing infrastructure can be ready in minutes or hours, rather than the days or weeks—and sometimes months—it could take to set up internally.

**Improves business continuity and disaster recovery:** Achieving high availability, business continuity, and disaster recovery is expensive, since it requires a significant amount of technology and staff. But with the right service level agreement (SLA) in place, IaaS can reduce this cost and access applications and data as usual during a disaster or outage.

**Respond quicker to shifting business conditions:** IaaS enables you to quickly scale up resources to accommodate spikes in demand for your application— during the holidays, for example—then scale resources back down again when activity decreases to save money. Because you don’t need to first set up the infrastructure before you can develop and deliver apps, you can get them to users faster with IaaS.

**Increase stability, reliability, and supportability:** With IaaS there’s no need to maintain and upgrade software and hardware or troubleshoot equipment problems. With the appropriate agreement in place, the service provider assures that your infrastructure is reliable and meets SLAs.

## PaaS

Platform as a service is a complete development and deployment environment in the cloud. With PaaS, you can to build and deploy everything from simple cloud-based apps to sophisticated, cloud-enabled enterprise applications. You purchase the resources from a cloud service provider on a pay-as-you-go basis and access them over a secure Internet connection. Like IaaS, PaaS includes infrastructure such as servers, storage, and networking. In addition, it also includes middleware, development tools, and other services. PaaS supports the complete web application lifecycle: building, testing, deploying, managing, and updating. PaaS removes the need to manage software licenses, middleware, and infrastructure of the services. You manage the applications and services you develop, and the cloud service provider typically manages everything else.

### Common scenarios

Let's imagine your healthcare company needs a website to describe a product. Your developers want to use PHP. Using PaaS, your developers have the option to *create a web app*. The infrastructure details such as creating a virtual machine, installing a web server, and installing middleware are abstracted away. You don't need to care what operating system it runs on or what physical hardware is required. Your developers deploy the website files to the cloud and your website is available on the Interenet.

Let's imagine another scenario. Your company needs a SQL database to support data analysts for a special project. You don't have infrastructure to accomodate the request. You can quickly provision a SQL Server in the cloud that meets the need of the project. The data analyts can connect to the server or. The SQL Server database is provided as a service. Therefore, you don't worry about updates, security patches, or optimizing physical storage for reads and writes.

Some other common scenarios include:

**Development framework:** PaaS provides a framework that developers can build upon to develop or customize cloud-based applications. Similar to the way you create an Excel macro, PaaS lets developers create applications using built-in software components. Cloud features such as scalability, high-availability, and multi-tenant capability are included, reducing the amount of coding that developers must do.

**Analytics or business intelligence:** Analysis tools provided as a service allow you to analyze and mine data. Organizations can find insights and patterns to predict outcomes to improve forecasting, product design decisions, investment returns, and other business decisions.

### Advantages

By delivering infrastructure as a service, PaaS has similar advantages as IaaS. But its additional features including middleware, development tools, and other business tools provide additional advantages:

**Reduced development time:** PaaS development tools can reduce development time for new applications. Developers can use pre-coded application components built into the platform, such as workflow, directory services, security features, and search. Platform as a service components can give your development team new capabilities without you needing to add staff having the required skills.

**Develop for multiple platforms:** Some service providers give you development options for multiple platforms, such as desktop, mobile devices, and browsers making cross-platform apps quicker and easier to develop.

**Use sophisticated tools affordably:** A pay-as-you-go model makes it possible for individuals or organizations to use sophisticated development software and business intelligence and analytics tools that they could not afford to purchase outright.

**Support geographically distributed development teams:** Because the development environment is accessed over the Internet, development teams can work together on projects even when team members are in remote locations.

**Efficiently manage the application lifecycle:** PaaS provides all of the capabilities that you need to support the complete web application lifecycle: building, testing, deploying, managing, and updating within the same integrated environment.

## SaaS

Software as a service allows users to connect to and use cloud-based apps over the Internet. Common examples are email, calendaring, and office tools such as Microsoft Office 365. SaaS provides a complete software solution that you purchase on a pay-as-you-go basis from a cloud service provider. You *rent* the use of an application for your organization. Your users connect to the service over the Internet, usually with a web browser. All of the underlying infrastructure, middleware, app software, and app data are located in the service provider’s data center. The service provider manages the hardware and software, and with the appropriate service agreement, will ensure the availability and the security of the app and your data as well. SaaS allows your organization to get quickly up and running with an app at minimal upfront cost.

If you’ve used a web-based email service such as Outlook, Hotmail, or Yahoo! Mail, then you’ve already used a form of SaaS. With these services, you log into your account over the Internet, often from a web browser. The email software is located on the service provider’s network, and your messages are stored there as well. You can access your email and stored messages from a web browser on any computer or Internet-connected device.

### Common scenarios

Let's imagine your healthcare company requires a customer relationship management (CRM) solution for its sales team. The team is global. You can use a SaaS CRM provider to quickly implement a solution to your organization's sales team.

For organizational use, you can rent productivity apps, such as email, collaboration, and calendaring; and sophisticated business applications such as customer relationship management (CRM), enterprise resource planning (ERP), and document management. You pay for the use of these apps by subscription or according to the level of use.

### Advantages

**Gain access to sophisticated applications:** To provide SaaS apps to users, you don’t need to purchase, install, update, or maintain any hardware, middleware, or software. SaaS makes even sophisticated enterprise applications, such as ERP and CRM, affordable for organizations that lack the resources to buy, deploy, and manage the required infrastructure and software themselves.
Pay only for what you use. You also save money because the SaaS service automatically scales up and down according to the level of usage.

**Use free client software:** Users can run most SaaS apps directly from their web browser without needing to download and install any software. You don't need to purchase or deploy client software for your users.

**Mobilize your workforce easily:** Users can access SaaS apps and data from any Internet-connected computer or mobile device. The service provider focuses on the delivery of the service to devices.

**Access app data from anywhere:** With data stored in the cloud, users can access their information from any Internet-connected computer or mobile device. And when app data is stored in the cloud, no data is lost if a user’s computer or device fails.