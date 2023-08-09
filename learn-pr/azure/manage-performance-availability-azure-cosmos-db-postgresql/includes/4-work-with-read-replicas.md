Woodgrove Bank expanded their application to Europe, as they've opened a corporate location and branches throughout Europe. The European office wants to view dashboards and run frequent reports to analyze the transactions and application usage. As they only need read-only access, a read replica can help this task. To boost performance of the analytics in the European office, the read replica can be located in a European region, different from the primary cluster located in the United States.

## What are read replicas?

Read replicas are read-only clusters, complete with their own set of coordinator and worker nodes. Write operations should be sent to the primary replica, whereas analytics systems can be configured to connect directly to the read replica cluster. Read replicas are updated asynchronously with eventual consistency, so this data isn't immediately in sync with the primary cluster. There's some lag time between the primary cluster and any associated read replica clusters.

When replicas are created, the read replica cluster is created then filled with data from the primary cluster. The duration of creating a read replica varies, depending on how much data is in your primary cluster. This process could be as little as minutes to upwards of hours.

There are other costs associated with the read replicas. You're billed for the compute and storage costs for the read replicas.

## Considerations

There are some things to consider when working with read replicas:

* There's a limit of five read replicas for a primary cluster. This limit is on the total number of replicas available, not at a per region basis.
* Read replicas must be created separately. An existing primary cluster can't be converted into a read replica.
* Read replicas have their own configurations for compute, firewall rules, and private endpoints. These configuration items can be managed after creation.
* Storage size and worker nodes are inherited from the primary cluster and can't be changed.
* Firewall rules and parameters aren't inherited from the primary cluster to the read replicas. These rules and parameters need to be specified manually.

Suppose the Woodgrove Bank's analysis team in the United States wanted to pull analytics for their app data. While the primary cluster is located locally, the users are also working from the primary cluster. The load from analysis can have an effect on the performance for the users. It may make sense to have a read replica for the local analysis team to offload their usage from the primary cluster. Use read replicas to help move the load for read-only options from a primary cluster to where the load is solely read access.

:::image type="content" source="../media/primary-two-replicas.svg" alt-text="Diagram of a primary cluster in the United States with read replicas in Europe and the United States.":::
