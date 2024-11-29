Azure Data Factory (ADF) and Azure Synapse pipelines maintain a separate Platform as a Service (PaaS) roadmaps. These two solutions continue to coexist alongside Fabric Data Factory, which serves as the Software as a Service (SaaS) offering. ADF and Synapse pipelines remain fully supported, and there are no plans for deprecation. It's important to highlight that, for any upcoming projects, our suggestion is to initiate them using Fabric Data Factory. Additionally, we have strategies in place to facilitate the transition of ADF and Synapse pipelines to Fabric Data Factory, enabling them to take advantage of new Fabric functionalities. You can learn more about this [here.](/fabric/data-factory/upgrade-paths#migrate-from-azure-data-factory-adf)

## Maximizing Data Movement Throughput with Fabric Data Factory

Fabric Data Factory enables you to develop pipelines that maximize data movement throughput for your environment. These pipelines fully utilize key resources to ensure efficient data transfer.

## Key Resources Utilized

- **Network Bandwidth**: Between the source and destination data stores.
- **IOPS and Bandwidth**: Input/output operations per second and bandwidth of the source or destination data store.

## Estimating Throughput

To estimate overall throughput, measure the minimum throughput available with the following resources:

- **Source Data Store**
- **Destination Data Store**
- **Network Bandwidth**: This is the bandwidth between the source and destination data stores.

## Performance Innovations

We continuously innovate to boost the best possible throughput. Currently, the service can:

- Move a **1-TB TPC-DI dataset (Parquet files)** into both Fabric Lakehouse table and Data Warehouse within **5 minutes**.
- Move **1 billion rows** in under **1 minute**.

> [!NOTE]
> **Note**: This performance is based on the testing dataset previously mentioned. Actual throughput depends on the factors listed previously.

## Enhancing Throughput

You can multiply your throughput by running multiple copy activities in parallel. For example, using a **ForEach loop**. Properly ***profiling*** the data, its proper order for loading, and traditional warehouse techniques are always helpful if there is:

- Load failure
- Processing slowly changing dimensions (SCDs)
- Handling missing records
- use of surrogate keys to separate source data from warehouse data
- providing a feedback loop to resolve issues by the business owners of the source systems.

By using these strategies and resources, you can maximize data movement throughput in Fabric Data Factory, ensuring efficient and effective data transfer for your analytical workloads.
