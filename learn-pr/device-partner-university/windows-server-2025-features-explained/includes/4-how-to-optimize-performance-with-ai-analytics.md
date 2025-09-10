Organizations today run increasingly complex applications, from advanced analytics to artificial intelligence (AI) and machine learning (ML). Windows Server 2025 provides new infrastructure capabilities that help IT professionals deliver the performance and scalability required for these workloads.

:::image type="content" source="../media/azure-employee.png" alt-text="A photograph of a person standing with arms crossed in front of three computer monitors displaying various software interfaces.":::

## How to use GPU partitioning for AI and ML

Windows Server 2025 introduces [GPU partitioning](/windows-server/virtualization/hyper-v/plan/gpu-partitioning), a feature that allows a single GPU to be divided into multiple virtual GPUs. This enables more efficient use of GPU resources for AI and machine learning workloads. IT teams can:  

- Allocate GPU resources to multiple virtual machines (VMs) simultaneously.  
- Improve efficiency by ensuring workloads use only the GPU resources they need.  
- Support AI and ML workloads without requiring dedicated GPUs for every VM.  

> [!TIP]
> Try it yourself: Configure GPU partitioning in Hyper-V and assign virtual GPUs to two VMs. Run a sample ML workload to compare performance.

This approach reduces hardware costs while enabling more flexible and scalable AI-driven solutions.  


## How to manage virtual machines with Hyper-V

Windows Server 2025 includes built-in virtualization tools through [Hyper-V](/windows-server/virtualization/hyper-v/overview). Virtual machines (VMs) let you run multiple operating systems on one physical server—saving space and resources.

With Hyper-V, you can:
- Create virtual machines for testing, development, or production.
- Assign memory, CPU, and storage to each VM based on its needs.
- Run older apps in a safe, isolated environment.

> [!TIP]
> Try it yourself: Open Hyper-V Manager and create a new VM. Choose your operating system and assign resources like memory and disk space.

## How to run containers with Windows Server

Containers are a lightweight way to run apps without installing them directly on your server. They’re faster to start and easier to manage than traditional apps.

Windows Server 2025 supports two types of containers:
- **Windows containers**: Share the OS with other containers.
- **Hyper-V containers**: Run in a more isolated environment for added security.

You can use tools like Docker or Windows Admin Center to manage containers.

> [!TIP]
> Try it yourself: Use [Windows Admin Center](/windows-server/manage/windows-admin-center/overview) to deploy a sample container. Explore how it runs independently from other apps.

## How to keep virtual workloads secure

Virtual machines and containers need protection just like physical servers. Windows Server 2025 includes features to help:

- **Shielded VMs**: Encrypt data and prevent tampering.
- **Host Guardian Service (HGS)**: Verifies that your server is safe before running sensitive workloads.
- **Security baselines**: Apply recommended settings to keep your environment secure.

## How to scale compute and storage

Meeting evolving business needs often requires scaling compute and storage capabilities. Windows Server 2025 provides:  

- Expanded support for large-scale VMs to handle resource-intensive applications.  
- Improved storage performance with faster input/output (I/O) operations.  
- Advanced compression and deduplication features to reduce storage costs.  

By leveraging these improvements, IT professionals can ensure workloads remain responsive and cost-efficient, even as demand grows.

:::image type="content" source="../media/azure-retail-employee.png" alt-text="A photograph of a person at a desk with two monitors showing code and charts, wearing headphones around their neck.":::

## How to optimize networking and datacenter efficiency

Networking is critical to performance. Windows Server 2025 offers:  

- Software-defined datacenter (SDDC) features that automate the management of compute, storage, and networking resources.  
- Improved load balancing and traffic management for high-demand applications.  
- Unified administration through Windows Admin Center for both on-premises and hybrid environments.  

These tools enable IT teams to reduce manual overhead and focus on innovation rather than day-to-day operations. With greater scalability, GPU partitioning, and datacenter efficiency, Windows Server 2025 ensures your infrastructure can keep up with evolving demands. Now that performance is optimized, it’s time to look ahead—how can these tools prepare your organization for the future?