Before installing and configuring WSUS (Windows Server Update Services) servers, you must consider how to deploy WSUS in your environment. WSUS implementations vary in size and configuration depending on your network environment and how you want to manage updates. You could have a single WSUS server for your entire organization, multiple WSUS servers acting independently, or multiple WSUS servers connected to each other in a hierarchy.

## Single WSUS server

The most basic implementation of WSUS uses a single WSUS server inside your network. This server connects to Microsoft Update and downloads updates through the firewall. The WSUS server uses port 8530 for HTTP communication and port 8531 for HTTPS, instead of the default 80 and 443, respectively. You need to make sure your firewall has the necessary rules to allow the server to connect to Microsoft Update. This basic scenario is commonly used for small networks with a single physical location.

## Multiple WSUS servers

If your environment is composed of several isolated physical locations, you might need to implement a WSUS server in each location. In this scenario, each WSUS server has its own connection to the Internet to download updates from Microsoft Update.

Although this is a valid option, it requires substantially more administrative effort—especially as the number of physical locations grows—because you must manage each individual WSUS server independently. You have to download updates to each server separately, approve updates on each server individually, and manage WSUS clients so that they receive updates from the correct WSUS server.

Individual WSUS servers work well for organizations that have a small number of physical locations, where each physical location has its own IT management team. You can also use this scenario for a single physical location that has too many clients for a single WSUS server to manage, by placing multiple WSUS servers in a Network Load Balancing (NLB) cluster.

## Disconnected WSUS servers

A disconnected WSUS server is a server that doesn't connect to Microsoft Update over the internet or receive its updates from any other server in the network. Instead, this server receives its updates from removable media generated on another WSUS server.

A disconnected WSUS server is most common in isolated network environments without internet access, such as in some high security environments. You can use a WSUS server in a different location to synchronize with Microsoft Update, then export the updates to portable media, and then transport the portable media to the remote location to be imported into the disconnected WSUS server.

## WSUS server hierarchies

All the scenarios we have discussed so far deal with an independently managed WSUS server that connects directly to Microsoft Update or receives its updates in a disconnected manner. However, in larger organizations with multiple physical locations you might want to have the ability to synchronize with Microsoft Update on one server. You might also want to push the updates to servers in various locations over your network and approve updates from a single location.

- WSUS server hierarchies allow you to:

- Download updates to servers that are closer to clients, such as servers in branch offices.

- Download updates once to a single server, and then replicate the updates over your network to other servers.

- Separate WSUS servers based on the language used by their clients.

- Scale WSUS servers for a large organization that has more client computers than a single WSUS server can manage.

In a WSUS server hierarchy, there are two types of servers:

- Upstream servers. Upstream servers connect directly to Microsoft Update to retrieve updates, or are disconnected and receive updates by using portable media.

- Downstream servers. Downstream servers receive updates from a WSUS upstream server.

You can configure downstream servers in one of two modes:

- Autonomous mode. Autonomous mode, or distributed administration, allows a downstream server to receive updates from an upstream server, but enables administrators to maintain administration of the updates locally. In this scenario, the downstream server maintains its own set of computer groups, and updates can be approved independently of approval settings in the upstream servers. This allows a different group of administrators to manage updates at their own locations, and only use the upstream server as a source of downloadable updates.

- Replica mode. Replica mode, or centralized administration, allows a downstream server to receive updates, computer group membership information, and approvals from an upstream server. In this scenario, a single group of administrators can manage updates for the entire organization. In addition, downstream servers can be placed in different physical offices and receive all updates and management data from an upstream server.

You can have multiple layers in your WSUS hierarchy. You can configure some of your downstream servers to use autonomous mode, while you can use replica mode to configure other servers. For example, you can have a single upstream server connected to Microsoft Update, downloading updates for your entire organization. You can have two other downstream servers in autonomous mode, one that manages updates for all computers running software in English, and another for all computers running software in Spanish. Finally, you can have another set of downstream servers receiving their updates from the middle-tier WSUS servers configured in replica mode. These are the actual servers that clients receive updates from, but all the management is done at the middle tier.

> [NOTE] 
> You can configure downstream servers to download the update information metadata from an upstream server, but to download the actual updates themselves from Microsoft Update. This is a common configuration when the downstream servers have good internet connectivity and you want to reduce WAN traffic.

