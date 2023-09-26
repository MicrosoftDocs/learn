## Introduction

Before investigating memory management options, let's first get an overview of ThreadX services and data types. ThreadX must provide various services to the developer of real-time embedded systems. These services allow the developer to create, manipulate, and manage system resources and entities to facilitate application development.

This image contains a summary of these services and components:

:::image type="content" alt-text="Diagram that lists ThreadX services and components in a table." source="../media/services-components.svg" border="false" loc-scope="Azure":::

In this module, we concentrate on threads, memory byte pools, and memory block pools. We discuss the other components in later modules.  

ThreadX uses special primitive data types that map directly to data types of the underlying C compiler. The purpose of these data types is to ensure portability between different C compilers.

This table contains a summary of ThreadX primitive data types and their associated meanings:

|Data type|Description|
|-------------|-----|
|`CHAR` | Most often a standard 8-bit character type|
|`UINT` | Basic unsigned integer. This type must support 8-bit unsigned data; however, it's mapped to the most convenient unsigned data type, which may support 16-bit or 32-bit signed data|
|`ULONG` | Unsigned long type. This type must support 32-bit unsigned data|
|`VOID` | Almost always equivalent to the compiler's void types|

In addition to the primitive data types, ThreadX uses system data types to define and declare system resources, such as threads and mutexes.

This table contains a summary of the ThreadX system data types:

|System data type|System resource|
|-------------|-----|
|`TX_BLOCK_POOL` | Memory block pool|
|`TX_BYTE_POOL` | Memory byte pool|
|`TX_EVENT_FLAGS_GROUP` | Event flags group|
|`TX_MUTEX` | Mutex|
|`TX_QUEUE` | Message queue|
|`TX_SEMAPHORE` | Counting semaphore|
|`TX_THREAD` | Application thread|
|`TX_TIMER` | Application timer|
