We'll list and discuss several performance tips including mounting options and client VM configurations when running your HPC/EDA applications on Azure NetApp Files.

>[!NOTE]
>NFS client best practices are dependent on the applications being used. The following suggestions are not set in stone and can be overridden by application recommendations or by workload testing. Therefore, it's highly recommended to test those practices before deploying in production.

## Use mount options "actimeo & nocto" to improve performance in relatively static datasets and massive read scenarios

The actimeo mount option controls the NFS client caches attributes of a directory. If not specified, the NFS client uses a 60-sec maximum.

Nocto stands for “no close-to-open,” which means a file can close before a write has completed to save time. By default, nocto is not set, which means all files will wait to finish writes before allowing a close.

Most HPC applications, including EDA in our scenario, have relatively static data sets. In that case, nocto and actimeo can be used to reduce getattr/access operations to storage and speed up the application.

For example, setting "nocto,actimeo=600" is advisable for EDA tools/libraries volumes as files aren’t changing, therefore there's no cache coherency to maintain and it will eliminate metadata calls and improve the overall performance.

## Tune system parameters for optimal performance

Run below commands to apply basic server tuning and typical latency tuning for your client VMs:

```bash
sudo systemctl enable --now tuned
sudo tuned-adm profile latency-performance
```

Some or all of the following system parameters (/etc/sysctl.conf) may be helpful on Linux Client VMs for optimal performance. If you have client VMs with huge amounts of RAM, or higher networking bandwidth like InfiniBand, you may want to set some values even higher than what is listed below.

```bash
#
# Recommended client tunes 
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
# Network parameters. In unit of bytes
net.core.wmem_max = 16777216
net.core.wmem_default = 1048576
net.core.rmem_max = 16777216
net.core.rmem_default = 1048576
net.ipv4.tcp_rmem = 1048576 8388608 16777216
net.ipv4.tcp_wmem = 1048576 8388608 16777216
net.core.optmem_max = 2048000
net.core.somaxconn = 65535
#
# These settings are in 4 KiB size chunks, in bytes they are:
# Min = 16MiB, Def=350MiB, Max=16GiB
# In unit of 4k pages
net.ipv4.tcp_mem = 4096 89600 4194304
#
# Misc network options and flags
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
# Various filesystem / pagecache options
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

To make these tunings persistent:

```bash
sudo sysctl -P
```

## Use mount options nconnect to expand network connections when applicable

The nconnect NFS mount option has entered General Availability in the Linux kernel 5.3 or above. To check your Client VM's Linux kernel:

```bash
uname -r
```

The purpose of nconnect is to provide multiple transport connections per TCP connection or mount points on a client. This helps increase parallelism and performance for NFS mounts. The less # of clients, the more value nconnect can help to boost performance as it could potentially utilize all possible network bandwidth. And its value gradually diminishes when # of clients increases, as there's only certain amount of bandwidth in total to go around.

Consider setting: sunrpc.tpc_max_slot_table_entries=256 or 512 if you're using nconnect=8 or 16.

However, please note that nconnect is only available for Linux kernel 5.3+ VMs, and you might need to reboot the VM when upgrading the kernel. Which means it might not be applicable for some cases.

## Use NFSv3 instead of NFSv4.1 when consider only performance

NFSv3 and NFSv4.1 are both supported by Azure NetApp Files. You should validate what version your application requires and create your volume using the appropriate version.

When considering only performance, NFSv3 will perform better than NFSv4.1 in most of the HPC/EDA applications.  

## Choose proper size of mount options "rsize and wsize"

The mount options wsize and rsize determine how much data is sent between the NFS client and server for each packet sent. This may help optimize performance for specific applications, as what is best for one application may not be best for other applications.

The best practice for Azure NetApp Files is to set rsize and wsize the same value. And it's generally recommended to set both rsize and wsize value as 262144 (256 K) in the mount options.

## Choose proper settings of mount options "hard/soft" & "intr/nointr"

The "hard" or "soft" mount options specify whether the program using a file using NFS should stop and wait (hard) for the server to come back online if the NFS server is unavailable or if it should report an error (soft). The "intr" allows NFS processes to be interrupted when a mount is specified as a hard mount.

We recommend using "intr" with "hard" mounts whenever applicable.

## Consider no change of MTU (jumbo frames) number

The default MTU for Azure VMs is 1,500 bytes. And we don't encourage customers to increase VM MTUs.

## Mount example

Below an example to mount an Azure NetApp Files volume using actimeo & nocto, NFSv3, nconnect, rsize & size, hard & intr, tcp, and with default MTU (1,500).

```bash
sudo mount -t nfs -o rw,nconnect=16,nocto,actimeo=600,hard,intr,rsize=262144,wsize=262144,vers=3,tcp 10.1.x.x:/ultravol ultravol
```
