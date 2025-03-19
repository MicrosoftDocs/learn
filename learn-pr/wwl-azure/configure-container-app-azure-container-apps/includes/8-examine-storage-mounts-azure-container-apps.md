A container app has access to different types of storage. A single app can take advantage of more than one type of storage if necessary.

| Storage type | Description | Usage examples |
|---|---|---|
| Container-scoped storage | Ephemeral storage available to a running container. | Writing a local app cache. |
| Replica-scoped storage | Ephemeral storage for sharing files between containers in the same replica. | The main app container writing log files that a sidecar container processes. |
| Azure Files | Permanent storage. | Writing files to a file share to make data accessible by other systems. |

## Ephemeral storage

A container app can read and write temporary data to ephemeral storage. Ephemeral storage can be scoped to a container or a replica. The total amount of container-scoped and replica-scoped storage available to each replica depends on the total number of vCPUs allocated to the replica.

| vCPUs | Total ephemeral storage |
|---|---|
| 0.25 or lower | 1 GiB |
| 0.5 or lower | 2 GiB |
| 1 or lower | 4 GiB |
| Over 1 | 8 GiB |

### Container-scoped storage

A container can write to its own file system.

Container file system storage has the following characteristics:

- The storage is temporary and disappears when the container is shut down or restarted.
- Files written to this storage are only visible to processes running in the current container.

### Replica-scoped storage

You can mount an ephemeral, temporary volume that is equivalent to EmptyDir (empty directory) in Kubernetes. This storage is scoped to a single replica. Use an EmptyDir volume to share data between containers in the same replica.

Replica-scoped storage has the following characteristics:

- Files are persisted for the lifetime of the replica.

    - If a container in a replica restarts, the files in the volume remain.

- Any init or app containers in the replica can mount the same volume.

- A container can mount multiple EmptyDir volumes.

To configure replica-scoped storage, first define an EmptyDir volume in the revision. Then define a volume mount in one or more containers in the revision.

## Azure Files volume

You can mount a file share from Azure Files as a volume in a container.

Azure Files storage has the following characteristics:

- Files written under the mount location are persisted to the file share.

- Files in the share are available via the mount location.

- Multiple containers can mount the same file share, including ones that are in another replica, revision, or container app.

- All containers that mount the share can access files written by any other container or method.

- More than one Azure Files volume can be mounted in a single container.

To enable Azure Files storage in your container, you need to set up your environment and container app as follows:

- Create a storage definition in the Container Apps environment.
- If you're using NFS, your environment must be configured with a custom VNet and the storage account must be configured to allow access from the VNet.
- If your environment is configured with a custom VNet, you must allow ports 445 and 2049 in the network security group (NSG) associated with the subnet.
- Define a volume of type AzureFile (SMB) or NfsAzureFile (NFS) in a revision.
- Define a volume mount in one or more containers in the revision.
- The Azure Files storage account used must be accessible from your container app's virtual network. If you're using NFS, you must also disable secure transfer.
