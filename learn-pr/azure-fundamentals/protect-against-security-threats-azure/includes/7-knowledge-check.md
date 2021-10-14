Consider the following scenario.

Tailwind Traders is moving its online payment system from its datacenter to the cloud. The payment system consists of virtual machines (VMs) and SQL Server databases.

Here are a few security requirements that the company identifies as it plans the migration:

 -  It wants to ensure a good security posture across all of its systems, both on Azure and on-premises.
 -  In the datacenter, access to VMs requires a TLS certificate. The company needs a place to safely store and manage its certificates.

Here are some additional requirements that relate to regulatory compliance:

 -  Tailwind Traders must store certain customer data on-premises, in its datacenter.
 -  For certain workloads, the company must be the only customer running VMs on the physical hardware.
 -  The company must only run approved business applications on each VM.

See the following diagram that shows the proposed architecture.

:::image type="content" source="../media/7-architecture-dca029ba.png" alt-text="A diagram showing the proposed architecture. Virtual machines run both on Azure and in the datacenter.":::


On Azure, Tailwind Traders will use both standard VMs and VMs that run on dedicated physical hardware. In the datacenter, the company will run VMs that can connect to databases within its internal network.

Choose the best response for each question. Then select **Check your answers**.