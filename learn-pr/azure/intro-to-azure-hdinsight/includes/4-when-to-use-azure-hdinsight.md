You can use Azure HDInsight to process big data in many scenarios, either with historical or real-time data. But the question is, should you? Perhaps the biggest strength of HDInsight is the extensive range of configurations it provides. In this unit, you'll consider whether Azure HDInsight is the correct choice for your organization. You'll analyze criteria to help you decide, including:

- Range of workloads
- Scalability
- Fault tolerance
- Security

## Decision criteria

To determine whether Azure HDInsight can meet your organization's big data needs, use the criteria described in the following table.

| **Criteria** | **Analysis**|
| ---------------------------- | ------------------------------------------------------------ |
| **Range of workloads** | If you require support for a variety of workloads, you'll need a platform capable of supporting those requirements. |
| **Scalability** | Does your organization need to scale to accommodate increases in data volume, and also data velocity? It's important to choose a platform that can scale automatically. It's also important to use a platform that supports compute and storage scaling independently. |
| **Fault tolerance** | If your data analysis must continue despite component failure, you'll need to choose  a fault tolerant platform. |
| **Security** | Most organizations expect the data they work with to be secure at rest and in transit. It's also important for almost all organizations to meet government compliance standards. |

## Apply the criteria

Consider how your organization wants to work with big data. Then apply the following criteria to help you determine whether HDInsight is a good choice:

- **Range of workloads**. It enables you to support a wide variety of workloads. These workloads could be batch processing of data, working with streaming data, or managing data warehouses and/or data science workloads. This feature makes HDInsight a compelling choice, especially if your business process contains multiple workloads.
- **Scalability**. HDInsight supports independently scalable compute and storage. In addition, worker nodes can auto scale based on workload or schedule. 

   > [!TIP]
   > The separation of compute and storage, in addition to automatic cluster scaling, can lead to significant cost optimizations.

- **Fault tolerance**. HDInsight’s head nodes are resilient to failure. The head nodes are backed by fault tolerant VMs leading to a highly available service with an SLA of 99.9%.
- **Security**. Azure Active Directory integration provides enterprise security authentication and authorization. These capabilities, in addition to encryption and virtual network support, provide granular control of who can access your data.


In summary, consider using Azure HDInsight when you want to:

- Gather massive amounts of data at scale and:

   - Gain real-time insights
   - Process the data with optimized cost, minimal effort, and strong security

- Migrate:

   - an on-premises OSS vendor packaged Hadoop distribution to the cloud with as little cost and effort as possible
   - an OSS big data service from a competitor cloud offering to Azure

