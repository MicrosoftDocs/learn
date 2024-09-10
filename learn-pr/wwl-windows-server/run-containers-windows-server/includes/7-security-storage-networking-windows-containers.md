Contoso has asked you, as the Windows Server administrator, to evaluate the security, storage and networking needs of Windows containers. You're especially interested in understanding how those needs differ between containers and VMs in Windows Server.

**Windows containers security**

Windows containers are built on the same base as Windows instances running on physical or virtual machines. However, some security aspects are either handled differently or are specific for Windows containers:

- **Shared components.** Windows containers share some of the host's components for security purposes. This includes the Windows Firewall, Windows Defender (Antivirus), and other resource access limitations. You don't need to configure these components on your container directly because the container host makes the necessary adjustments based on your container workload. For example, if the container makes a web request, the container host will forward the necessary traffic through its firewall so the container can access the web.

- **Isolation mode.** Windows containers can be deployed in process or Hyper-V isolation mode, with Hyper-V providing the most secure isolation. In process isolation, the container shares its kernel, file system, and registry with the host, which allows for an elevated (admin) process to interact with the container processes and services. Choosing the correct isolation mode for your application is important to ensure the appropriate security mode.

- **Windows updates.** Because the servicing stack isn't present on Windows containers, Windows containers don't receive updates like general Windows instances. Instead, you need to rebuild Windows containers using the latest available base container image. Customers can leverage Azure pipelines for that purpose. Microsoft updates the base container images for all its official images each month following the Patch Tuesday cadence.

- **Container user account.** By default, applications inside Windows containers run with elevated privileged under the ContainerAdmin user account. This is helpful for installing and configuring the necessary components inside the container image. However, you should consider changing the user account to ContainerUser when running an application that doesn't require the elevated privileges. For specific scenarios, you can also create a new account with the appropriate privileges.

- **Image and runtime scanning.** Containers require that images on repositories and containers instances are secure. Microsoft recommends that you use Microsoft Defender for Containers for image scanning and runtime scanning. Defender for Containers supports Windows containers for vulnerability assessment with registry scan and runtime protection with threat detection.

For more information on security of Windows containers, see [Secure Windows containers](/virtualization/windowscontainers/manage-containers/container-security).

**Persistent storage for Windows containers**

Windows containers by default use ephemeral storage. All container I/O happens in a "scratch space". A scratch space is a temporary storage provided to the container for changes in the file system. Each container gets their own scratch. File creation and file writes are captured in the scratch space and do not escape to the host. When a container instance is deleted, all changes that occurred in the scratch space are thrown away. When a new container instance is started, a new scratch space is provided for the instance.

You may have cases where it's important that an app be able to persist data in a container, or you want to show files into a container that were not included at container build-time. For that purpose, persistent storage can be provided to Windows containers.

Persistent storage can be provided to Windows containers either via the Docker engine or the container orchestrator. On development/test environments, the Docker engine provides a quick and easy way to assign local storage to Windows containers with Bind mounts or named volumes. Bind mounts allow a container to share a directory with the host. This is useful if you want a place to store files on the local machine that are available if you restart a container or want to share it with multiple containers. If you want the container to run on multiple machines with access to the same files, then a named volume or SMB mount should be used instead.

For production environments, the container orchestrator can provide enterprise grade persistent storage options. For example, Kubernetes natively provides Persistent Volumes which can be used to provide persistent storage for multiple containers running on multiple hosts. Additionally, Kubernetes also provides for third-party plugins to be used to map volumes on cloud storage, such as Azure Storage.

For more information on persistent storage for Windows containers, see [Container Storage overview](/virtualization/windowscontainers/manage-containers/container-storage).

**Windows containers networking**

Windows containers function similarly to virtual machines regarding networking. Each container has a virtual network adapter (vNIC) which is connected to a Hyper-V virtual switch (vSwitch). Windows supports five different networking drivers or modes which can be created through Docker: nat, overlay, transparent, l2bridge, and l2tunnel. Depending on your physical network infrastructure and single- vs multi-host networking requirements, you should choose the network driver which best suits your needs.

| Docker Windows Network Driver| Typical uses| Container-to-container (Single node)| Container-to-external (single node + multi-node)| Container-to-container (multi-node) |
| - | - | - | - | - |
| NAT (Default)| Good for Developers| Same Subnet: Bridged connection through Hyper-V virtual switch<br>Cross subnet: Not supported (only one NAT internal prefix)| Routed through Management vNIC (bound to WinNAT)| Not directly supported: requires exposing ports through host |
| Transparent| Good for Developers or small deployments| Same Subnet: Bridged connection through Hyper-V virtual switch<br>Cross Subnet: Routed through container host| Routed through container host with direct access to (physical) network adapter| Routed through container host with direct access to (physical) network adapter |
| Overlay| Good for multi-node; required for Docker Swarm, available in Kubernetes| Same Subnet: Bridged connection through Hyper-V virtual switch<br>Cross Subnet: Network traffic is encapsulated and routed through Mgmt vNIC| Not directly supported - requires second container endpoint attached to NAT network on Windows Server 2016 or VFP NAT rule on Windows Server 2019.| Same/Cross Subnet: Network traffic is encapsulated using VXLAN and routed through Mgmt vNIC |
| L2Bridge| Used for Kubernetes and Microsoft SDN| Same Subnet: Bridged connection through Hyper-V virtual switch<br>Cross Subnet: Container MAC address re-written on ingress and egress and routed| Container MAC address re-written on ingress and egress| Same Subnet: Bridged connection<br>Cross Subnet: routed through Mgmt vNIC on WSv1809 and above |
| L2Tunnel| Azure only| Same/Cross Subnet: Hair-pinned to physical host's Hyper-V virtual switch to where policy is applied| Traffic must go through Azure virtual network gateway| Same/Cross Subnet: Hair-pinned to physical host's Hyper-V virtual switch to where policy is applied |


In addition to the Docker options above, Kubernetes provides different Container Network Interface (CNI) plugins. These CNI implement different modes for networking configuration, network policies, etc.

For more information on networking for Windows containers, see [Windows containers networking](/virtualization/windowscontainers/container-networking/architecture).
