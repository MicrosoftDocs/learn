<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->

# Goal

We will list and discuss several performance tips including mounting options and client VM configurations when running your HPC/EDA applications on Azure NetApp Files.

Please note NFS client best practices are generally dependent on the applications being used. The following suggestions are not set in stone and can be overridden by application recommendations or by workload testing.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->

## actimeo & nocto

The actimeo mount option controls the NFS client caches attributes of a directory. If not specified, the NFS client uses a 60-sec maximum.

Nocto stands for “no close-to-open,” which means that a file can close before a write has completed to save time. By default, nocto is not set, which means that all files will wait to finish writes before allowing a close.

Most HPC applications, including EDA in our scenario, have relatively static data sets. In that case, nocto and actimeo can be used to reduce getattr/access operations to storage and speed up the application.

For example, nocto and actimeo=600 is advisable for EDA tools/libraries volumes as files aren’t changing, therefore there is no cache coherency to maintain and ti will eliminate metadata calls and improve the overall performance.

## Update /etc/sysctl.conf

Some or all of the following system parameters may be helpful on Linux Client VMs for optimal performance. If you have clients with large amounts of RAM, or higher networking bandwidth like InfiniBand, you may want to set some values even higher than what is listed below.

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

## nconnect

The "nconnect" NFS mount option has entered General Availability in the Linux kernel 5.3 or above. To check your Client VM's Linux kernel:

```bash
uname -r
```

The purpose of "nconnect" is to provide multiple transport connections per TCP connection or mount point on a client. This helps increase parallelism and performance for NFS mounts. The less # of clients, the more value "nconnect" can help to boost performance as it could potentially utilize all possible network bandwidth. And it's value gradually diminishes # of clients increases, as there is only certain amount of bandwidth to go around.

Consider setting: sunrpc.tpc_max_slot_table_entries=256 or 512 if you are using nconnect=8 or 16.

However, please note that "nconnect" is only available for Linux kernel 5.3+ VMs, and you might need to reboot the VM when upgrading the kernel. Which means it might not be applicable for some cases.

## NFS version

NFSv3 and NFSv4.1 are both supported by Azure NetApp Files. You should validate what version your application requires and create your volume using the appropriate version.

When considering only performance, NFSv3 will perform better than NFSv4.1 in most of the HPC/EDA applications.  

## rsize and wsize

The mount options wsize and rsize determine how much data is sent between the NFS client and server for each packet sent. This may help optimize performance for specific applications, as what is best for one application may not be best for other applications.

The best practice for Azure NetApp Files is to set rsize and wsize the same value. And it's generally recommended to set that value as 262144 (256K) in the mount options.

Below an example to mount an Azure NetApp Files volume using actimeo & nocto, NFSv3, nconnect, rsize & size and using tcp.

```bash
sudo mount -t nfs -o rw,nconnect=16,nocto,actimeo=600,hard,rsize=262144,wsize=262144,vers=3,tcp 10.1.x.x:/ultravol ultravol
```

## hard/soft & intr/nointr

The "hard" or "soft" mount options specify whether the program using a file using NFS should stop and wait (hard) for the server to come back online if the NFS server is unavailable or if it should report an error (soft). The "intr" allows NFS processes to be interrupted when a mount is specified as a hard mount.

We recommend using "intr" with "hard" mounts whenever applicable.

## MTU (jumbo frames)

The default MTU for Azure VMs is 1,500 bytes. And we don't encourage customers to increase VM MTUs.

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
