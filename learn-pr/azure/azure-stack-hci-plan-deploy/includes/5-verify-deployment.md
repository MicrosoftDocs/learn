Before deploying production workloads into an Azure Stack HCI cluster, you should confirm that its intended configuration is valid and meets intended performance objectives. Several validation steps provide complementing checks, including:

- Validation of cluster configuration by using Failover Clustering validation tools.
- Validation of cluster performance by using synthetic workloads.

The validation process should be also part of the cluster deployment process in the Contoso's proof-of-concept environment.

## Assess cluster configuration by using Failover Clustering validation tools

The Windows Server Failover Clustering feature offers built-in functionality to run a set of tests on a collection of servers, networks, and associated storage that are either part of an existing cluster or are supposed to form a new one. The validation process tests the underlying hardware and software to assess whether the current configuration adheres to Microsoft support requirements. The test identifies all misconfigurations and generates a report containing a comprehensive summary of its findings.

Cluster validation is ideal for:

- Preparing for deployment of production workloads into a newly installed cluster.
- Preparing for releasing workloads running on clustered guest VMs into production.
- Adding a new server to an existing cluster.
- Adding drives to the nodes of the existing cluster.
- Applying changes that affect cluster firmware or drivers.
- Restoring cluster configuration or its nodes from backup.
- Performing diagnostic tests on an existing cluster.

You can run cluster validation by using the:

- Validate Cluster option in Windows Admin Center.
- Validate a Configuration Wizard in Failover Cluster Manager.
- `Test-Cluster` Windows PowerShell cmdlet.

> [!CAUTION]
> Running the Validate Cluster option in Windows Admin Center requires that you enable Credential Security Service Provider (CredSSP) authentication for the duration of the validation process. You should disable it afterwards for security reasons. You can enable and disable CredSSP directly from Windows Admin Center.

## Validate the network operational state by using Test-NetStack

Test-NetStack is a PowerShell-based testing tool that you [download from GitHub](https://github.com/microsoft/Test-NetStack). Test-NetStack performs ICMP, TCP, and RDMA traffic testing of networks and can help identify potential network fabric and host misconfiguration or operational instability.

Test-NetStack can validate the various network data paths, testing native, synthetic, and hardware offloaded (RDMA) data paths for issues with:

- Connectivity.
- Packet fragmentation.
- Low throughput.
- Congestion.

## Validate cluster performance by using synthetic workloads

The most comprehensive performance validation approach relies on generating synthetic workloads that simulate the projected usage patterns, capturing relevant performance characteristics, and analyzing the captured data. To implement this approach on Azure Stack HCI, you use the utilities that are part of the GitHub DISKSPD repo, including VM Fleet. VM Fleet provisions a distributed set of VMs to emulate the functional or performance impact of actual workloads in your Azure Stack HCI cluster.
