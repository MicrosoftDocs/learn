Consider the following scenario. Then choose the best response for each question that follows and select "Check your answers."

Tailwind Traders is moving their online payment system from their datacenter to the cloud. Their payment system consists of virtual machines (VMs) and SQL Server databases.

Here are a few of security requirements they identify as they plan their migration:

* They want to ensure they'll have a good security posture across all of their systems, both on Azure and on-premises.
* In their datacenter, access to virtual machines requires a TLS certificate. They need a place to safely store and manage their certificates.

Here are some additional requirements that relate to regulatory compliance:

* They must store certain customer data on-premises, in their datacenter.
* For certain workloads, they must be the only customers running VMs on the physical hardware.
* They must only run approved business applications on each VM.

Here's a diagram that shows their proposed architecture:

:::image type="content" source="../media/7-architecture.png" alt-text="A diagram showing the proposed architecture. Virtual machines run both on Azure and in the datacenter. Some virtual machines on Azure must run on dedicated physical hardware. The datacenter also contains SQL Server databases." border="false":::

On Azure, Tailwind Traders will use both standard virtual machines as well as virtual machines that run on dedicated physical hardware. In their datacenter, they'll run virtual machines that can connect to databases within their internal network.
