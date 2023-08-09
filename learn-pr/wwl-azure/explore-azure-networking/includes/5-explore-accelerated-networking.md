

Network performance of Azure VMs running Windows Server (including Windows Server 2012 R2, 2016, and 2019) and major distributions of Linux (including Red Hat) can be optimized for network throughput by enabling accelerated networking. Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, greatly improving its networking performance. The high-performance path bypasses the host from the Datapath, reducing latency, jitter, and CPU utilization, for use with the most demanding network workloads on supported VM types.

Accelerated networking is supported on most general purpose and compute-optimized instance sizes with 2 or more vCPUs (D/DSv2 and F/Fs). On instances that support hyperthreading, Accelerated Networking is supported on VM instances with 4 or more vCPUs (D/Dsv3, E/Esv3, Fsv2, Lsv2, Ms/Mms and Ms/Mmsv2).

:::image type="content" source="../media/accelerated-networking-35431646.png" alt-text="Diagram illustrating accelerated and non-accelerated networking.":::

For details, refer to [Optimize network throughput for Azure virtual machines](/azure/virtual-network/virtual-network-optimize-network-bandwidth).
