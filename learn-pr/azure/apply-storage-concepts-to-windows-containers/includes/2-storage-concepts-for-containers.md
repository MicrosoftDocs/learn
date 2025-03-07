Windows containers by default use ephemeral storage (scratch space) for all input and output. Each container has its own scratch space, where all file creation and file writes are captured so they don't escape to the host. When a container instance is deleted, all changes that occurred in the scratch space are thrown away. When a new container instance is started, a new scratch space is provided for the instance.

## Layer storage

All containers are created from container images. A container image is a bundle of files organized into a stack of layers (referred to as layer storage) that resides on your local machine or in a remote container registry. The container image consists of the user mode operating system files needed to:

- Support your app
- Any application runtime
- Dependencies of your app
- Any other miscellaneous configuration files your app needs to run properly

In a Windows environment, layers are stored using CimFS, and are supported on NTFS (New Technology File System), ReFS, or RefDisks for layer storage. You can change where the files are stored using the `docker-root`(or equivalent with container) configuration, but you shouldn't modify any files in the layer directories. They're carefully managed using docker (or equivalent commands).

## Persistent storage

You may have cases where your app needs to be able to persist data in a container. Or you may want to store files in a container that weren't included at container build-time. You can give persistent storage to your Windows containers in a couple of ways:

- Bind mounts
- Named volumes

## Bind mounts

Bind mounts allow a container to share a directory with the host by mapping a directory on the host to a directory inside the container. Bind mounts are useful if you want a place to store files on the local machine that are available if you restart a container and lose your scratch space. Or, if you want to share a file with multiple containers.  

However, if you want a container to run on multiple machines with access to the same files, then a named volume or SMB (Server Message Block) mount should be used instead. It's important that you don't bind mount sensitive directories such as `C:\` into an untrusted container. This bind would allow it to change files on the host that it wouldn't normally have access to and could create a security breach.

The following example shows the Docker command for creating a bind mount to folder `C:\ContainerData` on the host, to `C:\data` inside the container with default read/write access:

`docker run -v c:\ContainerData:c:\data`

## Named Volumes

Named volumes allow you to create a volume by name, assign it to a container, and reuse it later by the same name. Volumes give you a way of creating and managing a special location on the host dedicated to storing container data. You don't need to keep track of the actual path of where it was created, just the name.

The Docker engine on Windows has a built-in named volume plugin that can create volumes on the local machine. If you want to use named volumes on multiple machines, another plugin is required.

The following example shows the docker commands to create and start a container named mycontainer that is mapped to the local volume `c:data`:

`docker volume create myvolume`
`docker run -v myvolume:c:\data microsoft/windowsservercore`

While bind mounts are dependent on the directory structure and operating system (OS) of the host machine, Docker completely manages volumes. Volumes have several advantages over bind mounts:

- Volumes are easier to back up or migrate than bind mounts.
- You can manage volumes using Docker CLI commands or the Docker API.
- Volumes work on both Linux and Windows containers.
- Volumes can be shared among multiple containers more safely.
- Volume drivers let you store volumes on remote hosts or cloud providers, to encrypt the contents of volumes, or to add other functionality.
- New volumes can have their content prepopulated by a container.

In addition, volumes are often a better choice than persisting data in a container's writable layer (scratch space). A volume doesn't increase the size of the containers using it (just like bind mount), and the volume's contents exist outside the lifecycle of a given container.
