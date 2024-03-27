In this module, we discuss mount options and client VM configurations that improve performance when you're running HPC or EDA applications on Azure NetApp Files.

>[!NOTE]
>Best practices for NFS clients depend on the applications being used. The following suggestions are not absolute and can be overridden by application recommendations or by workload testing. We highly recommend that you test these practices before deploying in production.

## Use actimeo and nocto mount options to improve performance

You can use the following mount options to improve performance in relatively static datasets and massive read scenarios:

- `actimeo`: Controls the NFS client cache attributes of a directory. If you don't specify it, the NFS client uses a 60-second default maximum.
- `nocto`: Stands for "no close-to-open," which means a file can close before a write has finished to save time. By default, `nocto` isn't set  in the NFS mount options. That means all files wait to finish writes before allowing a close.

Most HPC applications, including EDA in our scenario, have relatively static datasets (meaning the data doesn't change frequently). In that case, you can use `nocto` and `actimeo` to reduce `getattr` or access operations to storage, which can help speed up the application.

For example, we recommend setting `"nocto,actimeo=600"` (600 seconds or 10 minutes) for EDA tools and library volumes. Because those files aren't changing, there's no cache coherency to maintain. Setting those mount options reduces metadata calls, which improves overall performance.

## Tune system parameters for optimal performance

`Tuned` is a daemon that can be used to monitor and configure connected devices on Linux clients. In most cases, `tuned` is installed by default. If it's not installed, it can be added and enabled to simplify client-side tuning parameters with built-in default templates.

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

The lower the number of clients, the more value `nconnect` provides in helping to boost performance, because it can potentially utilize all available network bandwidth. Its value gradually diminishes when the number of clients increases; there's only a certain amount of bandwidth in total to go around, and the maximum number of TCP connections can be exhausted faster, which can result in denial of service until TCP connections are freed.

Because Azure NetApp Files allows a maximum of 128 simultaneous in-flight requests per TCP connection before a throttle is incurred (where new requests are queued until resources are made available), `nconnect` can help extend the number of in-flight requests allowed by increasing the available TCP connections per mount point. For instance, if `nconnect` is set to use eight TCP connections, then 1,024 (8x128) requests are potentially available to the client.

Modern Linux clients allow up to 65,535 requests per connection (a dynamic value). This can potentially overrun an Azure NetApp Files volume’s available in-flight request queue and lead to undesirable performance results, where clients send more requests than can be honored at a given time. To reduce the risk for performance impact due to this behavior, consider setting `sunrpc.tpc_max_slot_table_entries=256` or `512` if you're using `nconnect=8` or `16` to a lower, static value. Use the following table as guidance.

>[!NOTE]
>Different Linux client OS types may have different methods to set this value. Consult your OS documentation for details.

| `nconnect` value | Recommended TCP max slot table entries |
| - | - | 
| 0-1 | 128 |
| 2-4 | 256 |
| 6-8 | 512 |
| >8 | No change needed |

>[!NOTE]
>The `nconnect` option is available only for Linux kernel 5.3+ VMs. You might need to restart the VM when you're upgrading the kernel. That means it might not be applicable for some cases.

## Use NFSv3 instead of NFSv4.1 when you're considering only performance

NFSv3 is a stateless protocol, which means the client and server don't communicate with each other about files in use. Locking is performed outside of the protocol stack by the Network Lock Manager (NLM), which presents some challenges when locks become stale and must be cleaned out manually. Locks are only established upon request by the application, so there may be scenarios where locks don't need to be negotiated. Because there are no client IDs, state IDs, session IDs, lock states, etc. to keep track of, NFSv3 tends to perform a bit better than NFSv4.1 in some workloads--particularly in high file count/high metadata workloads, such as EDA and software development.

NFSv4.1 keeps track of states of files, including locks. When many files are in use at once in NFSv4.1, each file gets assigned a state ID and receives a lock. Being stateful adds overhead to the performance of the workload, as each state and lock must be processed by the NFS server. In some workloads (such as EDA), NFSv4.1 performance can be affected anywhere from 25% to 75%. Other workloads, such as large files, streaming IO, or databases don't see performance degradation when using NFSv4.1 and may even benefit from the compound operations the protocol uses. 

Azure NetApp Files supports both NFSv3 and NFSv4.1. You should validate what version your application requires by comparing the similarities and differences between the NFS versions (as well as testing) and creating your volume by using the appropriate version. If necessary, Azure NetApp Files volumes can be configured to a different protocol version after creation.

## Choose the proper values for the rsize and wsize mount options 

The mount options `rsize` (read size) and `wsize` (write size) determine how much data is sent between the NFS client and server for each packet sent. For instance, setting `rsize` or  `wsize` to 65,536 means that up to 64 K of data can be sent per packet. If an application sends data in smaller chunks (such as 8 K), then the amount of data sent depends on the mount options used (such as `sync`).

The best practice for Azure NetApp Files is to set `rsize` and `wsize` to the same value. We generally recommend that you set both `rsize` and `wsize` values as `262144 (256 K)` in the mount options.

### Understand sync and async mount options 

If `sync` is used, then each `WRITE` call is sent with a `FILE_SYNC` command. This means every WRITE must be acknowledged by the server and committed to disk before the next `WRITE` can occur. `Sync` is used when an application must guarantee that all data is committed to disk. `WRITE` calls send only the amount of data specified by the application’s block size, which means smaller block sizes generate more NFS traffic regardless of the `wsize` and `rsize` values of the mount, causing a performance impact.

If you use the (default) `async` mount operation, a client can send multiple `WRITE` calls over NFS with the `UNSTABLE` command. In this scenario, data gets flushed to disk after a timeout period. Because the NFS client isn't always waiting on the server to commit data to disk before starting the next WRITE, job completion times for writes to async mounts is much lower than with sync. When smaller block sizes are used with larger `rsize` and `wsize` values, the `WRITE` calls send as much data as allowed in a single NFS call. For instance, if 8 K block sizes are used with a 64 K `wsize`/`rsize`, then each NFS WRITE call sends eight blocks per packet (64 K/8 K). When the write is flushed to disk, the NFS server sends a `FILE_SYNC` reply back to the NFS client. This reduces the total number of `WRITE` calls and replies over a network needed to complete a job, which improves performance.  

For example, in a test where a 1-GiB file was created using an 8 K block size generated 262,144 `WRITE` calls and replies and finished in 70 seconds when using the `sync` mount option. The same file creation using an 8 K block size and the `async` mount option sent only 16,384 WRITE calls and replies, completing in six seconds.

Azure NetApp Files makes use of battery-backed NVRAM storage as a buffer cache for incoming NFS writes. Data in NVRAM is flushed to disk every 10 seconds or until the buffer cache is filled (whichever comes first). Since the NVRAM is backed by a battery, it can survive unexpected outages for a minimum of 72 hours while retaining data, such as the unlikely event of an Azure datacenter losing power. The combination of the data resiliency of Azure NetApp Files and the performance impact of using `sync` mount option makes async the preferred choice in nearly all use cases.

### Understand the impact of wsize and rsize values

When mounting over NFS, the `wsize` and `rsize` values determine how much data can be sent per NFS call to an NFS server. If unspecified in the mount options, then the values are set to whatever the NFS server has been configured with. Azure NetApp Files uses a maximum transfer size for both `wsize` and `rsize` of 1 MB (1048576). This value can't be changed in Azure NetApp Files. This means if NFS mounts don't specify the `wsize` and `rsize` values, the mounts default to 1 MB. The recommended `wsize` and `rsize` values for NFS mounts in EDA workloads is 256 K.  

If an application needs to create a 1-GiB file on an Azure NetApp Files NFS mount, it needs to write 1048,576 KiB to storage. A math exercise can show why performance might improve with more efficient `wsize` or `rsize` values.  

* If the `wsize` is set to 64 K, then the number of operations/packets required to write the 1-GiB file is 1048576/64=16384.
* If the `wsize` is set to 256 K, then the number of operations/packets required to write the 1-GiB file is 1048576/256=4096. 

Fewer packets/operations mean network latency (which impacts RTT) less impact on workloads, which can be critical in cloud deployments. However, if the application writes files that are smaller than the `wsize`/`rsize` values, then the larger `wsize`/`rsize` values have no effect on performance.

Larger chunks of data mean more processing cycles on the client and server, but most modern CPUs are sufficiently equipped to handle those requests efficiently.

The best practice for Azure NetApp Files is to set `rsize` and `wsize` to the same value. It's recommended that you set both `rsize` and `wsize` values to 262144 (256K) in the mount options. This setting covers an array of application read and write size values.  

## Choose proper settings for the hard, soft, and intr mount options

The `hard` and `soft` mount options specify whether the program that's using a file that uses NFS should take one of the following actions:

- Stop and wait (`hard`) for the server to come back online if the NFS server is unavailable.
    This option appears as a mount hang on the client, but ensures in-flight operations aren't lost in the event of network outages. Instead, the client continues retrying the request until the server is available or until the application times out.
- Report an error (`soft`).
    Mounts don't hang, but in-flight operations may be lost.

The `intr` mount option allows NFS processes to be interrupted when a mount is specified as a `hard` mount (such as `CTRL+C`). We recommend using `intr` with `hard` mounts when applicable for the best combination of data reliability and manageability.

## Consider no change of MTUs

The default maximum transmission units (MTUs) for Azure VMs is 1,500 bytes. We don't encourage customers to increase VM MTUs for jumbo frames.

## Mount example

The following example code would mount an Azure NetApp Files volume by using the preceding best practices for `actimeo`, `nocto`, `NFSv3`, `nconnect`, `rsize`, `wsize`, `hard`, `intr`, `tcp`, and default MTUs (1,500):

```bash
sudo mount -t nfs -o rw,nconnect=16,nocto,actimeo=600,hard,intr,rsize=262144,wsize=262144,vers=3,tcp 10.1.x.x:/ultravol ultravol
```

>[!NOTE]
>`Async` is not specified, as NFS mounts default to `async`.