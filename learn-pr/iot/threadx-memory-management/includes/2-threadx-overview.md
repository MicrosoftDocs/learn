Before investigating memory management options, let's first get an overview of ThreadX services and data types. ThreadX must provide a variety of services to the developer of real-time embedded systems. These services allow the developer to create, manipulate, and manage system resources and entities to facilitate application development.

This image contains a summary of these services and components:

:::image type="content" alt-text="Diagram that lists ThreadX services and components in a table." source="../media/services-components.svg" border="false" loc-scope="Azure":::

In this module, we'll concentrate on threads, memory byte pools, and memory block pools. We'll discuss the other components in later modules.  

ThreadX uses special primitive data types that map directly to data types of the underlying C compiler. This is done to ensure portability between different C compilers.

This image contains a summary of ThreadX service call data types and their associated meanings:

:::image type="content" alt-text="Diagram that lists the ThreadX service call data types and their associated meanings in a table." source="../media/primitive-data-types.svg" border="false" loc-scope="Azure":::

In addition to the primitive data types, ThreadX uses system data types to define and declare system resources, such as threads and mutexes.

This image contains a summary of these data types:

:::image type="content" alt-text="Diagram that lists the ThreadX system data types and their associated meanings in a table." source="../media/system-data-types.svg" border="false" loc-scope="Azure":::
