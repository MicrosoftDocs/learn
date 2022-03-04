A denial of service attack (DoS) is an attack that has the goal of preventing access to services or systems. If the attack originates from one location, it is called a DoS. If the attack originates from multiple networks and systems, it is called distributed denial of service (DDoS).

Before learning more about DDoS, you need to know what botnets are. Botnets are collections of internet-connected systems that an individual controls and uses without their owners’ knowledge. Botnet owners use them to perform various actions of their choosing.

Often, they use them for spamming, data storage, DDoS, or various other actions that are up to the person in control of the botnet. In the past, botnets were made up just of compromised computers, but now, botnets are also made up of Internet of Things (IoT) devices. Malicious hackers can get these poorly secured security cameras, digital video recorders, thermostats, and other internet-connected devices under their control.

So, DDoS is a collection of attack types aimed at disrupting the availability of a target. These attacks involve a coordinated effort that uses multiple internet-connected systems to launch many network requests against DNS, web services, email, and more. Pretty much any application that the malicious hacker can access might become the target of a DDoS. The malicious hacker’s goal is to overwhelm system resources on targeted servers so they can no longer process legitimate traffic, effectively making the system inaccessible.

A DDoS generally involves many systems sending traffic to targets as part of a botnet. In most cases, the owners of the systems in a botnet don’t know that their devices are compromised and participating in an attack. Botnets are becoming a bigger problem than before because of the increasing numbers of connected devices.

Designing and building for DDoS resiliency requires planning and designing for a variety of failure modes. The following table lists the best practices for building DDoS-resilient services in Azure.

### Best practice 1

Ensure that **security is a priority throughout the entire lifecycle of an application**, from design and implementation to deployment and operations. Applications might have bugs that allow a relatively low volume of requests to use a lot of resources, resulting in a service outage.

### Solution 1

To help protect a service running in Azure, understand your application architecture, and focus on the **five pillars of software quality**. They are:

:::row:::
  :::column:::
    **Pillar**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Scalability**
  :::column-end:::
  :::column:::
    The ability of a system to handle increased load
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Availability**
  :::column-end:::
  :::column:::
    The proportion of time that a system is functional and working
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Resiliency**
  :::column-end:::
  :::column:::
    The ability of a system to recover from failures and continue to function
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Management**
  :::column-end:::
  :::column:::
    Operations processes that keep a system running in production
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Security**
  :::column-end:::
  :::column:::
    Protecting applications and data from threats
  :::column-end:::
:::row-end:::


You should know typical traffic volumes, the connectivity model between the application and other applications, and the service endpoints that are exposed to the public internet.

‎Helping ensure that an application is resilient enough to handle a DoS targeted at the application itself is most important. Security and privacy features are built in to the Azure platform, beginning with the Microsoft Security Development Lifecycle (SDL). The SDL addresses security at every development phase and ensures that Azure is continually updated to make it even more secure. We will look at SDL later in this course.

### Best practice 2

Design your applications to scale horizontally to meet the demands of an amplified load—specifically, in the event of a DDoS. If your application depends on a single instance of a service, it creates a single point of failure. Provisioning multiple instances makes your system more resilient and more scalable.

### Solution 2

For Azure App Service, select an App Service plan that offers multiple instances.<br>For Azure Cloud Services, configure each of your roles to use multiple instances.<br>‎For Azure Virtual Machines, ensure that your VM architecture includes more than one VM and that each VM is included in an availability set. We recommend using virtual machine scale sets for autoscaling capabilities.

### Best practice 3

Layer security defenses in an application to reduce the chance of a successful attack. Implement security-enhanced designs for your applications by using the built-in capabilities of the Azure platform.

### Solution 3

Be aware that the risk of attack increases with the size, or surface area, of the application. You can reduce the surface area by using IP allowlists to close down the exposed IP address space and listening ports that aren’t needed on the load balancers (for Azure Load Balancer and Azure Application Gateway).

‎You can also use NSGs to reduce the attack surface. You can use service tags and application security groups as a natural extension of an application’s structure to minimize complexity for creating security rules and configuring network security.
