During the monitoring of your private mobile network, you may find network issues. For example, a connection or a network function may not be working as expected. In this case, you can use a *distributed tracing tool*, which is a network issue diagnostic tool that Azure Private 5G Core offers, to diagnose the issues reported.

The distributed tracing tool allows you to collect detailed traces for signaling flows involving packet core instances. Each *trace* represents the results of a distinct occurrence of a network activity. Through a web graphical user interface (GUI), you can use traces to diagnose many common configuration, network, and interoperability problems affecting network services.

The distributed tracing tool is available from the ASE on which the packet core instance runs. As the tool resides within each site in your private mobile network, it doesn't have much reliance on the network bandwidth or the cloud connectivity. With the tool, you can quickly diagnose network issues and minimize their impact to your network services.

To effectively diagnose issues in your private mobile network, you need to be familiar with the network functions that Azure Private 5G Core provides. For more information about the network functions, see [Packet core architecture](/azure/private-5g-core/private-5g-core-overview#packet-core-architecture). You also need to understand how different components in an [Azure private multi-access edge compute (MEC)](https://azure.microsoft.com/solutions/private-multi-access-edge-compute-mec/#overview) solution interact with each other.

<!-- Insert an issue debugging video here once it is available -->

## Access the distributed tracing tool

The URL for accessing the distributed tracing tool is as follows:

`https://<LocalMonitoringIP>/sas`

Here *\<`LocalMonitoringIP`\>* is the IP address for accessing the local monitoring tools that you set up when you configure the management network during Azure Private 5G Core deployment.

<!-- Need to verify if the AAD feature will be delivered for GA -->
Azure Private 5G Core provides two authentication methods for the distributed tracing tool:

- Username and password: The username/password method allows you to sign in the distributed tracing tool with a default account. If your site isn't always connected to Azure, use this method.

  You can use the following default account to sign in:

  - Username: *admin*
  - Password: *packetCoreAdmin*
  
  Change the password for the account after the initial sign-in.

- Azure Active Directory (AD): The Azure AD method allows users to sign in to the packet core dashboards with their Azure accounts. If your site isn't always connected to Azure, use this method.

  For more information about enabling and configuring the Azure AD authentication method, see [Distributed tracing](/azure/private-5g-core/distributed-tracing).

You can select an authentication method when you create or modify a site through the Azure portal.

## Diagnostics details that you can check

To help you diagnose issues, the distributed tracing tool provides detailed information about signaling flows and errors through three views:

- The **Summary** view: The summary of each flow or error.
- The **Detailed Timeline** view: The sequence of operations and events that occurred during the flow or error.
- The **Call Flow** view: The sequence of messages flowing between components during the course of the flow or error.

Each entry in the **Detailed Timeline** view represents an event. The entry includes the date and time at which the event occurred and the name of the component on which it occurred. You can check the details about each event. Additionally, you can filter the events by different levels. For example, the detailed events level includes the network protocol messages and more fine-grained detail of events. 

The **Call Flow** view uses a diagram to visually indicate the messages flowing between network functions. As shown in the example view below, the vertical lines show the network components involved in the flow. The black lines indicate packet core Network Functions that have logged sending or receiving messages for this flow. The gray lines indicate other components that don't log messages. A horizontal line shows each individual signaling message flowing between two network components. An arrow indicates the direction of flow from the sending to the receiving component. The messages appear in the diagram in the order in which they occurred.

:::image type="content" source="../media/distributed-tracing-call-flow.png" alt-text="A screenshot showing the message flows in an example Call Flow view" border="true":::

For detailed instructions on using these views, see [Distributed tracing](/azure/private-5g-core/distributed-tracing).

## Search for specific information

To find the root cause of a network issue, you'll need to find signal flows or errors involving a particular subscriber. The distributed tracing tool allows you to search for activities involving a particular subscriber using their subscription permanent identifier (SUPI) or, in 4G networks, their international mobile subscriber identity (IMSI). For errors, the tool allows you to search for error condition occurrences across all subscribers.

In addition, the distributed tracing tool allows you to use a date/time range to specify a custom time window in which to search for diagnostics data.

> [!TIP]
> Long search ranges result in slower searches. We recommend that you keep the search range to an hour or less if possible.

For detailed instructions on searching for information in the distributed tracing tool, see [Distributed tracing](/azure/private-5g-core/distributed-tracing).

## An example of diagnosis

TBD

## Collect diagnostics packages for technical support

<!-- Need to check if this feature is delivered for GA before the publication of this module -->
If you can't find the root cause of an issue, you may need Microsoft technical support to help you. In this case, you'll need to collect the diagnostics packages from the relevant packet core instance and share the packages with Microsoft support personnel.

The distributed tracing tool allows you to use the Azure portal to collect diagnostics packages from a site. You can enable package collection either when you create a site or when you edit a site.

To enable diagnostics package collection, you'll need to specify the following information:

- A storage account for storing your diagnostics package.
- A managed identity that has the write access to the storage account.

  The distributed tracing tool uses this identity to upload the collected packages to your specified storage account.

Once package collection is enabled, you can use the **Collect Diagnostics Package** link on the overview page of the relevant site to trigger package collection. After the collection is completed, share the package access Uniform Resource Identifier (URI) with Microsoft support personnel.

For details about diagnostics package collection, see [Distributed tracing](/azure/private-5g-core/distributed-tracing).