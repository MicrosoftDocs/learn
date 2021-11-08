Large Instances are physical servers based on the Intel EX E7 CPU architecture and configured in a large instance stamp — that is, a specific set of servers or blades. A compute unit equals one server or blade, and a stamp is made up of multiple servers or blades. Within a large instance stamp, servers are not shared and are dedicated to running one customer’s deployment of SAP HANA.

Various SKUs are available for HANA Large Instances, supporting up to 20 TB single instance (60 TB scale-out) of memory for S/4HANA or other SAP HANA workloads. Two classes of servers are offered:

 -  **Type I** class of SKUs comprising S72, S72m, S96, S144, S144m, S192, S192m, and S192xm
 -  **Type II** class of SKUs comprising S384, S384m, S384xm, S384xxm, S576m, S576xm, S768m, S768xm, and S960m

For example, the S72 SKU comes with 768 GB RAM, 3 terabytes (TB) of storage, and 2 Intel Xeon processors (E7-8890 v3) with 36 cores. Choose a SKU that fulfills the sizing requirements you determined in your architecture and design sessions. Always ensure that your sizing applies to the correct SKU. Capabilities and deployment requirements vary by type, and availability varies by region. You can also step up from one SKU to a larger SKU.

Microsoft helps establish the Large Instance setup, but it is your responsibility to verify the operating system’s configuration settings. Make sure to review the most current SAP Notes for your exact Linux release.

Sizing for HANA Large Instance is no different than sizing for HANA in general. For existing and deployed systems that you want to move from other RDBMS to HANA, SAP provides several reports that run on your existing SAP systems. If the database is moved to HANA, these reports check the data and calculate memory requirements for the HANA instance. For more information on how to run these reports and obtain their most recent patches or versions, refer to the following SAP Notes:

 -  [SAP Note \#1793345 - Sizing for SAP Suite on HANA](https://launchpad.support.sap.com/#/notes/1793345)
 -  [SAP Note \#1872170 - Suite on HANA and S/4 HANA sizing report](https://launchpad.support.sap.com/#/notes/1872710)
 -  [SAP Note \#2121330 - FAQ: SAP BW on HANA sizing report](https://launchpad.support.sap.com/#/notes/2121330)
 -  [SAP Note \#1736976 - Sizing report for BW on HANA](https://launchpad.support.sap.com/#/notes/1736976)
 -  [SAP Note \#2296290 - New sizing report for BW on HANA](https://launchpad.support.sap.com/#/notes/2296290)

For greenfield implementations, SAP Quick Sizer is available to calculate memory requirements of the implementation of SAP software on top of HANA.

Memory requirements for HANA increase as data volume grows. Be aware of your current memory consumption to help you predict what it's going to be in the future. Based on memory requirements, you then can map your demand onto one of the HANA Large Instance SKUs.
