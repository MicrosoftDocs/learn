Learn how to deploy Azure NetApp Files application volume group for Oracle.

Before you begin, you should understand the [requirements and considerations for application volume group for SAP HANA](https://learn.microsoft.com/azure/azure-netapp-files/application-volume-group-considerations).

### Register for feature

Azure NetApp Files application volume group for Oracle is currently in preview. Before using this feature for the first time, you need to register it.

```powershell
Register-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFOracleVolumeGroup

```

### Deploy

While deploying an application volume group for Oracle, you need to provide the following information.

1. **Unique System ID (SID):**
  Choose a unique identifier that will be used in the naming proposals for all your storage objects and helps to uniquely identify the volumes for this database.
2. **Group name / Group description:**
  Provide the volume group name and description.
3. **Number of Oracle data volumes (1-8):**
  Depending on your sizing and performance requirements of the database you can create a minimum of 1 and up to 8 data volumes.
4. **Oracle database size in (TiB):**
  Specify the total capacity required for your database. If your performance and capacity inputs require more than one database volume, the capacity is distributed evenly among all volumes. You may change each individual volume once the proposals have been created.
5. **Additional capacity for snapshots (%):**
  It's highly recommended to use snapshots for primary data protection and recovery. Snapshots take relatively small spaces, but you need to plan for extra capacity. This field adds an additional size (%) for the data volume.
6. **Oracle database storage throughput (MiB/s):**
  Specify the total throughput required for your database. If you select more than one database volume, the throughput is distributed evenly among all volumes. You may change each individual volume once the proposals have been created.

In the **Volume group** tab, you need to provide information for creating the volume group:

1. **Availability options:** There are two Availability options.
2. **Availability Zone:** Select the zone where Azure NetApp Files is available. In regions without zones, you can select no.
3. **Network features:** Select either Basic or Standard network features. All volumes should use the same network feature. This selection is set for each individual volume.
4. **Capacity pool:** All volumes will be placed in a single manual QoS capacity pool.
5. **Virtual network:** Specify an existing VNet where the VMs are placed.
6. **Subnet:** Specify the delegated subnet where the IP addresses for the NFS exports will be created. Ensure that you have a delegated subnet with enough free IP addresses.

Next, the **Volumes** tab summarizes the volumes that are being created with proposed volume name, quota, and throughput. When you select a volume in the Volumes tab, you can change the following values in the **Basics** tab:

- **Volume Name:** It's recommended that you retain the suggested naming conventions.
- **Quota:** The size of the volume.
- **Throughput:** You can edit the proposed throughput requirements for the selected volume.

The **Review + Create** tab lists all the volumes and their creation method. Select **Create Volume Group** to start the volume group creation.
