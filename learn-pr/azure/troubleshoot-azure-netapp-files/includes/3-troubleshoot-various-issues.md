You learn resolutions to issues you might have when managing Azure NetApp Files resources.

### Troubleshoot capacity pool errors

Some error conditions you may encounter while managing capacity pools and their resolutions are given in the table below:

|  |  |
| --- | --- |
| **Error message** | **Resolution** |
| Issues creating a capacity pool | Make sure that the capacity pool count doesn't exceed the limit. See [Resource limits for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-resource-limits). |
| Issues deleting a capacity pool | Make sure that you remove all Azure NetApp Files volumes and snapshots in the subscription where you're trying to delete the capacity pool. |
| Volume creation or modification fails with **Requested throughput not available error | Available throughput for a volume is determined by its capacity pool's size and the service level. If you don't have sufficient throughput, you should increase the pool size or adjust the existing volume throughput. |
| The capacity pool size is too small for total volume size. | The error is a result of the destination capacity pool not having the available capacity for the volume being moved. Increase the size of the destination pool, or choose another pool that's larger. |
| The pool change can't be completed because a volume called `{source pool name}` already exists in the target pool `{target pool name}` | This error occurs because the volume with same name already exists in the target capacity pool. Select another capacity pool that doesn't have a volume with same name. |

For more information on troubleshooting capacity pool errors, refer to <https://learn.microsoft.com/azure/azure-netapp-files/troubleshoot-capacity-pools>

### Troubleshoot volume errors for Azure NetApp Files

Some error conditions you may encounter while creating and managing volumes and their resolutions are given in the table below:

|  |  |
| --- | --- |
| **Error message** | **Resolution** |
| The SMB or dual-protocol volume creation fails with the following error: ``{"code":"DeploymentFailed", "message" :"At least one resource deployment operation failed. Please list deployment operations for details. Please see <https://aka.ms/DeployOperations> for usage details.", "details":[{"code" :"InternalServerError", "message":"Error when creating - Could not query DNS server. Verify that the network configuration is correct and that DNS servers are available."}]}`` | This error indicates that the DNS isn't reachable. Consider the following solutions: <ul><li>If you're using Basic network features, check if Active Directory Domain Services (AD DS) and the volume are being deployed in same region</li><li>Check if AD DS and the volume are using the same virtual network (VNet). If they're using different VNets, make sure that the VNets are peered with each other. The DNS server might have network security groups (NSGs) applied. As such, it doesn't allow the traffic to flow. In this case, open the NSGs to the DNS or AD to connect to various ports.</li><ul> |
| The SMB or dual-protocol volume creation fails with the following error: ``{"code":"DeploymentFailed","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/DeployOperations for usage details.","details":[{"code":"InternalServerError", "message":"Error when creating - Failed to create the Active Directory machine account \"SMBTESTAD-C1C8\". Reason: Kerberos Error: Invalid credentials were given Details: Error: Machine account creation procedure failed [ 563] Loaded the preliminary configuration.**[ 670] FAILURE: Could not authenticate as 'test@contoso.com': ** Unknown user (KRB5KDC_ERR_C_PRINCIPAL_UNKNOWN). "}]}`` | <ul><li>Make sure that the username entered is correct.</li><li>Make sure that the user is part of the Administrator group that has the privilege to create machine (computer) accounts.</li><li>If you use Microsoft Entra Domain Services, make sure that the user is part of the Microsoft Entra group Azure AD DC Administrators.</li></ul> |
| LDAP over TLS is enabled, and dual-protocol volume creation fails with the error. ``This Active Directory has no Server root CA Certificate.`` | If this error occurs when you're creating a dual-protocol volume, make sure that the root CA certificate is uploaded in your NetApp account. |
| Error allocating volume - ``Export policy rules does not match kerberosEnabled flag`` | Azure NetApp Files doesn't support Kerberos for NFSv3 volumes. Kerberos is supported only for the NFSv4.1 protocol. |
| Error when creating an SMB volume with LDAP enabled as true: Error Message: ``ldapEnabled option is only supported with NFS protocol volume.`` | You can't create an SMB volume with LDAP enabled. Create SMB volumes with LDAP disabled. |
| Error when creating new volumes or resizing existing volumes. Error message: ``There was a problem locating [or extending] storage for the volume. Please retry the operation. If the problem persists, contact Support.`` | The error indicates that the service ran into an error when attempting to allocate resources for this request. Retry the operation after some time. Contact Support if the issue persists. |

If a volume create-read-update-delete (CRUD) operation is performed on a volume not in a terminal state, the operation will fail. Automation workflows and portal users should check for the terminal state of the volume before executing subsequent asynchronous operations on the volume.

To learn all possible volume errors and warnings you may experience with Azure NetApp Files and how to troubleshoot them refer to [Troubleshoot volume errors for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/troubleshoot-volumes).

### Troubleshoot application volume group errors

Here you see errors or warnings you might experience when using application volume groups and suggested possible remedies.

|  |  |
| --- | --- |
| **Error message** | **Resolution** |
| Out of storage capacity when creating a volume group with close proximity to compute. Error message: ``No storage available with network locality that matches the provided Proximity Placement Group.`` | <ul><li>The error indicates that there are insufficient resources available under the user-provided proximity placement group (PPG).</li><li>You should use the SAP HANA pinning process by using the [**SAP HANA VM pinning request form**](https://aka.ms/HANAPINNING) to ensure that enough resources are available.</li></ul> |
| Deployment failed with error message: ``Template parameter Token type is not valid. Expected 'Integer'. Actual 'Float'.`` | <ul><li>When application volume group calculates the size, it shows the values for all volumes in the **Volumes** tab. For very small HANA systems, some of the volumes are displayed as floating point values. The deployment will fail if the final size isn't an integer GB number.</li><li>If you look into volume details for these volumes, the floating point values will be rounded automatically to integer to avoid this deployment error.</li></ul> |

### Troubleshoot snapshot policy errors

|  |  |
| --- | --- |
| **Error message** | **Resolution** |
| Snapshot policy creation fails with invalid snapshot policy name. | An error occurs during snapshot policy creation if your snapshot policy name is invalid. The following guidelines apply for snapshot policy names: <ul><li>The snapshot policy name can't contain non-ASCII or special characters.</li><li>The snapshot policy name must begin with a letter or a number and can contain letters, numbers, underscore ('_') and hyphens ('-') only.</li><li>The snapshot policy name must be between 1 and 64 characters. Revise the snapshot policy name according to the guidelines.</li></ul> |
| Snapshot policy creation fails with invalid values. | Azure NetApp Files fails to create a snapshot policy if you enter an invalid value for a field such as ``Number of snapshots to keep or Minute on the hour to take snapshot``. The valid values are as follows: <ul><li>The value must be a valid number.</li><li>The value must be between 0 and 59.</li></ul>  Make sure that a valid value is provided for the fields. |
| Snapshot policy creation fails with the error ``Total number of snapshots to keep exceeds 255.`` | Each volume can have a [maximum of 255 snapshots](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-resource-limits). The maximum includes the sum of all hourly, daily, weekly, and monthly snapshots. Decrease the Snapshots to keep value and try again. |
| Assigning policy to a volume fails with the error ``Total snapshot policy is over the max '255'.`` | Each volume can have a [maximum of 255 snapshots](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-resource-limits). When the sum of all on-demand, hourly, daily, weekly, and monthly snapshots exceed the maximum, an error occurs. Decrease the snapshots to keep value or delete some on-demand snapshots and try again. |

### Troubleshoot cross-region replication errors

|  |  |
| --- | --- |
| **Error message** | **Resolution** |
| ``Volume {0} cannot be used as source because it is already in replication.`` | You can't create a replication with a source volume that is already in a data replication relationship. |
| ``Peered region '{0}' is not accepted.`` | You're attempting to create a replication between un-peered regions. |
| ``RemoteVolumeResource '{0}' of wrong type '{1}'.`` | Validate that the remote resource ID is a volume resource ID. |

To know all possible error messages and resolutions that can help you troubleshoot cross-region replication issues for Azure NetApp Files, refer to [Troubleshoot cross-region replication errors](https://learn.microsoft.com/azure/azure-netapp-files/troubleshoot-cross-region-replication).

### Troubleshoot Azure NetApp Files Resource Provider errors

You learn the common Azure NetApp Files Resource Provider errors, their causes, solutions, and workarounds (if available).

1. ***Creation of netAppAccounts has been restricted in this region.***

    This situation occurs when the user attempts to create a NetApp account.

    - Cause:
      Azure Resource Provider for Azure NetApp Files isn't registered successfully.
    - Solution:
      Complete all the steps described in Register the NetApp Resource Provider.

2. ***BareMetalTenantId cannot be changed.***

    This error occurs when you try to update or patch a volume and the BaremetalTenantId property has a changed value.

    - Cause:
      You're trying to update a volume and the BaremetalTenantId property has a different value from the value stored in Azure.
    - Solution:
      Don't include BaremetalTenantId in the patch and update (put) request. Alternatively, make sure BaremetalTenantId is the same in the request.

3. ***ServiceLevel cannot be changed.***

    This error occurs when you try to update or patch a capacity pool with a different service level when the capacity pool already has volumes in it.

    - Cause:
      You're trying to update a capacity pool service level when the pool contains volumes.
    - Solution:
      Delete all volumes from the capacity pool, then change the service level.
    - Workaround:
      Create another capacity pool, then create the volumes again in the new capacity pool.

4. ***PoolId cannot be changed***

    This error occurs when you try to update or patch a capacity pool with a changed PoolId property.

    - Cause:
      You're trying to update a capacity pool PoolId property. The PoolId property is a read-only property and can't be changed.
    - Solution:
      Don't include PoolId in the patch and update (put) request. Alternatively, make sure PoolId is the same in the request.

5. ***CreationToken cannot be changed.***

    This error occurs when you try to change the file path (CreationToken) after the volume has been created. File path (CreationToken) must be set when the volume is created, and it can't be changed later.

    - Cause:
      You're trying to change the file path (CreationToken) after the volume has been created, which isn't a supported operation.
    - Solution:
      If changing the file path isn't needed, then consider removing the parameter from the request to dismiss the error message.
    - Workaround:
      If you need to change the file path (CreationToken), you can create a new volume with a new file path, and then migrate the data to the new volume.

6. ***CreationToken must be at least 16 characters long.***

    This error occurs when the file path (CreationToken) doesn't meet the length requirement. The length of the file path must be at least one character in length.

    - Cause:
      The file path is empty. When you create a volume by using the API, a creation token is required. If you're using the Azure portal, the file path is generated automatically.
    - Solution:
      Enter at least one character as the file path (CreationToken).
    
To learn more Azure NetApp Files Resource Provider errors, their causes, solutions, and workarounds (if available), refer to [Troubleshoot Azure NetApp Files Resource Provider errors](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-troubleshoot-resource-provider-errors/).
