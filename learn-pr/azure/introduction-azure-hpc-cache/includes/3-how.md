Here, we'll discuss how Azure HPC Cache works. You'll learn how the different storage and network elements come together to provide a faster storage experience.

- Source data
- Data access
- Network

## How source data is accessed

Without a caching solution, clients would directly access the source data. When using the caching service, clients access Azure HPC Cache for faster access to data instead of directly accessing the source data.

Azure HPC Cache reads data from a customer storage target like network-attached storage (NAS) in the customer data center and stores frequently-accessed data in memory and on high-speed drives.

## How the cache manages the data

Clients request data from Azure HPC Cache. The cache reads the data from the storage target. Client write operations are written to the cache. The cache pushes the new data to the storage target.

When multiple clients read the same data, the cache supplies the data faster than the NAS.

## How data is handled over the internet

To access the data from the storage target, the cache typically exchanges traffic over the public internet. Data transmissions are secured using encryption.

Because bandwidth can be low and slow the transfer of information, an ExpressRoute is recommended to accelerate data transfer. While it's not required, a dedicated line like an ExpressRoute is recommended to provide faster data transfers than relying on public internet communication alone.

:::image type="content" source="../media/infrastructure-diagram.png" alt-text="Diagram showing clients connecting to the cache which is then connected to data center storage via Express Route.":::
