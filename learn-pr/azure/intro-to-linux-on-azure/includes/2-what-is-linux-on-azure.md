The Microsoft Azure cloud is a worldwide network of state-of-the-art datacenters and more than 200 products and cloud services designed to support a broad spectrum of business and technical scenarios. Moving to Azure enables you to minimize the burden of maintaining physical infrastructure and benefit from advanced compute services. Microsoft and third parties on Azure offer many programming languages, development frameworks, and operating-system distributions. Microsoft and its partners also offer hundreds of prebuilt solutions that can quickly add value to both new and existing workloads.

Linux is the fastest growing platform on Azure, so Linux users will find familiar tools and systems. Microsoft and its partners also offer hundreds of prebuilt solutions that can quickly add value to both new and existing workloads.

- First, choose the Linux distribution you want based on familiarity, usage, cost, and support requirements. You can bring your own distribution or find distributions in [Azure Marketplace](https://azuremarketplace.microsoft.com).

- If you bring your own Linux distribution, follow [Azure guidelines to prepare your image](/azure/virtual-machines/linux/create-upload-generic).

- Linux-based images in Azure Marketplace include base distributions and images with preinstalled software for specific scenarios. All images contain the software and configuration that's needed to ensure smooth operation on Azure VMs. This includes kernel-level driver support for Azure infrastructure like storage and networking, and Azure-supported features like remote direct memory access.

- Many of the images in Azure Marketplace are free: you pay only for the virtual infrastructure your VM consumes. Some images have other license and purchase terms for the software they include. You'll learn more about pricing and support options later in this module.

- You can also find hundreds of other Linux images for third-party developer tools, security, databases, analytics, and more.

As you think about designing a computing environment on Azure, distinguish between four general-usage models available: infrastructure as a service (IaaS), platform as a service (PaaS), database as a service (DBaaS), and software as a service (SaaS). Unit 4 describes in more depth why you might choose one of these models over the other and what the tradeoffs might be.

**IaaS**: Azure maintains the physical hardware and provisions more computing resources as needed. You, the customer, are responsible for managing the operating system, configuring other services for security, web applications, your development environment, application deployment, and monitoring.

**PaaS**: Azure maintains all aspects of the infrastructure, but allows you to control, configure, and deploy applications.

**DBaaS**: Azure automates database updates, provisioning, and backups, which let you focus on application development.

**SaaS**: Azure manages complete applications that customers subscribe to, such as Microsoft 365 and Dynamics 365. ISVs (Independent software vendors) offer a wide range of SaaS solutions on the Microsoft [AppSource](https://appsource.microsoft.com/) site.

This module focuses on IaaS, PaaS, and DBaaS options for Linux.
