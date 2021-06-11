Here, we'll discuss how Azure HPC Cache works. You'll learn how the different storage and network elements come together to provide a faster storage experience.

- Source data
- Data access
- Network

## How source data is accessed

Without a caching solution, clients would directly access the source data. When using the caching service, clients access Azure HPC Cache for faster access to data instead of directly accessing the source data.

Azure HPC Cache reads data from a customer storage target like network-attached storage (NAS) in the customer data center and stores frequently-accessed data in memory and on high-speed drives.

## How the cache manages the data

Clients request data from Azure HPC Cache. The cache reads the data from the storage target. Client write operations are written to the cache. The cache pushes the new data to the storage target.

When multiple clients read the same data, the cache supplies the data faster than the NAS.

## How data is handled over the internet

To access the data from the storage target, the cache typically exchanges traffic over the public internet. Data transmissions are secured using encryption.

Because bandwidth can be low and slow the transfer of information, an ExpressRoute is recommended to accelerate data transfer. While it's not required, a dedicated line like an ExpressRoute is recommended to provide faster data transfers than relying on public internet communication alone.

![Diagram showing clients connecting to the cache which is then connected to data center storage via Express Route.](../resources/3-what-is-hpc-cache-01.png)

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)
