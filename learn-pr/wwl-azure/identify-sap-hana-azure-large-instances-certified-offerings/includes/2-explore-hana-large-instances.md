When implementing SAP HANA-based workloads in Azure, you have the choice of deploying SAP HANA on Azure virtual machines or bare-metal, purpose-built hardware referred to as **SAP HANA on Azure (Large Instances)** (frequently abbreviated to **HANA Large Instances** or **HLI**).

SAP HANA on Azure (Large Instances) involves deploying and running SAP HANA without the use of a hypervisor, with each physical server dedicated to an individual customer. The server hardware is part of a larger stamp that contains networking, compute, and storage infrastructure. Each stamp is associated with a tenant. A tenant is assigned to a single customer. A customer can have multiple tenants.

SAP HANA on Azure (Large Instances) represents an example of HANA tailored data center integration (TDI) certified deployment methodology. Customers can choose from several server SKUs, ranging from 36 Intel CPU cores and 768 GB of memory to 480 Intel CPU cores and 24 TB (up to 120 TB in the scale-out configuration) of memory.

Customer isolation within each infrastructure stamp involves networking, storage, and compute provisions:

 -  **Networking**: The network isolation of tenants prohibits network communication between tenants in the infrastructure stamp level, even if the tenants belong to the same customer.
 -  **Storage**: Storage volumes can be assigned to one storage virtual machine only. A storage virtual machine is assigned exclusively to one single tenant in the SAP HANA TDI certified infrastructure stack. As a result, storage volumes assigned to a storage virtual machine can be accessed in one specific and related tenant only. They aren't visible between the different deployed tenants.
 -  **Compute**: Individual physical servers aren't shared between tenants. Each server is an atomic bare-metal compute unit that is assigned to one single tenant. No hardware partitioning or soft partitioning is used that might result in sharing a host or a server with another customer. Storage volumes that are assigned to the storage virtual machine of the specific tenant are mounted to such a server. A tenant can have multiple server units of different SKUs.

The bare-metal server units are supported to run SAP HANA only. The SAP application layer or workload middle-ware layer runs in Azure virtual machines. The infrastructure stamps that run the SAP HANA on Azure (Large Instances) units are connected to the Azure network services backbone via ExpressRoute to maximize bandwidth and minimize latency.
