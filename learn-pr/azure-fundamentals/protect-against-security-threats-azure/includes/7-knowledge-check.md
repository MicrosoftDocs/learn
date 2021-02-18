Consider the following scenario. Then choose the best response for each question that follows and select **Check your answers**.

Tailwind Traders is moving its online payment system from its datacenter to the cloud. The payment system consists of virtual machines (VMs) and SQL Server databases.

Here are a few security requirements that the company identifies as it plans the migration:

* It wants to ensure a good security posture across all of its systems, both on Azure and on-premises.
* In the datacenter, access to virtual machines requires a TLS certificate. The company needs a place to safely store and manage its certificates.

Here are some additional requirements that relate to regulatory compliance:

* Tailwind Traders must store certain customer data on-premises, in its datacenter.
* For certain workloads, the company must be the only customer running VMs on the physical hardware.
* The company must only run approved business applications on each VM.

See the following diagram that shows the proposed architecture.

:::image type="content" source="../media/7-architecture.png" alt-text="A diagram showing the proposed architecture. Virtual machines run both on Azure and in the datacenter." border="false":::

On Azure, Tailwind Traders will use both standard virtual machines and virtual machines that run on dedicated physical hardware. In the datacenter, the company will run virtual machines that can connect to databases within its internal network.
