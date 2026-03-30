You may have heard of the shared responsibility model, but you may not understand what it means or how it impacts cloud computing.

## How responsibilities shift in cloud

Start with a traditional on-premises datacenter. Your team is responsible for maintaining the physical space, ensuring security, and maintaining or replacing the servers if anything happens. The IT department is responsible for maintaining all the infrastructure and software needed to keep the datacenter up and running. They're also likely to be responsible for keeping all systems patched and on the correct version.

With the shared responsibility model, these responsibilities get shared between the cloud provider and the consumer. Physical security, power, cooling, and network connectivity are the responsibility of the cloud provider. The consumer isn't collocated with the datacenter, so it wouldn't make sense for the consumer to have any of those responsibilities.

At the same time, the consumer is responsible for the data and information stored in the cloud. (You wouldn't want the cloud provider to be able to read your information.) The consumer is also responsible for access security, meaning you only give access to those who need it.

For some things, the responsibility depends on the situation. If you're using a cloud SQL database, the cloud provider would be responsible for maintaining the actual database. However, you're still responsible for the data that gets ingested into the database. If you deployed a virtual machine and installed an SQL database on it, you'd be responsible for database patches and updates, as well as maintaining the data and information stored in the database.

With an on-premises datacenter, you're responsible for everything. With cloud computing, those responsibilities shift. The shared responsibility model is heavily tied into the cloud service types covered later in this learning path: infrastructure as a service (IaaS), platform as a service (PaaS), and software as a service (SaaS). IaaS places the most responsibility on the consumer, with the cloud provider being responsible for the basics of physical security, power, and connectivity. On the other end of the spectrum, SaaS places most of the responsibility with the cloud provider. PaaS is a middle ground between IaaS and SaaS, distributing responsibility evenly between the cloud provider and the consumer.

## Responsibility by service model

The following diagram highlights how the shared responsibility model informs who is responsible for what, depending on the cloud service type.

:::image type="content" source="../media/shared-responsibility-model.png" alt-text="Diagram showing how responsibility shifts from customer to cloud provider across On-Premises, IaaS, PaaS, and SaaS service models.":::

## What always stays with you

When using a cloud provider, you're always responsible for:

- The information and data stored in the cloud
- Devices that are allowed to connect to your cloud (cell phones, computers, and so on)
- The accounts and identities of the people, services, and devices within your environment

## What the provider always owns

The cloud provider is always responsible for:

- The physical datacenter
- The physical network
- The physical hosts

## What depends on the service type

Your service model determines responsibility for things like:

- Operating systems
- Network controls
- Applications
- Identity and infrastructure