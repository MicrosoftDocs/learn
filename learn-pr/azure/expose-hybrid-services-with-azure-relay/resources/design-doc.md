# Title

Expose hybrid services securely with Azure Relay

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Relay

## Prerequisites

- Familiarity with HTTP requests and responses
- Familiarity with C# programming

## Summary

Securely expose services that run in your on-premises network to the cloud, without opening a port on your firewall, or making intrusive changes to your corporate network infrastructure.

## Learning objectives

1. Describe the features and use cases for Azure Relay.
1. Create an application and expose it to through Azure Relay.

## Chunk your content into subtasks

Identify the subtasks of *Expose hybrid services securely with Azure Relay*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an Azure Relay Hybrid Connection | "Regulations in your jurisdiction mean that you're unable to move this web service into Azure, but you would like to expose it securely, without the network complexity that typically goes with exposing services to the internet" | Exercise | Describe the features and use cases for Azure Relay | Yes |
| Send requests through a Relay Hybrid Connection | "You think Azure Relay may fit your use case, and would like to learn more about it" | Exercise | Create an application and expose it to through Azure Relay | Yes |

## Outline the units

1. **Introduction**

    You work for a financial organization that has a credit-checking web service. The service runs in an on-premises environment that you need to integrate with applications running in the cloud. Regulations in your jurisdiction mean that you're unable to move this web service into Azure, but you would like to expose it securely, without the network complexity that typically goes with exposing services to the internet. You think Azure Relay may fit your use case, and would like to learn more about it.

1. **Create an Azure Relay Hybrid Connection**

    List the content that will enable the learner to *Create an Azure Relay Hybrid Connection*:

    - What is Azure Relay
        - Azure Relay use cases
        - Hybrid connections and WCF connections
        - WebSockets connections and HTTP connections
    - How Azure Relay works
        - Architecture
        - How requests flow
        - How Relay maintains security when you use it to expose services to the cloud 
    - Configuring a connection
        - Namespaces, keys, and connection strings

1. **Exercise - Create an Azure Relay Hybrid Connection**

    List the steps, which apply the learning content from previous unit:

    1. Create a new namespace in Azure Relay
    1. Get the primary connection string and primary key and store them for later use
    1. Create a new hybrid connection in the namespace

1. **Send requests through a Relay Hybrid Connection**

    List the content that will enable the learner to *Send requests through a Relay Hybrid Connection*:

    - Connect to a Relay namespace
        - Namespaces, connection names, and primary keys
        - How to use a `TokenProvider` object to pass the key
    - Listen for requests
        - How to create and configure a `HybridConnectionListener` object.
        - How to subscribe to listen status events
        - How to respond to requests
    - Send requests
        - How to create an `HttpRequestMessage` object and set the token
        - How to send a request through Azure Relay asynchronously and obtain a response

1. **Exercise - Send requests through a Relay Hybrid Connection**

    List the steps, which apply the learning content from previous unit:

    1. Obtain the incomplete console applications by using `git clone`
    1. In the listener application, add the namespace, connection name, and primary key.
    1. Create a `HybridConnectionListener` and subscribe to events.
    1. Respond to requests
    1. Start the listener
    1. In the sender application, add the namespace, connection name, and primary key.
    1. Use an `HttpClient` object to send a request to the listener application, through the Relay Service.
    1. Run both applications and show the results

    > [!NOTE]
    > If possible, clone the console applications in the Cloud Shell. Complete them there by using the `code` editor and execute them. This way, you can avoid the necessity to install Visual Studio Code or another editor locally.

1. **Summary**

    Your financial organization needed to continue running its credit-checking web service on-premises for regulatory compliance, even though it has many systems migrated into the cloud. You wanted to find a way to call this web service securely from cloud components, without the complexity of setting up and maintaining a virtual private network. By using an Azure Relay namespace, you provided a destination in Azure, where cloud components could call the service. The namespace forwards requests to the on-premises web service and returns responses. 

    You can use a virtual private network or Azure ExpressRoute to create secure connections between cloud-hosted components and on-premises systems. However, these methods impose an extra layer of complexity and more administrative load on your team. Azure Relay is simple to configure and secure.

    *[(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)*

## Notes

You may need to use an Azure VNet that emulates a corporate network in order to do so. Focus should be on hybrid connections as opposed to WCF, though you can mention WCF in the learning content for awareness.

https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-protocol

https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-http-requests-dotnet-get-started

Other useful links:

- [What is Azure Relay?](https://docs.microsoft.com/azure/service-bus-relay/relay-what-is-it)
- [Get started with Relay Hybrid Connections HTTP requests in .NET](https://docs.microsoft.com/azure/service-bus-relay/relay-hybrid-connections-http-requests-dotnet-get-started)