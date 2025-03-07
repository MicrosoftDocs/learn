## Compute

To scale up or down, you can choose from many sizes of servers that are available for HANA Large Instances. They are categorized as Type I and Type II and tailored for different workloads. Choose a size that can grow with your workload for the next three years. One-year commitments are also available. S/4HANA and SAP Business Suite on HANA on a single blade can be scaled up to 20 TB with a single HANA Large Instances instance.

A multi-host scale-out deployment is generally used for BW/4HANA deployments as a kind of database partitioning strategy. To scale out, plan the placement of HANA tables prior to installation. From an infrastructure standpoint, multiple hosts are connected to a shared storage volume, enabling quick takeover by standby hosts in case one of the compute worker nodes in the HANA system fails.

For greenfield scenarios, the SAP Quick Sizer is available to calculate memory requirements of the implementation of SAP software on top of HANA. Memory requirements for HANA increase as data volume grows. Use your system’s current memory consumption as the basis for predicting future consumption, and then map your demand into one of the HANA Large Instances sizes.

If you already have SAP deployments, SAP provides reports you can use to check the data used by existing systems and calculate memory requirements for a HANA instance. For example, see the following SAP Notes:

 -  [SAP Note \#1793345 - Sizing for SAP Suite on HANA](https://launchpad.support.sap.com/#/notes/1793345)
 -  [SAP Note \#1872170 - Suite on HANA and S/4 HANA sizing report](https://launchpad.support.sap.com/#/notes/1872170)
 -  [SAP Note \#2121330 - FAQ: SAP BW on HANA Sizing Report](https://launchpad.support.sap.com/#/notes/2121330)
 -  [SAP Note \#1736976 - Sizing Report for BW on HANA](https://launchpad.support.sap.com/#/notes/1736976)
 -  [SAP Note \#2296290 - New Sizing Report for BW on HANA](https://launchpad.support.sap.com/#/notes/2296290)

## Storage

You can purchase additional storage in 1 TB units. This additional storage can be added as additional volumes or used to extend one or more of the existing volumes. It isn't possible to decrease the sizes of the volumes as originally deployed. It also isn't possible to change the names of the volumes or mount names. The storage volumes are attached to the HANA Large Instance units as NFS4 volumes.

## SAP HANA data tiering and extension nodes

SAP supports a data tiering model for SAP BW of different SAP NetWeaver releases and SAP BW/4HANA. With HANA Large Instance, you can use option-1 configuration of SAP HANA extension nodes as explained in [SAP BW/4HANA and SAP BW-on-HANA with SAP HANA Extension Nodes](https://www.sap.com/documents/2018/05/9878c71f-037d-0010-87a3-c30de2ffd8ff.html?url_id=text-glo-404-reclink). Option-2 configurations can be set up with the following HANA Large Instance SKUs: S72m, S192, S192m, S384, and S384m.

When you look at the documentation, the advantage might not be visible immediately. But when you look at the SAP sizing guidelines, you can see an advantage by using option-1 and option-2 SAP HANA extension nodes. Here are examples:

 -  SAP HANA sizing guidelines usually require double the amount of data volume as memory. When you run your SAP HANA instance with the hot data, you have only 50 percent or less of the memory filled with data. The remainder of the memory is ideally held for SAP HANA doing its work.
 -  That means in a HANA Large Instance S192 unit with 2 TB of memory, running an SAP BW database, you only have 1 TB as data volume.
 -  If you use an additional SAP HANA extension node of option-1, also an S192 HANA Large Instance SKU, it gives you an additional 2-TB capacity for data volume. In the option-2 configuration, you get an additional 4 TB for warm data volume. Compared to the hot node, the full memory capacity of the "warm" extension node can be used for data storing for option-1. Double the memory can be used for data volume in option-2 SAP HANA extension node configuration.
 -  You end up with a capacity of 3 TB for your data and a hot-to-warm ratio of 1:2 for option-1. You have 5 TB of data and a 1:4 ratio with the option-2 extension node configuration.

The higher the data volume compared to the memory, the higher the chances are that the warm data you are asking for is stored on disk storage.
