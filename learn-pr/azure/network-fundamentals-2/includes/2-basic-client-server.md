The first thing you need to understand about the composition of a network is how it's built. Servers are the workhorses of a network. Connections are achieved throughout a network through a mix of hubs, switches, and routers. This knowledge applies whether it's your own organization's network, or more extensive networks like the web. All networks are built on the same principles.

In this unit, you'll gain a better understanding of the various client options. You'll also explore the various server models and options available.

## Network clients

In the traditional sense, a network client is a lightweight computer or device that can't run programs on its own. This type of client is typically used to access and interact with a mainframe computer. As technology has advanced, the client has transformed from a simple terminal and can now represent any hardware or software system that interacts with services made available on a server. This server is located elsewhere and accessed through a network.

A client is part of the client-server model that's in use today.

### Types of clients

| Client  | Uses local storage | Uses local CPU |
| ------- | ------------------ | -------------- |
| Thick   |        Yes         | Yes            |
| Hybrid  |         No         | Yes            |
|  Thin   |         No         | No             |

Three types of clients are typically used in a client-server configuration:

- **Thick**: This type of client is the most common in today's network environments. A thick client is sometimes known as a workstation, and can process and store data locally without using a server. The client's interaction with a server is minimal, and might only be to store data on a shared network drive.
- **Thin**: Historically, a thin client was a terminal. A thin client can't process or store data locally, and relies totally on the server to provide computational power and storage. Today, thin clients are represented by web applications that request and display information from servers regardless of the device on which they're running.
- **Hybrid**: This client combines the best of both thick and thin clients. A hybrid client can do limited local data processing, but has no local storage capability. An example of such a client is a device that renders content and stores the results on the server, like in automated rating systems.

## Servers

A server is a variable term for a software system, a hardware device, or both. Historically, a server was the mainframe that occupied a large room and serviced hundreds of thin clients throughout the organization. Although the size of the hardware has shrunk, the essence of a server persists. A server's hardware is usually a high-end computer with dozens of CPUs or cores and vast amounts of memory. Associated with a server is an array of switches, routers, load balancers, and firewalls. A server will usually run server software (for example, Windows Server 2019 or Linux).

Servers and server software expose various services and functions to network clients. A server supports multiple clients, and a client can connect to and use the services from multiple servers. For example, an application might use a media server to retrieve images and sound clips, but use a database server to pull data for display. Both services could be offered from the same server hardware, with each server service running as its own instance or virtual machine.

### Server models

There are a few client-server models. Each is dependent on how the client and server software communicates and how the server shares data and resources with clients:

- **Request-response**: In this model, the client sends a request to the server. The server carries out an activity and sends back a response. The response is either the result of a request or an acknowledgment.
- **Peer-to-peer (P2P)**: In this model, every network device attached to the network is both a client and a server. Each client can request services (for example, files) from any other device on the network and vice versa. P2P is an unstructured network suited for ad-hoc usage.
- **Publish-subscribe**: This model is a messaging pattern, where clients subscribe to a service on the server. When a server receives a new message, it sends a response to each client that has subscribed. An RSS feed is a typical publish-subscribe type of client-server, where the user subscribes to the RSS feed and is automatically notified when new items appear.

### Server types

A server's main task is to provide services and resources to its clients. The larger the number of applications and users, the more the server is dedicated to specific purposes. The following table shows a broad range of servers, their usage, and the type of client that uses them.

| Server           | Purpose                           | Clients                        |
| :-------------------: | :-------------------------------: | :----------------------------: |
| Application  | Hosts an application, which can run through a web browser or customized client software. |   Any network device with access   |
| Computing  | Makes CPU and memory available to the client. This type of server might be a supercomputer or mainframe. | Any networked computer that requires more CPU power and RAM to complete an activity |
| Database  | Maintains and provides access to any database. | Any form of software that requires access to structured data. |
|   File    | Makes shared files and folders available across a network. | Any client that needs access to shared resources |
|   Game    | Provisions a multiplayer game environment. | Personal computers, tablets, smartphones, or game consoles |
|   Mail    | Hosts your email and makes it available across the network. |  User of email applications  |
|  Media   | Enables media streaming of digital video or audio over a network. | Web and mobile applications |
|  Print   | Shares printers over a network. |  Any device that needs to print |
|    Web    | Hosts webpages either on the internet or on private internal networks. |   Any device with a browser |

## Advantages and disadvantages of client-server networks

The client-server network architecture is the most common type of network architecture used today. As with all models, there are pros and cons in its use.

### Advantages of client-server networks

There are several advantages that a client-server provides an organization. These advantages are typically associated with resource management and security:

- All users are centrally managed, governing access and control to your servers and their services.
- If your server architecture is designed to scale, there are fewer performance issues when usage increases.
- All data can be stored and accessed centrally, which reduces the likelihood of data duplication.
- Data is more easily safeguarded with centralized storage of data to tape or other backup mediums.

### Disadvantages of client-server networks

As with any technology, there are also disadvantages that you should consider when you use a client-server network architecture:

- The failure of the server can block users from accessing resources. Because the resources are now centralized, any access disruption will affect all users.
- Setting up a client-server architecture can be expensive, because it requires dedicated hardware and software.
- Running and maintaining a network requires IT professionals with dedicated technical knowledge.
- Multiple requests for the same operation affect the performance of the server; for example, in a denial-of-service attack.

## Peer-to-peer networks

Another common network architecture type is the peer-to-peer network. Peer-to-peer is a distributed network model where every network device can be both a client and a server.

## What's available in Azure

Azure has several tools that can help you configure and manage clients and servers in your network. Here's a brief overview of two common Azure tools:

- **Azure Resource Manager**: This is a management service that provides a means to organize and secure your organization's assets and resources. It uses declarative templates to manage your infrastructure. It uses role-based access control (RBAC) to improve the security and access to your assets and resources.

- **Azure Virtual Machines**: By using this service, you can implement a server without the need to purchase and house server hardware. Virtualization provides the flexibility to have multiple dedicated servers within a cloud environment. Azure VMs will work with both the cloud and your on-premises network. They are scalable and will dynamically adapt to meet your organization's needs as you grow.
