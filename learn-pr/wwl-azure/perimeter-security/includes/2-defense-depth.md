The **Defense in depth** approach includes other controls in the design to mitigate risk to the organization in the event a primary security control fails. This design should consider how likely the primary control is to fail, the potential organizational risk if it does, and the effectiveness of the additional control (especially in the likely cases that would cause the primary control to fail).

During this module, we will explore the defense-in-depth design of Azure services and capabilities to help you securely manage and monitor your cloud data and infrastructure as a managed service. Microsoft designs and operates its cloud services with security at the core and provides you built-in controls and tools to meet your security needs. In addition, with Machine Learning (ML) and Microsoft's significant investments in cyber defense you can benefit from unique intelligence and proactive measures to protect you from threats. Azure offers unified security management and advanced threat protection for your resources whether they're in the cloud, your data center, or both. Each Service in Azure is built with security in mind from the ground up to host your infrastructure apps and data. All services are designed and operated to support multiple layers of defense, spanning your data apps, virtual machines, network perimeter-related policies, and physical security within our data centers. Including how the data sensors and systems that run Azure are architected and operated to the controls you can apply as part of your defense in-depth security management. An example strategy is illustrated in the following image.

:::image type="content" source="../media/az500-defense-depth-e6c9fa5c.png" alt-text="Layers from inside to outside Data, Applications, Compute, Networking, Perimeter, Identity and Access, and Physical security.":::


As more of a company’s digital resources reside outside the corporate network, in the cloud and on personal devices, it becomes obvious that a perimeter only based security, i.e. firewalls, DMZ, VNets, are no longer adequate. The adoption of software-defined networking (SDN) and software-defined data center (SDDC) technologies are driving Network Segmentation concepts to be more granular, i.e. Network Micro-Segmentation.

## Network Micro-Segmentation

Micro-segmentation is a way to create secure zones in data centers and Azure deployments that allow you to isolate workloads and protect them individually. Security policies in a virtual environment can be assigned to virtual connections that can move with an application if the network is reconfigured – making the security policy persistent.

**A best practice recommendation is to adopt a Zero Trust strategy based on user, device, and application identities**. In contrast to network access controls that are based on elements such as source and destination IP address, protocols, and port numbers, Zero Trust enforces and validates access control at “access time”. Granting access at access-time avoids the need to play a prediction game for an entire deployment, network, or subnet – only the destination resource needs to provide the necessary access controls.

 -  **Azure Network Security Groups** can be used for basic layer 3 &amp; 4 access controls between Azure Virtual Networks, their subnets, and the Internet.
 -  **Application Security Groups** enable you to define fine-grained network security policies based on workloads, centralized on applications, instead of explicit IP addresses.
 -  **Azure Web Application Firewall** and the **Azure Firewall** can be used for more advanced network access controls that require application layer support.
 -  **Local Admin Password Solution (LAPS)** or a third-party Privileged Access Management can set strong local admin passwords and just in time access to them.

Additionally, third parties offer micro-segmentation approaches that may enhance your network controls by applying zero trust principles to networks you control with legacy assets on them.
