Azure Relay gives you a way to connect services across network boundaries and firewalls, without having to reconfigure your security setup.

You want to move all the systems in your financial organization into the cloud. However, regulations in your jurisdiction prevent you from migrating your credit-checking service. This service must remain on-premises for data protection purposes. You need a way to connect the cloud services to the credit-checking service. Ideally, you'd prefer not to open extra ports on your on-premises firewall or to build a virtual private network.

In this unit, you learn how Azure Relay can provide this connection.

## What is Azure Relay?

Many organizations are migrating their systems to the cloud. This process is often done component-by-component, as a phased approach. Such an approach limits the effect of problems that might arise during the migration, but it has its own challenges. For example, a newly migrated cloud component often needs to communicate with another component that remains on-premises but is protected by a firewall or other security systems. 

In other cases, you might find that an on-premises service can't be migrated to the cloud. For example, your jurisdiction might impose extra security requirements on financial systems, which you can't comply with in a cloud system. 

In situations like these, you need on-premises services to be addressable from internet clients or cloud components. You could open a firewall port to enable this communication, but that approach might have unintended consequences. For example, you might accidentally expose services other than the one you had in mind. In large organizations, you might not be in charge of the firewall. An alteration to the security regime might require high-level authorization that takes time to obtain.

Azure Relay addresses these kinds of problems by providing a point in the cloud where on-premises and internet-based components can connect. Because the on-premises system initiates this connection, you don't need to open any firewall ports or reconfigure the on-premises network in any way. 

## Hybrid connections and Windows Communication Foundation connections

Azure Relay establishes a connection between two components, such as an Azure function and an on-premises service. When the connection is established, requests and responses can be exchanged through the relay, as if there were a direct connection. You can make two types of connections in Azure Relay:

- **Hybrid connections**: Hybrid connections are two-way streams of binary data that use either WebSocket or HTTP standards. Because these connections are based on open standards, you can use them from almost any language or coding framework. For example, you could use them to connect an on-premises Node.js server to an Azure web job that's written in C# and the .NET Framework.
- **WCF connections**: Some developers use Windows Communication Foundation (WCF) to enable remote procedure calls. WCF was commonly used for network communications with older versions of the .NET Framework. WCF is now considered a legacy protocol, but it remains in common use in older applications. Because Azure Relay supports WCF, you can use it with existing .NET Framework components that use this standard, without having to rewrite them. 

Use hybrid connections unless you're supporting existing .NET Framework components that use WCF.

## WebSocket connections and HTTP connections

Hybrid connections can use one of these protocols:

- **HTTP**: This stateless protocol consists of requests such as GET and POST, and it's used to transfer webpages between web servers and browsers. Usually, HTTP uses TCP port 80 or 443 when the request is secured with Secure Sockets Layer. This protocol is widely supported and easy to code for. However, because this protocol is stateless, it's less efficient for persistent communications.
- **WebSocket**: This protocol creates a full duplex communication channel over port 80 or 443, which is more efficient than the stateless HTTP protocol. A WebSocket connection is especially efficient when the communication consists of many messages, not just a single request and response.

In this module, because the process is a simple request for a credit check, followed by a single response, you use a hybrid connection and the HTTP protocol.

## How Azure Relay works

Because both the cloud-hosted and on-premises components initiate the connection to Azure Relay, on-premises firewalls don't intervene. When the connection is established, communications can be sent in both directions. 

The following diagram shows how the connection is made:

:::image type="content" source="../media/2-how-relay-works.png" alt-text="Diagram showing how Azure Relay exchanges messages.":::

1. A listener requests a connection to Azure Relay. The request is sent to a relay gateway by Azure Load Balancer.
1. The gateway creates an Azure relay in the gateway store. At this point, the listener is ready to receive messages.
1. A sender requests a connection, which might be received by a different gateway.
1. The gateway obtains information for the relay from the gateway store.
1. The sender's gateway sends the connection request to the listener's gateway.
1. The listener's gateway forwards the connection request to the listener. This request includes the identity of the sender's gateway.
1. The listener makes a connection to the sender's gateway. At this point, the sender and listener can exchange messages.
1. The sender's gateway forwards messages from the listener to the sender.
1. The sender's gateway also forwards messages from the sender to the listener. 

## How to create a relay

To create a relay, you need a namespace that's unique within the *servicebus.windows.net* domain. You also specify a subscription, resource group, and location for the relay, which should be close to most of your clients.

To control what clients can do when they connect, use shared access policies. You use these policies to permit whether clients can send messages to or read messages from the relay. Each shared access policy has primary and secondary keys. To connect to the relay, each client must supply one of these keys.

Finally, you should create a connection in the namespace. It can be either a hybrid connection or a WCF connection.
