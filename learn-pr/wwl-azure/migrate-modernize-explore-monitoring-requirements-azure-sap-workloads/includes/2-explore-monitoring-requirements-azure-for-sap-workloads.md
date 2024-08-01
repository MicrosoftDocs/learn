As per [SAP Note \#2015553](https://me.sap.com/notes/2015553), "for full support, you must enable built-in SAP monitors to retrieve information about configuration and resource utilization from the underlying Azure infrastructure." Therefore, you must set up every Azure instance that hosts SAP software and related DBMS systems such that:

- The Azure Extension for SAP is deployed and correctly configured.
- Data from the Azure Extension for SAP is visible in the SAP NetWeaver system.

Make sure that the following Azure Extension for SAP technical requirements are met:

- The Azure virtual machine instance requires an active route to the internet to be able to access the Azure Extension Pool. This might require setting Internet proxies for the virtual machine instance before deploying the Azure Extension for SAP.
- SAP Enhanced Monitoring is deployed. To include Azure performance counters in SAP Enhanced Monitoring, SAP has enhanced the SAP Host Agent and its monitoring transaction ST06. Therefore, check the configuration, the required versions, and minimum support package levels, as described in the following SAP Notes:

  - **Windows**: [SAP Note \#1409604](https://me.sap.com/notes/1409604)
  - **Linux**: [SAP Note \#1102124](https://me.sap.com/notes/1102124)

Explore SAP HANA monitoring:

In order to effectively analyze problems related to SAP HANA (both in Azure VMs and on bare-metal hardware), it's useful to narrow down the root cause of a problem. SAP has published a large amount of documentation to help you. Applicable FAQs related to SAP HANA performance can be found in the following SAP Notes:

- [SAP Note \#2222200 – FAQ: SAP HANA Network](https://me.sap.com/notes/2222200)
- [SAP Note \#2100040 – FAQ: SAP HANA CPU](https://me.sap.com/notes/2100040)
- [SAP Note \#1999997 – FAQ: SAP HANA Memory](https://me.sap.com/notes/1999997)
- [SAP Note \#200000 – FAQ: SAP HANA Performance Optimization](https://me.sap.com/notes/200000)
- [SAP Note \#199930 – FAQ: SAP HANA I/O Analysis](https://me.sap.com/notes/199930)
- [SAP Note \#2177064 – FAQ: SAP HANA Service Restart and Crashes](https://me.sap.com/notes/2177064)
