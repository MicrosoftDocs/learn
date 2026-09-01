Here you learn how to deploy the first SAP HANA host using Azure NetApp Files application volume group for SAP HANA.

All deployments start with the volumes for a single SAP HANA host. The shared, log-backup, and data-backup volumes are created only for the first host. All other hosts in a multiple-host environment share these volumes, and they add only data and log volumes for each additional host.

- Before you begin, you should understand the [requirements and considerations for application volume group for SAP HANA](https://learn.microsoft.com/azure/azure-netapp-files/application-volume-group-considerations).
- Be sure to follow the [pinning recommendations](https://forms.cloud.microsoft/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbRxjSlHBUxkJBjmARn57skvdUQlJaV0ZBOE1PUkhOVk40WjZZQVJXRzI2RC4u) and have at least one HANA virtual machine (VM) in the availability set started. Alternatively, you can use Application volume group for SAP HANA Extension 1.

### Register for Extension 1

Azure NetApp Files application volume group for SAP HANA Extension 1 is currently in preview.

Application volume group for SAP HANA extension one offers support for:

- [Availability zone volume placement](https://learn.microsoft.com/azure/reliability/reliability-netapp-files)

Designating the same availability zone for the volumes ensures that virtual machines and Azure NetApp Files volumes reside in the same availability zone and meet the latency requirements for SAP HANA. This improvement simplifies the deployment process, avoiding the manual AvSet pinning process and eliminating the requirement for availability sets.

- [Standard network features](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-network-topologies)

Application volume group for SAP HANA now supports selecting Standard network features for all volumes in the volume group. Standard network features support enhanced security including [network security groups (NSGs)](https://learn.microsoft.com/azure/virtual-network/network-security-group-how-it-works)

You need to register the feature before using it for the first time. Feature registration may take up to 60 minutes to complete.

```powershell
Register-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFHANAVolumeGroupExtension1
```

### Deploy SAP HANA

#### SAP HANA tab

While deploying a SAP HANA host, in the **SAP HANA** tab you need to provide the following information:

- **SAP ID (SID)**: The three alphanumeric-character SAP HANA system identifier.
- **Group name**: The volume group name. For a multiple-host SAP HANA system, each host creates its own group. Because you're creating the first host, the group name starts with `Name-proposal-00001`.
- **Group description**: A description for the volume group for admin reference.
- **SAP node memory**: This value defines the size of the SAP HANA database on the host. It's used to calculate the required volume size and throughput.
- **Capacity overhead (%)**: When you use snapshots for data protection, you need to plan for extra capacity. This field adds an additional size (%) for the data volume. You can estimate this value by using "change rate per day" × "number of days retention."
- **Single-host**: Select this option for an SAP HANA single-host system or the first host for a multiple-host system. Only the shared, log-backup, and data-backup volumes are created with the first host.
- **Multiple-host**: Select this option for adding additional hosts to a multiple-host HANA system.

#### Volume group tab

In the **Volume group** tab, you need to provide information for creating the volume group:

- **Availability option**: Select either Availability zone or Proximity placement group. When selecting Availability zone, you must select the appropriate availability zone in the next field.
- **Proximity placement group (PPG)**: Specifies that the data, log, and shared volumes are to be created close to the VMs.
- **Availability Zone**: This option lets you deploy the volumes in the logical availability zone that you specify. Select an availability zone where Azure NetApp Files resources are present.
- **Network features**: Standard network feature is the default and preferred option, however you can still use Basic network features.
- **Capacity pool**: All volumes are placed in a single manual QoS capacity pool. If you want to create the log-backup and data-backup volumes in a separate capacity pool, you can choose not to add those volumes to the volume group.
- **Virtual network**: Specify an existing VNet where the VMs are placed.
- **Subnet**: Specify the delegated subnet where the IP addresses for the NFS exports are created. Ensure that you have a delegated subnet with enough free IP addresses.

#### Volumes tab

The **Volumes** tab summarizes the volumes that are being created with proposed volume name, quota, and throughput. When you select a volume in the Volumes tab, you can change the following values in the **Basics** tab:

- **Volume Name**: It's recommended that you retain the suggested naming conventions.
- **Quota**: The size of the volume.
- **Throughput**: You can increase as desired, or decrease the throughput requirements for development or test systems accordingly to the value required for your use cases.

#### Review + Create tab

The **Review + Create** tab lists all the volumes and their creation method. Select **Create Volume Group** to start the volume group creation.
