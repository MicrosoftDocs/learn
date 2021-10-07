In this unit, you'll learn about the virtual disk server.

## Run the Altair virtual disk server

If you don't have the MikroE microSD Click, then you can run the virtual disk server for read/write storage for your CP/M applications. The virtual disk server can run on your desktop or in a cloud-based Azure Virtual Machine.

Drive B: disk sector reads and writes are redirected over MQTT to an MQTT enabled Python-based virtual disk server. Drive B: disk sectors are also cached on one of the real-time cores. Caching significantly improves read/write performance.

## The Altair virtual disk server

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram of the Altair virtual disk architecture." border="false" lightbox="../media/altair-azure-sphere-disk-cache-server.png":::

Disk reads work as follows:

1. The Altair emulator first checks if the disk sector is available from the disk sector cache.
1. If the disk sector is found in the cache, then the sector is returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector is not found in the cache, then the sector is requested from the virtual disk server.
1. When the virtual disk server returns the disk sector, it is added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

Disk writes work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

The virtual disk server is not required if you have an Avnet Azure Sphere Starter Kit and the MikroE microSD Click. If you have MikroE microSD Click, you can skip to the Knowledge check unit for this module.

## Starting the virtual disk server

Applications running on CP/M will have read/write access to drive B: enabling you can save files when the virtual disk server running. The virtual disk server can run on your desktop, or in a cloud-based Azure Virtual Machine.

Drive B: disk sector reads and writes are sent over MQTT to the Python-based virtual disk server. The disk sector **Cache-aside** cache is used to improve the performance of the virtual drive.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram that shows the Altair Web Terminal architecture." border="false" lightbox="../media/altair-azure-sphere-disk-cache-server.png":::

In the following exercise, you'll learn how to:

* Install the virtual disk server.
* Run the virtual disk server.

In the following exercise, you'll install and run the Altair emulator virtual disk server.
