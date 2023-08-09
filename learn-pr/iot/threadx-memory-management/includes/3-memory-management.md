## Introduction

You can choose from two memory management techniques in ThreadX: memory byte pools and memory block pools.

## Memory byte pools

The first memory management technique is the memory byte pool, a continuous block of bytes, illustrated in the following image:

:::image type="content" alt-text="Diagram that demonstrates a memory byte pool as one contiguous block of bytes." source="../media/memory-byte-pool.png" loc-scope="Azure":::

As its name implies, the memory byte pool is a contiguous collection of bytes that may be used for any of the resources. A memory byte pool is similar to a standard C heap, but there's no limit to the number of memory byte pools that can be created. Also, threads can suspend on a memory byte pool until the requested memory is available. Allocations from a memory byte pool are based on a specified number of bytes. ThreadX allocates from the byte pool in a first-fit manner: the first free memory block that satisfies the request is allocated. Excess memory from this block is converted to a new block and placed back in the free memory list, often resulting in fragmentation. ThreadX merges adjacent free memory blocks together during a subsequent allocation search for a large enough block of free memory. This process is called defragmentation and may cause nondeterministic system behavior.

### Memory byte pool attributes

A memory byte pool has specific attributes. This image lists the attributes of a memory byte pool:

:::image type="content" alt-text="Diagram that lists the attributes of a memory byte pool in a table." source="../media/memory-byte-pool-attributes.svg" border="false" loc-scope="Azure":::

Every memory byte pool must have a control block that contains essential system information. Every memory byte pool is assigned a name, which is used primarily for user identification purposes. The starting address of the byte pool must be provided, and the total number of bytes to be allocated to the memory byte pool.

## Memory block pools

The second type of ThreadX memory management technique is the memory block pool, illustrated in the following image:

:::image type="content" alt-text="Diagram that demonstrates a memory block pool as composed of fixed-size memory blocks." source="../media/memory-block-pool.svg" border="false" loc-scope="Azure":::

A memory block pool consists of fixed-size memory blocks, so there's never a fragmentation problem. There's a lack of flexibility because the same amount of memory is allocated each time. However, as with all ThreadX resources, there's no limit on the number of memory block pools you can create, and each pool can have a different memory block size. In general, memory block pools are preferred over memory byte pools. Access to memory block pools is faster, and the fragmentation problem is eliminated.

The total number of memory blocks in a memory block pool can be calculated as shown in this image:

:::image type="content" alt-text="Diagram that shows the calculation for the total number of memory blocks." source="../media/memory-blocks-calculate.png" loc-scope="Azure":::

Each memory block contains one pointer of overhead that's invisible to the user. The *sizeof (void*)* expression in the preceding formula represents this pointer. You should avoid wasting memory space by correctly computing the total number of bytes to allocate, based on the number of memory blocks you want.

### Memory block pool attributes

A memory block pool has specific attributes. This image lists the attributes of a memory block pool:

:::image type="content" alt-text="Diagram that lists the attributes of a memory block pool in a table." source="../media/memory-block-pool-attributes.svg" border="false" loc-scope="Azure":::

Every memory block pool must have a control block that contains important system information. Every memory block pool is assigned a name, which is used primarily for identification purposes. The number of bytes in each fixed-size memory block must be specified. The address where the memory block pool is located must be provided. Finally, the total number of bytes available to the entire memory block pool must be specified.
