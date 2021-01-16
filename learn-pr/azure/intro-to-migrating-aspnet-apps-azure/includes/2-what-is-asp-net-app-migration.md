Modernizing your ASP.NET application and supporting data platforms to an online environment can raise many questions, such as:

- What problem is being solved?

- Will you need to rearchitect the application?

- How much will it cost to migrate and host?

- What downtime will your application experience?

If you’ve reached the point of considering a migration to a cloud-hosted solution, it likely means that you want to take advantage of the many facets of the cloud-hosting option. Many organizations want to benefit from the performance benefits, scalability, and cost savings that a cloud-hosting solution offers.

Before beginning the migration process, you should evaluate your existing environment to better understand the requirements and considerations around factors such as security, cost, and transition downtime. Microsoft provides many tools to help evaluate your migration before you start the process.

## Azure hosting options

Microsoft currently offers three main hosting service options. You can choose from IaaS, PaaS, or SaaS. The options are distinguished by responsibility related to hardware and software. The hosting service graphic presented here highlights the key points.

:::image type="content" source="../media/2-hosting-graphic.png" alt-text="Hosting responsibilities for an on-premises model as compared to IaaS, PaaS, and SaaS.":::

### On-premises

As you might expect, the on-premises model places all the responsibility of management on the organization. You are responsible for acquiring and installing all the hardware and software. You will set up and control the networking and security for the servers and hosted applications. You are also responsible for updates, patches, and licensing.

### IaaS

You can choose to offload some of the responsibilities to a hosting provider by using the IaaS model. You’re still responsible for managing the applications, any runtimes, security, and the data on your database systems. In this model, you’re renting the IT infrastructure. This model makes use of virtual machines (VMs) to contain the operating system (OS), software, and data. You’re still responsible for supplying and maintaining the OS, applications, and data. You also install patches and updates to the OS.

VMs are an emulation of a computer system's hardware and OS environment. For example, you can create a VM on Azure by specifying a hardware configuration and an OS to install. After the configuration is complete and the VM has been deployed and started, you can sign in to that VM and interact with it in the same manner as a physical computer. You install software and configure the aspects of the OS as needed. By using VMs, you can host various operating systems and versions to meet your needs for compatibility or any other reason. Azure supports VMs that host Windows and Linux operating systems.

You might have to choose this model if your application uses proprietary software that's not provided in the PaaS service. By using IaaS, you could use an on-premises VM that has the software configuration for your application. You can take a snapshot of the virtual machine and "rehost" it, or move it, to the cloud.

You might have to choose IaaS for various reasons. Three of the more common reasons are:

- Security. Your company might have to comply with specific security practices and policies pertaining to data.
- Control. Your company might want more control over the environment for software and OS configurations.
- Policies. Your company might have other policies that restrict hosting options, or you might have vendor or other technology "lock-in" objections.  With a VM, you can move your VM disk (.vhd file) over to another cloud provider or back to on-premises if the need arises.

### PaaS

Though the IaaS option is often the quickest and easiest method to move an application to a cloud-hosted environment, PaaS offers more benefits. By using PaaS, you offload the responsibility of maintaining system software, OS, hardware, and more to the hosting provider. You are responsible for your applications. PaaS provides the database server for your data that supports the applications.

In the scenario for this module, your application is the ASP.NET app and the data that resides in the on-premises SQL Server database. You’ll migrate the data to a SQL Azure database instance. The hosting provider will manage the SQL Azure database and the security for it.

In this module, you’ll evaluate different aspects of migrating an ASP.NET app and a SQL Server database to an IaaS solution. This will involve considerations around using the Azure App Service for the ASP.NET application and Azure SQL Database for hosting the current on-premises SQL Server data. This might require refactoring of the app or rebuilding it.

### SaaS

The SaaS option isn't relevant for this module scenario. Consider SaaS solutions such as Office 365 or Microsoft Dynamics 365, where you’re essentially "renting" software. To use SaaS, you’re replacing your existing application. If your application is a custom app, then it’s unlikely that SaaS will be an option for you.
