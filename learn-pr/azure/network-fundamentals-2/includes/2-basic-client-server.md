The first step in understanding the composition of a network is how they're built. Servers are the workhorses of a network. Connections are achieved throughout a network through a mix of hubs, switches, and routers. This knowledge applies whether it's your own organization's network, or more extensive networks like the world wide web. All networks are built on the same principals.

In this unit, you'll get a better understanding of the various client options. You'll also explore the various server models and options available.

## Network clients

In the traditional sense, a network client was a light-weight computer or device that was unable to run programs on their own. This type of client was typically used to access and interact with a mainframe computer. As technology has advanced, the client has transformed from a simple terminal, to represent any hardware or software system that interacts with services running on, or made available on, a server. This server is usually located elsewhere and is accessed via a network.

A client would be considered as part of a client-server model, a model that is in use today.

### Types of clients

| Client  | Uses local storage | Uses local CPU |
| ------- | ------------------ | -------------- |
| Thick   |        Yes         | Yes            |
| Hybrid  |         No         | Yes            |
|  Thin   |         No         | No             |

There are three types of clients we typically used in a client-server configuration:

- **Thick** - This type of client is the most common in today's network environments. Thin clients are sometimes known as a workstation, and can process and store data locally without using a server. The client's interaction with a server is minimal and may only be to store data on a shared network drive.
- **Thin** - Historically, a thin client would be a terminal. A thing client is unable to process or store data locally, and relies totally on the server to provide computational power and storage. Today, thin clients are represented by web-applications, which make requests to a server, and displays the results, regardless of the device they're running on.
- **Hybrid** - This client combines the best of both thick and thin clients. It's capable of limited local data processing but has no local storage capability. An example of such a client might be seen in a device that renders content and stores the results on the server like you see in the automated rating systems.

## Servers

A server is a variable term for either a software system, a hardware device, or both. Historically, a server was the mainframe that occupied a large room and serviced hundreds of thin-clients throughout the organization. While the size of the hardware has shrunk, the essence of a server persists. A server's hardware is usually a high-end computer with dozens of CPUs or cores, and vast amounts of memory. Associated with a server are an array of switches, routers, load balancers, and firewalls. A server will usually run server software, for example, Windows Server 2019, or Linux.

Servers and server software expose various services and functions to network clients. A server supports multiple clients, and a client is capable of connecting to and using the services from multiple different servers. For example, an application may use a media server to retrieve images and sound clips while using a database server to pull data for display. Both services could be offered from the same server hardware, with each server service running as its own instance or virtual machine.

### Server models

There are a number of client-server models. These models are dependent on the way the client and server software communicates and the server shares data and resources with clients.

- **request-response** - In this model, the client sends a request to the server, which carries out an activity, and sends back a response. The response will either a result of the request, or an acknowledgment.
- **Peer-To-Peer (P2P)** - In this model, every network device attached to the network is both a client and a server. Each client can request services, for example files, from any other device on the network and vice-versa. P2P is an unstructured network suited for ad-hoc usage.
- **publish-subscribe** - This model is a messaging pattern, where clients subscribe to a service on the server. When a server receives a new message, it sends a response to each client that has subscribed. An RSS feed is a typical publish-subscribe type client-server, where the user subscribes to the RSS feed, and when new items appear, they're automatically notified.

### Server types

A server's main task is to provide services and resources to its clients. With an increase in the number of applications and users the server we find servers becomes dedicated to one specific purpose. The table below shows a broad range of servers, their usage, and the type of client that uses them.

| Server           | Purpose                           | Clients                        |
| :-------------------: | :-------------------------------: | :----------------------------: |
| Application  | Hosts a applications, which can be run through a web browser or bespoke client software. |   Any network device with access.   |
| Computing  | Makes available CPU and memory to the client. This type of server might be a super-computer or mainframe. | Any networked computer that requires more CPU power and RAM to complete an activity. |
| Database  | Maintains and provides access to any database. | Any form of software that requires access to structured data. |
|   File    | To make available shared files and folders across a network. | Any client that needs access to shared resources. |
|   Game    | Provision of a multiplayer game environment. | Personal computers, tablets, smartphones, or game consoles. |
|   Mail    | Hosts your email and makes it available across the network. |  User of email applications  |
|  Media   | Enables media streaming of digital video or audio over a network. | web and mobile applications. |
|  Print   | Shares printers over a network. |  Any device that needs to print. |
|    Web    | Hosts web pages either on the internet or on private internal networks. |   Any device with a browser. |

## Advantages and disadvantages of client-server networks

The client-server network architecture is the most common type of network architecture used today. As with all models, there are pros and cons in their use.

### Advantages of client-server networks

There are several advantages that a client-server provides an organization. We find that these advantages typically are associated with resource management and security.

- All users are centrally managed, governing access and control to your servers and their services.
- If your server architecture is design to scale, there will never be any performance issues when user usage increases.
- All data can be stored and accessed centrally, which reduces the likelihood of data duplication.
- Data is easier safe guarded with centralized storage of data to tape or other back-up mediums.

### Disadvantages of client-server networks

Like with any technology, there are also disadvantages that we need to consider when using the client-server client-server network architecture.

- The failure of the server can stop users from accessing resources. Since the resources are now centralized, any disruption in terms of access will impact all users.
- Setting up a client-server architecture can be expensive as it requires dedicated hardware and software.
- Running and maintaining a network requires IT professionals with dedicated technical knowledge.
- Multiple requests for the same operation impact the performance of the server, as might be seen in a Denial of Service Attack.

## Advantages and disadvantages of peer-to-peer networks

Another common network architecture type is the peer-to-peer network. Peer-to-peer is a distributed network model where every network device can be both being a client and a server.

## What is available in Azure

Azure has several tools that can help with the configuration and management of clients and servers in your network. Here is a brief overview of some of the more common Azure tools.

- **Azure Resource Manager** - It's a management service that provides a means to organize and secure your organization's assets and resources. It uses declarative templates to manage your infrastructure. It uses Role-Based Access Control to improve the security and access to your assets and resources.

- **Azure VM** - Azure Virtual Machines are the perfect mechanism for implementing a server without the need to purchase and house server hardware. Virtualization provides the flexibility to have multiple dedicated servers all within a cloud environment. Azure VMs will work with both the cloud and your on-premises network. Azure VMs are scalable, and will dynamically adapt to meet your organization's needs as you grow.
