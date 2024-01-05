Much like your local computers, virtual-machine performance can often be tied directly to how quickly the VM can read and write data. To understand how to improve that performance, we first have to understand how performance is measured. We also have to understand the settings and choices that affect that measurement.

We're looking specifically at the underlying disks and storage used for VMs. When you're looking at performance, keep in mind that you also have to consider the application layer. For example, if you're running a database in a VM, you want to look at the performance settings specific to the database to ensure the database is optimized for the VM and storage on which you're running it.

Let's start by defining a few terms and the guarantees Azure makes about them.

## I/O operations per second

The storage type you select (Standard or Premium) decides how fast your disks are. We measure this performance in I/O operations per second, or IOPS (pronounced "eye-ops").

IOPS is the number of requests that a disk can process in one second. A single request is a read or write operation. This measurement is applied directly to storage. For example, if you have a disk that can do **5000 IOPS**, it means that it's theoretically capable of processing 5,000 read and or write operations per second.

> [!NOTE]
> External factors, including latency, can affect IOPS.

IOPS directly effects your application performance. Some applications, such as retail websites, need high IOPS to handle all the small and random I/O requests that must be processed quickly to keep the site responsive.

### IOPS in Azure

When you attach a premium storage disk to your high-scale VM, Azure provisions a guaranteed number of IOPS as per the disk specification. For example, a **P50** disk provisions **7500 IOPS**. Each high scale VM size also has a specific IOPS limit that it can sustain. For example, a **Standard GS5** VM has an **80,000 IOPS** limit.

IOPS is a performance measurement of your disks; however, it's a *theoretical* limit. Two other factors can affect the actual application performance: **throughput** and **latency**.

### What is throughput?

Throughput is the amount of data that your application is sending to the storage disks in a specified interval (typically per second). If your application is performing I/O with large blocks of data, it requires high throughput.

Azure provisions throughput in premium storage disks based on that disk's specification. For example, a **P50** disk provisions **250 MB per second** disk throughput. Each high scale VM size also has as specific *throughput limit* that it can sustain. For example, **Standard GS5** VM has a maximum throughput of **2,000 MB per second**.

#### IOPS vs. throughput

Throughput and IOPS have a direct relationship, and changing one has a direct effect on the other. To get a theoretical limit of throughput, you can use the formula: `IOPS x I/O size = throughput`. It's important to consider both of these values when planning your application.

### What is latency?

Reading and writing data takes time. *Latency* is the time it takes your app to send a request to the disk and get a response. Essentially, latency tells us how long it takes to *process* a single read or write I/O request.

Latency puts a limit on IOPS. For example, if our disk can handle 5000 IOPS but each operation takes 10 ms to process, then our app is capped at 500 operations per second due to the processing time. This example is a simple illustration; most of the time latency is considerably lower. Ultimately, latency and throughput determine how fast your app can process data from storage.

Premium storage provides consistent low latencies, and you can achieve even better latency when necessary through *caching*.

## Test your disk performance

You can adjust and balance the IOPS, throughput, and latency of your VM disks by selecting the right VM size and storage type. Typically, the larger or more expensive VM sizes have higher guarantees for max IOPS and throughput. Add into that equation Standard vs. Premium storage and HDD vs. SSD choices, and you have several parameters to play with.

Selecting the right combination involves understanding your application requirements. High-I/O applications, such as database servers or online transactional processing systems, require higher IOPS, whereas more computational-based applications might get by with lower requirements. In addition, the *types* of operations the applications perform affects your throughput. High random access I/O tends to be slower than long sequential reads.

Once you select your configuration, you can use tools such as [Iometer](http://iometer.org/) to test your disk performance on Linux and Windows VMs. This test gives you a more real-world sense of what kind of performance to expect. It can also help you to identify ways to improve your app's usage of storage. For example, an application that does single threaded I/O is likely to suffer reduced I/O performance because of latency.

In the next unit, we look at some other things we can do to improve our disk performance.
