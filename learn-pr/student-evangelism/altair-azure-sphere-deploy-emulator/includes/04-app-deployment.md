In this unit, you will learn about the virtual disk sector cache-aside server.

## Understand the virtual disk Cache-Aside server

The cloud-enabled Altair on Azure Sphere project redirects disk read and write requests for drive B: over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) to a cloud-based Python virtual disk server.

To improve the virtual disk performance there is a [cache-aside](https://docs.microsoft.com/azure/architecture/patterns/cache-aside) disk sector cache running on the Azure Sphere. The cache-aside cache is offloaded onto one of the real-time cores. So not only is virtual disk performance significantly faster but the Altair also benefits from the Cortex M4 real-time processing and TCM (Tightly Coupled Memory) resources. The cache-aside disk sector uses a [hash table](https://en.wikipedia.org/wiki/Hash_table) to quickly locate the sector in memory, and a [Least Recently Used (LRU)](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)) policy to manage cache memory. If the cache becomes full then the "Least Recently Used" disk sector in the cache is deleted to make space for a new sector.

Disk reads work as follows:

1. The Altair emulator disk driver first checks if the requested disk sector is available from the disk sector cache server.
1. If the disk sector is found in the cache, then it is immediately returned to the Altair emulator. This is very fast, the round trip for a successful disk sector request from the cache is approximately 200 microseconds.
1. If the requested disk sector is not found in the local cache, then a request for the sector is sent over MQTT to the cloud-based virtual disk server running in an Azure Virtual Machine.
1. When the disk sector is returned from the cloud-based virtual disk server it is sent to the disk sector cache manager and then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

:::image type="content" source="../media/altair-on-azure-sphere-disk-cache-server.png" alt-text="The illustration shows the architecture of the real-time disk cache server.":::

In the following exercise, you will deploy the disk sector cache manager and the environment monitor real-time applications along with the Python-based Virtual Disk Server.
