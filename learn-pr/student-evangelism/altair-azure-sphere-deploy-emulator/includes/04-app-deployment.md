In this unit, you'll learn about the virtual disk sector cache-aside server.

## Understand the virtual disk Cache-Aside server

The cloud-enabled Altair on Azure Sphere project redirects disk read and write requests for drive B: over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) to a cloud-based Python virtual disk server.

A [cache-aside](/azure/architecture/patterns/cache-aside) cache is used to improve the virtual disk performance and runs on one of the real-time cores.

The cache-aside disk sector uses a [hash table](https://en.wikipedia.org/wiki/Hash_table) to quickly locate disk sectors in memory.

The space in the cache is managed using a [Least Recently Used (LRU)](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)) algorithm. If the cache becomes full, then the "Least Recently Used" disk sector in the cache is discarded if a new disk sector needs to be stored in the cache.

Disk reads work as follows:

1. The Altair emulator first checks if the disk sector is available from the disk sector cache.
1. If the disk sector is found in the cache, then the sector is returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector is not found in the cache, then the sector is requested from the virtual disk server.
1. When the virtual disk server returns the disk sector, it is added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

:::image type="content" source="../media/altair-on-azure-sphere-disk-cache-server.png" alt-text="The illustration shows the architecture of the real-time disk cache server.":::

In the following exercise, you'll deploy the disk sector cache manager and the environment monitor real-time applications along with the Python-based Virtual Disk Server.
