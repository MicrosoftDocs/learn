Organizations face many challenges with securing their data centers, including recruiting and keeping security experts, using many security tools, and keeping pace with the volume and complexity of threats.

As computing environments move from customer-controlled data centers to the cloud, the responsibility of security also shifts. Security of the operational environment is now a concern shared by both cloud providers and customers. By shifting these responsibilities to a cloud service like Azure, organizations can reduce the focus on activities that aren't core business competencies. Depending on the specific technology choices, some security protections will be built into the particular service, while addressing others will remain the customer's responsibility. To ensure that the proper security controls are provided, a careful evaluation of the services and technology choices becomes necessary.

:::image type="complex" source="../media/2-cloud-security.png" alt-text="Diagram depicting the advantages of using cloud technology for security.":::
    Diagram titled Security Advantages of Cloud Era. Showing two grids of boxes, one titled traditional approach, one titled cloud-enabled security, where boxes are shaded representing satisfied responsibility, unmet responsibility, partially met responsibility, and Cloud Provider responsibility. The traditional approach has these boxes scattered while the cloud-enabled security grid has them consolidated with several enabling factors: shift commodity responsibilities to provider and re-allocate your resources, leverage cloud-based security capabilities for more effectiveness, and use cloud intelligence to improve detection/response time.
:::image-end:::

#### Understand security threats

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWkotg]

## Security is a shared responsibility

The first shift you'll make is from on-premises data centers to infrastructure as a service (IaaS). With IaaS, you are leveraging the lowest-level service and asking Azure to create virtual machines (VMs) and virtual networks. At this level, it's still your responsibility to patch and secure your operating systems and software, as well as configure your network to be secure. At Contoso Shipping, you are taking advantage of IaaS when you start using Azure VMs instead of your on-premises physical servers. In addition to the operational advantages, you receive the security advantage of having outsourced concern over protecting the physical parts of the network.

Moving to the platform as a service (PaaS) outsources several security concerns. At this level, Azure is taking care of the operating system and of most foundational software like database management systems. Everything is updated with the latest security patches and can be integrated with Azure Active Directory for access controls. PaaS also comes with many operational advantages. Rather than building whole infrastructures and subnets for your environments by hand, you can "point and click" within the Azure portal or run automated scripts to bring complex, secured systems up and down and scale them as needed. Contoso Shipping uses Azure Event Hubs for ingesting telemetry data from drones and trucks as well as a web app with an Azure Cosmos DB back end with its mobile apps which are all examples of PaaS.

With software as a service (SaaS), you outsource almost everything. SaaS is software that runs with an internet infrastructure. The code is controlled by the vendor but configured to be used by the customer. Like so many companies, Contoso Shipping uses Microsoft 365 (formerly Office 365), which is a great example of SaaS!

:::image type="complex" source="../media/2-shared_responsibilities.png" alt-text="Illustration showing how cloud providers and customers share security responsibilities under different types of compute service implementation: on-premises, infrastructure as a service, platform as a service, and software as a service.":::
    Responsibilities shift from customer to Microsoft moving from on-prem to IaaS to PaaS to SaaS. In on-prem, all boxes are customer. In IaaS, physical hosts, network, and datacenter are now Microsoft. In PaaS, additional responsibility moves to or becomes shared by Microsoft: operating system is entirely Microsoft; network controls, application, and identity & directory infrastructure are shared responsibility. In SaaS, network controls and application become entirely the responsibility of Microsoft.
:::image-end:::

For all cloud deployment types, you own your data and identities. You are responsible for helping secure your data and identities, your on-premises resources, and the cloud components you control (which vary by service type).

Regardless of the deployment type, you always retain responsibility for the following items:

- Data
- Endpoints
- Accounts
- Access management

#### Azure security: you versus the cloud

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEvj]

## A layered approach to security

*Defense in depth* is a strategy that employs a series of mechanisms to slow the advance of an attack aimed at acquiring unauthorized access to information. Each layer provides protection so that if one layer is breached, a subsequent layer is already in place to prevent further exposure. Microsoft applies a layered approach to security, both in physical data centers and across Azure services. The objective of defense in depth is to protect and prevent information from being stolen by individuals who are not authorized to access it.

Defense in depth can be visualized as a set of concentric rings, with the data to be secured at the center. Each ring adds an additional layer of security around the data. This approach removes reliance on any single layer of protection and acts to slow down an attack and provide alert telemetry that can be acted upon, either automatically or manually. Let's take a look at each of the layers.

:::image type="content" source="../media/defense_in_depth_layers_small.png" alt-text="Illustration showing Defense in depth with Data at the center. The rings of security encompassing data are: application, compute, network, perimeter, identity and access, and physical security.":::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-data.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Data**

In almost all cases, attackers are after data:

- Stored in a database
- Stored on disk inside virtual machines
- Stored on a SaaS application such as Microsoft 365
- Stored in cloud storage

It's the responsibility of those storing and controlling access to data to ensure that it's properly secured. Often, there are regulatory requirements that dictate the controls and processes that must be in place to ensure the confidentiality, integrity, and availability of the data.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-application.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Application**

- Ensure applications are secure and free of vulnerabilities.
- Store sensitive application secrets in a secure storage medium.
- Make security a design requirement for all application development.

Integrating security into the application development life cycle will help reduce the number of vulnerabilities introduced in code. We encourage all development teams to ensure their applications are secure by default and that they're making security requirements non-negotiable.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-compute.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Compute**

- Secure access to virtual machines.
- Implement endpoint protection and keep systems patched and current.

Malware, unpatched systems, and improperly secured systems open your environment to attacks. The focus in this layer is on making sure your compute resources are secure and that you have the proper controls in place to minimize security issues.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-networking.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Networking**

- Limit communication between resources.
- Deny by default.
- Restrict inbound internet access and limit outbound, where appropriate.
- Implement secure connectivity to on-premises networks.

At this layer, the focus is on limiting the network connectivity across all your resources to allow only what is required. By limiting this communication, you reduce the risk of lateral movement throughout your network.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-perimeter.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Perimeter**

- Use distributed denial of service (DDoS) protection to filter large-scale attacks before they can cause a denial of service for end-users.
- Use perimeter firewalls to identify and alert on malicious attacks against your network.

At the network perimeter, it's about protecting from network-based attacks against your resources. Identifying these attacks, eliminating their impact, and alerting you when they happen are essential ways to keep your network secure.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-policies-and-access.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Identity and access**

- Control access to infrastructure and change control.
- Use single sign-on and multi-factor authentication.
- Audit events and changes.

The identity and access layer are all about ensuring identities are secure, access granted is only what is needed, and changes are logged.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/2-physical-security.png" border="false":::
  :::column-end:::
  :::column span="3":::  
**Physical security**

- Physical building security and controlling access to computing hardware within the data center is the first line of defense.

With physical security, the intent is to provide physical safeguards against access to assets. These safeguards ensure that other layers can't be bypassed, and loss or theft is handled appropriately.
  :::column-end:::
:::row-end:::

Azure helps alleviate your security concerns. But security is still a **shared responsibility**. How much of that responsibility falls on us depends on which model we use with Azure. We use the *defense in depth* rings as a guideline for considering what protections are adequate for our data and environments.
