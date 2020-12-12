Modernizing your ASP.NET application and supporting data platforms to an online environment, can raise many questions. What problem is being solved? Will you need to rearchitect the application? How much will it cost to migrate and host? What downtime will my application experience?

If you have reached the point of considering a migration to a cloud-hosted solution, it likely means you are interested in taking advantage of the many facets of the cloud hosting option. Many organizations want to take advantage of performance benefits, scalability, and cost savings offered by a cloud-hosting solution.

Before beginning the migration process, you should evaluate your existing environment to better understand the requirements and considerations around security, cost, transition down time, etc.  Microsoft provides many tools to help evaluate your migration before you start the process.

## Azure Hosting Options

Microsoft currently offers three main hosting service options. You can choose from Infrastructure as a Service (IaaS), Platform as a Service (PaaS), or Software as a Service (SaaS). The options are distinguished by responsibility related to hardware and software. The hosting service graphic presented here highlights the key points.

:::image type="content" source="../media/hosting-graphic.png" alt-text="Hosting responsibilities across the three hosting options":::

### On-Premises

As you might expect, the on-premises model places all the responsibility of management on the organization. You are responsible for acquiring and installing all hardware and software. You will set up and control the networking and security for the servers and hosted applications, and you are responsible for updates, patches, and licensing.

### Infrastructure as a Service (IaaS)

You can choose to offload some of the responsibilities to a hosting provider using the Infrastructure as a Service model. You are still responsible for managing the applications, any runtimes, security, and the data on your database systems. In this model, you are renting the IT infrastructure. This model makes use of virtual machines (VMs) to contain the operating system (OS), software, and data. You are still responsible for supplying and maintaining the OS, applications, and data. You also install patches and updates to the OS.

Virtual machines are essentially an emulation of a computer system's hardware and operating system environment. For example, you can create a VM on Microsoft Azure by specifying a hardware configuration and an operating system to install.  Once the configuration is complete and the VM has been started, you can log into that VM and interact with it in the same manner as a physical computer. You install software and configure the aspects of the OS as needed.  Using VMs, you can host various operating systems and versions to meet your needs for compatibility or any other reason. Microsoft Azure supports VMs that host Windows and Linux operating systems.

### Platform as a Service (PaaS)

WHile the IaaS option is often the quickest and easiest method to move an application to a cloud-hosted environment, PaaS offers more benefits. Using the Platform as a Service option, you offload the responsibility of maintaining system software, OS, hardware, etc., to the hosting provider. You are responsible for your application(s). PaaS provides the database server for your data that supports the applications.  In the scenario for this module, your application is the ASP.NET app and the data that resides in the on-premises SQL Server database.  You will migrate the data to a SQL Azure database instance. The hosting provider will manage the SQL Azure database and the security for it.

### Software as a Service (SaaS)

The SaaS option isn't relevant for the module scenario. Consider SaaS solutions like Office 365 or Microsoft Dynamics 365. In this hosting option, you are essentially "renting" software.
