A realistic assessment of your available network bandwidth is essential to determine the feasibility and duration of an online migration. When you underestimate bandwidth needs, migration delays follow.

## Estimate transfer duration

Calculate the expected migration duration based on your data volume and available bandwidth. As a reference:
- 1 Gbps sustained throughput can transfer approximately 10 TB per day.
- 10 Gbps sustained throughput can transfer approximately 100 TB per day.
- Account for protocol overhead, encryption, and real-world throughput (typically 60–80% of theoretical bandwidth).
- Also factor in the daily change rate. Data changed during migration must be re-synced before cutover.

### Worked example

Consider a 50 TB data estate with 1 Gbps available bandwidth:
- At 80% efficiency, effective throughput is approximately 800 Mbps, or roughly 8 TB per day.
- The initial full copy takes approximately 6–7 days.
- If the daily change rate is 1% (500 GB), each delta sync takes roughly 1.5 hours.
- After 2–3 delta passes, the final sync before cutover could complete in under an hour.

Use this type of calculation for each data set in your estate. Total migration duration is determined by the largest or slowest data set, not the sum of all data.

### Impact of object count on transfer speed

Migration duration is not determined by data volume alone. The number of individual files or objects has a significant impact on throughput:

- Every file or object incurs per-item overhead: source enumeration, metadata reads, API calls to create the object on the target, and integrity validation. This overhead is roughly constant per item regardless of file size.
- Migrating a few thousand large files (GB-sized) is dramatically faster than migrating billions of small files (KB-sized) totaling the same data volume. A 50 TB estate made up of 500 GB files might transfer in hours, while 50 TB of 10 KB files could take weeks.
- Small-file-heavy workloads are often bottlenecked by IOPS and API transaction rates rather than network bandwidth.
- Azure Storage Mover and AzCopy both support parallel transfers to maximize throughput, but even with high parallelism, per-object overhead accumulates when object counts are in the hundreds of millions or billions.
- Specialized ISV migration tools address this challenge by bundling many small files into larger transfer streams and applying compression during transit. This reduces per-object overhead and network utilization at the same time, producing significantly higher effective throughput for small-file-heavy estates. See the "Explore offline and ISV migration tools" unit for available solutions.

Factor object count into your migration timeline alongside data volume. Use pilot migrations on representative subsets of your data to validate throughput assumptions before committing to a full migration schedule.

### Impact of data structure on enumeration

The way data is organized in directories or containers affects how quickly migration tools can discover and enumerate objects:

- **Flat structures**: A single directory or container holding billions of objects forces sequential enumeration, which can take days before any data transfer even begins. Migration tools must list all objects to build a transfer plan, and flat namespaces offer no opportunity to parallelize this discovery phase.
- **Hierarchical structures**: Data organized into a tree of directories or virtual folder prefixes allows migration tools to enumerate multiple branches in parallel, dramatically reducing discovery time.
- **Prefix-based partitioning**: For object storage, using well-distributed prefixes (for example, date-based or hash-based) enables tools to split enumeration across prefix ranges concurrently.

If your source data is stored in a flat structure with very high object counts, consider whether restructuring before migration is feasible. Even a simple one-level partitioning (for example, grouping by first two characters of the file name) can significantly improve enumeration performance and overall migration speed.

If the estimated online transfer duration exceeds your migration window, consider offline migration with Azure Data Box for the initial bulk transfer, followed by online delta synchronization using Azure Storage Mover or Azure File Sync.

## Connectivity options

Once you know how long the transfer takes, you need to evaluate which network path to use:
- **Public internet**: Simplest setup, but throughput may be limited and variable. Suitable for smaller datasets.
- **Azure ExpressRoute**: Dedicated private connection with predictable bandwidth (up to 100 Gbps). Recommended for large-scale migrations. Lead times for provisioning apply.
- **VPN Gateway**: Encrypted tunnel over the internet. Lower throughput than ExpressRoute but faster to set up.
- **ExpressRoute with FastPath**: Bypasses the virtual network gateway for improved data-path performance.

## Throttling and QoS

Migration traffic can saturate your network and starve production workloads if left unchecked. Plan for traffic management:

- **Throttle migration throughput**: Most migration tools allow you to limit bandwidth consumption. Azure Storage Mover and AzCopy both support throughput caps. Configure these limits based on the bandwidth you can afford to dedicate to migration.
- **Schedule around peak hours**: Run bulk transfers during off-peak windows (evenings, weekends) to minimize impact on business operations.
- **QoS policies**: If your network infrastructure supports Quality of Service, assign migration traffic a lower priority class than production traffic. This ensures business-critical applications are not affected even during sustained transfers.
- **Monitor during migration**: Track network utilization on both the source and Azure side. Unexpected congestion or throughput drops can indicate bottlenecks that need to be resolved before they delay the overall migration timeline.

## Storage account throughput limits

Azure storage accounts have ingress and egress limits that can become a bottleneck during migration:

- General-purpose v2 storage accounts have a default maximum ingress of 60 Gbps in most regions.
- Individual blob and file operations have per-request size and rate limits that vary by storage service.
- If your migration involves many parallel streams writing to a single storage account, monitor for throttling (HTTP 503 responses) and distribute data across multiple storage accounts if needed.
- You can request a limit increase through Azure support if your migration requires throughput beyond the defaults.

Learn more: [Scalability targets for standard storage accounts](/azure/storage/common/scalability-targets-standard-account)

## Multi-region and geographic considerations

Where your source data lives relative to your target Azure region affects both speed and cost:

- **Latency**: Higher latency increases the round-trip time for each operation. For protocols that are sensitive to latency (such as SMB), this can significantly reduce effective throughput even on high-bandwidth connections.
- **Region selection**: Choose the Azure region closest to your source data center to minimize latency. If the final destination is a different region, migrate to the nearest region first and then use Azure-to-Azure copy or replication to move data to the final region.
- **ExpressRoute peering location**: Ensure your ExpressRoute circuit peers at a location geographically close to both your data center and the target Azure region.

## Bandwidth cost considerations

Network costs can affect the total migration budget:
- Ingress to Azure is free. Data flowing into Azure storage accounts does not incur bandwidth charges.
- ExpressRoute circuits have monthly fees based on the port speed and peering type.
- If existing contracts with your ISP or network provider limit bandwidth or impose overage charges, factor these into your migration timeline rather than trying to exceed them.
- For very large datasets (hundreds of TB or PB), compare the total cost of sustained bandwidth against the one-time cost of Azure Data Box.

Learn more:

- [Azure ExpressRoute overview](/azure/expressroute/expressroute-introduction)
- [Azure VPN Gateway overview](/azure/vpn-gateway/vpn-gateway-about-vpngateways)

With your bandwidth requirements and network path understood, you can build a realistic migration timeline and identify potential bottlenecks before they cause delays.
