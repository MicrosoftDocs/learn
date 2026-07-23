Create application volume group (AVG) for Oracle using the REST API.

### Application volume group create

In a `create` request, use the following URI format:

`/subscriptions/<subscriptionId>/providers/Microsoft.NetApp/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.NetApp/netAppAccounts/<accountName>/volumeGroups/<volumeGroupName>?api-version=<apiVersion>`

| URI parameter | Description | Restrictions for Oracle AVG |
| --- | --- | --- |
| subscriptionId | Subscription ID |  |
| resourceGroupName | Resource group name |  |
| accountName | NetApp account name |  |
| volumeGroupName | Volume group name | The recommended format is `<SID>-<Name>`. SID can contain alphanumeric characters, hyphens (`-`), and underscores (`_`) only. It must be min 3 characters and max 12 characters and begin with a letter. Name is a string of your choice. Example: `ORA-Testing`. |
| apiVersion | API version | Must be `2023-05-01` or later |

### Request body

The request body consists of the *outer* parameters, the group properties, and an array of volumes to be created, each with their individual outer parameters and volume properties.

The following table describes the request body parameters and group level properties required to create an Oracle deployment.

| URI parameter | Description | Restrictions for Oracle AVG |
| --- | --- | --- |
| Location | Region in which to create the application volume group | No |
| **Group Properties** |  |  |
| groupDescription | Description for the group | Free-form string |
| applicationType | Application type | Use `ORACLE` for AVG for Oracle deployments |
| applicationIdentifier | Application specific identifier string | For Oracle, this parameter is the unique system ID |
| deploymentSpecId | Deployment specification identifier defining the rules to deploy the specific application volume group type | Must be: `10542149-bfca-5618-1879-9863dc6767f1` |
| volumes | Array of volumes to be created (see the next table for volume-granular details) | There can be 2-12 volumes as part of Oracle deployment: **Required**: 1 data and 1 log; **Optional**: data 2-8, mir-log, backup, binary |

The following table describes the request body parameters and volume properties for creating a volume in an Oracle application volume group.

| Volume-level request parameter | Description | Restrictions for Oracle |
| --- | --- | --- |
| name | Volume name, which includes Oracle SID to identify database using the volumes in the group | Examples or recommended volume names: `<sid>-ora-data1`, `<sid>-ora-data2`, `<sid>-ora-log`, `<sid>-ora-log-mirror`, `<sid>-ora-binary`, `<sid>-ora-backup` |
| tags | Volume tags |  |
| zones | Availability Zones | If the region has availability zones, then you must select zones (1, 2, or 3). If a region has no available zones and the use of PPG isn't enabled, you can go for regional deployment (requires PPG activation). |

To learn more about how to create Oracle volume groups using `curl` and see related examples, [see this guidance](https://learn.microsoft.com/azure/azure-netapp-files/configure-application-volume-oracle-api#create-application-volume-groups-for-oracle-using-curl).
