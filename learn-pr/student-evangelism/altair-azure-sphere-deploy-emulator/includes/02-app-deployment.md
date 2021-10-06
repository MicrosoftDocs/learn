In this unit, you'll learn about the real-time Altair emulator disk services.

The Altair emulator file system can read and write files to an SD Card or the virtual disk server. The file system uses disks for storage. Disk drive A: contains the operating system, utilities and programming languages. Disk drive B: is empty, and can be used for the applications you write.

1. The SD Card service running on the Azure Sphere (Recommended). 
    - The SD Card service requires an Avnet Azure Sphere Starter Kit Rev 1 or Rev 2 plus the MikroE microSD Card Click.  
    - Using the SD card, there is file read write support for both the A: and B: disk drives.
1. The virtual disk server running on your computer or cloud based virtual machine.
    - Install the virtual disk cache service on the Azure Sphere to improve the performance of the file system.
    - The virtual disk server supports read/write access for the B: disk drive.

## Understand the virtual disk Cache-Aside service

Install the virtual disk Cache-Aside service if you don't have an SD Card and you plan to use the virtual disk server for the B: disk drive. The virtual disk [Cache-Aside](/azure/architecture/patterns/cache-aside?azure-portal=true) service improves the performance of the virtual disk server.

The Altair emulator file system redirects disk read and write requests for drive B: over [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) to the virtual disk server.

Disk reads work as follows:

1. The Altair emulator file system first checks if the disk sector is available from the disk cache-aside service. The cache-aside service uses a [hash table](https://en.wikipedia.org/wiki/Hash_table?azure-portal=true) to quickly locate the requested disk sector in memory.
1. If the disk sector is found in the cache, then the sector is returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector is not found in the cache, then the Altair emulator file system requests the disk sector from the virtual disk server.
1. When the virtual disk server returns the disk sector, it is added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator file system first sends the disk sector to the cache service.
1. The disk sector is then sent to the virtual disk server over MQTT.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram that shows the architecture of the real-time disk cache service." border="false":::

The space in the cache is managed using a [Least Recently Used (LRU)](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)?azure-portal=true) algorithm. If the cache becomes full, then the "Least Recently Used" disk sector in the cache is discarded if a new disk sector needs to be stored in the cache.
