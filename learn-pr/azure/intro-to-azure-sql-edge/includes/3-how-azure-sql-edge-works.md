Azure SQL Edge is a containerized Linux application that runs on either an ARM64-based or an x64-based processor. The startup memory footprint for Azure SQL Edge is less than 500 MB. Within this small footprint, you can design and build apps that run on a very wide range of IoT devices. 

> [!TIP]
> These devices can include battery-powered or solar-powered devices deployed in remote areas with only occasional connectivity. 

In this unit, you'll learn how Azure SQL Edge: 

- Captures continuous streams of increasing volumes of data in real time.
- Integrates data from the edge to cloud to on-premises.
- Supports a choice of suitable platforms.
- Provides excellent security and performance.

## Capture continuous streams of data in real time  

Given the volume of data and the need to ingest and analyze this data in a timely manner, its vital that any solution you select at the edge must be capable of capturing continuous streams of increasing amounts of data in real time. It's also important you can derive valuable insights on that data. SQL Edge supports a built-in streaming engine to help address these needs. 

### Time series and streaming data support

IoT sensors typically transmit time-sequenced measurements, called time-series data, as a data stream. There are two aspects of the time-series capabilities offered by Azure SQL Edge:

- A built-in streaming engine that allows:

   - Transformation
   - Windowed aggregation
   - Simple anomaly detection
   - Classification of the incoming stream of data

   > [!NOTE]
   > This engine is built using the same codebase as Azure Stream Analytics.

- The time-series storage engine allows storage of time-indexed data, which you can later aggregate in the cloud for future analysis.

The following graphic displays the following components:

- The streaming data engine with native analytics.
- A SQL database engine containing built-in ML capabilities. 

The graphic indicates that the real time streamed data ingested by the streaming analytics engine can also be aggregated in the local SQL database. 

> [!TIP] 
> You can also use standard procedures and functions to process this data as required.

:::image type="content" source="../media/streaming.png" alt-text="A graphic depicting the streaming engine and related components of Azure SQL Edge.":::

## Integrate data

In the past, those developing IoT apps have realized that edge data cannot always be easily integrated within an comprehensive organizational  data solution. This can result in the data from the IoT devices at the edge being inaccessible in a proprietary solution. Because SQL Edge uses the same codebase as SQL Server and SQL Database, this is no longer a problem. 

As indicated in the following graphic, Azure SQL Edge offers compatibility with other Microsoft services and apps by providing:

- Synchronization with Azure services such as:

   - SQL Database
   - SQL Server on an Azure virtual machine (VM)
   - Azure Cosmos DB

- The ability to choose data sources (sensors) and targets that best suit your organization's needs 
- Native integration with Azure products and services such as:

   - Azure IoT Edge 
   - Azure Stack Edge 

:::image type="content" source="../media/consistent-code.png" alt-text="A graphic depicting xxx.":::

## Run SQL Edge on the appropriate platform

Because edge scenarios often require the flexibility to run on different platforms, SQL Edge provides you with the following options: 

- **Architecture**. Device architecture supports both ARM64 and x64-based architectures.
- **Container OS**. You can choose either Windows or Linux as the host for your container.
- **Container type**. You can choose either Kubernetes or Linux Docker containers to orchestrate your device infrastructure for better efficiency and automation.
- **Mode**. Online or offline modes to support various edge environments.

## Protect data at the edge

Security is a top concern when deploying IoT apps to the edge. Any device that's accessible over the internet is at risk of being the target for a malicious hacker. Consequently, any data stored on that device is at risk of being compromised. 

SQL Server is the most secure database platform available. Since SQL Edge is based on SQL Server technology, the same security features of SQL Server Enterprise are available in SQL Edge. These built-in security features are discussed in the following table.

| Feature        | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| RBAC and ABAC  | *Role-based access control* (RBAC) manages access to specific resources based on permissions assigned to the user requesting access (or a group to which they belong). *Attribute-based access control* (ABAC) manages access control based on rules that refer to the attributes of the user or target data or resource. |
| Encryption     | *Data protection with Transparent Data Encryption* (TDE) enables compliance with many security regulations by encrypting database and log files through an encryption key that itself is encrypted. *Always Encrypted* provides a separation between those who own the data and those who manage it; this helps prevent those with administrator privileges to a database from accessing encrypted data that they do not own in that database. |
| Classification | This feature helps you comply with security regulations by allowing data to be categorized by sensitivity and business impact. Once you classify data, you can manage it in ways that help protect sensitive or important data from theft or loss. |






