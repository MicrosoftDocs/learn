Earlier, you discovered the container becomes the unit you'll use to distribute your apps. You also learned the container is in a standardized format both your developer and operation teams use.

In your example, you're developing an order-tracking portal that your company's various outlets will use. With the Docker image built, your operations team is now responsible for the deploying, rolling out updates, and managing your order-tracking portal.

In the previous unit, you looked at how a Docker image is built. Here, you'll look a bit at a Docker container's lifecycle and how to manage containers. You'll also look at how to think about configuring data storage and the network options for your containers.

## How to manage Docker containers

A Docker container has a lifecycle that you can use to manage and track the state of the container.

:::image type="content" source="../media/4-docker-container-lifecycle-2.png" alt-text="Diagram that shows the lifecycle of a container and the transition between the lifecycle phases.":::

To place a container in the run state, use the _run_ command. You can also restart a container that's already running. When restarting a container, the container receives a termination signal to enable any running processes to shut down gracefully before the container's kernel terminates.

A container is considered in a running state until it's either paused, stopped, or killed. A container, however, can also exit from the run state by itself. A container can self-exit when the running process completes, or if the process goes into a fault state.

To pause a running container, use the _pause_ command. This command suspends all processes in the container.

To stop a running container, use the _stop_ command. The stop command enables the working process to shut down gracefully by sending it a termination signal. The container's kernel terminates after the process shuts down.

If you need to terminate the container, use the _kill_ command to send a kill signal. The container's kernel captures the kill signal, but the running process doesn't. This command forcefully terminates the working process in the container.

Lastly, to remove containers that are in a stopped state, use the _remove_ command. After removing a container, all data stored in the container gets destroyed.

## How to view available containers

To list running containers, run the `docker ps` command. To see all containers in all states, pass the `-a` argument.

Here's an example:

```console
docker ps -a
```

Here's the output from that command:

```output
CONTAINER ID    IMAGE        COMMAND         CREATED       STATUS           PORTS        NAMES
d93d40cc1ce9    tmp-ubuntu:latest  "dotnet website.dll …"  6 seconds ago    Up 5 seconds        8080/tcp      happy_wilbur
33a6cf71f7c1    tmp-ubuntu:latest  "dotnet website.dll …"  2 hours ago     Exited (0) 9 seconds ago            adoring_borg
```

There are three items to review in the preceding output:

- The image name listed in the _IMAGE_ column; in this example, _tmp-ubuntu: latest_. Notice how you're allowed to create more than one container from the same image. This is a powerful management feature you can use to enable scaling in your solutions.

- The container status listed in the _STATUS_ column. In this example, you have one container that's running and one container that has exited. The container's status is usually your first indicator of the container's health.

- The container name listed in the _NAMES_ column. Apart from the container ID in the first column, containers also receive a name. In this example, you didn't explicitly provide a name for each container, and as a result, Docker gave the container a random name. To give a container an explicit name using the `--name` flag, use the `run` command.

### Why are containers given a name?

This feature enables you to run multiple container instances of the same image. Container names are unique, which means if you specify a name, you can't reuse that name to create a new container. The only way to reuse a specific name is to remove the previous container.

## How to run a container

To start a container, use the `docker run` command. You only need to specify the image to run with its name or ID to launch the container from the image. A container launched in this manner provides an interactive experience.

Here, to run the container with our website in the background, add the `-d` flag.

```console
docker run -d tmp-ubuntu
```

The command, in this case, only returns the ID of the new container.

After you specify an image to run, Docker finds the image, loads container from the image, and executes the command specified as the entry point. It's at this point that the container is available for management.

## How to pause a container

To pause a container, run the `docker pause` command. Here's an example:

```console
docker pause happy_wilbur
```

Pausing a container suspends all processes. This command enables the container to continue processes at a later stage. The `docker unpause` command unsuspends all processes in the specified containers.

### How to restart a container

To restart containers, run the `docker restart` command. Here's an example:

```console
docker restart happy_wilbur
```

The container receives a stop command followed by a start command. If the container doesn't respond to the stop command, then a kill signal is sent.

### How to stop a container

To stop a running container, run the `docker stop` command. Here's an example:

```console
docker stop happy_wilbur
```

The stop command sends a termination signal to the container and the processes running in the container.

### How to remove a container

To remove a container, run the `docker rm` command. Here's an example:

```console
docker rm happy_wilbur
```

After you remove the container, all data in the container is destroyed. It's essential to always consider containers as temporary when thinking about storing data.

## Docker container storage configuration

As we described earlier, always consider containers as temporary when the app in a container needs to store data.

Let's assume your tracking portal creates a log file in a subfolder to the root of the app; that is, directly to the container file system. When your app writes data to the log file, the system writes the data to the writable container layer.

Even though this approach works, it unfortunately has several drawbacks.

- **Container storage is temporary.**

    Your log file won't persist between container instances. For example, let's assume that you stop and remove the container. When you launch a new container instance, the new instance bases itself on the specified image, and all your previous data will be missing. Remember, all data in a container is destroyed with the container when you remove a container.

- **Container storage is coupled to the underlying host machine.**

    Accessing or moving the log file from the container is difficult, because the container is coupled to the underlying host machine. You have to connect to the container instance to access the file.

- **Container storage drives are less performant.**

    Containers implement a storage driver to allow your apps to write data. This driver introduces an extra abstraction to communicate with the host OS kernel, and is less performant than writing directly to a host filesystem.

Containers can make use of two options to persist data. The first option is to make use of _volumes_, and the second is _bind mounts_.

### What is a volume?

A volume is stored on the host filesystem at a specific folder location. Choose a folder where you know the data won't be modified by non-Docker processes.

Docker creates and manages the new volume by running the `docker volume create` command. This command can form part of our Dockerfile definition, which means that you can create volumes as part of the container-creation process. Docker will create the volume if it doesn't exist when you try to mount the volume into a container the first time.

Volumes are stored within directories on the host filesystem. Docker will mount and manage the volumes in the container. After mounting, these volumes are isolated from the host machine.

Multiple containers can simultaneously use the same volumes. Volumes also don't get removed automatically when a container stops using the volume.

In this example, you can create a directory on our container host and mount this volume into the container when you create the tracking portal container. When your tracking portal logs data, you can access this information via the container host's filesystem. You'll have access to this log file even if your container is removed.

Docker also provides a way for third-party companies to build add-ons to be used as volumes. For example, Azure Storage provides a plugin to mount Azure Storage as volumes on Docker containers.

### What is a bind mount?

A bind mount is conceptually the same as a volume; however, instead of using a specific folder, you can mount any file or folder on the host. You're also expecting that the host can change the contents of these mounts. Just like volumes, the bind mount is created if you mount it and it doesn't yet exist on the host.

Bind mounts have limited functionality compared to volumes, and even though they're more performant, they depend on the host having a specific folder structure in place.

Volumes are considered the preferred data-storage strategy to use with containers.

For Windows containers, another option is available: You can mount an SMB path as a volume and present it to containers. This allows containers on different hosts to use the same persistent storage.

## Docker container network configuration

The default Docker network configuration allows for isolating containers on the Docker host. This feature enables you to build and configure apps that can communicate securely with each other.

Docker provides different network settings for Linux and Windows.

For Linux, there are six preconfigured network options:

- Bridge
- Host
- Overlay
- IPvLan
- MACvLan
- None

For Windows, there are six preconfigured network options:

- NAT (Network Address Translation)
- Transparent
- Overlay
- L2Bridge
- L2Tunnel
- None

You can choose which of these network configurations to apply to your container depending on its network requirements.

### What is the bridge network?

The bridge network is the default configuration applied to containers when launched without specifying any other network configuration. This network is an internal, private network used by the container, and it isolates the container network from the Docker host network.

Each container in the bridge network is assigned an IP address and subnet mask, with the hostname defaulting to the container name. Containers connected to the default bridge network are allowed to access other bridge-connected containers by IP address. The bridge network doesn't allow communication between containers using hostnames.

By default, Docker doesn't publish any container ports. To enable port mapping between the container ports and the Docker host ports, use the Docker port `--publish` flag.

The publish flag effectively configures a firewall rule that maps the ports.

In this example, your tracking portal is accessible to clients browsing to port 80. You'll have to map port 80 from the container to an available port on the host. You have port 8080 open on the host, which enables you to set the flag like this:

```console
--publish 8080:80
```

Any client browsing to the Docker host IP and port 8080 can access the tracking portal.

Aside from Linux-specific configurations, the NAT network on Windows hosts functions the same as a bridge network. Also, NAT is the default network on Windows, and all containers will connect to it unless otherwise specified.

### What is the host network?

The host network enables you to run the container on the host network directly. This configuration effectively removes the isolation between the host and the container at a network level.

In this example, let's assume you decide to change the networking configuration to the host network option. Your tracking portal is still accessible using the host IP. You can now use the well-known port 80 instead of a mapped port.

Keep in mind that the container can use only ports the host isn't already using.

On Windows, the host network isn't available. On Windows hosts, there's no option to share the same IP address (networking stack) between the host and container. The NAT network functions much like a bridge network, and the Overlay option provides an IP address to the container from the same network as the host, but not the _same_ IP address.

### Overlay and other network options

For more advanced scenarios, both Linux and Windows provide additional network options. For example, the overlay option creates a virtual switch from the host network, so containers on that network can get IP addresses from DHCP servers or operate with IP addresses from that network segment. Furthermore, Docker allows third-party vendors to create network plugins.

### What is the none network?

To disable networking for containers, use the _none_ network option. This might be useful if you have an application that doesn't use the network, or if you just want to validate that an application runs as expected in a container.

### Operating system considerations

Keep in mind that there are differences among desktop operating systems for the Docker network-configuration options. For example, the _Docker0_ network interface isn't available on macOS when using the bridge network, and using the host-network configuration isn't supported for both Windows and macOS desktops.

These differences might affect the way your developers configure their workflow to manage container development. In addition, container orchestrators might also provide other networking configurations on top of the Docker setup.
