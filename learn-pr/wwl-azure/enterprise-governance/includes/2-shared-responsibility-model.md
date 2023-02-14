
Organizations face many challenges with securing their datacenters, including recruiting and keeping security experts, using many security tools, and keeping pace with the volume and complexity of threats.

As computing environments move from customer-controlled datacenters to the cloud, the responsibility of security also shifts. Security of the operational environment is now a concern shared by both cloud providers and customers. By shifting these responsibilities to a cloud service like Azure, organizations can reduce focus on activities that aren't core business competencies. Depending on the specific technology choices, some security protections will be built into the service, while others will remain the customer’s responsibility. To ensure that the proper security controls are provided, a careful evaluation of the services and technology choices becomes necessary.

The first thing to understand about cloud security is that different scopes of responsibility exist, depending on the kinds of services you use.

For example, if you use virtual machines (VMs) in Azure, which provide Infrastructure as a Service (IaaS), Microsoft will be responsible for helping secure the physical network, physical storage, and virtualization platform, which includes updating the virtualization hosts. But you’ll need to take care of helping secure your virtual network and public endpoints and updating the guest operating system (OS) of your VMs.

The following figure depicts the various responsibility zones.

:::image type="content" source="../media/az500-shared-responsibility-model-1b0dd365.png" alt-text="Diagram that depicts the responsibility zones, which indicate who handles each responsibility scope.":::


For all cloud deployment types, you own your data and identities. You are responsible for helping secure your data and identities, your on-premises resources, and the cloud components you control (which vary by service type).

Regardless of the deployment type, **you always retain responsibility for the following:**

 -  Data
 -  Endpoints
 -  Accounts
 -  Access management

> [!IMPORTANT]
> It’s important to understand the division of responsibility between you and Microsoft in a Software as a Service (SaaS), Platform as a Service (PaaS), or Infrastructure as a Service (IaaS) deployment.
