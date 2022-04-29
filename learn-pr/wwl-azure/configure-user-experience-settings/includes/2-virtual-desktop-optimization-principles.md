To optimize Windows 10 in a virtual desktop environment, you should eliminate background activities and processes that don't benefit the virtual desktop environment.

A secondary goal is to reduce disk space usage in the base image to the bare minimum.

## Optimization principles

Some implementations of virtual desktop environments use a "base" operating system image, which becomes the basis for the virtual desktop. There are persistent and non-persistent base images.

The smallest possible base, or "gold" image size, can reduce memory utilization on the host system and reduce network operations for Azure Virtual Desktop.

The persistent base image preserves changes to the virtual desktop operating system from one session to the next. The non-persistent base image does not preserve changes to the virtual desktop operating system from one session to the next.

To the user this desktop is little different than other virtual or physical device, other than it is accessed over a network.

The optimization settings can be reviewed on a reference machine. A virtual machine (VM) would be an ideal place to build the VM, because state can be saved, checkpoints can be made, backups can be made, and so on. A default OS installation is performed to the base VM. That base VM is then optimized by removing unneeded apps, installing Windows updates, installing other updates, deleting temporary files, applying settings, and so on.

## Virtual Desktop Security

For virtual desktops, security is not handled much differently than physical devices. Enterprise customers may choose to utilize the built-in to Windows services of Windows Security, which comprises a suite of services that work well connected or not connected to the Internet.

For those virtual desktop environments not connected to the Internet, security signatures can be downloaded proactively several times per day, because Microsoft may release more than one signature update per day. Those signatures can then be provided to the virtual desktop devices and scheduled to be installed during production, regardless of persistent or non-persistent.

## Updates

Virtual desktop administrators control the process of updating through a process of shutting down VMs based on a "master" or "gold" image, unseal that image, which is read-only, patch the image, then reseal it and bring it back into production. Therefore, there is no need to have virtual desktop devices checking Windows Update.

The optimization scripts can be found at [https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool](https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool).
