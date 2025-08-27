Windows Server 2025 is a modern, secure, and scalable operating system designed to support diverse workloads—from traditional on-premises infrastructure to hybrid cloud environments. This unit introduces the key components of Windows Server 2025 and explains how they work together to deliver reliable, high-performance services.

## Core components of Windows Server 2025

### 1. Operating system kernel
- Manages hardware resources, memory, processes, and security.
- Ensures stability and performance across all workloads.

### 2. Server roles and features
- Modular roles like **Active Directory**, **DNS**, **DHCP**, and **IIS**.
- Admins install only the roles needed, improving efficiency and security.

>[!NOTE]
>Modular roles such as **Active Directory**, **DNS**, **DHCP**, and **IIS** refer to discrete server functionalities that can be independently installed and configured based on organizational requirements:
>
>- **Active Directory**: Provides centralized domain management, including user authentication, authorization, and directory services.
>- **DNS (Domain Name System)**: Resolves domain names to IP addresses, enabling networked devices to locate each other using human-readable names.
>- **DHCP (Dynamic Host Configuration Protocol)**: Automatically assigns IP addresses and network configuration settings to client devices on the network.
>- **IIS (Internet Information Services)**: A web server role used to host and manage websites, web applications, and services.
>
>These roles are modular, meaning administrators can install only the components needed for a specific deployment, which helps reduce system overhead and potential attack surfaces.

### 3. Hyper-V virtualization
- Run multiple virtual machines (VMs) on a single physical server.
- Supports nested virtualization and live migration.

### 4. Storage and networking
- **Storage Spaces Direct** for fault-tolerant storage.
- **Software-defined networking (SDN)** for dynamic configuration.

### 5. Security infrastructure
- **Credential Guard**, **Secured-Core Server**, and **BitLocker**.
- **Group Policy** and **Active Directory** enforce access control.

### 6. Management and automation
- **Windows Admin Center** for centralized GUI management.
- **PowerShell** and **DSC** for automation.

### 7. Hybrid cloud integration
- **Azure Arc** for managing on-prem servers like cloud resources.
- **Hotpatching** for updates without rebooting.

## How these parts work together

Windows Server 2025 is modular and interoperable. Here's how its components interact:

- The **kernel** provides the foundation for all services and roles.
- **Server roles** run as isolated services, communicating securely.
- **Hyper-V** hosts VMs using the same kernel and roles.
- **Storage and networking** are managed centrally for flexibility.
- **Security features** are embedded across all layers.
- **Management tools** unify control across local and cloud environments.

Together, these components form a cohesive platform that adapts to different organizational needs—whether you're running a small business server or a global datacenter.

## Scenario overview

A retail company operates hundreds of stores in various locations. Each store requires local server capabilities to support point-of-sale systems, inventory management, and customer Wi-Fi. The central IT team seeks unified control, consistent security, and scalable infrastructure across all locations. To meet these requirements, the company adopts Windows Server 2025.

## How Windows Server 2025 components work together

The following sections describe how each component of Windows Server 2025 contributes to the company's distributed infrastructure strategy.

### Operating system kernel
- Provides a stable foundation for all workloads, ensuring consistent performance across store servers and central datacenter systems.

### Server roles and features
- Store servers utilize **DHCP** to assign IP addresses to devices, **DNS** for internal name resolution, and **IIS** to host a local web-based inventory application.
- The central datacenter employs **Active Directory** for identity and access management across all store locations.

### Hyper-V virtualization
- Store servers host multiple virtual machines (VMs), including instances for point-of-sale, inventory, and guest Wi-Fi services.
- Central IT uses nested virtualization to validate updates prior to chain-wide deployment.

### Storage and networking
- **Storage Spaces Direct** provides fault-tolerant local storage, maintaining data availability in the event of disk failure.
- **Software-defined networking (SDN)** enables dynamic adjustment of network policies based on traffic patterns and security requirements.

### Security infrastructure
- **Credential Guard** secures login credentials on store servers.
- **Group Policy** enforces standardized security configurations across all locations.

### Management and automation
- IT administrators use **Windows Admin Center** for remote monitoring and management of all servers.
- **PowerShell scripts** automate routine tasks such as nightly backups and patch deployments.

### Hybrid cloud integration
- **Azure Arc** connects store servers to cloud-based management tools, allowing centralized policy enforcement and monitoring.
- **Hotpatching** applies critical updates without requiring reboots, maintaining uptime for point-of-sale systems during business hours.

This scenario illustrates how Windows Server 2025 supports:

- **Scalability** across a distributed retail network.
- **Security** through centralized identity and policy management.
- **Hybrid flexibility** via Azure Arc and hotpatching.
- **Performance and resilience** through virtualization and fault-tolerant storage.
