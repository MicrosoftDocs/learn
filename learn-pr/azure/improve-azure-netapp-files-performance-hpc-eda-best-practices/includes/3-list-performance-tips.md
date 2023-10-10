In this module, we discuss mount options and client VM configurations that improve performance when you're running HPC or EDA applications on Azure NetApp Files.

>[!NOTE]
>Best practices for NFS clients depend on the applications being used. The following suggestions are not absolute and can be overridden by application recommendations or by workload testing. We highly recommend that you test these practices before deploying in production.

## Use actimeo and nocto mount options to improve performance

You can use the following mount options to improve performance in relatively static datasets and massive read scenarios:

- `actimeo`: Controls the NFS client cache attributes of a directory. If you don't specify it, the NFS client uses a 60-second maximum.
- `nocto`: Stands for "no close-to-open," which means a file can close before a write has finished to save time. By default, `nocto` isn't set. That means all files wait to finish writes before allowing a close.

Most HPC applications, including EDA in our scenario, have relatively static datasets. In that case, you can use `nocto` and `actimeo` to reduce `getattr` or access operations to storage and speed up the application.

For example, we recommend setting `"nocto,actimeo=600"` for EDA tools and library volumes. Because those files aren't changing, there's no cache coherency to maintain. Setting those mount options eliminates metadata calls and improves overall performance.

## Tune system parameters for optimal performance

Run the following commands to apply basic server tuning and typical latency tuning for your client VMs:

```bash
sudo systemctl enable --now tuned
sudo tuned-adm profile latency-performance
```

Some or all of the following system parameters (*/etc/sysctl.conf*) might be helpful on Linux client VMs for optimal performance. If you have client VMs with huge amounts of RAM, or higher network bandwidth like InfiniBand, you might want to set some values even higher than the following example shows.

```bash
#
# Recommended client tuning 
#
# For more information, see sysctl.conf(5) and sysctl.d(5)
# Network parameters, in units of bytes
net.core.wmem_max = 16777216
net.core.wmem_default = 1048576
net.core.rmem_max = 16777216
net.core.rmem_default = 1048576
net.ipv4.tcp_rmem = 1048576 8388608 16777216
net.ipv4.tcp_wmem = 1048576 8388608 16777216
net.core.optmem_max = 2048000
net.core.somaxconn = 65535
#
# These settings are in 4-KiB chunks, in bytes:
# Min=16MiB, Def=350MiB, Max=16GiB
# In units of 4K pages
net.ipv4.tcp_mem = 4096 89600 4194304
#
# Miscellaneous network options and flags
#
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_sack = 1
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.route.flush = 1
net.ipv4.tcp_low_latency = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_slow_start_after_idle = 0
net.core.netdev_max_backlog = 300000
#
# Various file system and page cache options
#
vm.dirty_expire_centisecs = 100
vm.dirty_writeback_centisecs = 100
vm.dirty_ratio = 20
vm.dirty_background_ratio = 5
#
# Recommended by: https://cromwell-intl.com/open-source/performance-tuning/tcp.html
#
net.ipv4.tcp_sack = 0
net.ipv4.tcp_dsack = 0
net.ipv4.tcp_fack = 0
```

To make these tunings persistent, run:

```bash
sudo sysctl -P
```

## Use the nconnect mount option to expand network connections when applicable

The `nconnect` NFS mount option entered general availability in the Linux kernel 5.3 or later. To check your client VM's Linux kernel, run:

```bash
uname -r
```

The purpose of `nconnect` is to provide multiple transport connections per TCP connection or mount points on a client. This technique helps increase parallelism and performance for NFS mounts.

The lower the number of clients, the more value `nconnect` provides in  helping to boost performance, because it can potentially utilize all network bandwidth. Its value gradually diminishes when the number of clients increases, because there's only a certain amount of bandwidth in total to go around.

Consider setting `sunrpc.tpc_max_slot_table_entries=256` or `512` if you're using `nconnect=8` or `16`.

> [!NOTE]
> The `nconnect` option is available only for Linux kernel 5.3+ VMs. You might need to restart the VM when you're upgrading the kernel. That means it might not be applicable for some cases.

## Use NFSv3 instead of NFSv4.1 when you're considering only performance

Azure NetApp Files supports both NFSv3 and NFSv4.1. You should validate what version your application requires and create your volume by using the appropriate version.

When you're considering only performance, remember that NFSv3 performs better than NFSv4.1 in most of the HPC and EDA applications.  

## Choose the proper size of the rsize and wsize mount options

The mount options `rsize` and `wsize` determine how much data is sent between the NFS client and server for each packet sent. Setting these options might help optimize performance for specific applications, because what's best for one application might not be best for other applications.

The best practice for Azure NetApp Files is to set `rsize` and `wsize` to the same value. We generally recommend that you set both `rsize` and `wsize` values as `262144(256 K)` in the mount options.

## Choose proper settings for the hard, soft, and intr mount options

The `hard` and `soft` mount options specify whether the program that's using a file that uses NFS should take one of the following actions:

- Stop and wait (`hard`) for the server to come back online if the NFS server is unavailable.
- Report an error (`soft`).

The `intr` mount option allows NFS processes to be interrupted when a mount is specified as a `hard` mount. We recommend using `intr` with `hard` mounts when applicable.

## Consider no change of MTUs

The default maximum transmission units (MTUs) for Azure VMs is 1,500 bytes. We don't encourage customers to increase VM MTUs for jumbo frames.

## Mount example

The following example code would mount an Azure NetApp Files volume by using the preceding best practices for `actimeo`, `nocto`, `NFSv3`, `nconnect`, `rsize`, `wsize`, `hard`, `intr`, `tcp`, and default MTUs (1,500):

```bash
sudo mount -t nfs -o rw,nconnect=16,nocto,actimeo=600,hard,intr,rsize=262144,wsize=262144,vers=3,tcp 10.1.x.x:/ultravol ultravol
```
