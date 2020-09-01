Tailwind Traders currently runs their workloads on-premises, in their datacenter. Running on-premises means that they're responsible for all aspects of security - from physical access to buildings all the way down to how data travels in and out of the network. They want to know how their current defense in depth strategy compares to running in the cloud.

The objective of *defense in depth* is to protect information and prevent it from being stolen by those who aren't authorized to access it.

A defense in depth strategy uses a series of mechanisms to slow the advance of an attack that aims at acquiring unauthorized access to data.

You can visualize defense in depth as a set of layers, with the data to be secured at the center.

:::image type="content" source="../media/2-defense-depth.png" alt-text="A diagram showing each defense in depth layer. From the center, these layers are: Data, Application, Compute, Network, Perimeter, Identity & Access, and Physical Security." border="false":::

Each layer provides protection so that if one layer is breached, a subsequent layer is already in place to prevent further exposure. This approach removes reliance on any single layer of protection. It slows down an attack and provides alert telemetry that security teams can act upon, either automatically or manually.

Here's a brief overview of the role of each layer:

+ The **Physical Security** layer is the first line of defense to protect computing hardware in the datacenter.
+ The **Identity & Access** layer controls access to infrastructure and change control.
+ The **Perimeter** layer uses distributed denial-of-service (DDoS) protection to filter large-scale attacks before they can cause a denial of service for end users.
+ The **Networking** layer limits communication between resources through segmentation and access controls.
+ The **Compute** layer secures access to virtual machines.
+ The **Application** layer ensures that applications are secure and free of security vulnerabilities.

These defense in depth layers provide a guideline for you to help make security configuration decisions in all of the layers of your applications.

Let's take a closer look at each layer:

:::row:::
  :::column:::
    ![Image representing data](../media/2-data.png)
  :::column-end:::
  :::column span="3":::  

**Data**

In almost all cases, attackers are after data:

- Stored in a database.
- Stored on disk inside virtual machines.
- Stored in software as a service (SaaS) applications, such as Office 365.
- Managed through cloud storage.

It's the responsibility of those storing and controlling access to data to ensure that it's properly secured. Often, there are regulatory requirements that dictate the controls and processes that must be in place to ensure the confidentiality, integrity, and availability of the data.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![Image of a file on the network](../media/2-application.png)
  :::column-end:::
  :::column span="3":::

**Application**

At this layer, it's important to:

- Ensure that applications are secure and free of vulnerabilities.
- Store sensitive application secrets in a secure storage medium.
- Make security a design requirement for all application development.

Integrating security into the application development lifecycle helps reduce the number of vulnerabilities introduced in code. Every development team should ensure that their applications are secure by default.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A terminal representing compute](../media/2-compute.png)
  :::column-end:::
  :::column span="3":::

**Compute**

At this layer, it's important to:

- Secure access to virtual machines.
- Implement endpoint protection on devices and keep systems patched and current.

Malware, unpatched systems, and improperly secured systems open your environment to attacks. The focus in this layer is on making sure that your compute resources are secure and that you have the proper controls in place to minimize security issues.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![Three connected systems representing networking](../media/2-networking.png)
  :::column-end:::
  :::column span="3":::

**Networking**

At this layer, it's important to:

- Limit communication between resources.
- Deny by default.
- Restrict inbound internet access and limit outbound access where appropriate.
- Implement secure connectivity to on-premises networks.

At this layer, the focus is on limiting the network connectivity across all your resources to allow only what's required. By limiting this communication, you reduce the risk of an attack spreading to other systems in your network.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A physical barrier representing the network perimeter](../media/2-perimeter.png)
  :::column-end:::
  :::column span="3":::

**Perimeter**

At this layer, it's important to:

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

At this layer, it's important to:

- Control access to infrastructure and change control.
- Use single sign-on (SSO) and multi-factor authentication (MFA).
- Audit events and changes.

The identity and access layer is all about ensuring that identities are secure, access is granted only to what's needed, and sign-in events and changes are logged.
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    ![A security camera representing physical security](../media/2-physical-security.png)
  :::column-end:::
  :::column span="3":::  
**Physical security**

Physically securing access to buildings and controlling access to computing hardware within the datacenter is the first line of defense.

With physical security, the intent is to provide physical safeguards against access to assets. These safeguards ensure that other layers can't be bypassed, and loss or theft is handled appropriately. Microsoft uses various physical security mechanisms in its cloud datacenters.
  :::column-end:::
:::row-end:::

## Understand your security posture

Your *security posture* is your organization's ability to protect from and respond to security threats. The common principles used to define a security posture are *confidentiality*, *integrity*, and *availability*, known collectively as CIA.

+ **Confidentiality**

    The *principle of least privilege* means restricting access to information only to individuals explicitly granted access, at only the level they need to perform their work. This information includes protection of user passwords, email content, and access levels to applications and underlying infrastructure.
+ **Integrity**

    The prevention of unauthorized changes to information at rest (when it is stored) or in transit (when it is being transferred from one place to another, including from a local computer to the cloud). A common approach used in data transmission is for the sender to create a unique fingerprint of the data using a one-way hashing algorithm. The hash is sent to the receiver along with the data. The data's hash is recalculated and compared to the original by the receiver to ensure the data wasn't lost or modified in transit.
+ **Availability**

    Ensure services are functioning and are able to be accessed only by authorized users. *Denial of service attacks* are specifically designed to degrade the availability of a system, impacting its users.
