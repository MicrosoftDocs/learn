Network performance of Azure Virtual Machines running Windows Server (including Windows Server 2012 R2, 2016, and 2019) and major distributions of Linux (including Red Hat) can be optimized for network throughput by enabling accelerated networking. Accelerated networking enables single root I/O virtualization (SR-IOV) to a virtual machine, greatly improving its networking performance. The high-performance path bypasses the host from the Datapath, reducing latency, jitter, and CPU utilization, for use with the most demanding network workloads on supported virtual machine types.

Accelerated networking is supported on most general purpose and compute-optimized instance sizes with 2 or more vCPUs (D/DSv2 and F/Fs). On instances that support hyperthreading, Accelerated Networking is supported on virtual machine instances with 4 or more vCPUs (D/Dsv3, E/Esv3, Fsv2, Lsv2, Ms/Mms and Ms/Mmsv2).

:::image border="false" type="content" source="../media/accelerated-networking-35431646.png" alt-text="Diagram showing accelerated and non-accelerated networking.":::

For details, refer to [Optimize network throughput for Azure Virtual Machines](/azure/virtual-network/virtual-network-optimize-network-bandwidth).
