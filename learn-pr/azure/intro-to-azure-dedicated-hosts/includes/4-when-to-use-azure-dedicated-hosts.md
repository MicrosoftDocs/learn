Azure Dedicated Hosts meets your IT organization's needs in the following application scenarios:

- **Security compliance and regulatory requirements:** Businesses with strict compliance and regulatory requirements can benefit from the isolation provided by dedicated hosts. Specific security situations related to in-memory data being stolen from the host. A bad actor's VM being on the same host as another user's VM are of concern to many high-profile entities.

- **Hardware Maintenance:** Businesses that require control over hardware maintenance events can use dedicated hosts to manage the timing of these events. While Azure notifies users well before any scheduled maintenance, certain clients require greater control over when and how VMs are maintained. Dedicated hosts does this by providing the user a 35-day rolling window for the user to choose when required maintenance is conducted.

- **Host-level licensing:** Businesses that have host-level software licenses can take advantage of dedicated hosts to optimize their licensing costs. Some software can be less expensive to run if licenses are applied at a physical core level rather than against virtual CPUs.

- **Performance and resource isolation:** Businesses with performance-sensitive workloads can benefit from the resource isolation provided by dedicated hosts. While standard multi-tenant VMs guarantee a certain allocation of resources, they're still limited by nonconfigurable hardware limitations. A neighboring tenant VM or number of VMs might be utilizing more of the CPU's cache, running more I/O operations, or provisioning host resources while your VMs are running normally. Dedicated hosts allow you to control for those aspects and gain the uninterrupted performance of a single host.
