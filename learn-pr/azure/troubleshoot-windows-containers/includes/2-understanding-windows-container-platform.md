To run Windows containers, you need a Windows host and a supported container runtime. For Windows containers, the available ones are containerd, Moby, and Mirantis. Mirantis Container Runtime (MCR) is based on the Docker Enterprise Edition and provides the same functionality as the product formerly called Docker Community Edition (CE). Today, Docker provides Docker Desktop for free on specific scenarios. Both the MCR and Docker are based on an Open-Source project called Moby.

Under the hood, Moby can use either the Docker Runtime (dockerd) or containerd. Containerd is also an Open-Source project that serves as container runtime that can be used on Windows or Linux and be called by Docker, Kubernetes, etc. As an industry, containerd is being widely adopted as the preferred container runtime.

When you interact with containers, you use either a Command-Line Interface (CLI) or a Graphical User Interface (GUI). For example, Docker Desktop provides both a CLI and GUI. Moby provides a CLI only. The CLI or GUI then interacts with the container runtime, such as dockerd or containerd. The container runtime will in turn send the command to the Operating System.

On Windows client (Windows 10 or Windows 11) you can install Docker Desktop. Docker Desktop will install all the required components in the Operating System, including Windows Subsystem for Linux (for Linux containers). You can then use either the GUI or the CLI to run either Linux containers or Windows containers. However, Windows client can run containers for development and testing only. For production workloads, you can use Windows Server. On Windows Server you can install either Moby, MCR or another supported tool for running with containerd.

## Windows container architecture

When troubleshooting a Windows container environment, it's important to keep in mind the different levels of interactions that take place from when you specify a command (that is: start a container) from the GUI or CLI all the way down to the Operating System.

:::image type="content" source="../media/1-windows-container-architecture.png" alt-text="Diagram that shows the components that are called when the Orchestrator requests an action on the Operating System.":::

## Host Compute Service (HCS)

HCS is a management service, which acts as a layer of abstraction above the low-level functionality. The HCS is a stable API  that the runtime (Docker, containerd) can build upon, and it's also easier to use. Making a Windows container with the HCS is just a single API call. Making a Hyper-V Container instead just means to add a flag when calling into the API.

## Host Networking Service (HNS)

HNS is the management service for container networking. It works similarly to HCS. HNS responsibilities include creating the network (Hyper-V virtual switch), network namespaces, assigns IP, DNS rules to the created endpoint.

In the image above, you can see a diagram of the operation calls from a Kubernetes environment. We'll cover Kubernetes in a later section, but for now, it's important to understand what happens under the hood when a Windows container is created:

- User applies Kubernetes deployment manifest (yaml) with kubectl.
- Kubernetes scheduler assigns the deployment to a node.
- Kubelet (Kubernetes agent running on all nodes) sees the pending container and calls the runtime to create the container.
- The runtime will call the lower-level APIs to HCS and HNS to actually create the container and its network. This applies for both Docker and containerd, although the Docker container runtime is being deprecated from the Kubernetes platform.
- Container is started and the application inside of it starts as well.

Points of failure could appear at the container, runtime, HCS/HNS, and kubelet level. If you're troubleshooting a Windows container environment, here are some general troubleshooting steps you can follow:

- Check container or application logs.
- Check for host OS and container runtime logs.
- Restart the runtime.
- Prune all resources.
- Make sure you're using the latest version. Upgrade to it if it's not the case.
- Reset to defaults, or fresh install of the runtime.
