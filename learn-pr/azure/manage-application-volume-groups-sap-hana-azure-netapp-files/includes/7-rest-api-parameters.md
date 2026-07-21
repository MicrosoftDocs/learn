Application volume groups allow you to define volume size and throughput according to your specific requirements. To ensure you can customize to your specific needs, you must only use manual QoS capacity pools. According to the SAP HANA certification, only a subset of volume features can be used for the different volumes. Since enterprise applications such as SAP HANA require application-consistent data protection, it's *not* recommended to configure automated snapshot policies for any of the volumes. Instead consider using specific data protection applications such as [AzAcSnap](https://learn.microsoft.com/azure/azure-netapp-files/azacsnap-introduction) or Commvault.

The following tables describe the generic application volume group creation using the REST API, detailing selected parameters, and properties required for SAP HANA application volume group creation.

### Application volume group create

In a create request, use the following URI format:

`/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.NetApp/netAppAccounts/<accountName>/volumeGroups/<volumeGroupName>?api-version=<apiVersion>`

| URI parameter | Description | Restrictions for SAP HANA |
| --- | --- | --- |
| subscriptionId | Subscription ID | None |
| resourceGroupName | Resource group name | None |
| accountName | NetApp account name | None |
| volumeGroupName | Volume group name | The recommended format is `<SID>-<Name>-<ID>` where SID is the HANA System ID, Name is a string of your choosing, and ID is the five-digit HANA Host ID. Example: `SH9-Testing-00003` |
| apiVersion | API version | Must be 2022-03-01 or later |

### Request body

The request body consists of the *outer* parameters, the group properties, and an array of volumes to be created, each with their individual outer parameters and volume properties.

The following table describes the request body parameters and group level properties required to create an SAP HANA application volume group.

| URI parameter | Description | Restrictions for SAP HANA |
| --- | --- | --- |
| Location | Region in which to create the application volume group | None |
| **GROUP PROPERTIES** | | |
| groupDescription | Description for the group | Free-form string |
| applicationType | Application type | Must be `"SAP-HANA"` |
| applicationIdentifier | Application specific identifier string, following application naming rules | The SAP System ID, for example `SH9` |
| volumes | Array of volumes to be created | Volume count depends on host configuration: Single-host (3–5 volumes): required data, log, and shared; optional data-backup and log-backup. Multiple-host (two volumes): required data and log. |

The following table describes the request body parameters and volume properties for creating a volume in an SAP HANA application volume group.

| Volume-level request parameter | Description | Restrictions for SAP HANA |
| --- | --- | --- |
| name | Volume name | Examples: `SH9-data-mnt00001` (data, single-host), `SH9-log-backup` (log-backup, single-host), `HSR-SH9-shared` (shared, HSR secondary), `DR-SH9-data-backup` (CRR destination), `DR2-SH9-data-backup` (CRR destination of HSR secondary). |
| tags | Volume tags | Optionally add a tag to HSR partner volumes: Name `HSRPartnerStorageResourceId`, Value `<Partner volume Id>`. |
| **VOLUME PROPERTIES** | **Description** | **SAP HANA Value Restrictions** |
| creationToken | Export path name, typically same as the volume name | Example: `SH9-data-mnt00001` |
| throughputMibps | QoS throughput | Must be between 1 Mbps and 4500 Mbps. Set throughput based on volume type. |
| usageThreshold | Size of the volume in bytes, in the 50 GiB to 100 TiB range | Example: 100 GiB = 107374182400 bytes. Set volume size depending on volume type. |
| exportPolicyRule | Volume export policy rule | At least one export policy rule must be specified. Modifiable values: `unixReadOnly` (should be false), `unixReadWrite` (should be true), `allowedClients` (use `0.0.0.0/0` for no restrictions), `hasRootAccess` (must be true to install SAP), `chownMode`, `nfsv41` (true for data, log, and shared volumes), `nfsv3` (optionally true for data-backup and log-backup). All other rule values must be left at defaults. |
| volumeSpecName | Specifies the type of volume for the application volume group | Must be one of: `"data"`, `"log"`, `"shared"`, `"data-backup"`, or `"log-backup"`. |
| proximityPlacementGroup | Resource ID of the Proximity Placement Group (PPG) | Required for data, log, and shared volumes. Required but ignored for data-backup and log-backup volumes. |
| subnetId | Delegated subnet ID for Azure NetApp Files | The number of IP addresses required depends on the order of the application volume group created in the subscription. The first group typically requires 3–5 IP addresses; subsequent groups typically require fewer. |
| capacityPoolResourceId | ID of the capacity pool | The capacity pool must be of type manual QoS. All SAP volumes are generally placed in a common capacity pool, but this isn't a requirement. |
| protocolTypes | Protocol to use | Should be either NFSv3 or NFSv4.1, and must match the protocol specified in the Export Policy Rule. |

To learn more about how to create SAP HANA volume groups using **curl** and see related examples, see [Configure application volume groups for SAP HANA using REST API](https://learn.microsoft.com/azure/azure-netapp-files/configure-application-volume-group-sap-hana-api?tabs=without-extension-1#creating-sap-hana-volume-groups-using-curl).
