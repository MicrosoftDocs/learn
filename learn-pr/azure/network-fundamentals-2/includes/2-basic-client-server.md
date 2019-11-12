The first step in understanding the composition of a network is how they're built. Servers are the workhorses of a network. Connections are achieved throughout a network through a mix of hubs, switches, and routers. This knowledge applies whether it's your own organization's network, or more extensive networks like the world wide web. All networks are built on the same principals.

In this unit, you'll get a better understanding of the various client options. You'll also explore the various server models and options available.

## Clients

### What is a client

In the traditional sense, a client was a light-weight computer or device that was unable to run programs on their own. This type of client was typically used to access and interact with a mainframe computer. As technology has advanced, the client has transformed from a simple terminal, to represent any hardware or software system that interacts with services running on, or made available on, a server. This server is usually located elsewhere and is accessed via a network.

A client would be considered as part of a client-server model, a model that is in use today.

### Types of clients

| Client  | Uses local storage | Uses local CPU |
| ------- | ------------------ | -------------- |
| Thick   |        Yes         | Yes            |
| Hybrid  |         No         | Yes            |
|  Thin   |         No         | No             |

There are three types of clients typically used in a client-server configuration:

- **Thick** - Sometimes known as a workstation, can process and store data locally, without using a server. These client types are the most common in today's network environments. Interaction with a server is minimal and may only be to store data on a shared network drive.
- **Thin** - Unable to process or store data locally, relies totally on the server to provide computational power and storage. Historically, a thin client would be a terminal, like the VT100. Today, thin clients are represented by web-applications, which make requests of a server, and displays the results, regardless of the device they're running on.
- **Hybrid** - Blends the best of both thick and thin clients. It's capable of limited local data processing but has no local storage capability. This type of client might be seen in a device that renders content and stores the results on the server like you see in the automated rating systems.

## Servers

A server is a mercurial term for either a software system, a hardware device, or both. Historically, a server was the mainframe that occupied a large room and serviced hundreds of thin-clients throughout the organization. While the size of the hardware has shrunk, the essence of a server persists. A server's hardware is usually a high-end computer with dozens of CPUs or cores, and vast amounts of memory. Associated with a server are an array of switches, routers, load balancers, and firewalls. A server will usually run server software, for instance, Windows Server 2019, or Linux. 

Servers and server software expose to their client's various services and functions. A server will support multiple clients, and a client is capable of connecting to and using the services from multiple different servers. For example, an application may use a media server to retrieve images and sounds while using a database server to pull data for display. Both services could be offered from the same server hardware, with each server service running as its own instance or virtual machine.

### Server models

There are many client-server models:

- **request-response** - in this model, the client sends a request to the server, which carries out an activity, and sends back a response. It will either be as a result of the request, or as an acknowledgment.
- **Peer-To-Peer (P2P)** - In this model, every network device attached to the network is both a client and a server. Each client can request services, like files from any other device on the network and vice-versa. P2P is an unstructured network suited for ad-hoc usage.
- **publish-subscribe** - this model is a messaging pattern, where clients subscribe to a service on the server. When a server receives a new message, it sends a response to each client that has subscribed. An RSS feed is a typical publish-subscribe type client-server, where the user subscribes to the RSS feed, and when new items appear, they're automatically notified.

Ultimately, the role of a server is to share data and resources to its clients.

### Server types

A server exists to provide services or processes to its clients. With an increase in the number of applications and users. Servers have also had to adapt and diversify. Now you'll find servers dedicated to one specific purpose. The table below shows a broad range of servers, their usage, and the type of client that uses them.

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

The client-server model is the most common type of network architecture used today. As with all models, there are pros and cons in their use.

### Advantages of client-server networks

- All users are centrally managed, governing access and control to your servers and their services.
- If your server architecture is design to scale, there will never be any performance issues when user usage increases.
- Reduces the likelihood of data duplication, since all data can be stored and accessed centrally
- A backup of centrally stored data to tape or other back-up mediums is easier.

### Disadvantages of client-server networks

- The failure of the server can stop users from accessing resources.
- Setting up a client-server architecture can be expensive as it requires dedicated hardware and software.
- Running and maintaining a network requires IT professionals with dedicated technical knowledge.
- Multiple requests for the same operation impact the performance of the server, as might be seen in a Denial of Service Attack.

## Advantages and disadvantages of peer to peer networks

Another common network architecture type is the peer to peer network. Peer-to-peer is a distributed network model where every network device can be both being a client and a server.

### Advantages of a peer to peer network

- No requirement for a server-based operating system.
- No expensive decentralized server.
- No need for professional IT staff to run or manage the network.
- If one of the computers in the network fails, it has minimal effect on the network.

### Disadvantages of a peer to peer network

- The performance of a peer-to-peer network can be slower.
- Data is distributed, which can make backing up critical files difficult.
- With a distributed network, if one machine goes offline, it means any data on that computer is no longer available.
- Network security stays with the individual, and there's no enforced security

## What is available in Azure

Azure has several tools that can help with the configuration and management of clients and servers in your network. Here is a brief overview of some of the more common Azure tools.

- **Azure Resource Manager** - It's a management service that provides a means to organize and secure your organization's assets and resources. It uses declarative templates to manage your infrastructure. It uses Role-Based Access Control to improve the security and access to your assets and resources.

- **Azure VM** - Azure Virtual Machines are the perfect mechanism for implementing a server without the need to purchase and house server hardware. Virtualization provides the flexibility to have multiple dedicated servers all within a cloud environment. Azure VMs will work with both the cloud and your on-premises network. Azure VMs are scalable, and will dynamically adapt to meet your organization's needs as you grow.
