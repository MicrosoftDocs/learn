In this unit, you'll learn about the Altair virtual disk server.

## Run the Altair virtual disk server

If you don't have the MikroE microSD Click, you can run the virtual disk server for read/write storage for your Control Program for Microcomputers (CP/M) applications. The virtual disk server can run on your desktop or on a cloud-based Azure virtual machine.

Reads and writes for drive B disk sectors are redirected over MQTT to an MQTT-enabled, Python-based virtual disk server. Drive B disk sectors are also cached on one of the real-time cores. Caching significantly improves read/write performance.

## The Altair virtual disk server

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram of the Altair virtual disk architecture." border="false" lightbox="../media/altair-azure-sphere-disk-cache-server.png":::

The disk *reads* work as follows:

1. The Altair emulator checks to see whether the disk sector is available from the disk sector cache.
1. If the disk sector is found in the cache, it's returned to the Altair emulator. Getting sectors from the cache is much faster than requesting the sector from the virtual disk server.
1. If the disk sector isn't found in the cache, the sector is requested from the virtual disk server.
1. When the virtual disk server returns the disk sector, it's added to the disk sector cache. The sector is then returned to the Altair emulator for processing.

The disk *writes* work as follows:

1. The Altair emulator disk driver sends the disk sector to the cache manager.
1. The disk sector is then sent to the cloud-based virtual disk manager.

The virtual disk server is not required if you have an Avnet Azure Sphere Starter Kit and the MikroE microSD Click. If you have the MikroE microSD Click, you can skip to the "Knowledge check" unit for this module.

## Starting the virtual disk server

Applications that run on CP/M have read/write access to drive B. This lets you save files when the virtual disk server is running. The virtual disk server can run on your desktop or on a cloud-based Azure virtual machine.

Reads and writes for drive B disk sectors are sent over MQTT to the Python-based virtual disk server. The disk sector *cache-aside* cache is used to improve the performance of the virtual drive.

In the next unit, you'll install and run the Altair emulator virtual disk server.
