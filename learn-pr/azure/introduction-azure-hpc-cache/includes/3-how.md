Here, we discuss how Azure HPC Cache works. You learn how the different storage and network elements come together to provide a faster storage experience, such as:

- Source data
- Data access
- Network

## How source data is accessed

Without a caching solution, clients directly access the source data. When clients use the caching service, they access HPC Cache for faster access to data instead of directly accessing the source data.

HPC Cache reads data from a customer storage target like network-attached storage (NAS) in the customer datacenter, and stores frequently accessed data in memory and on high-speed drives.

## How the cache manages the data

Clients request data from HPC Cache. The cache reads the data from the storage target. Client write operations are written to the cache. The cache pushes the new data to the storage target.

When multiple clients read the same data, the cache supplies the data faster than the NAS.

## How data is handled over the internet

To access the data from the storage target, the cache typically exchanges traffic over the public internet. Data transmissions are secured by using encryption.

Because bandwidth can be low and slow the transfer of information, consider using Azure ExpressRoute to accelerate data transfer. While it's not required, a dedicated line like ExpressRoute provides faster data transfers than relying on public internet communication alone.

:::image type="content" source="../media/infrastructure-diagram.png" alt-text="Diagram showing clients connecting to the cache that is then connected to datacenter storage via ExpressRoute.":::
