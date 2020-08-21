The objective of **defense in depth** is to protect and prevent information from being stolen by individuals not authorized to access it. A defense in depth strategy uses a series of mechanisms to slow the advance of an attack aimed at acquiring unauthorized access to data. 

<div style="background:yellow;">
TODO: 
1. Overall the wording of this unit is complex. I've taken one pass at re-writing to soften some of the language.
2. Is the CIA content below needed for the exam? If not - remove. If so, I would move this to the top OR bottom. It's breaking the flow between the Defence in depth paras.  
</div>

Your **security posture** is your organization's ability to protect from and respond to security threats. The common principles used to define a security posture are **confidentiality**, **integrity**, and **availability**, known collectively as CIA.

+ **Confidentiality** - The *principle of least privilege* means restricting access to information only to individuals explicitly granted access, at only the level they need to perform their work. This information includes protection of user passwords, email content, and access levels to applications and underlying infrastructure. 
+ **Integrity** - The prevention of unauthorized changes to information at rest (when it is stored) or in transit (when it is being transferred from one place to another, including from a local computer to the cloud). A common approach used in data transmission is for the sender to create a unique fingerprint of the data using a one-way hashing algorithm. The hash is sent to the receiver along with the data. The data's hash is recalculated and compared to the original by the receiver to ensure the data wasn't lost or modified in transit.
+ **Availability** - Ensure services are functioning and are able to be accessed by authorized users. *Denial of service attacks* are specifically designed to degrade the availability of a system, impacting its users.

Defense in depth can be visualized as a set of layers, with the Data to be secured at the center. Each layer provides protection so that if one layer is breached, a subsequent layer is already in place to prevent further exposure. This approach removes reliance on any single layer of protection and acts to slow down an attack and provide alert telemetry that can be acted upon, either automatically or manually.

:::image type="content" source="../media/defense-depth.png" alt-text="Defense in depth layers: Data, Application, Compute, Network, Perimeter, Identity & Access, and Physical Security.":::

+ **Physical security** is the first line of defense to protect computing hardware in the datacenter. 
+ **Identity & access** controls access to infrastructure and change control. 
+ **Perimeter** layer uses distributed denial-of-service (DDoS) protection to filter large-scale attacks before they can cause a denial of service for end users.
+ **Networking** layer limits communication between resources through segmentation and access controls.
+ **Compute** layer secures access to virtual machines.
+ **Application** layer ensures applications are secure and free of vulnerabilities.


The *defense in depth* rings provide a guideline for you to help make security configuration decisions in all of the layers of applications. 


---

:::row:::
  :::column:::
    ![Image representing data](../media/2-data.png)
  :::column-end:::
  :::column span="3":::  
**Data**

In almost all cases, attackers are after data:

- Stored in a database
- Stored on disk inside virtual machines
- Stored in a Software-as-a-Service application, such as Office 365
- Stored in cloud storage

It's the responsibility of those storing and controlling access to data to ensure that it's properly secured. Often, there are regulatory requirements that dictate the controls and processes that must be in place to ensure the confidentiality, integrity, and availability of the data.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![Image of a file on the network](../media/2-application.png)
  :::column-end:::
  :::column span="3":::  
**Application**

- Ensure applications are secure and free of vulnerabilities.
- Store sensitive application secrets in a secure storage medium.
- Make security a design requirement for all application development.

Integrating security into the application development life cycle will help reduce the number of vulnerabilities introduced in code. We encourage all development teams to ensure their applications are secure by default, and that they're making security requirements non-negotiable.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A terminal representing compute](../media/2-compute.png)
  :::column-end:::
  :::column span="3":::  
**Compute**

- Secure access to virtual machines.
- Implement endpoint protection on devices and keep systems patched and current.

Malware, unpatched systems, and improperly secured systems open your environment to attacks. The focus in this layer is on making sure your compute resources are secure, and that you have the proper controls in place to minimize security issues.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![Three connected systems representing networking](../media/2-networking.png)
  :::column-end:::
  :::column span="3":::  
**Networking**

- Limit communication between resources.
- Deny by default.
- Restrict inbound internet access and limit outbound, where appropriate.
- Implement secure connectivity to on-premises networks.

At this layer, the focus is on limiting the network connectivity across all your resources to allow only what is required. By limiting this communication, you reduce the risk of an attack spreading to other systems in your network.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A physical barrier representing the network perimeter](../media/2-perimeter.png)
  :::column-end:::
  :::column span="3":::  
**Perimeter**

- Use distributed denial of service (DDoS) protection to filter large-scale attacks before they can impact the availability of a system for end users.
- Use perimeter firewalls to identify and alert on malicious attacks against your network.

At the network perimeter, it's about protecting from network-based attacks against your resources. Identifying these attacks, eliminating their impact, and alerting you when they happen are important ways to keep your network secure.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A badge representing a secure access](../media/2-policies-access.png)
  :::column-end:::
  :::column span="3":::  
**Identity and access**

- Control access to infrastructure and change control.
- Use single sign-on and multi-factor authentication.
- Audit events and changes.

The identity and access layer is all about ensuring identities are secure, access granted is only what is needed, and log-in events and changes are logged.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A security camera representing physical security](../media/2-physical-security.png)
  :::column-end:::
  :::column span="3":::  
**Physical security**

- Physical building security and controlling access to computing hardware within the data center is the first line of defense.

With physical security, the intent is to provide physical safeguards against access to assets. These safeguards ensure that other layers can't be bypassed, and loss or theft is handled appropriately. Microsoft uses various physical security mechanisms in its cloud datacenters.
  :::column-end:::
:::row-end:::

<div style="background:yellow;">
TODO: Add closing para.
</div>
