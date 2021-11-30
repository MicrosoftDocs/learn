Event log subscriptions enables a single server to collect copies of events from multiple systems. Using the Windows Remote Management (WinRM) and Windows Event Collector services (Wecsvc), you can collect events in the event logs of a centralized server, where you can analyze them together with the event logs of other computers that are being collected on the same central server.

## What are the subscriptions types?

Subscriptions can either be collector-initiated or source computer-initiated, as described in the following table.

| Subscription type| Description|
| :--- | :--- |
| Collector-initiated | A collector-initiated subscription, or a pull subscription, identifies all the computers from which the collector will receive events and typically pulls events from these computers. In a collector-initiated subscription, the subscription definition is stored and maintained on the collector computer. You use pull subscriptions when you must configure many of the computers to forward the same types of events to a central location. In this manner, you must define and specify only one subscription definition to apply to all computers in the group. |
| Source computer-initiated | In a source computer-initiated subscription, or a push subscription, source computers push events to the collector. In a source computer-initiated subscription, you create and manage the subscription definition on the source computer, which is the computer that's sending events to a central source. You can define these subscriptions manually or by using Group Policy. You create push subscriptions when each server is forwarding a set of events different from what the other servers are forwarding or when you must maintain control over the event-forwarding process at the source computer. This might be the case when you must make frequent changes to the subscription. |

## Enable subscriptions

To use event log subscriptions, you must configure the forwarding and the collecting computers. The event-collecting functionality depends on the WinRM service and Wecsvc. Both of these services must be running on computers that are participating in the forwarding and collecting process.

To enable subscriptions, perform the following tasks:

1. On each source computer, run the following command at an elevated Command Prompt to enable WinRM:

    - winrm quickconfig

    > [!TIP]
    > Windows Server computers are already enabled for Windows Remote Management, so this step might not be necessary.

1. On the collector computer, enter the following command at an elevated Command Prompt to enable Wecsvc:

    - wecutil qc

1. Add the computer account of the collector computer to the local Event Log Readers group on each of the source computers.

> [!TIP]
> You can also use the Event Monitor console and Group Policy to enable and configure event subscriptions.

