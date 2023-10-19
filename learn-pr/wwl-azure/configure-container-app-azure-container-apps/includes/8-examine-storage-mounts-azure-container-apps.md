A container app has access to different types of storage. A single app can take advantage of more than one type of storage if necessary.

| Storage type | Description | Usage examples |
|---|---|---|
|Container file system | Temporary storage scoped to the local container | Writing a local app cache. |
| Ephemeral storage | Temporary storage scoped to an individual replica | Sharing files between containers in a replica. For instance, the main app container can write log files that are processed by a sidecar container. |
| Azure Files | Permanent storage | Writing files to a file share to make data accessible by other systems. |

## Container file system

A container can write to its own file system.

Container file system storage has the following characteristics:

- The storage is temporary and disappears when the container is shut down or restarted.

- Files written to this storage are only visible to processes running in the current container.

- There are no capacity guarantees. The available storage depends on the amount of disk space available in the container.

## Ephemeral volume

You can mount an ephemeral, temporary volume that is equivalent to emptyDir in Kubernetes. Ephemeral storage is scoped to a single replica.

Ephemeral storage has the following characteristics:

- Files are persisted for the lifetime of the replica.

    - If a container in a replica restarts, the files in the volume remain.

- Any containers in the replica can mount the same volume.

- A container can mount multiple ephemeral volumes.

- The available storage depends on the total number of vCPUs allocated to the replica.

## Azure Files volume

You can mount a file share from Azure Files as a volume in a container.

Azure Files storage has the following characteristics:

- Files written under the mount location are persisted to the file share.

- Files in the share are available via the mount location.

- Multiple containers can mount the same file share, including ones that are in another replica, revision, or container app.

- All containers that mount the share can access files written by any other container or method.

- More than one Azure Files volume can be mounted in a single container.

To enable Azure Files storage in your container, you need to set up your container in the following ways:

- Create a storage definition in the Container Apps environment.

- Define a volume of type AzureFile in a revision.

- Define a volume mount in one or more containers in the revision.
