You can use HDInsight to process big data in many scenarios, using historical or real-time data; but should you? The biggest strength of HDInsight is the extensive range of configurations it provides. In this unit, you'll consider whether HDInsight is the correct choice for your organization. You'll analyze the following criteria to help you decide:

- Range of workloads
- Scalability
- Fault tolerance
- Security

## Decision criteria

To determine whether HDInsight can meet your organization's big-data needs, use the criteria described in the following table:

| **Criteria** | **Analysis**|
| ---------------------------- | ------------------------------------------------------------ |
| **Range of workloads** | If you require support for various workloads, you'll need a platform that can support those requirements. |
| **Scalability** | Does your organization need to scale to accommodate increases in data volume and data velocity? It's important to choose a platform that can scale automatically and support compute and storage scaling independently. |
| **Fault tolerance** | If your data analysis must continue despite component failure, you'll need to choose a fault-tolerant platform. |
| **Security** | Most organizations expect the data they work with to be secure at rest and in transit. It's also important for almost all organizations to meet government compliance standards. |

## Apply the criteria

Consider how your organization wants to work with big data. Now apply the decision criteria to determine whether HDInsight is a good choice:

- **Range of workloads**: HDInsight enables you to support a wide variety of workloads. These workloads could be batch data processing, working with streaming data, or managing data warehouses and/or data-science workloads. This feature makes HDInsight a compelling choice, especially if your business process contains multiple workloads.
- **Scalability**: HDInsight supports independently scalable compute and storage. Also, worker nodes can auto-scale based on workload or schedule.

   > [!TIP]
   > Significant cost optimizations can result from separating compute and storage and having automatic cluster scaling.

- **Fault tolerance**: HDInsight’s head nodes are resilient to failure and backed by fault-tolerant VMs. This makes it a highly available service that has an SLA of 99.9%.
- **Security**: Azure Active Directory integration provides enterprise security authentication and authorization. These capabilities, in addition to encryption and virtual network support, give you granular control of who can access your data.

In summary, consider using HDInsight when you want to:

- Gather massive amounts of data at scale and:

  - Gain real-time insights.
  - Process the data with optimized costs, minimal effort, and strong security.

- Migrate:

  - An on-premises, open-source software, vendor-packaged Hadoop distribution to the cloud with as little cost and effort as possible.
  - An open-source software, big-data service from a competitor cloud offering to Azure.
