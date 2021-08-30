In this unit, you'll learn about the virtual disk sector cache-aside service.

The Altair emulator file system supports read/write disks using the SD Card service or the virtual disk server.

1. The SD Card service running on the Azure Sphere (Recommended).
    - The SD Card service supports read/write access for the A: and B: drives.
    - The SD Card service requires an Avnet Azure Sphere Starter Kit Rev 1 and Rev 2 plus the MikroE microSD Card Click.
1. The virtual disk server running on your desktop or cloud.
    - The virtual disk server supports read/write access for the B: drive.
    - Install the virtual disk cache service on the Azure Sphere to improve the performance of the file system.

## Understand the virtual disk Cache-Aside service

Install the virtual disk Cache-Aside service to improve the performance of the Altair file system.

The cloud-connected Altair emulator file system redirects disk read and write requests for drive B: over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) to a cloud-based Python virtual disk server.

A [cache-aside](/azure/architecture/patterns/cache-aside?azure-portal=true) cache is used to improve the virtual disk performance and runs on one of the real-time cores.

The cache-aside disk sector uses a [hash table](https://en.wikipedia.org/wiki/Hash_table?azure-portal=true) to quickly locate disk sectors in memory.

The space in the cache is managed using a [Least Recently Used (LRU)](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)?azure-portal=true) algorithm. If the cache becomes full, then the "Least Recently Used" disk sector in the cache is discarded if a new disk sector needs to be stored in the cache.

Disk reads work as follows:

1. The Altair emulator first checks if the disk sector is available from the disk sector cache.
1. If the disk sector is found in the cache, then the sector is returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector is not found in the cache, then the sector is requested from the virtual disk server.
1. When the virtual disk server returns the disk sector, it is added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="The illustration shows the architecture of the real-time disk cache service.":::

In the following exercise, you'll deploy real-time Altair emulator services to your Azure Sphere.
