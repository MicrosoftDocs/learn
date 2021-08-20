In this unit, you'll learn about the virtual disk server.

## Starting the Virtual Disk Server

Applications running on CP/M will have read/write access to drive B: enabling you can save files when the virtual disk server running. The virtual disk server can run on your desktop, or in a cloud-based Azure Virtual Machine.

Drive B: disk sector reads and writes are sent over MQTT to the Python-based virtual disk server. The disk sector **Cache-aside** cache is used to improve the performance of this virtual drive.

:::image type="content" source="../media/altair-azure-sphere-disk-cache-server.png" alt-text="Diagram that shows the Altair Web Terminal architecture." border="false":::

In the following exercise, you'll learn how to:

* Install the virtual disk server.
* Run the virtual disk server.

In the following exercise, you'll install and run the Altair emulator virtual disk server.
