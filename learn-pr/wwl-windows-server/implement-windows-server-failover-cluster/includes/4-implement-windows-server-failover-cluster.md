Windows Server failover clusters have more stringent hardware and software requirements than standalone servers, so implementation requires additional validation tasks. Your cluster provisioning will be simplified by performing successful validation before implementing failover clusters.

## Failover cluster validation

Cluster validation is a critical component of failover clustering lifecycle. You should use it not only prior to the initial deployment but also following a wide range of configuration changes. It's also helpful when troubleshooting performance and stability issues. You can use Failover Cluster Manager or Windows PowerShell to run validation. Both run a wide range of tests to ensure that you configured cluster components in the supported manner.

> [!IMPORTANT]
> All the tests in the Validate a Configuration Wizard must pass before the cluster is considered a configuration that Microsoft supports.

You should run validation tests whenever you make any major configuration changes, including:

- Adding a node to the cluster.
- Upgrading or replacing storage hardware.
- Upgrading firmware or drivers of host bus adapters.
- Updating multipathing software or a version of device-specific modules.
- Changing or updating a network adapter.

Microsoft Support might also ask you to run validation tests when troubleshooting a production cluster. In some scenarios, you might want to run only a subset of the tests. For example, when troubleshooting a problem with networking, Microsoft Support might ask you to run only the hardware and software inventory and the networking test against the production cluster.

> [!IMPORTANT]
> Running validation tests against storage triggers the transition of disk resources, and the resources that depend on these disks, into the offline state. You should only run these tests when the resources aren't in use.

## Create a failover cluster

Once you have validated the configuration of the servers that will form a failover cluster, you can proceed with the provisioning process.

### Create a failover cluster by using the Failover Cluster Manager console

The Create Cluster Wizard in the Failover Cluster Manager console guides you through the cluster provisioning process, prompting you to specify:

- The servers to include in the cluster.
- The name of the cluster.
- Static IP address configuration settings.

Once the provisioning completes, you can review the installation report directly in the Create Cluster Wizard interface or by accessing the corresponding file in the `C:\Cluster\Reports` directory.

### Create a failover cluster in Windows Admin Center

*Windows Admin Center* is a browser-based management tool used to manage Windows Server computers. You can manage failover cluster nodes as individual servers by adding them as server connections in Windows Admin Center. You can also add them as failover clusters to a view, and manage cluster resources, storage, network, nodes, roles, VMs, and virtual switches.

In addition, Windows Admin Center provides an intuitive interface, with which you can:

- Examine cluster performance history to assess the status of clusters and their nodes.
- Examine the system insights feature of Windows Server, which uses machine learning and predictive analytics to facilitate capacity planning.

> [!NOTE]
> You can also implement a failover cluster by using Windows PowerShell. The demo concluding this unit illustrates this type of installation.

## Configure quorum

The cluster automatically assigns a vote to each node and dynamically manages the node votes. If suitable shared storage is available, the cluster will automatically select a witness disk to optimize the high availability configuration of your cluster.

You can change, add, or remove a witness resource. The Configure Cluster Quorum Wizard available from the Failover Cluster Manager console allows you to validate whether the current quorum configuration is optimal for a cluster. The test output provides recommendations if a change to the quorum is warranted. You can also use the Configure Cluster Quorum Wizard to apply the recommended settings.

You might want to consider changing the quorum configuration when:

- You need to add or evict nodes.
- You need to add or remove storage.
- A long-term node or witness failure occurs.
- You need to recover a cluster in a multi-site disaster recovery scenario.

## Demonstration

The following video demonstrates how to:

- Validate cluster configuration.
- Create a Windows Server failover cluster by using Windows PowerShell.
- Configure a Windows Server failover cluster quorum.

The main steps in the process are:

1. Create an AD DS environment. Create a single-domain AD DS forest with two domain members servers.
1. Validate failover cluster configuration. Use Windows PowerShell to validate whether two domain member servers are suitable for the setup of a failover cluster.
1. Create a failover cluster. Use Windows PowerShell to create a failover cluster.
1. Configure a Windows Server failover cluster quorum.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MJKA]