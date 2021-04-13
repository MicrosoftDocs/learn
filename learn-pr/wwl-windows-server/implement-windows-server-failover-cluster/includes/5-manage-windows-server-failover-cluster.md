Once you created a failover cluster, you need to create clustered roles to host highly available workloads. You also need to configure the roles' high-availability settings, including their failover and failback behavior. In addition, you might have to occasionally perform such management tasks as adding, pausing, or evicting a cluster node.

## Configure cluster roles

The following table lists the clustered roles that you can configure by using the High Availability Wizard and the associated server role or feature that you must install as a prerequisite.

|Clustered role|Role or feature prerequisite|
|--|-|
|Namespace Server|Namespaces (part of the File Server role)|
|DFS Namespace Server|DHCP Server role|
|Distributed Transaction Coordinator (DTC)|None|
|File Server|File Server role|
|Generic Application|Not applicable|
|Generic Script|Not applicable|
|Generic Service|Not applicable|
|Hyper-V Replica Broker|Hyper-V role|
|iSCSI Target Server|iSCSI Target Server (part of the File Server role)|
|iSNS Server|iSNS Server Service feature|
|Message Queuing|Message Queuing Services feature|
|Other Server|None|
|Virtual Machine|Hyper-V role|
|WINS Server|WINS Server feature|

## Configure failover and failback

You can adjust failover settings, including preferred owners and failback settings, to control how a cluster responds when roles or services fail. You can configure these settings on the **property** pane (on either the **General** or **Failover** tab) for the clustered service or application in the Failover Cluster Manager interface.

You can individually set preferred owners in the properties of each role. You can select multiple preferred owners and place them in any order. Selecting preferred owners provides more control over what node a specific role fails overs to and actively runs on.

Each role for failover and failback has additional settings that you can control. Failover settings allow you to control how many times a cluster will try restarting a role in a specific amount of time, with the default value of 1 failure every 6 hours. You also have the option to **Prevent Failback**, which is the default, or **Allow Failback**. You can allow fail back to take place immediately or set a wait period to a certain number of hours.

### Examples of failover settings

The following table provides examples that illustrate how these settings work.

|Example|Settings|Result|
|-|--||
|Example 1|General tab, Preferred owner: Node1; Failover tab, Failback setting: Allow failback (Immediately)|If the service or application fails over from Node1 to Node2, the service or application fails back to Node1 as soon as Node1 is available again.|
|Example 2|Failover tab, Maximum failures in the specified period: 2; Failover tab, Period (hours): 6|If the application or service fails no more than two times in a six-hour period, it restarts or fails over every time. If the application or service fails a third time in a six-hour period, it remains in a failed state. The default value for the maximum number of failures is n −1, where n is the number of nodes.|

## Manage failover clusters

Once your failover cluster transitions to a production environment, you might have to occasionally manage its nodes. In addition, you should properly maintain it by implementing monitoring and regularly deploying OS updates.

### Manage cluster nodes

Cluster node management tasks include the following actions:

- Add a node. You can add a node to a failover cluster by selecting **Add Node** in the **Actions** pane of the Failover Cluster Manager console.
- Pause a node. You can pause a node to prevent resources from failing over or moving to the node. You typically pause a node during maintenance or troubleshooting.
- Evict a node. You can evict a node from a cluster. You evict a node when it fails and can't be repaired right away or when it's no longer needed in the cluster. If you repair a failed node, you can add it back to the cluster.

### Monitor cluster events with Event Viewer

If you encounter issues affecting a failover cluster, use Event Viewer to examine events with the Critical, Error, or Warning severity level. You can review informational-level events in the Failover Clustering Operations log in Event Viewer on each cluster node. Informational-level events include such operations as nodes leaving or joining the cluster and resources transitioning between the offline or online states. Event Viewer also provides access to more detailed Debug and Analytic logs.

Windows Server doesn't replicate event logs among nodes. However, the Cluster Events option in Failover Cluster Manager provides a consolidated view of all events across all cluster nodes.

### Deploy updates to cluster nodes

With Cluster-Aware Updating (CAU) in Windows Server, you can automate deployment of updates to cluster nodes without downtime. This eliminates the need for manually coordinating patching of individual cluster nodes. CAU in Windows Server 2019 automatically evaluates the need for a restart for each installed update.

CAU can operate in one of two modes:

- Self-updating mode. Implement CAU as a clustered role running on the cluster that you intend to update.
- Remote-updating mode. Use CAU admin tools to initiate an update process from a computer that isn't part of the cluster. This provides more visibility into the progress of Updating Run but requires an administrative action to trigger it.

> [!TIP]
> To use CAU in remote-updating mode, install the Failover Clustering Tools on a remote computer with direct connectivity to the cluster nodes.

## Demonstration

The following video demonstrates how to:

- Configure a cluster role.
- Configure failover and failback of a role.
- Perform failover and failback of a role.

The main steps in the process are:

1. Create an AD DS environment:
    - Create a single-domain AD DS forest including three domain member servers.
    - Each of the servers should contain four data disks.
1. Create a Windows Server failover cluster by using Windows PowerShell.
    - Use the first two domain member servers to create a two-node cluster.
1. Set up an iSCSI target.
    - Use the third domain member servers to set up an iSCSI target.
1. Set up iSCSI storage.
    - On the third domain member server, create an iSCSI virtual disk and make it available to iSCSI initiators on the cluster nodes.
1. Set up iSCSI Initiators.
    - Configure iSCSI Initiators on the cluster nodes to set up shared storage.
1. Configure Cluster shared Volumes (CSV) by using **Failover Cluster Manager**.
1. Create and configure a cluster role by using **Failover Cluster Manager**.
1. Configure failover and failback settings of the newly-created cluster role by using **Failover Cluster Manager**.
1. Perform failover and failback of the newly-created cluster role by using **Failover Cluster Manager**.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MHJL]